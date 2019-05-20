#!/bin/bash
# Arg1 is the current EllLevel
export SPEC_BUILD_DIR=/home/geoffrey/Codes/spec/spec-orca0c/

ThisEllLev=$1
#Prepare input files for extrapolation

#Extrapolate
echo "DoExtrapAndGetAH.bash: Extrapolating..."
pushd Lev${ThisEllLev}
mkdir Extr
cd Extr
ln -s ${SPEC_BUILD_DIR}/Support/bin/InterpolateAndExtrapolateToNewDomain .

cp ../*input .
mv ExtrDomain.input ./Domain.input
mv ExtrEllipticItems.input ./EllipticItems.input
mv ExtrEllipticObservers.input ./EllipticObservers.input
mv ExtrPetsc.input ./petsc.input
ln -s ../SpEC ./Spells
#mpirun -np 3 Spells #dump ConformalMetric, TrExtrinsicCurvature
./Spells #dump ConformalMetric, TrExtrinsicCurvature
#Do extrapolate XCTS vars
./InterpolateAndExtrapolateToNewDomain -i CardinalInterpolator -v -t ConformalFactor,LapseTimesConformalFactor -r Scalar,Scalar -source ../ -target . -e "SphereTaylor(Order=8; Interpolator=CardinalInterpolator;)" &
./InterpolateAndExtrapolateToNewDomain -i CardinalInterpolator -v -t Shift -r 1 -source ../ -target . -e "SphereTaylor(Order=8; Interpolator=CardinalInterpolator;)" &
wait

echo "DoExtrapAndGetAH.bash: Preparing data in EvID..."
cd ../
mkdir EvID
cd EvID
cp ../ComputeEvolutionID.input .
cp ../Extr/Domain.input .
echo "HistoryFile=<<NONE>>;" >> Domain.input
cp ../GlobalItems.input .
cp ../SpatialCoordMap.input .
ln -s ${SPEC_BUILD_DIR}/Support/bin/ApplyObservers .
./ApplyObservers -dir ../Extr -t ConformalFactor,LapseTimesConformalFactor,Shift,ConformalMetric,TrExtrinsicCurvature,dtTeukolskyh -r Scalar,Scalar,1,11,Scalar,11 -NoDomainHistory ./ComputeEvolutionID.input

#Find the AH
echo "DoExtrapAndGetAH.bash: Finding apparent horizons..."
mkdir FindAH
cd FindAH
cp ../Domain.input .
cp ../SpatialCoordMap.input .
cp ../../FindAh.input .
cp ../../GlobalItems.input .
cp ../../../DoFindAh.bash .
ln -s ../Nid*dump .
ln -s ../ApplyObservers .
DoFindAh.bash

popd

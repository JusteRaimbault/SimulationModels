
chdir('~/ComplexSystems/SimulationModels/Models/Tests/ScilabTask')

data = rand(100, 100) + 1000000 //, 100)
//data = [1,2,3,4,5,6,7,8]
//data = [%T,%T,%F]//rand(10,1)
//data = ["a","b","a","a","a","b","a","a","a","b","a","a","a","b","a","a","a","b","a","a","a","b","a","a","a","b","a","a","a","b","a","a","a","b","a","a","a","b","a","a"]
//data=[data,data]

print('test_print.txt', data)
//write('test_write.txt', data')
fprintfMat('test_fprintfMat',data, "%.16e")
// https://en.wikipedia.org/wiki/IEEE_754

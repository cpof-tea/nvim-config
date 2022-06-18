// 01 .123 is not a jsNumber
test.123test
test .123test

// 02 .123 is a jsNumber
test .123 test
test+.123+test

// 03 .123e is not a jsNumber
test.123etest
test .123e test

// 04 .123e1 is not a jsNumber
test.123e1test
test .123e1test

// 05 .123e1 is a jsNumber
test .123e1 test
test+.123e1+test

// 06 .123e-1 is not a jsNumber
test.123e-1

// 07 .123e-1 is a jsNumber
test .123e-1
test+.123e-1+test

// 08 123.123 is not a jsNumber
test123.123

// 09 123.123 is a jsNumber
test 123.123
test+123.123+test

// 10 123.123e is not a jsNumber
test123.123e
test 123.123e

// 11 123.123e1 is not a jsNumber
test123.123e1test
test 123.123e1test

// 12 123.123e1 is a jsNumber
test 123.123e1
test+123.123e1+test

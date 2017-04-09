#include "gtest/gtest.h"
#include "gmock/gmock.h"

using namespace ::testing;

struct MockTest {
    MOCK_METHOD0(testMock, int());
};

TEST(MockTestSuite, MockTest1)
{
    MockTest mock;
    EXPECT_CALL(mock, testMock()).WillOnce(Return(42));
    ASSERT_EQ(5, mock.testMock());
}

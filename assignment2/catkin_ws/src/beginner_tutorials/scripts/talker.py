#!/usr/bin/env python
# license removed for brevity

import rospy
from std_msgs.msg import String

def talker():
    # Chatter: The topic that we will publish to
    # String: What type of message
    # queue_size: max number of queued messages...
    pub = rospy.Publisher('chatter', String, queue_size=10)

    # talker: the name we are giving 
    # anonymous: name we are giving will be guarenteed as unique, lib will add
    # random characters after it...
    rospy.init_node('talker', anonymous=True)

    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        hello_str = "hello world %s" % rospy.get_time()
        rospy.loginfo(hello_str)
        pub.publish(hello_str)
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass

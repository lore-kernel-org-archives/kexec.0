Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ausmtp05.au.ibm.com ([202.81.18.154])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I61RO-0005Xw-1W
	for kexec@lists.infradead.org; Wed, 04 Jul 2007 10:46:37 +0100
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l649kcMV2723920
	for <kexec@lists.infradead.org>; Wed, 4 Jul 2007 19:46:58 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l649mYjG158906
	for <kexec@lists.infradead.org>; Wed, 4 Jul 2007 19:48:38 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l649j2J6023016
	for <kexec@lists.infradead.org>; Wed, 4 Jul 2007 19:45:02 +1000
Message-ID: <468B6B13.8070007@linux.vnet.ibm.com>
Date: Wed, 04 Jul 2007 15:10:35 +0530
From: Subrata Modak <subrata@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [ANNOUNCE] The Linux Test Project has been Released for June 2007,
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org

Dear All,

The Linux Test Project test suite <http://www.linuxtestproject.org> has 
been released for the month of June 2007. The latest version of the 
testsuite contains 3000+ tests for the Linux OS and can be found at 
http://prdownloads.sourceforge.net/ltp/ltp-full-20070630.tgz?download. 
Our web site also contains other information such as:  
- A Linux test tools matrix  
- Technical papers  
- How To's on Linux testing  
- Code coverage analysis tool.  
 
Release Highlights:
* Updation of OPEN_HPI_TESTSUITE from version 0.5.0 to 2.9.2
* Addition of 'writev06'  testcase by <dmonakhov@openvz.org> to check 
for "fault in pages readable" functionality
* Addition of 'SYSVIPC (containers)' testcases by 
<risrajak@linux.vnet.ibm.com>
* KDUMP and UTSNAMESPACE testcases(s) getting more matured with more 
community contribution
* Updation of 'fsx-linux' testcase to include new feature(s) including 
"Distributed filesystem coherency" by 'Andreas Dilger'
* Patches to support arm eabi-compliant gcc for g-cov kernel
* Many more patches to fix Bugs/anomalies in various test cases
 
Note(s) from the Maintainer:
* We have seen that the LTP mailing lists has become active for the last 
couple of months. Thanks to all who has made this happen. We as an 
integrated team can work hard to make this Project a resounding success. 
Following are the different milestones/activities that we aim to 
perform/achieve in the coming months:
1) Investigation into LTP Log(s) Library to make this more meaningful 
and parsible. Kindly provide your inputs for the output that LTP 
generates now and whether/how you would like it to be in future
2) Investigate all the existing test cases and find out whether they are 
relevant to today's testing of higher Kernel versions. If not, then how 
do we mold it to test the present day 
scenarios/functionalities/regressions ??
And when you investigate them you can look into the following points as 
well:
* Investigate & understand what the testcase is supposed to do, and 
increase documentation content/comments on the same testcase,
* Make the test case completely full proof to error/exception handling,
* See whether more Log library calls(existing) need to be made to 
communicate more info to the Log Library for reporting errors/exceptions 
etc,
* Is there any need to change the code to improve the stress testing the 
testcase is doing ?? or do we need to add a new testcase for doing a 
separate stress, but, for the same functionality ??
3) LTP today does not cover more than 60% of the Kernel Code coverage. 
We need to write more test cases for all those functionalities which are 
not tested by LTP today. I promise your new test case will see the light 
of next release without fail,
4) LTP wiki will be active in coming days, where we will post all those 
activities going on inside LTP,
More community contribution from all of you will decide whether all of 
these above milestones are truly and successfully completed. Kindly Pour 
in your suggestions on all those that you want to see in LTP.

New Testcases to be Added to  next  releases:
Following are the new testcases that we intend(tentative) to add in the 
next release(s) of LTP:
1) Real Time Linux Testcases
2) CPU Sets Testcases

We encourage the community to post results to ltp-results@lists.sf.net, 
and patches, new tests, bugs or comments/questions to ltp-list@lists.sf.net,
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=103382 (for 
New Bug(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=303382 (for 
New Patch(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=353382 (for 
New Feature Request(s))
 
Please also see the ChangeLog Below (June 2007):
1)Log Message: "carmelo.amoroso@st.com" points out the wrong usage of 
the option -s
File(s) Affected: ltp/testcases/kernel/mem/mtest06/mmap1.c
2)Log Message: "carmelo.amoroso@st.com" pointed out that id (returned by 
shmget) has to be used for all shm operations
File(s) Affected: ltp/testcases/kernel/mem/mtest06/shmat1.c
3)Log Message: "rsalveti@linux.vnet.ibm.com" fixed the way "inotify" 
should compile in kernels below 2.6.13
File(s) Affected: ltp/testcases/kernel/syscalls/inotify/inotify01.c
ltp/testcases/kernel/syscalls/inotify/inotify02.c
4)Log Message: Removing 'alarm04' testcase call, as alarm04 has been 
removed to be no-more-valid
File(s) Affected: ltp/runtest/ltplite
ltp/runtest/stress.part3
5)Log Message: "sachinp@in.ibm.com" rectified kdump lkdtm tests for 
powerpc architecture with RedHat distribution
File(s) Affected: ltp/testcases/kdump/rhtools/lkdtm_mod/lkdtm.c
6)Log Message: "rahaman.riaz@gmail.com" fixed some Thread Handling Anomaly
File(s) Affected: 
ltp/testcases/open_posix_testsuite/conformance/interfaces/mq_timedsend/12-1.c
7)Log Message: "rahaman.riaz@gmail.com" fixed ways by which OPEN POSIX 
displays warnings
File(s) Affected: 
open_posix_testsuite/conformance/interfaces/sem_unlink/2-2.c
open_posix_testsuite/conformance/interfaces/sigaltstack/9-1.c
8)Log Message: "yxu@suse.de" corrected the way by which pthread_exit() 
handles pointer argument
File(s) Affected: ltp/testcases/kernel/io/disktest/threading.h
9)Log Message: "rsalveti@linux.vnet.ibm.com" fixed the problem reported 
at bug [1732287] mtest06/mmap1.c missing run_once check in do loop
File(s) Affected: ltp/runtest/ltplite
ltp/runtest/mm
ltp/runtest/stress.part1
ltp/testcases/kernel/mem/mtest06/mmap1.c
10)Log Message: gcov-kernel: add patches to support arm eabi-compliant gcc
File(s) Affected: 
/ltp/utils/analysis/gcov-kernel/linux-2.6.18-gcov-arm-eabi.patch
/ltp/utils/analysis/gcov-kernel/linux-2.6.19-gcov-arm-eabi.patch
/ltp/utils/analysis/gcov-kernel/linux-2.6.20-gcov-arm-eabi.patch
/ltp/utils/analysis/gcov-kernel/linux-2.6.21-gcov-arm-eabi.diff
11)Log Message: "dmonakhov@openvz.org" added this test case to check for 
"fault in pages readable" functionality
File(s) Affected: ltp/runtest/stress.part3
ltp/runtest/syscalls
ltp/runtest/ltplite
File(s) Added:    ltp/testcases/kernel/syscalls/writev/writev06.c
12)Log Message: "risrajak@linux.vnet.ibm.com" added sysvipc 
(conatainers) namespace testcases
File(s) Added:    ltp/testcases/kernel/containers/sysvipc/Makefile
ltp/testcases/kernel/containers/sysvipc/runipcnstest.sh
ltp/testcases/kernel/containers/sysvipc/runtests_noltp.sh
ltp/testcases/kernel/containers/sysvipc/shmnstest.c
File(s) Affected: ltp/README ltp/testcases/kernel/containers/Makefile
ltp/testcases/kernel/containers/README
ltp/testcases/kernel/containers/container_test.sh
13)Log Message: Randy Dunlap writes: Convert kernel/sched/pthreads/*.c 
to use the standard message output functions instead of printf().
File(s) Affected: ltp/testcases/kernel/sched/pthreads/pth_str01.c
ltp/testcases/kernel/sched/pthreads/pth_str02.c
ltp/testcases/kernel/sched/pthreads/pth_str03.c
14)Log Message: "rdunlap@xenotime.net" did "mmstress" cleanups to make 
output unbuffered so that it is not produced repetitively and erroneously
File(s) Affected: ltp/testcases/kernel/mem/mtest05/mmstress.c
15)Log Message: "krisw@us.ibm.com" wants to solve segfault problem with 
"mount03" on SLES10
File(s) Affected: ltp/testcases/kernel/syscalls/mount/Makefile
ltp/testcases/kernel/syscalls/mount/mount03.c
16)Log Message: as Ricardo Salveti de Araujo points out, dont set CC so 
it can easily be overridden
File(s) Affected: ltp/testcases/kernel/containers/utsname/Makefile
17)Log Message: "Andreas Dilger" updated "fsx-linux" testcase to include 
new feature(s) including distributed filesystem coherency
Log Message:    Copyright Statements once added cannot be deleted, 
however, many Copyright Statements can co-exist
File(s) Affected: ltp/testcases/kernel/fs/fsx-linux/fsx-linux.c
18)Log Message: Fix from "rdunlap@xenotime.net" to use standard test 
results output
File(s) Affected: ltp/testcases/kernel/mem/mem/mem01.c
ltp/testcases/kernel/mem/mtest01/Makefile
ltp/testcases/kernel/mem/mtest01/mtest01.c
ltp/testcases/misc/math/float/main.c
19)Log Mesage:  "serue@us.ibm.com" fixes conatiner testing with 
'unshare' support for lower kernel versions
File(s) Affected: ltp/testcases/kernel/containers/Makefile
ltp/testcases/kernel/containers/container_test.sh
20)Log Message: Fix for Bug no "1736357",tar file is not multiplatform, 
pointed out by "Neil Brewitt"
File(s) Added:    ltp/testcases/network/nfsv4/locks/deploy_info
File(s) Deleted:  ltp/testcases/network/nfsv4/locks/DEPLOY
21)Log Message: "serue@us.ibm.com" fixes conatiner testing with 
'unshare' support for lower kernel versions
File(s) Added:    ltp/testcases/kernel/containers/check_for_unshare.c
22)Log Message: Update to OpenHPI 2.9.2
File(s) Addedd/Modified/Deleted: ltp/testcases/open_hpi_testsuite/
 
Happy testing,
Regards & Thanks--
Subrata Modak,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

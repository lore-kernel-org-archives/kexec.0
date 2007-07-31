Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ausmtp06.au.ibm.com ([202.81.18.155])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IFk87-00081e-0V
	for kexec@lists.infradead.org; Tue, 31 Jul 2007 06:19:11 +0100
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.18.232])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l6V5JjNl4083900
	for <kexec@lists.infradead.org>; Tue, 31 Jul 2007 15:19:48 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.250.237])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6V5Fvd4261812
	for <kexec@lists.infradead.org>; Tue, 31 Jul 2007 15:15:57 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6V5GgAx004156
	for <kexec@lists.infradead.org>; Tue, 31 Jul 2007 15:16:42 +1000
Message-ID: <46AEC45B.2040405@linux.vnet.ibm.com>
Date: Tue, 31 Jul 2007 10:40:51 +0530
From: Subrata Modak <subrata@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [ANNOUNCE] The Linux Test Project has been Released for JULY 2007
Reply-To: subrata@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0509950419=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org

This is a multi-part message in MIME format.
--===============0509950419==
Content-Type: multipart/alternative;
	boundary="------------070904060509080209020808"

This is a multi-part message in MIME format.
--------------070904060509080209020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear All,

The Linux Test Project test suite <http://www.linuxtestproject.org> has 
been released for the month of JULY 2007. The latest version of the 
test-suite contains 3000+ tests for the Linux OS and can be found at 
http://prdownloads.sourceforge.net/ltp/ltp-full-20070731.tgz?download. 
Latest happenings in LTP can be found at 
http://ltp.sourceforge.net/wiki/ and 
http://ltp.sourceforge.net/wikiArchives.php. Our web site also contains 
other information such as:
- A Linux test tools matrix
- Technical papers
- How To's on Linux testing
- Code coverage analysis tool.

Release Highlights:
* Updation of OPEN_POSIX_TESTSUITE to version 1.5.2 ,
* KDUMP testcases getting more matured,
* 'fsx-linux' testcase for "Distributed filesystem coherency" being made 
uniform across LTP,
* Gcov-kernel patch for 2.6.22, and other updation for LCOV
* Many more patches to fix Bugs/anomalies in various test cases

Note(s) from the Maintainer:
Work has been initiated to improve LTP log formats, fix false positives 
and add new test-cases to LTP. We are also in discussion to start 
*LTP-DASH-MM* tree within LTP, which would incorporate test-cases for 
newly developed/built Kernel features. The Idea is to merge the same 
test-cases into LTP once those features becomes part of the main kernel. 
Would request your suggestions on this too.


We encourage the community to post results to ltp-results@lists.sf.net, 
and patches, new tests, bugs or comments/questions to 
ltp-list@lists.sf.net,
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=103382 (for 
New Bug(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=303382 (for 
New Patch(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=353382 (for 
New Feature Request(s))

Please also see the ChangeLog Below (JULY 2007):

1)  Log Message: lcov: preparations for new release by 
"oberpapr@users.sourceforge.net"
- updated CHANGES file
- added compat-libtool + no-compat-libtool option
- changed libtool default to on (due to popular request)
- added checksum option
- changed checksum default to off (to reduce cpu time + file size)
- added geninfo_checksum option to lcovrc, deprecated geninfo_no_checksum
- added geninfo_compat_libtool option to lcovrc
- minor update of README file
File(s) Affected:
ltp/utils/analysis/lcov/CHANGES
ltp/utils/analysis/lcov/README
ltp/utils/analysis/lcov/lcovrc
ltp/utils/analysis/lcov/bin/geninfo
ltp/utils/analysis/lcov/bin/lcov

2)  Log Message: update manpage by "oberpapr@users.sourceforge.net"
File(s) Affected:
ltp/utils/analysis/lcov/man/lcov.1

3)  Log Message: "sachinp@in.ibm.com" has fixed a probe point definition 
from 'll_rw_lock' to 'll_rw_block'
File(s) Affected:
ltp/testcases/kdump/susetools/lkdtm_mod/lkdtm.c

4)  Log Message: man page update by "oberpapr@users.sourceforge.net"
File(s) Affected:
ltp/utils/analysis/lcov/man/genhtml.1
ltp/utils/analysis/lcov/man/geninfo.1
ltp/utils/analysis/lcov/man/lcov.1

5)  Log Message: lcov: another update in preparation for a new release 
by "oberpapr@users.sourceforge.net"
File(s) Affected:
ltp/utils/analysis/lcov/bin/lcov
ltp/utils/analysis/lcov/man/lcovrc.5
ltp/utils/analysis/lcov/CHANGES
ltp/utils/analysis/lcov/lcovrc

6)  Log Message: fixed bug that would not delete .gcda files when using 
-z, by "oberpapr@users.sourceforge.net"
File(s) Affected:
ltp/utils/analysis/lcov/CHANGES
ltp/utils/analysis/lcov/bin/lcov

7)  Log Message: lcov: - add new option --initial to get zero coverage 
data from graph files by "oberpapr@users.sourceforge.net"
File(s) Affected:
ltp/utils/analysis/lcov/CHANGES
ltp/utils/analysis/lcov/bin/geninfo
ltp/utils/analysis/lcov/bin/lcov
ltp/utils/analysis/lcov/man/geninfo.1
ltp/utils/analysis/lcov/man/lcov.1

8)  Log Message: "carmelo.amoroso@st.com" fixed the anomaly when "SHLBA 
!= getpagesize()", like in SH architecture
File(s) Affected:
ltp/testcases/kernel/mem/shmt/shmt09.c

9)  Log Message: "hdeller@users.sf.net" fixed unitialized variable 
useage in "lseek09" testcase
File(s) Affected:
ltp/testcases/kernel/syscalls/lseek/lseek09.c

10) Log Message: "naveenspen@gmail.com" pointed out that 
syslog_cmd="/etc/init.d/syslog" should be used irrespective of any Distro
File(s) Affected:
ltp/testcases/kernel/syscalls/syslog/syslog01
ltp/testcases/kernel/syscalls/syslog/syslog02
ltp/testcases/kernel/syscalls/syslog/syslog03
ltp/testcases/kernel/syscalls/syslog/syslog04
ltp/testcases/kernel/syscalls/syslog/syslog05
ltp/testcases/kernel/syscalls/syslog/syslog06
ltp/testcases/kernel/syscalls/syslog/syslog07
ltp/testcases/kernel/syscalls/syslog/syslog08
ltp/testcases/kernel/syscalls/syslog/syslog09
ltp/testcases/kernel/syscalls/syslog/syslog10

11) Log Message: "rsalveti@linux.vnet.ibm.com" pointed out to have same 
"fsx-linux" testcase for "fs", "ltp-aiodio" and "nfs"
File(s) Affected:
ltp/testcases/kernel/io/ltp-aiodio/fsx-linux.c
ltp/testcases/network/nfs/fsx-linux/fsx-linux.c

12) Log Message: Randy Dunlap writes: Fix printf format warnings
File(s) Affected:
ltp/testcases/network/stress/ns-tools/Makefile
ltp/testcases/network/stress/ns-tools/ns-igmp_querier.c
ltp/testcases/network/stress/ns-tools/ns-mcast_join.c
ltp/testcases/network/stress/ns-tools/ns-mcast_receiver.c
ltp/testcases/network/stress/ns-tools/ns-tcpserver.c

13) Log Message: getsockopt() takes a socklen_t, not an int, as its optlen
File(s) Affected:
ltp/testcases/network/stress/ns-tools/ns-tcpclient.c
ltp/testcases/network/stress/ns-tools/ns-tcpserver.c
ltp/testcases/network/stress/ns-tools/ns-udpserver.c

14) Log Message: cleanup file
File(s) Affected:
ltp/testcases/kernel/syscalls/gethostid/gethostid01.c

15) Log Message: back out uclinux changes to something that doesnt spit 
warnings as reported by Randy Dunlap
File(s) Affected:
ltp/testcases/kernel/syscalls/gethostid/gethostid01.c

16) Log Message: fixup gcc warnings by removing silly pieces of code
File(s) Affected:
ltp/testcases/kernel/mem/mtest06/mmap1.c
ltp/testcases/kernel/mem/mtest06/mmap2.c
ltp/testcases/kernel/mem/mtest06/mmap3.c
ltp/testcases/kernel/mem/mtest06/shmat1.c

17) Log Message: Randy Dunlap writes: Convert mmap1 to use standard test 
results output format. Correct several typos.
File(s) Affected:
ltp/testcases/kernel/mem/mtest06/Makefile
ltp/testcases/kernel/mem/mtest06/mmap1.c

18) Log Message: gcov-kernel: adding gcov-kernel patch for 2.6.22
File(s) Addes:
ltp/utils/analysis/gcov-kernel/linux-2.6.22-gcov-arm-hack.patch
ltp/utils/analysis/gcov-kernel/linux-2.6.22-gcov.patch

19) Log Message: [1754301] Helge Deller writes: mark hppa/parisc as 
expecting a segv as well
File(s) Affected:
ltp/testcases/kernel/syscalls/mmap/mmap03.c

20) Log Message: Randy Dunlap writes: convert output to match the 
standard LTP output
File(s) Affected:
ltp/testcases/kernel/fs/linktest/linktest.pl

21) Log Message: close stdout to remove noise
File(s) Affected:
ltp/testcases/kernel/mem/mtest05/dummy.c

22) Log Message: Randy Dunlap writes: Convert mmstress to use the 
standard results format
File(s) Affected:
ltp/testcases/kernel/mem/mtest05/Makefile
ltp/testcases/kernel/mem/mtest05/mmstress.c

23) Log Message: "rsalveti@linux.vnet.ibm.com" updated the contact 
information at ltp-howto doc
File(s) Affected:
ltp/doc/ltp-howto.lyx
ltp/doc/ltp-howto.txt

24) Log Message: "rsalveti@linux.vnet.ibm.com" wants to update this with 
kernel/fs/fsstress/fsstress.c
File(s) Affected:
ltp/testcases/network/nfs/nfs_fsstress/fsstress.c

25) Log Message: "suzuki@in.ibm.com" added SIGNAL and Address Fault 
handling capability for all architectures
File(s) Affected:
ltp/testcases/kernel/mem/mtest06/mmap1.c

26) Log Message: "rsalveti@linux.vnet.ibm.com" added more options to 
'runltp'
File(s) Affected:
ltp/runltp
ltp/doc/man1/pan.1
ltp/pan/pan.c

27) Log Message: Upgrade to Posix Testsuite 1.5.2
File(s) Affected/Added:
ltp/testcases/open_posix_testsuite

28) Log Message: Fixing Proper Freeing of Memory Chunks
File(s) Affected:
ltp/tools/genload/stress.c

Happy testing,
Regards--
Subrata Modak,


--------------070904060509080209020808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<div class="moz-text-flowed"
 style="font-family: -moz-fixed; font-size: 12px;" lang="x-western">Dear
All,
<br>
<br>
The Linux Test Project test suite <a class="moz-txt-link-rfc2396E"
 href="http://www.linuxtestproject.org">&lt;http://www.linuxtestproject.org&gt;</a>
has been released for the month of JULY 2007. The latest version of the
test-suite contains 3000+ tests for the Linux OS and can be found at
<a class="moz-txt-link-freetext"
 href="http://prdownloads.sourceforge.net/ltp/ltp-full-20070731.tgz?download">http://prdownloads.sourceforge.net/ltp/ltp-full-20070731.tgz?download</a>.
Latest happenings in LTP can be found at
<a class="moz-txt-link-freetext" href="http://ltp.sourceforge.net/wiki/">http://ltp.sourceforge.net/wiki/</a>
and
<a class="moz-txt-link-freetext"
 href="http://ltp.sourceforge.net/wikiArchives.php">http://ltp.sourceforge.net/wikiArchives.php</a>.
Our web site also contains other information such as:<br>
- A Linux test
tools matrix<br>
- Technical papers<br>
- How To's on Linux testing<br>
- Code
coverage analysis tool.<br>
<br>
Release Highlights:<br>
* Updation of OPEN_POSIX_TESTSUITE to version 1.5.2
,<br>
* KDUMP testcases getting more matured,<br>
* 'fsx-linux' testcase for "Distributed filesystem coherency" being
made uniform across LTP,<br>
* Gcov-kernel patch for 2.6.22, and other updation for LCOV<br>
* Many more patches to fix Bugs/anomalies in various test cases
<br>
<br>
Note(s) from the Maintainer:
<br>
Work has been initiated to improve LTP log formats, fix false positives
and add new test-cases to LTP. We are also in discussion to start
<b>LTP-DASH-MM</b> tree within LTP, which would incorporate test-cases
for
newly developed/built Kernel features. The Idea is to merge the same
test-cases into LTP once those features becomes part of the main
kernel.
Would request your suggestions on this too.<br>
<br>
<br>
We encourage the community to post results to <a
 class="moz-txt-link-abbreviated" href="mailto:ltp-results@lists.sf.net">ltp-results@lists.sf.net</a>,
and patches, new tests, bugs or comments/questions to <a
 class="moz-txt-link-abbreviated" href="mailto:ltp-list@lists.sf.net">ltp-list@lists.sf.net</a>,
<br>
<a class="moz-txt-link-freetext"
 href="http://sourceforge.net/tracker/?func=add&amp;group_id=3382&amp;atid=103382">http://sourceforge.net/tracker/?func=add&amp;group_id=3382&amp;atid=103382</a>
(for New Bug(s)),
<br>
<a class="moz-txt-link-freetext"
 href="http://sourceforge.net/tracker/?func=add&amp;group_id=3382&amp;atid=303382">http://sourceforge.net/tracker/?func=add&amp;group_id=3382&amp;atid=303382</a>
(for New Patch(s)),
<br>
<a class="moz-txt-link-freetext"
 href="http://sourceforge.net/tracker/?func=add&amp;group_id=3382&amp;atid=353382">http://sourceforge.net/tracker/?func=add&amp;group_id=3382&amp;atid=353382</a>
(for New Feature Request(s))
<br>
<br>
Please also see the ChangeLog Below (JULY 2007):
<br>
<br>
1)&nbsp; Log Message: lcov: preparations for new release by
<a class="moz-txt-link-rfc2396E"
 href="mailto:oberpapr@users.sourceforge.net">"oberpapr@users.sourceforge.net"</a><br>
- updated CHANGES file<br>
- added compat-libtool + no-compat-libtool option<br>
- changed libtool default to on (due to popular request)<br>
- added checksum option<br>
- changed checksum default to off (to reduce cpu time + file size)<br>
- added geninfo_checksum option to lcovrc, deprecated
geninfo_no_checksum<br>
- added geninfo_compat_libtool option to lcovrc<br>
- minor update of README file <br>
File(s) Affected:<br>
ltp/utils/analysis/lcov/CHANGES<br>
ltp/utils/analysis/lcov/README<br>
ltp/utils/analysis/lcov/lcovrc<br>
ltp/utils/analysis/lcov/bin/geninfo<br>
ltp/utils/analysis/lcov/bin/lcov<br>
<br>
2)&nbsp; Log Message: update manpage by <a class="moz-txt-link-rfc2396E"
 href="mailto:oberpapr@users.sourceforge.net">"oberpapr@users.sourceforge.net"</a><br>
File(s) Affected:<br>
ltp/utils/analysis/lcov/man/lcov.1<br>
<br>
3)&nbsp; Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:sachinp@in.ibm.com">"sachinp@in.ibm.com"</a> has fixed a
probe point
definition from 'll_rw_lock' to 'll_rw_block' <br>
File(s) Affected:<br>
ltp/testcases/kdump/susetools/lkdtm_mod/lkdtm.c<br>
<br>
4)&nbsp; Log Message: man page update by <a class="moz-txt-link-rfc2396E"
 href="mailto:oberpapr@users.sourceforge.net">"oberpapr@users.sourceforge.net"</a><br>
File(s) Affected:<br>
ltp/utils/analysis/lcov/man/genhtml.1<br>
ltp/utils/analysis/lcov/man/geninfo.1<br>
ltp/utils/analysis/lcov/man/lcov.1<br>
<br>
5)&nbsp; Log Message: lcov: another update in preparation for a new release
by <a class="moz-txt-link-rfc2396E"
 href="mailto:oberpapr@users.sourceforge.net">"oberpapr@users.sourceforge.net"</a><br>
File(s) Affected:<br>
ltp/utils/analysis/lcov/bin/lcov<br>
ltp/utils/analysis/lcov/man/lcovrc.5<br>
ltp/utils/analysis/lcov/CHANGES<br>
ltp/utils/analysis/lcov/lcovrc<br>
<br>
6)&nbsp; Log Message: fixed bug that would not delete .gcda files when using
-z, by <a class="moz-txt-link-rfc2396E"
 href="mailto:oberpapr@users.sourceforge.net">"oberpapr@users.sourceforge.net"</a><br>
File(s) Affected:<br>
ltp/utils/analysis/lcov/CHANGES<br>
ltp/utils/analysis/lcov/bin/lcov<br>
<br>
7)&nbsp; Log Message: lcov: - add new option --initial to get zero coverage
data from graph files by <a class="moz-txt-link-rfc2396E"
 href="mailto:oberpapr@users.sourceforge.net">"oberpapr@users.sourceforge.net"</a><br>
File(s) Affected:<br>
ltp/utils/analysis/lcov/CHANGES<br>
ltp/utils/analysis/lcov/bin/geninfo<br>
ltp/utils/analysis/lcov/bin/lcov<br>
ltp/utils/analysis/lcov/man/geninfo.1<br>
ltp/utils/analysis/lcov/man/lcov.1<br>
<br>
8)&nbsp; Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:carmelo.amoroso@st.com">"carmelo.amoroso@st.com"</a>
fixed the anomaly when "SHLBA
!= getpagesize()", like in SH architecture <br>
File(s) Affected:<br>
ltp/testcases/kernel/mem/shmt/shmt09.c<br>
<br>
9)&nbsp; Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:hdeller@users.sf.net">"hdeller@users.sf.net"</a> fixed
unitialized variable
useage in "lseek09" testcase<br>
File(s) Affected:<br>
ltp/testcases/kernel/syscalls/lseek/lseek09.c<br>
<br>
10) Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:naveenspen@gmail.com">"naveenspen@gmail.com"</a> pointed
out that
syslog_cmd="/etc/init.d/syslog" should be used irrespective of any
Distro<br>
File(s) Affected:<br>
ltp/testcases/kernel/syscalls/syslog/syslog01<br>
ltp/testcases/kernel/syscalls/syslog/syslog02<br>
ltp/testcases/kernel/syscalls/syslog/syslog03<br>
ltp/testcases/kernel/syscalls/syslog/syslog04<br>
ltp/testcases/kernel/syscalls/syslog/syslog05<br>
ltp/testcases/kernel/syscalls/syslog/syslog06<br>
ltp/testcases/kernel/syscalls/syslog/syslog07<br>
ltp/testcases/kernel/syscalls/syslog/syslog08<br>
ltp/testcases/kernel/syscalls/syslog/syslog09<br>
ltp/testcases/kernel/syscalls/syslog/syslog10<br>
<br>
11) Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:rsalveti@linux.vnet.ibm.com">"rsalveti@linux.vnet.ibm.com"</a>
pointed out to have same
"fsx-linux" testcase for "fs", "ltp-aiodio" and "nfs"<br>
File(s) Affected:<br>
ltp/testcases/kernel/io/ltp-aiodio/fsx-linux.c<br>
ltp/testcases/network/nfs/fsx-linux/fsx-linux.c<br>
<br>
12) Log Message: Randy Dunlap writes: Fix printf format warnings<br>
File(s) Affected:<br>
ltp/testcases/network/stress/ns-tools/Makefile<br>
ltp/testcases/network/stress/ns-tools/ns-igmp_querier.c<br>
ltp/testcases/network/stress/ns-tools/ns-mcast_join.c<br>
ltp/testcases/network/stress/ns-tools/ns-mcast_receiver.c<br>
ltp/testcases/network/stress/ns-tools/ns-tcpserver.c<br>
<br>
13) Log Message: getsockopt() takes a socklen_t, not an int, as its
optlen<br>
File(s) Affected:<br>
ltp/testcases/network/stress/ns-tools/ns-tcpclient.c<br>
ltp/testcases/network/stress/ns-tools/ns-tcpserver.c<br>
ltp/testcases/network/stress/ns-tools/ns-udpserver.c<br>
<br>
14) Log Message: cleanup file<br>
File(s) Affected:<br>
ltp/testcases/kernel/syscalls/gethostid/gethostid01.c<br>
<br>
15) Log Message: back out uclinux changes to something that doesnt spit
warnings as reported by Randy Dunlap<br>
File(s) Affected:<br>
ltp/testcases/kernel/syscalls/gethostid/gethostid01.c<br>
<br>
16) Log Message: fixup gcc warnings by removing silly pieces of code<br>
File(s) Affected:<br>
ltp/testcases/kernel/mem/mtest06/mmap1.c<br>
ltp/testcases/kernel/mem/mtest06/mmap2.c<br>
ltp/testcases/kernel/mem/mtest06/mmap3.c<br>
ltp/testcases/kernel/mem/mtest06/shmat1.c<br>
<br>
17) Log Message: Randy Dunlap writes: Convert mmap1 to use standard
test results output format. Correct several typos. <br>
File(s) Affected:<br>
ltp/testcases/kernel/mem/mtest06/Makefile<br>
ltp/testcases/kernel/mem/mtest06/mmap1.c<br>
<br>
18) Log Message: gcov-kernel: adding gcov-kernel patch for 2.6.22<br>
File(s) Addes:<br>
ltp/utils/analysis/gcov-kernel/linux-2.6.22-gcov-arm-hack.patch<br>
ltp/utils/analysis/gcov-kernel/linux-2.6.22-gcov.patch<br>
<br>
19) Log Message: [1754301] Helge Deller writes: mark hppa/parisc as
expecting a segv as well<br>
File(s) Affected:<br>
ltp/testcases/kernel/syscalls/mmap/mmap03.c<br>
<br>
20) Log Message: Randy Dunlap writes: convert output to match the
standard LTP output<br>
File(s) Affected:<br>
ltp/testcases/kernel/fs/linktest/linktest.pl<br>
<br>
21) Log Message: close stdout to remove noise<br>
File(s) Affected:<br>
ltp/testcases/kernel/mem/mtest05/dummy.c<br>
<br>
22) Log Message: Randy Dunlap writes: Convert mmstress to use the
standard results format<br>
File(s) Affected:<br>
ltp/testcases/kernel/mem/mtest05/Makefile<br>
ltp/testcases/kernel/mem/mtest05/mmstress.c<br>
<br>
23) Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:rsalveti@linux.vnet.ibm.com">"rsalveti@linux.vnet.ibm.com"</a>
updated the contact
information at ltp-howto doc<br>
File(s) Affected:<br>
ltp/doc/ltp-howto.lyx<br>
ltp/doc/ltp-howto.txt<br>
<br>
24) Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:rsalveti@linux.vnet.ibm.com">"rsalveti@linux.vnet.ibm.com"</a>
wants to update this
with kernel/fs/fsstress/fsstress.c <br>
File(s) Affected:<br>
ltp/testcases/network/nfs/nfs_fsstress/fsstress.c<br>
<br>
25) Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:suzuki@in.ibm.com">"suzuki@in.ibm.com"</a> added SIGNAL
and Address Fault
handling capability for all architectures <br>
File(s) Affected:<br>
ltp/testcases/kernel/mem/mtest06/mmap1.c<br>
<br>
26) Log Message: <a class="moz-txt-link-rfc2396E"
 href="mailto:rsalveti@linux.vnet.ibm.com">"rsalveti@linux.vnet.ibm.com"</a>
added more options to
'runltp'<br>
File(s) Affected:<br>
ltp/runltp<br>
ltp/doc/man1/pan.1<br>
ltp/pan/pan.c<br>
<br>
27) Log Message: Upgrade to Posix Testsuite 1.5.2<br>
File(s) Affected/Added:<br>
ltp/testcases/open_posix_testsuite<br>
<br>
28) Log Message: Fixing Proper Freeing of Memory Chunks<br>
File(s) Affected:<br>
ltp/tools/genload/stress.c<br>
<br>
Happy testing,
<br>
Regards--
<br>
Subrata Modak,
<br>
<br>
</div>
</body>
</html>

--------------070904060509080209020808--


--===============0509950419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0509950419==--


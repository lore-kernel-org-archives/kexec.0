Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ID549-0003Zk-Co
	for kexec@lists.infradead.org; Mon, 23 Jul 2007 17:03:42 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6NL3dxH007797
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 17:03:39 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	l6NL3dNk022297
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 17:03:39 -0400
Received: from redhat.com (crash.boston.redhat.com [172.16.80.17])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l6NL3dlT031187
	for <kexec@lists.infradead.org>; Mon, 23 Jul 2007 17:03:39 -0400
Message-ID: <46A518C6.5070108@redhat.com>
Date: Mon, 23 Jul 2007 17:08:22 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Determine version of kernel that produced vmcore 
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
To: kexec@lists.infradead.org



 > From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
...
 >
 > BTW, we should test makedumpfile by each linux(-rc1 ?) releases.
 > Now, I test the makedumpfile functions by comparing the crash utility's
 > output of /proc/vmcore and the one of the filtered dumpfile.
 > Often, the crash utility cannot read /proc/vmcore of the latest kernel.
 > Does anybody know the crash's option that the crash can run loosely for
 > the early test ?

There is no "loosely-run" option for the crash utility.

When you state "cannot read /proc/vmcore", I'm presuming that
you mean that something fails during initialization due to
the "shifting sands" of the upstream kernel (and which should
be reported to the crash-utility list so that it can be
addressed...)

There are a couple debug-only options that prevent crash from
accessing certain subsystems during initialization, such as
"--no_kmem_cache" to avoid traversing the kmalloc/slab subsystem,
and "--no_modules" to avoid traversing the vmalloc'd module list.
Those two may help if you have an "incomplete" dumpfile that is
missing pages that *should* be there.  There's also a "-f" to
force the use of split vmlinux/vmlinux.debug pair whose CRC's
do not match.  But if you're using a simple -g build vmlinux
files, that option wouldn't apply.

Dave

 >
 > Thanks
 > Ken'ichi Ohmichi






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

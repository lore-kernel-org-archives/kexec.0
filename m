Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Mtj3H-0007FA-T5
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 14:24:12 +0000
Date: Fri, 2 Oct 2009 10:24:05 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <394279530.1283331254493445641.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <667155093.1283251254493414370.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_57536_1495352853.1254493445639"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: CAI Qian <caiqian@redhat.com>
Cc: oomichi@mxs.nes.nec.co.jp, nhorman@redhat.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp

------=_Part_57536_1495352853.1254493445639
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


----- "Dave Anderson" <anderson@redhat.com> wrote:

> ----- "CAI Qian" <caiqian@redhat.com> wrote:
> 
> > From: CAI Qian <caiqian@redhat.com>
> > Subject: Re: Can't exclude unnecessary pages for 2.6.31 Kernel
> > Date: Fri, 02 Oct 2009 19:26:44 +0800 (CST)
> >
> > > Cced the crash utility maintainer.
> > >
> > > BZ filed -- https://bugzilla.redhat.com/show_bug.cgi?id=526749
> > >
> > >> It does make -d 16 works without errors. However, the crash utility
> > >> failed to read it (the log attached), but the full VMCore is working
> > >> fine there.
> > >>
> > >> crash: page excluded: kernel virtual address: ffffffff819f1764 type: "tss_struct ist array"
> >
> 
> I believe that the "tss_struct" issue is a crash bug if in fact it works
> OK with a full vmcore.  I'll look at the vmlinux/vmcores from the BZ.

Definitely a crash utility bug -- I'll fix it in the next upstream release.

Dave


------=_Part_57536_1495352853.1254493445639
Content-Type: text/x-patch; name=tss.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=tss.patch

Index: x86_64.c
===================================================================
RCS file: /nfs/projects/cvs/crash/x86_64.c,v
retrieving revision 1.126
diff -u -r1.126 x86_64.c
--- x86_64.c	14 Sep 2009 20:09:01 -0000	1.126
+++ x86_64.c	2 Oct 2009 14:14:33 -0000
@@ -860,7 +860,7 @@
 				break;
 		}
 	} else if (symbol_exists("per_cpu__init_tss")) {
-		for (c = 0; c < NR_CPUS; c++) {
+		for (c = 0; c < kt->cpus; c++) {
                 	if ((kt->flags & SMP) && (kt->flags & PER_CPU_OFF)) {
 				if (kt->__per_cpu_offset[c] == 0)
 					break;

------=_Part_57536_1495352853.1254493445639
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

------=_Part_57536_1495352853.1254493445639--


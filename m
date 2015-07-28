Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZK0Q2-0004sR-LP
 for kexec@lists.infradead.org; Tue, 28 Jul 2015 08:39:27 +0000
Date: Tue, 28 Jul 2015 10:39:04 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Enable compressed dump formats for Xen
Message-ID: <20150728103904.0774f5d4@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DD2A68@BPXM01GP.gisp.nec.co.jp>
References: <20150723124321.7d8406c0@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DD2A05@BPXM01GP.gisp.nec.co.jp>
 <20150728095953.6c142dd5@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701DD2A68@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: kexec@lists.infradead.org

On Tue, 28 Jul 2015 08:12:02 +0000
Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:

>[...]
> >> BTW, I think we should fix the manuals as well. There are some wrong
> >> statements "-E option must be specified with this option" and
> >> some examples implicate that -E option is necessary to Xen dump.
> >
> >Good point. Should I send it as a separate patch, or include it in a
> >patch set and resend?
> 
> I prefer a separate patch, but I don't mind either way.

OK, here you go:

Remove notes about ELF being the only available format for Xen dumps

Since Xen dumps can now be stored in compressed formats, adjust documentation
that claims the opposite.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>

---
 makedumpfile.8 |    5 +----
 print_info.c   |    4 ++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 2d38cd0..3f66d73 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -16,7 +16,7 @@ makedumpfile \- make a small dumpfile of kdump
 .br
 \fBmakedumpfile\fR \-g \fIVMCOREINFO\fR \-x \fIVMLINUX\fR
 .br
-\fBmakedumpfile\fR \-E [\-\-xen-syms \fIXEN-SYMS\fR|\-\-xen-vmcoreinfo \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
+\fBmakedumpfile\fR    [\fIOPTION\fR] [\-\-xen-syms \fIXEN-SYMS\fR|\-\-xen-vmcoreinfo \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE\fR
 .br
 \fBmakedumpfile\fR \-\-dump-dmesg [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fILOGFILE\fR
 .br
@@ -441,7 +441,6 @@ This option is mainly for debugging.
 \fB\-\-xen-syms\fR \fIXEN-SYMS\fR
 Specify the \fIXEN-SYMS\fR with debug information to analyze the xen's memory usage.
 This option extracts the part of xen and domain-0.
-\-E option must be specified with this option.
 .br
 .B Example:
 .br
@@ -453,7 +452,6 @@ Specify \fIVMCOREINFO\fR instead of \fIXEN-SYMS\fR for analyzing the xen's memor
 .br
 \fIVMCOREINFO\fR should be made beforehand by makedumpfile with \-g option, and
 it contains the xen's information.
-\-E option must be specified with this option.
 .br
 .B Example:
 .br
@@ -464,7 +462,6 @@ it contains the xen's information.
 Exclude all the user domain pages from Xen kdump's \fIVMCORE\fR, and extracts the
 part of xen and domain-0. If \fIVMCORE\fR contains \fIVMCOREINFO\fR for Xen, it is
 not necessary to specify \fI\-\-xen-syms\fR and \fI\-\-xen-vmcoreinfo\fR.
-\-E option must be specified with this option.
 .br
 .B Example:
 .br
diff --git a/print_info.c b/print_info.c
index 9c36bec..4857b39 100644
--- a/print_info.c
+++ b/print_info.c
@@ -87,10 +87,10 @@ print_usage(void)
 	MSG("\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE of Xen:\n");
-	MSG("  # makedumpfile -E [--xen-syms XEN-SYMS|--xen-vmcoreinfo VMCOREINFO] VMCORE DUMPFILE\n");
+	MSG("  # makedumpfile [-c|-l|-p|-E] [--xen-syms XEN-SYMS|--xen-vmcoreinfo VMCOREINFO] VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Filtering domain-0 of Xen:\n");
-	MSG("  # makedumpfile -E -d DL -x vmlinux VMCORE DUMPFILE\n");
+	MSG("  # makedumpfile [-c|-l|-p|-E] -d DL -x vmlinux VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Generating VMCOREINFO of Xen:\n");
 	MSG("  # makedumpfile -g VMCOREINFO --xen-syms XEN-SYMS\n");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

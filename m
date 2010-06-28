Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OT5dw-0007Bs-Kj
	for kexec@lists.infradead.org; Mon, 28 Jun 2010 04:08:26 +0000
Date: Mon, 28 Jun 2010 13:01:13 +0900 (JST)
Message-Id: <20100628.130113.166830409.igawa@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] add missing options to the --help output
From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
In-Reply-To: <20100622.171909.16259691.igawa@mxs.nes.nec.co.jp>
References: <1414379256.643411277182628954.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1205413910.643441277182670290.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100622.171909.16259691.igawa@mxs.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: caiqian@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Hi, CAI.

From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] add missing options to the --help output
Date: Tue, 22 Jun 2010 17:19:09 +0900 (JST)
> Thank you for your patch.
> I'll check it.

I've changed your patch for adding other options and fixing the format.
I'll merge and push this patch.

If you have questions or comments, please let me know that.

====
commit ea35b5782aea1fc1d8d521cb19c7467f5ab0e8cb
Author: caiqian@redhat.com <caiqian@redhat.com>
Date:   Tue Jun 22 00:57:50 2010 -0400

    add missing options to the --help output
    
    It tries to keep --help output and manpage in sync.
    
    Signed-off-by: CAI Qian <caiqian@redhat.com>
    Signed-off-by: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>

diff --git a/makedumpfile.c b/makedumpfile.c
index 89360bd..7ad6199 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -622,9 +622,19 @@ print_usage(void)
 	MSG("  Rearranging the dump data in the flattened format to a readable DUMPFILE:\n");
 	MSG("  # makedumpfile -R DUMPFILE\n");
 	MSG("\n");
+	MSG("  Split the dump data to multiple DUMPFILEs in parallel:\n");
+	MSG("  # makedumpfile --split [OPTION] [-x VMLINUX|-i VMCOREINFO] VMCORE DUMPFILE1\\\n");
+	MSG("    DUMPFILE2 DUMPFILE3 ..\n");
+	MSG("\n");
+	MSG("  Reassemble multiple DUMPFILEs:\n");
+	MSG("  # makedumpfile --reassemble DUMPFILE1 DUMPFILE2 [DUMPFILE3 ..] DUMPFILE\\\n");
+	MSG("\n");
 	MSG("  Generating VMCOREINFO:\n");
 	MSG("  # makedumpfile -g VMCOREINFO -x VMLINUX\n");
 	MSG("\n");
+	MSG("  Extracting the dmesg log from a VMCORE:\n");
+	MSG("  # makedumpfile --dump-dmesg [-x VMLINUX|-i VMCOREINFO] VMCORE LOGFILE\n");
+	MSG("\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE of Xen:\n");
 	MSG("  # makedumpfile -E [--xen-syms XEN-SYMS|--xen-vmcoreinfo VMCOREINFO] VMCORE DUMPFILE\n");
@@ -673,8 +683,9 @@ print_usage(void)
 	MSG("      Specify VMCOREINFO instead of VMLINUX for analyzing the first kernel's\n");
 	MSG("      memory usage.\n");
 	MSG("      VMCOREINFO should be made beforehand by makedumpfile with -g option,\n");
-	MSG("      and it contains the first kernel's information. If Dump_Level is 2 or\n");
-	MSG("      more and [-x VMLINUX] is not specified, this option is necessary.\n");
+	MSG("      and it contains the first kernel's information. This option is necessary\n");
+	MSG("      if VMCORE does not contain VMCOREINFO, [-x VMLINUX] is not specified,\n");
+	MSG("      and dump_level is 2 or more.\n");
 	MSG("\n");
 	MSG("  [-g VMCOREINFO]:\n");
 	MSG("      Generate VMCOREINFO from the first kernel's VMLINUX.\n");
@@ -694,6 +705,18 @@ print_usage(void)
 	MSG("      Rearrange the dump data in the flattened format from the standard input\n");
 	MSG("      to a readable DUMPFILE.\n");
 	MSG("\n");
+	MSG("  [--split]:\n");
+	MSG("      Split the dump data to multiple DUMPFILEs in parallel. If specifying\n");
+	MSG("      DUMPFILEs on different storage devices, a device can share I/O load with\n");
+	MSG("      other devices and it reduces time for saving the dump data. The file size\n");
+	MSG("      of each DUMPFILE is smaller than the system memory size which is divided\n");
+	MSG("      by the number of DUMPFILEs.\n");
+	MSG("      This feature supports only the kdump-compressed format.\n");
+	MSG("\n");
+	MSG("  [--reassemble]:\n");
+	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
+	MSG("      into one DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile.\n");
+	MSG("\n");
 	MSG("  [--xen-syms XEN-SYMS]:\n");
 	MSG("      Specify the XEN-SYMS to analyze Xen's memory usage.\n");
 	MSG("\n");
@@ -735,6 +758,13 @@ print_usage(void)
 	MSG("      of virtual address. If specifing the VIRTUAL_ADDRESS, its physical\n");
 	MSG("      address is printed.\n");
 	MSG("\n");
+	MSG("  [--dump-dmesg]:\n");
+	MSG("      This option overrides the normal behavior of makedumpfile. Instead of\n");
+	MSG("      compressing and filtering a VMCORE to make it smaller, it simply\n");
+	MSG("      extracts the dmesg log from a VMCORE and writes it to the specified\n");
+	MSG("      LOGFILE. If a VMCORE does not contain VMCOREINFO for dmesg, it is\n");
+	MSG("      necessary to specfiy [-x VMLINUX] or [-i VMCOREINFO].\n");
+	MSG("\n");
 	MSG("  [-D]:\n");
 	MSG("      Print debugging message.\n");
 	MSG("\n");
@@ -744,6 +774,10 @@ print_usage(void)
 	MSG("  [-h]:\n");
 	MSG("      Show help message.\n");
 	MSG("\n");
+	MSG("  [-b <order>]\n");
+	MSG("      Specify the cache 2^order pages in ram when generating vmcore info\n");
+	MSG("      before writing to output\n");
+	MSG("\n");
 	MSG("  [-v]:\n");
 	MSG("      Show the version of makedumpfile.\n");
 	MSG("\n");
====


Thanks.
-- Masayuki Igawa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

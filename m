Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]
	helo=mx02.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OQvYX-0001Ry-KJ
	for kexec@lists.infradead.org; Tue, 22 Jun 2010 04:57:54 +0000
Date: Tue, 22 Jun 2010 00:57:50 -0400 (EDT)
From: caiqian@redhat.com
Message-ID: <1205413910.643441277182670290.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1414379256.643411277182628954.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: [PATCH] add missing options to the --help output
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30747_1709165626.1277182670289"
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
To: kexec@lists.infradead.org
Cc: oomichi@mxs.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp

------=_Part_30747_1709165626.1277182670289
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

It tries to keep --help output and manpage in sync.

Signed-off-by: CAI Qian <caiqian@redhat.com>
------=_Part_30747_1709165626.1277182670289
Content-Type: text/x-patch; name=help.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=help.patch

diff --git a/makedumpfile.c b/makedumpfile.c
index 8a90baa..8467fb9 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -694,6 +694,18 @@ print_usage(void)
 	MSG("      Rearrange the dump data in the flattened format from the standard input\n");
 	MSG("      to a readable DUMPFILE.\n");
 	MSG("\n");
+	MSG("  [--split]:\n");
+	MSG("      Split the dump data to multiple DUMPFILEs in parallel. If specifying DUMPFILEs\n");
+	MSG("      on different storage devices, a device can share I/O  load  with  other devices\n");
+	MSG("      and it reduces time for saving the dump data. The file size of each DUMPFILE is\n");
+	MSG("      smaller than the system memory size which is divided by the number of DUMPFILEs.\n");
+	MSG("      This feature supports only the kdump-compressed format.\n");
+	MSG("\n");
+	MSG("  [--reassemble]:\n");
+	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option, into one\n");
+	MSG("      DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile on the following\n");
+	MSG("      example.\n");
+	MSG("\n");
 	MSG("  [--xen-syms XEN-SYMS]:\n");
 	MSG("      Specify the XEN-SYMS to analyze Xen's memory usage.\n");
 	MSG("\n");
@@ -735,6 +747,13 @@ print_usage(void)
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
@@ -744,6 +763,10 @@ print_usage(void)
 	MSG("  [-h]:\n");
 	MSG("      Show help message.\n");
 	MSG("\n");
+	MSG("  [-b <order>]\n");
+	MSG("      cache 2^order pages in ram when generating vmcore info before writing to\n");
+	MSG("      output\n");
+	MSG("\n");
 	MSG("  [-v]:\n");
 	MSG("      Show the version of makedumpfile.\n");
 	MSG("\n");

------=_Part_30747_1709165626.1277182670289
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

------=_Part_30747_1709165626.1277182670289--


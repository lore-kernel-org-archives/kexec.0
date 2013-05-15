Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcggZ-0007ro-LM
 for kexec@lists.infradead.org; Wed, 15 May 2013 18:44:24 +0000
Subject: [PATCH] makedumpfile: warn on vmlinux without dwarf
Message-Id: <E1UcggB-0005hQ-Gr@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Wed, 15 May 2013 13:43:59 -0500
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

From: Cliff Wickman <cpw@sgi.com>

If the vmlinux does not have dwarf information makedumpfile fails in
a rather obscure way, with a flood of redundant errors,

Make it fail with more of a hint of what is wrong.

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 dwarf_info.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: makedumpfile.mmap/dwarf_info.c
===================================================================
--- makedumpfile.mmap.orig/dwarf_info.c
+++ makedumpfile.mmap/dwarf_info.c
@@ -139,6 +139,10 @@ process_module (Dwfl_Module *dwflmod,
 
 	/* get a debug context descriptor.*/
 	dwarf_info.dwarfd = dwfl_module_getdwarf (dwflmod, &dwbias);
+	if (dwarf_info.dwarfd == NULL) {
+		fprintf(stderr, "makedumpfile: dwfl_module_getdwarf error\n");
+		exit(1);
+	}
 	dwarf_info.elfd = dwarf_getelf(dwarf_info.dwarfd);
 
 	mod_name = dwfl_module_info(dwflmod, NULL, NULL, NULL, NULL, NULL,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wa4ehsobe003.messaging.microsoft.com ([216.32.181.13]
	helo=WA4EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MIrhi-00062n-GM
	for kexec@lists.infradead.org; Mon, 22 Jun 2009 22:09:44 +0000
Message-ID: <4A4000F1.8040908@am.sony.com>
Date: Mon, 22 Jun 2009 15:08:49 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: [patch] kexec: Fix printed symbol value
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Move the print statement so that the variable
value has been assigned before its value is
printed.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
index 74c4b35..1d3e22c 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -402,13 +402,13 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 			else {
 				sec_base = ehdr->e_shdr[sym.st_shndx].sh_addr;
 			}
+			value = sym.st_value;
+			value += sec_base;
+			value += rel.r_addend;
 #ifdef DEBUG
 			fprintf(stderr, "sym: %s value: %lx addr: %lx\n",
 				name, value, address);
 #endif
-			value = sym.st_value;
-			value += sec_base;
-			value += rel.r_addend;
 			machine_apply_elf_rel(ehdr, rel.r_type,
 				(void *)location, address, value);
 		}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

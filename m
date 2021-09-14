Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPzVp-00467V-LD
 for kexec@lists.infradead.org; Tue, 14 Sep 2021 03:53:39 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH v2 5/5] multiboot2: Accept x86-64 images
Date: Mon, 13 Sep 2021 20:51:42 -0700
Message-Id: <20210914035142.251818-6-hello@zhaofeng.li>
In-Reply-To: <20210914035142.251818-1-hello@zhaofeng.li>
References: <20210914035142.251818-1-hello@zhaofeng.li>
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
To: kexec@lists.infradead.org
Cc: Zhaofeng Li <hello@zhaofeng.li>, Simon Horman <horms@verge.net.au>

Signed-off-by: Zhaofeng Li <hello@zhaofeng.li>
---
 kexec/arch/i386/kexec-mb2-x86.c  | 6 ++++--
 kexec/arch/x86_64/kexec-x86_64.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
index f3e6b38..36fef20 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -76,8 +76,10 @@ int multiboot2_x86_probe(const char *buf, off_t buf_len)
 /* Is it a good idea to try booting this file? */
 {
 	int i, len;
-	/* First of all, check that this is an ELF file */
-	if ((i=elf_x86_probe(buf, buf_len)) < 0)
+
+	/* First of all, check that this is an ELF file for either x86 or x86-64 */
+	i = elf_x86_any_probe(buf, buf_len, CORE_TYPE_UNDEF);
+	if (i < 0)
 		return i;
 
 	/* Now look for a multiboot header. */
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index 394cfca..ffd84f0 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -33,11 +33,11 @@
 #include <arch/options.h>
 
 struct file_type file_type[] = {
+	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
+	  multiboot2_x86_usage },
 	{ "elf-x86_64", elf_x86_64_probe, elf_x86_64_load, elf_x86_64_usage },
 	{ "multiboot-x86", multiboot_x86_probe, multiboot_x86_load,
 	  multiboot_x86_usage },
-	{ "multiboot2-x86", multiboot2_x86_probe, multiboot2_x86_load,
-	  multiboot2_x86_usage },
 	{ "elf-x86", elf_x86_probe, elf_x86_load, elf_x86_usage },
 	{ "bzImage64", bzImage64_probe, bzImage64_load, bzImage64_usage },
 	{ "bzImage", bzImage_probe, bzImage_load, bzImage_usage },
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

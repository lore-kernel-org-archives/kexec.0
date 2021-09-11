Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOt5i-00EAjh-Q5
 for kexec@lists.infradead.org; Sat, 11 Sep 2021 02:50:08 +0000
From: Zhaofeng Li <hello@zhaofeng.li>
Subject: [PATCH 1/3] multiboot2: Correct MBI size calculation
Date: Fri, 10 Sep 2021 19:48:58 -0700
Message-Id: <20210911024900.1899877-2-hello@zhaofeng.li>
In-Reply-To: <20210911024900.1899877-1-hello@zhaofeng.li>
References: <20210911024900.1899877-1-hello@zhaofeng.li>
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

tag_load_base_addr is dependent on rel_tag, and tag_framebuffer was
not accounted for.

Signed-off-by: Zhaofeng Li <hello@zhaofeng.li>
---
 kexec/arch/i386/kexec-mb2-x86.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/kexec-mb2-x86.c b/kexec/arch/i386/kexec-mb2-x86.c
index b4996bc..c10c0ef 100644
--- a/kexec/arch/i386/kexec-mb2-x86.c
+++ b/kexec/arch/i386/kexec-mb2-x86.c
@@ -115,17 +115,24 @@ void multiboot2_x86_usage(void)
 static size_t
 multiboot2_get_mbi_size(int ranges, int cmdline_size, int modcount, int modcmd_size)
 {
-	return (2 * sizeof (uint32_t) + sizeof (struct multiboot_tag)
-		+ sizeof (struct multiboot_tag)
+	size_t mbi_size = (2 * sizeof (uint32_t) /* u32 total_size, u32 reserved */
 		+ ALIGN_UP (sizeof (struct multiboot_tag_basic_meminfo), MULTIBOOT_TAG_ALIGN)
 		+ ALIGN_UP ((sizeof (struct multiboot_tag_mmap)
 			+ ranges * sizeof (struct multiboot_mmap_entry)), MULTIBOOT_TAG_ALIGN)
-		+ ALIGN_UP (sizeof (struct multiboot_tag_load_base_addr), MULTIBOOT_TAG_ALIGN)
 		+ (sizeof (struct multiboot_tag_string)
 			+ ALIGN_UP (cmdline_size, MULTIBOOT_TAG_ALIGN))
 		+ (sizeof (struct multiboot_tag_string)
 			+ ALIGN_UP (strlen(BOOTLOADER " " BOOTLOADER_VERSION) + 1, MULTIBOOT_TAG_ALIGN))
-		+ (modcount * sizeof (struct multiboot_tag_module) + modcmd_size));
+		+ (modcount * sizeof (struct multiboot_tag_module) + modcmd_size))
+		+ sizeof (struct multiboot_tag); /* end tag */
+
+	if (mhi.rel_tag) mbi_size +=
+		  ALIGN_UP (sizeof (struct multiboot_tag_load_base_addr), MULTIBOOT_TAG_ALIGN);
+
+	if (mhi.fb_tag) mbi_size +=
+		  ALIGN_UP (sizeof (struct multiboot_tag_framebuffer), MULTIBOOT_TAG_ALIGN);
+
+	return mbi_size;
 }
 
 static void multiboot2_read_header_tags(void)
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

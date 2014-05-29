Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [119.145.14.65] (helo=szxga02-in.huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpweC-0005rC-8O
 for kexec@lists.infradead.org; Thu, 29 May 2014 09:29:17 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 2/2] kexec-tools: add --page-offset option for ARM
Date: Thu, 29 May 2014 17:20:03 +0800
Message-ID: <1401355203-63794-3-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1401355203-63794-1-git-send-email-wangnan0@huawei.com>
References: <1401355203-63794-1-git-send-email-wangnan0@huawei.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>, Wang Nan <wangnan0@huawei.com>

When KALLSYMS is disabled or /proc is not mounted, this patch allows
--page-offset cmdline option for user to setup correct page_offset.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 kexec/arch/arm/crashdump-arm.c        | 17 ++++++++++++++++-
 kexec/arch/arm/include/arch/options.h |  4 +++-
 kexec/arch/arm/kexec-zImage-arm.c     |  7 +++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index e6ff3e0..d124974 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -60,6 +60,7 @@ static struct crash_elf_info elf_info = {
 };
 
 unsigned long phys_offset;
+extern unsigned long long user_page_offset;
 
 /* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
 static unsigned long long get_kernel_stext_sym(void)
@@ -95,10 +96,24 @@ static int get_kernel_page_offset(struct kexec_info *info,
 {
 	unsigned long long stext_sym_addr = get_kernel_stext_sym();
 	if (stext_sym_addr == 0) {
+		if (user_page_offset != (-1ULL)) {
+			elf_info->page_offset = user_page_offset;
+			dbgprintf("Unable to get _stext symbol from /proc/kallsyms, "
+					"use user provided vaule: %llx\n",
+					elf_info->page_offset);
+			return 0;
+		}
 		elf_info->page_offset = (unsigned long long)DEFAULT_PAGE_OFFSET;
-		dbgprintf("Unable to get _stext symbol from /proc/kallsyms, use default: %llx\n",
+		dbgprintf("Unable to get _stext symbol from /proc/kallsyms, "
+				"use default: %llx\n",
 				elf_info->page_offset);
 		return 0;
+	} else if ((user_page_offset != (-1ULL)) &&
+			(user_page_offset != stext_sym_addr)) {
+		fprintf(stderr, "PAGE_OFFSET is set to %llx "
+				"instead of user provided value %llx\n",
+				stext_sym_addr & (~KVBASE_MASK),
+				user_page_offset);
 	}
 	elf_info->page_offset = stext_sym_addr & (~KVBASE_MASK);
 	dbgprintf("page_offset is set to %llx\n", elf_info->page_offset);
diff --git a/kexec/arch/arm/include/arch/options.h b/kexec/arch/arm/include/arch/options.h
index b68b746..6437c7d 100644
--- a/kexec/arch/arm/include/arch/options.h
+++ b/kexec/arch/arm/include/arch/options.h
@@ -8,6 +8,7 @@
 #define OPT_DTB		(OPT_ARCH_MAX+0)
 #define OPT_ATAGS	(OPT_ARCH_MAX+1)
 #define OPT_IMAGE_SIZE	(OPT_ARCH_MAX+2)
+#define OPT_PAGE_OFFSET	(OPT_ARCH_MAX+3)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -39,7 +40,8 @@
 	{ "ramdisk",		1, 0, OPT_RAMDISK },	\
 	{ "dtb",		1, 0, OPT_DTB }, 	\
 	{ "atags",		0, 0, OPT_ATAGS },	\
-	{ "image-size",		1, 0, OPT_IMAGE_SIZE },
+	{ "image-size",		1, 0, OPT_IMAGE_SIZE }, \
+	{ "page-offset",	1, 0, OPT_PAGE_OFFSET },
 
 #define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR "a:r:s:"
 
diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index bc99e79..44b87bb 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -25,6 +25,7 @@
 
 off_t initrd_base = 0, initrd_size = 0;
 unsigned int kexec_arm_image_size = 0;
+unsigned long long user_page_offset = (-1ULL);
 
 struct tag_header {
 	uint32_t size;
@@ -104,6 +105,8 @@ void zImage_arm_usage(void)
 		"     --ramdisk=FILE        Use FILE as the kernel's initial ramdisk.\n"
 		"     --dtb=FILE            Use FILE as the fdt blob.\n"
 		"     --atags               Use ATAGs instead of device-tree.\n"
+		"     --page-offset=PAGE_OFFSET\n"
+		"                           Set PAGE_OFFSET of crash dump vmcore\n"
 		);
 }
 
@@ -306,6 +309,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		{ "dtb",		1, 0, OPT_DTB },
 		{ "atags",		0, 0, OPT_ATAGS },
 		{ "image-size",		1, 0, OPT_IMAGE_SIZE },
+		{ "page-offset",	1, 0, OPT_PAGE_OFFSET },
 		{ 0, 			0, 0, 0 },
 	};
 	static const char short_options[] = KEXEC_ARCH_OPT_STR "a:r:";
@@ -342,6 +346,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 		case OPT_IMAGE_SIZE:
 			kexec_arm_image_size = strtoul(optarg, &end, 0);
 			break;
+		case OPT_PAGE_OFFSET:
+			user_page_offset = strtoull(optarg, &end, 0);
+			break;
 		}
 	}
 
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

From: Hui Li <lihui@loongson.cn>
Date: Sun, 24 Apr 2022 10:35:22 +0800
Subject: [PATCH v2 1/2] kexec-tools: mips: Add CONFIG_LOONGSON option.
In-Reply-To: <20220424023523.16869-1-lihui@loongson.cn>
References: <20220424023523.16869-1-lihui@loongson.cn>
Message-ID: <20220424023523.16869-2-lihui@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Under the mips architecture,PAGE_OFFSE is defined as 0xa800000000000000ULL.
But now loongson and many cpu's PAGE_OFFSET use 0xFFFFFFFF80000000ULL 
in kernel.so. add a --with-loongson option to distinguish PAGE_OFFSET 
between different platforms under mips.

Signed-off-by: Hui Li <lihui@loongson.cn>
---
 configure.ac                     | 5 +++++
 kexec/arch/mips/crashdump-mips.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index cf8e8a2..26bfbcd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -111,6 +111,11 @@ AC_ARG_WITH([booke],
 		AC_DEFINE(CONFIG_BOOKE,1,
 			[Define to build for BookE]))
 
+AC_ARG_WITH([loongson],
+		AC_HELP_STRING([--with-loongson],[build for loongson]),
+		AC_DEFINE(CONFIG_LOONGSON,1,
+			[Define to build for LoongsoN]))
+
 dnl ---Programs
 dnl To specify a different compiler, just 'export CC=/path/to/compiler'
 if test "${build}" != "${host}" ; then
diff --git a/kexec/arch/mips/crashdump-mips.h b/kexec/arch/mips/crashdump-mips.h
index 7edd859..d53c696 100644
--- a/kexec/arch/mips/crashdump-mips.h
+++ b/kexec/arch/mips/crashdump-mips.h
@@ -5,7 +5,11 @@ struct kexec_info;
 int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
 				unsigned long max_addr, unsigned long min_base);
 #ifdef __mips64
-#define PAGE_OFFSET	0xa800000000000000ULL
+#ifdef CONFIG_LOONGSON
+#define PAGE_OFFSET 0xFFFFFFFF80000000ULL
+#else
+#define PAGE_OFFSET 0xa800000000000000ULL
+#endif
 #define MAXMEM		0
 #else
 #define PAGE_OFFSET	0x80000000
-- 
2.20.1



Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <1366054836.2146.96.camel@smoke>
Subject: [RFC] Add --dtb option to ppc64
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 15 Apr 2013 12:40:36 -0700
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

All other architectures use the command line option --dtb to pass
a dtb file name.  For consistency add that option to ppc64.

Signed-off-by: Geoff Levand <geoff@infradead.org>

---
Hi All,

This consistency in option names will make it easier for platform
independent scripts and kexec front ends like petitboot.

I haven't yet tested this on ppc64, but if someone can do that
before I find some time I certainly would be grateful.

-Geoff

 kexec/arch/ppc64/include/arch/options.h |    1 +
 kexec/arch/ppc64/kexec-elf-ppc64.c      |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/kexec/arch/ppc64/include/arch/options.h b/kexec/arch/ppc64/include/arch/options.h
index 8f11c83..4ad9b75 100644
--- a/kexec/arch/ppc64/include/arch/options.h
+++ b/kexec/arch/ppc64/include/arch/options.h
@@ -38,6 +38,7 @@
 	{ "ramdisk",            1, NULL, OPT_RAMDISK },	\
 	{ "initrd",             1, NULL, OPT_RAMDISK },		\
 	{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },	\
+	{ "dtb",                1, NULL, OPT_DEVICETREEBLOB },	\
 	{ "args-linux",         0, NULL, OPT_ARGS_IGNORE },
 
 #define KEXEC_ALL_OPT_STR KEXEC_OPT_STR
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index f68f2bc..9a0e69a 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -101,6 +101,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 		{ "ramdisk",            1, NULL, OPT_RAMDISK },
 		{ "initrd",             1, NULL, OPT_RAMDISK },
 		{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },
+		{ "dtb",                1, NULL, OPT_DEVICETREEBLOB },
 		{ "args-linux",		0, NULL, OPT_ARGS_IGNORE },
 		{ 0,                    0, NULL, 0 },
 	};
@@ -345,6 +346,7 @@ void elf_ppc64_usage(void)
 	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
 	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
 	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
+	fprintf(stderr, "     --dtb=<filename> same as --devicetreeblob.\n");
 
 	fprintf(stderr, "elf support is still broken\n");
 }



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

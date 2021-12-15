Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxRN3-0009b9-EM
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 10:18:51 +0000
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 5/5] s390: add support for --reuse-cmdline
Date: Wed, 15 Dec 2021 11:18:36 +0100
Message-Id: <20211215101836.1181165-6-svens@linux.ibm.com>
In-Reply-To: <20211215101836.1181165-1-svens@linux.ibm.com>
References: <20211215101836.1181165-1-svens@linux.ibm.com>
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
Cc: kexec@lists.infradead.org, prudo@redhat.com, Sven Schnelle <svens@linux.ibm.com>, Alexander Egorenkov <egorenar@linux.ibm.com>

--reuse-cmdline reads the command line of the currently
running kernel from /proc/cmdline and uses that for the
kernel that should be kexec'd.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
---
 kexec/arch/s390/include/arch/options.h | 10 ++++++----
 kexec/arch/s390/kexec-image.c          |  9 +++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/s390/include/arch/options.h b/kexec/arch/s390/include/arch/options.h
index 76044a301ceb..c150244996c7 100644
--- a/kexec/arch/s390/include/arch/options.h
+++ b/kexec/arch/s390/include/arch/options.h
@@ -1,9 +1,10 @@
 #ifndef KEXEC_ARCH_S390_OPTIONS_H
 #define KEXEC_ARCH_S390_OPTIONS_H
 
-#define OPT_ARCH_MAX	(OPT_MAX+0)
-#define OPT_APPEND	OPT_MAX+0
-#define OPT_RAMDISK	OPT_MAX+1
+#define OPT_ARCH_MAX		(OPT_MAX+0)
+#define OPT_APPEND		(OPT_MAX+0)
+#define OPT_RAMDISK		(OPT_MAX+1)
+#define OPT_REUSE_CMDLINE	(OPT_MAX+2)
 
 /* Options relevant to the architecture (excluding loader-specific ones),
  * in this case none:
@@ -31,7 +32,8 @@
 	KEXEC_ARCH_OPTIONS				\
 	{"command-line",     1, 0, OPT_APPEND},		\
 	{"append",           1, 0, OPT_APPEND},		\
-	{"initrd",	     1, 0, OPT_RAMDISK},
+	{"initrd",	     1, 0, OPT_RAMDISK},	\
+	{"reuse-cmdline",    0, 0, OPT_REUSE_CMDLINE },
 
 #define KEXEC_ALL_OPT_STR KEXEC_ARCH_OPT_STR
 
diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 209ab77ddccb..69aaf96812f7 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -71,6 +71,10 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 		case OPT_RAMDISK:
 			ramdisk = optarg;
 			break;
+		case OPT_REUSE_CMDLINE:
+			free(info->command_line);
+			info->command_line = get_command_line();
+			break;
 		}
 	}
 
@@ -123,6 +127,10 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 			if (command_line_add(info, optarg))
 				return -1;
 			break;
+		case OPT_REUSE_CMDLINE:
+			free(info->command_line);
+			info->command_line = get_command_line();
+			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
 			break;
@@ -223,5 +231,6 @@ image_s390_usage(void)
 	printf("--command-line=STRING Set the kernel command line to STRING.\n"
 	       "--append=STRING       Set the kernel command line to STRING.\n"
 	       "--initrd=FILENAME     Use the file FILENAME as a ramdisk.\n"
+	       "--reuse-cmdline       Use kernel command line from running system.\n"
 		);
 }
-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

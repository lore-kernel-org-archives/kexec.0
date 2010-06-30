Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 1/4] configure: add support for ARM targets
Date: Wed, 30 Jun 2010 13:09:09 +0300
Message-Id: <98c5cb9237f8ddab7b01eaeb1aa38d142392d3f0.1277891104.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1277891104.git.ext-mika.1.westerberg@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: anderson@redhat.com
Cc: kexec@lists.infradead.org, "\\\"Mika Westerberg\\\"" <ext-mika.1.westerberg@nokia.com>, linux-arm-kernel@lists.infradead.org, crash-utility@redhat.com

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 configure.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/configure.c b/configure.c
index 627bb83..c8f1305 100644
--- a/configure.c
+++ b/configure.c
@@ -90,6 +90,7 @@ void make_spec_file(struct supported_gdb_version *);
 #undef S390X
 #undef PPC64
 #undef X86_64
+#undef ARM
 
 #define X86     1
 #define ALPHA   2
@@ -99,6 +100,7 @@ void make_spec_file(struct supported_gdb_version *);
 #define S390X   6
 #define PPC64   7
 #define X86_64  8
+#define ARM	9
 
 #define TARGET_X86    "TARGET=X86"
 #define TARGET_ALPHA  "TARGET=ALPHA"
@@ -108,6 +110,7 @@ void make_spec_file(struct supported_gdb_version *);
 #define TARGET_S390X  "TARGET=S390X"
 #define TARGET_PPC64  "TARGET=PPC64"
 #define TARGET_X86_64 "TARGET=X86_64"
+#define TARGET_ARM    "TARGET=ARM"
 
 #define TARGET_CFLAGS_X86    "TARGET_CFLAGS=-D_FILE_OFFSET_BITS=64"
 #define TARGET_CFLAGS_ALPHA  "TARGET_CFLAGS="
@@ -117,6 +120,7 @@ void make_spec_file(struct supported_gdb_version *);
 #define TARGET_CFLAGS_S390X  "TARGET_CFLAGS="
 #define TARGET_CFLAGS_PPC64  "TARGET_CFLAGS=-m64"
 #define TARGET_CFLAGS_X86_64 "TARGET_CFLAGS="
+#define TARGET_CFLAGS_ARM    "TARGET_CFLAGS=-D_FILE_OFFSET_BITS=64"
 
 /*
  *  The original plan was to allow the use of a particular version
@@ -274,6 +278,9 @@ get_current_configuration(void)
 #ifdef __x86_64__
         target_data.target = X86_64;
 #endif
+#ifdef __arm__
+        target_data.target = ARM;
+#endif
 
         if ((fp = fopen("Makefile", "r")) == NULL) {
 		perror("Makefile");
@@ -374,6 +381,9 @@ show_configuration(void)
 	case X86_64:
 		printf("TARGET: X86_64\n");
 		break;
+	case ARM:
+		printf("TARGET: ARM\n");
+		break;
 	}
 
 	if (strlen(target_data.program)) {
@@ -437,6 +447,10 @@ build_configure(struct supported_gdb_version *sp)
                 target = TARGET_X86_64;
                 target_CFLAGS = TARGET_CFLAGS_X86_64;
                 break;
+	case ARM:
+                target = TARGET_ARM;
+                target_CFLAGS = TARGET_CFLAGS_ARM;
+                break;
 	}
 
 	makefile_setup(&fp1, &fp2);
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

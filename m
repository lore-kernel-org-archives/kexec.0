Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ddfSU-00031D-M2
 for kexec@lists.infradead.org; Fri, 04 Aug 2017 16:28:20 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [makedumpfile PATCH] Fix formatting problems in header file
Date: Fri,  4 Aug 2017 05:29:08 -0700
Message-Id: <1501849748-11647-1-git-send-email-eric.devolder@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, ats-kumagai@wm.jp.nec.com
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, konrad.wilk@oracle.com

The list of #defines uses spaces to separate the value from the
name. A few used tabs, so those tabs have been converted to
spaces so that the values align again.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 makedumpfile.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 8a05794..34dd8d7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -2244,7 +2244,7 @@ struct elf_prstatus {
 #define OPT_DEBUG               'D'
 #define OPT_DUMP_LEVEL          'd'
 #define OPT_ELF_DUMPFILE        'E'
-#define OPT_EXCLUDE_UNUSED_VM	'e'
+#define OPT_EXCLUDE_UNUSED_VM   'e'
 #define OPT_FLATTEN             'F'
 #define OPT_FORCE               'f'
 #define OPT_GENERATE_VMCOREINFO 'g'
@@ -2271,10 +2271,10 @@ struct elf_prstatus {
 #define OPT_EPPIC               OPT_START+11
 #define OPT_NON_MMAP            OPT_START+12
 #define OPT_MEM_USAGE           OPT_START+13
-#define OPT_SPLITBLOCK_SIZE	OPT_START+14
+#define OPT_SPLITBLOCK_SIZE     OPT_START+14
 #define OPT_WORKING_DIR         OPT_START+15
-#define OPT_NUM_THREADS	OPT_START+16
-#define OPT_PARTIAL_DMESG	OPT_START+17
+#define OPT_NUM_THREADS         OPT_START+16
+#define OPT_PARTIAL_DMESG       OPT_START+17
 
 /*
  * Function Prototype.
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

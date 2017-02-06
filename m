Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cap8x-0000I2-M8
 for kexec@lists.infradead.org; Mon, 06 Feb 2017 19:40:14 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2 11/12] kexec: Add option to get crash kernel region size
Date: Mon,  6 Feb 2017 13:42:23 -0600
Message-Id: <1486410144-28595-12-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

From: Daniel Kiper <daniel.kiper@oracle.com>

Here print_crashkernel_region_size() function is available on all archs (even
if the functionality is not implemented on some). So, we can safely use it in
arch independent code and export the functionality to the user space.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index 2b06f59..3ac81f5 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -226,7 +226,8 @@ extern int file_types;
 #define OPT_LOAD_PRESERVE_CONTEXT 259
 #define OPT_LOAD_JUMP_BACK_HELPER 260
 #define OPT_ENTRY		261
-#define OPT_MAX			262
+#define OPT_PRINT_CKR_SIZE	262
+#define OPT_MAX			263
 #define KEXEC_OPTIONS \
 	{ "help",		0, 0, OPT_HELP }, \
 	{ "version",		0, 0, OPT_VERSION }, \
@@ -247,6 +248,7 @@ extern int file_types;
 	{ "kexec-file-syscall",	0, 0, OPT_KEXEC_FILE_SYSCALL }, \
 	{ "debug",		0, 0, OPT_DEBUG }, \
 	{ "status",		0, 0, OPT_STATUS }, \
+	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 
 #define KEXEC_OPT_STR "h?vdfxyluet:psS"
 
@@ -293,6 +295,7 @@ int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
 int is_crashkernel_mem_reserved(void);
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end);
+void print_crashkernel_region_size(void);
 char *get_command_line(void);
 
 int kexec_iomem_for_each_line(char *match,
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

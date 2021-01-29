Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Ji6-0005vo-Ql
 for kexec@lists.infradead.org; Fri, 29 Jan 2021 02:40:36 +0000
Received: by mail-pg1-x530.google.com with SMTP id b21so5635011pgk.7
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2021 18:40:34 -0800 (PST)
From: kazuhito.hagio@gmail.com
Subject: [PATCH 2/3] arm64: Make use of NUMBER(VA_BITS) in vmcoreinfo
Date: Fri, 29 Jan 2021 11:40:24 +0900
Message-Id: <1611888025-29321-3-git-send-email-kazuhito.hagio@gmail.com>
In-Reply-To: <1611888025-29321-1-git-send-email-kazuhito.hagio@gmail.com>
References: <1611888025-29321-1-git-send-email-kazuhito.hagio@gmail.com>
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
To: bhupesh.linux@gmail.com, piliu@redhat.com, kexec@lists.infradead.org

From: Kazuhito Hagio <k-hagio-ab@nec.com>

Make use of the NUMBER(VA_BITS) in vmcoreinfo, which was added by
kernel commit 20a166243328 (Linux 4.12 and later kernels), as the
current way of guessing VA_BITS does not work on Linux 5.4 and
later kernels.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
Signed-off-by: Kazuhito Hagio <k-hagio-ab@nec.com>
---
 arch/arm64.c | 63 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index 3d7b416..2916b4f 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -345,6 +345,43 @@ get_stext_symbol(void)
 	return(found ? kallsym : FALSE);
 }
 
+static int
+get_va_bits_from_stext_arm64(void)
+{
+	ulong _stext;
+
+	_stext = get_stext_symbol();
+	if (!_stext) {
+		ERRMSG("Can't get the symbol of _stext.\n");
+		return FALSE;
+	}
+
+	/*
+	 * Derive va_bits as per arch/arm64/Kconfig. Note that this is a
+	 * best case approximation at the moment, as there can be
+	 * inconsistencies in this calculation (for e.g., for 52-bit
+	 * kernel VA case, the 48th bit is set in * the _stext symbol).
+	 */
+	if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
+		va_bits = 48;
+	} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
+		va_bits = 47;
+	} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
+		va_bits = 42;
+	} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
+		va_bits = 39;
+	} else if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
+		va_bits = 36;
+	} else {
+		ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
+		return FALSE;
+	}
+
+	DEBUG_MSG("va_bits       : %d (guess from _stext)\n", va_bits);
+
+	return TRUE;
+}
+
 int
 get_machdep_info_arm64(void)
 {
@@ -398,27 +435,11 @@ get_xen_info_arm64(void)
 int
 get_versiondep_info_arm64(void)
 {
-	ulong _stext;
-
-	_stext = get_stext_symbol();
-	if (!_stext) {
-		ERRMSG("Can't get the symbol of _stext.\n");
-		return FALSE;
-	}
-
-	/* Derive va_bits as per arch/arm64/Kconfig */
-	if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
-		va_bits = 36;
-	} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
-		va_bits = 39;
-	} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
-		va_bits = 42;
-	} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
-		va_bits = 47;
-	} else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
-		va_bits = 48;
-	} else {
-		ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
+	if (NUMBER(VA_BITS) != NOT_FOUND_NUMBER) {
+		va_bits = NUMBER(VA_BITS);
+		DEBUG_MSG("va_bits      : %d (vmcoreinfo)\n", va_bits);
+	} else if (get_va_bits_from_stext_arm64() == FALSE) {
+		ERRMSG("Can't determine va_bits.\n");
 		return FALSE;
 	}
 
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fZ1Mf-0005lt-Rs
 for kexec@lists.infradead.org; Fri, 29 Jun 2018 21:55:39 +0000
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so4527146pgl.8
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2018 14:55:27 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] arm64: Fix calculation of page_offset in case we are running
 cases other than mem-usage
Date: Sat, 30 Jun 2018 03:18:28 +0530
Message-Id: <1530308908-15528-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: mas-tachibana@vf.jp.nec.com, bhsharma@redhat.com, bhupesh.linux@gmail.com, k-hagio@ab.jp.nec.com

Patch f49ca13e5eed5bbdc69e0fd5ef099cb46050cb3d added '--mem-usage'
support for arm64 architecture.

However, we also need to make sure that the calculation of
'page_offset' is valid in case we are running cases other than
'--mem-usage'.

This patch does the same. I tested this patch on my qualcomm and apm
mustang arm64 boards.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64.c b/arch/arm64.c
index c9dab677f2c9..2fd3e1874376 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -222,6 +222,12 @@ get_stext_symbol(void)
 int
 get_machdep_info_arm64(void)
 {
+	/* Check if va_bits is still not initialized. If still 0, call
+	 * get_versiondep_info() to initialize the same.
+	 */
+	if (!va_bits)
+		get_versiondep_info_arm64();
+
 	if (!calculate_plat_config()) {
 		ERRMSG("Can't determine platform config values\n");
 		return FALSE;
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

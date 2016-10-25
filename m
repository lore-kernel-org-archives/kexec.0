Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5Z-0000cr-Lx
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:24:03 +0000
Received: by mail-qt0-f174.google.com with SMTP id s49so137127630qta.0
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:40 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 06/10] arm64: fix re-filtering
Date: Tue, 25 Oct 2016 12:52:58 +0530
Message-Id: <ba6cc8acfb3f60180e7481729217bd4a27f50955.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, sgoel@codeaurora.org, mansip@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org

get_phys_base() is not called for re-filtering. Therefore,
calculate_plat_config() is never called if re-filtering is enabled.
Otherwise too, it seems more appropriate to call calculate_plat_config() in
get_machdep_info(). Therefore, moving calling of calculate_plat_config()
into get_machdep_info().

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64.c b/arch/arm64.c
index ce5869452484..a5b1bca43e64 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -171,11 +171,6 @@ get_phys_base_arm64(void)
 	unsigned long long phys_start;
 	int i;
 
-	if (!calculate_plat_config()) {
-		ERRMSG("Can't determine platform config values\n");
-		return FALSE;
-	}
-
 	/*
 	 * We resolve phys_base from PT_LOAD segments. LMA contains physical
 	 * address of the segment, and we use the lowest start as
@@ -201,6 +196,11 @@ get_phys_base_arm64(void)
 int
 get_machdep_info_arm64(void)
 {
+	if (!calculate_plat_config()) {
+		ERRMSG("Can't determine platform config values\n");
+		return FALSE;
+	}
+
 	info->max_physmem_bits = PHYS_MASK_SHIFT;
 	info->section_size_bits = SECTIONS_SIZE_BITS;
 	info->page_offset = 0xffffffffffffffffUL << (VA_BITS - 1);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

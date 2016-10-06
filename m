Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bs5K3-00039A-6Q
 for kexec@lists.infradead.org; Thu, 06 Oct 2016 09:50:39 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/3] makedumpfile: Move get_versiondep_info calling earlier
Date: Thu,  6 Oct 2016 17:50:07 +0800
Message-Id: <1475747408-25666-3-git-send-email-bhe@redhat.com>
In-Reply-To: <1475747408-25666-1-git-send-email-bhe@redhat.com>
References: <1475747408-25666-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: dyoung@redhat.com, kexec@lists.infradead.org, thgarnie@google.com, Baoquan He <bhe@redhat.com>, tonli@redhat.com

Because is_vmalloc_addr_x86_64 need be called very early, e.g in
readmem(). So we have to move get_versiondep_info calling earlier
to let PAGE_OFFSET/VMALLOC_START/VMEMMAP_START get value before
use them.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 89e1089..e132550 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3835,6 +3835,9 @@ initial(void)
 	if (!get_value_for_old_linux())
 		return FALSE;
 
+	if (!get_versiondep_info())
+		return FALSE;
+
 	if (info->flag_mem_usage && !get_kcore_dump_loads())
 		return FALSE;
 
@@ -3986,9 +3989,6 @@ out:
 		if (!check_release())
 			return FALSE;
 
-		if (!get_versiondep_info())
-			return FALSE;
-
 		/*
 		 * NOTE: This must be done before refering to
 		 * VMALLOC'ed memory. The first 640kB contains data
-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

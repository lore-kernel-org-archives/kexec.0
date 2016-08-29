Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beILE-0004MG-VE
 for kexec@lists.infradead.org; Mon, 29 Aug 2016 08:54:54 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/3] makedumpfile: Move get_versiondep_info calling earlier
Date: Mon, 29 Aug 2016 16:54:21 +0800
Message-Id: <1472460862-29842-3-git-send-email-bhe@redhat.com>
In-Reply-To: <1472460862-29842-1-git-send-email-bhe@redhat.com>
References: <1472460862-29842-1-git-send-email-bhe@redhat.com>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, thgarnie@google.com, Baoquan He <bhe@redhat.com>

Because is_vmalloc_addr_x86_64 need called very early, e.g in readmem().
So we have to move get_versiondep_info calling earlier to make
PAGE_OFFSET/VMALLOC_START/VMEMMAP_START get value before use them.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index ce68d61..2713f8a 100644
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

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXT54-0008Bc-A1
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 12:58:04 +0000
From: Martin Wilck <mwilck@suse.de>
Subject: [PATCH 2/3] move call to open_dump_bitmap() to after call to initial()
Date: Wed, 10 Aug 2016 14:56:57 +0200
Message-Id: <20160810125658.23366-3-mwilck@suse.de>
In-Reply-To: <20160810125658.23366-1-mwilck@suse.de>
References: <20160810125658.23366-1-mwilck@suse.de>
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
Cc: Martin Wilck <mwilck@suse.de>, ptesarik@suse.de, kexec@lists.infradead.org

When open_files_for_creating_dumpfile() is called, we don't have all
necessary information to determine whether a bitmap file is actually
needed. In particular, we don't know whether info->flag_cyclic will
ultimately be set. This patch moves the call to open_dump_bitmap()
to after initialize() when all flags are known.

For the dump_dmesg() path, no bitmap file is needed.

Signed-off-by: Martin Wilck <mwilck@suse.de>
---
 makedumpfile.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 9f05396..43278f1 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1480,9 +1480,6 @@ open_files_for_creating_dumpfile(void)
 	if (!open_dump_memory())
 		return FALSE;
 
-	if (!open_dump_bitmap())
-		return FALSE;
-
 	return TRUE;
 }
 
@@ -9708,6 +9705,9 @@ create_dumpfile(void)
 	if (!initial())
 		return FALSE;
 
+	if (!open_dump_bitmap())
+		return FALSE;
+
 	/* create an array of translations from pfn to vmemmap pages */
 	if (info->flag_excludevm) {
 		if (find_vmemmap() == FAILED) {
@@ -10878,6 +10878,9 @@ int show_mem_usage(void)
 	if (!initial())
 		return FALSE;
 
+	if (!open_dump_bitmap())
+		return FALSE;
+
 	if (!prepare_bitmap_buffer())
 		return FALSE;
 
-- 
2.9.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

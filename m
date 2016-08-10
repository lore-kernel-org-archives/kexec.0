Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXT54-00088Z-A8
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 12:58:02 +0000
From: Martin Wilck <mwilck@suse.de>
Subject: [PATCH 1/3] open_dump_bitmap: open bitmap file in non-cyclic case
Date: Wed, 10 Aug 2016 14:56:56 +0200
Message-Id: <20160810125658.23366-2-mwilck@suse.de>
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

The logic of set_bitmap() requires that a bitmap fd exists in the
non-cyclic case.

Signed-off-by: Martin Wilck <mwilck@suse.de>
---
 makedumpfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 853b999..9f05396 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1365,7 +1365,7 @@ open_dump_bitmap(void)
 
 	/* Unnecessary to open */
 	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
-	    && !info->flag_sadump && !info->flag_mem_usage)
+	    && !info->flag_sadump && !info->flag_mem_usage && info->flag_cyclic)
 		return TRUE;
 
 	tmpname = getenv("TMPDIR");
-- 
2.9.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bk8iS-0005tl-I9
 for kexec@lists.infradead.org; Wed, 14 Sep 2016 11:51:01 +0000
From: Martin Wilck <mwilck@suse.de>
Subject: [PATCH v3 3/3] close_dump_bitmap: simplify logic
Date: Wed, 14 Sep 2016 13:50:09 +0200
Message-Id: <20160914115009.20220-1-mwilck@suse.de>
In-Reply-To: <20160914101723.19003-3-mwilck@suse.de>
References: <20160914101723.19003-3-mwilck@suse.de>
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
Cc: mwilck@suse.de, ptesarik@suse.cz, kexec@lists.infradead.org

The boolean expression replicates the logic of open_dump_bitmap().
It's simpler and less error-prone to simply check if fd_bitmap is
valid.

(I forgot to apply the very change that Petr had asked for in V2 of
this patch. I'm very sorry. Please apply V3).

---
 makedumpfile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 30e1fa8..0f5be7f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8615,8 +8615,7 @@ close_dump_file(void)
 void
 close_dump_bitmap(void)
 {
-	if (!info->working_dir && !info->flag_reassemble && !info->flag_refiltering
-	    && !info->flag_sadump && !info->flag_mem_usage)
+	if (info->fd_bitmap < 0)
 		return;
 
 	if (close(info->fd_bitmap) < 0)
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

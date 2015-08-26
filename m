Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZURIl-0005Gq-IC
 for kexec@lists.infradead.org; Wed, 26 Aug 2015 03:23:04 +0000
From: Chao Fan <cfan@redhat.com>
Subject: [PATCH] makedumpfile: remove the double free of sph
Date: Wed, 26 Aug 2015 11:22:34 +0800
Message-Id: <1440559354-8252-1-git-send-email-cfan@redhat.com>
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
Cc: Chao Fan <cfan@redhat.com>, ats-kumagai@wm.jp.nec.com

sph will be freed twice when it meet below conditions:

            sph->signature1 != SADUMP_SIGNATURE1 ||
            sph->signature2 != SADUMP_SIGNATURE2

Then it will be freed once and goto error: to free again. So remove the
1st free.

Signed-off-by: Chao Fan <cfan@redhat.com>
---
 sadump_info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sadump_info.c b/sadump_info.c
index e8154f4..1474fb2 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -695,7 +695,6 @@ read_sadump_header_diskset(int diskid, struct sadump_diskset_info *sdi)
 	if (sph->signature1 != SADUMP_SIGNATURE1 ||
 	    sph->signature2 != SADUMP_SIGNATURE2) {
 		DEBUG_MSG("sadump: does not have partition header\n");
-		free(sph);
 		goto error;
 	}
 
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

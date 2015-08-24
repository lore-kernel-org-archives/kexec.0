Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTiFA-0004MI-9Y
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 03:16:20 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id AE1488A179
 for <kexec@lists.infradead.org>; Mon, 24 Aug 2015 03:16:02 +0000 (UTC)
From: Chao Fan <cfan@redhat.com>
Subject: [PATCH]makedumpfile.c: check rhe return value ofset_page_size
Date: Mon, 24 Aug 2015 11:15:52 +0800
Message-Id: <1440386153-21638-2-git-send-email-cfan@redhat.com>
In-Reply-To: <1440386153-21638-1-git-send-email-cfan@redhat.com>
References: <1440386153-21638-1-git-send-email-cfan@redhat.com>
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
Cc: Chao Fan <cfan@redhat.com>

check_return: Calling function "set_page_size" without checking
return value (as is done elsewhere 5 out of 6 times).

makedumpfile.c:8793: example_checked: "set_page_size(dh.block_size)"
has its value checked in "set_page_size(dh.block_size)". But in
makedumpfile.c:3213, the function "set_page_size" will not check
the return value.

Signed-off-by: Chao Fan <cfan@redhat.com>
---
 makedumpfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 32f5459..53efc04 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3213,7 +3213,8 @@ initial(void)
 			MSG("because the cyclic mode doesn't support sadump format.\n");
 		}
 
-		set_page_size(sadump_page_size());
+		if (!set_page_size(sadump_page_size()))
+			return FALSE;
 
 		if (!sadump_initialize_bitmap_memory())
 			return FALSE;
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

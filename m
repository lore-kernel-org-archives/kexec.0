Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22f.google.com ([2607:f8b0:400e:c03::22f])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Yw1gj-0005V4-EM
 for kexec@lists.infradead.org; Sat, 23 May 2015 05:09:37 +0000
Received: by padbw4 with SMTP id bw4so34529851pad.0
 for <kexec@lists.infradead.org>; Fri, 22 May 2015 22:09:11 -0700 (PDT)
From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] kernel:kexec - Fix for typo in comment in function
 sanity_check_segment_list().
Date: Sat, 23 May 2015 10:38:57 +0530
Message-Id: <1432357737-4269-1-git-send-email-shailendra.capricorn@gmail.com>
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
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>


Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 kernel/kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7a36fdc..50dffdb 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -189,7 +189,7 @@ static int sanity_check_segment_list(struct kimage *image)
 	}
 
 	/* Verify our destination addresses do not overlap.
-	 * If we alloed overlapping destination addresses
+	 * If we allowed overlapping destination addresses
 	 * through very weird things can happen with no
 	 * easy explanation as one segment stops on another.
 	 */
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

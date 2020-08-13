Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Cby-00026u-IC
 for kexec@lists.infradead.org; Thu, 13 Aug 2020 12:45:44 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH] kexec: Delete an unnecessary comparison
Date: Thu, 13 Aug 2020 20:45:30 +0800
Message-Id: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
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
To: Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Regardless of whether the ret value is zero or non-zero, the trajectory
of the program execution is the same, so there is no need to compare.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kernel/kexec_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 78c0837..3ad0ae2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -800,8 +800,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
 						     digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
 	}
 
 out_free_digest:
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

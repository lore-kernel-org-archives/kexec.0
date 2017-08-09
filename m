Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m12-13.163.com ([220.181.12.13])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1dfPCB-0006EP-Ea
 for kexec@lists.infradead.org; Wed, 09 Aug 2017 11:30:41 +0000
From: Pan Bian <bianpan2016@163.com>
Subject: [V2] kexec_file: use crypto_free_shash to free memory
Date: Wed,  9 Aug 2017 19:30:01 +0800
Message-Id: <1502278201-14562-1-git-send-email-bianpan2016@163.com>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Pan Bian <bianpan2016@163.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

In function kexec_calculate_store_digests(), kfree() is used to free
memory allocated by crypto_alloc_shash(). It is better to use function
crypto_free_shash(), which frees up tfm and any resources associated with
it. And then, the refcount of the algorithm used in crypto_alloc_shash()
is also dropped.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 kernel/kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 9f48f44..94eeb38 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -627,7 +627,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 out_free_desc:
 	kfree(desc);
 out_free_tfm:
-	kfree(tfm);
+	crypto_free_shash(tfm);
 out:
 	return ret;
 }
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

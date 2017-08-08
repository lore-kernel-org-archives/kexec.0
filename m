Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from m12-11.163.com ([220.181.12.11])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1df3fN-0001Wb-83
 for kexec@lists.infradead.org; Tue, 08 Aug 2017 12:31:25 +0000
From: Pan Bian <bianpan2016@163.com>
Subject: kexec_file: use crypto_free_shash to free memory
Date: Tue,  8 Aug 2017 20:30:40 +0800
Message-Id: <1502195440-3600-1-git-send-email-bianpan2016@163.com>
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
crypto_free_shash(), which also zeroizes the memory to be freed.

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

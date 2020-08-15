Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6r38-0000xJ-BS
 for kexec@lists.infradead.org; Sat, 15 Aug 2020 07:56:23 +0000
From: Youling Tang <tangyouling@loongson.cn>
Subject: [PATCH v2] kexec: Clean up kexec_calculate_store_digests() in
 kexec_file.c
Date: Sat, 15 Aug 2020 15:56:04 +0800
Message-Id: <1597478164-26477-1-git-send-email-tangyouling@loongson.cn>
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
Cc: Joe Perches <joe@perches.com>, kexec@lists.infradead.org, Youling Tang <tangyouling@loongson.cn>, Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org

Change a couple of breaks to gotos, remove multiple unnecessary checks.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Acked-by: Dave Young <dyoung@redhat.com>
Suggested-by: Joe Perches <joe@perches.com>
---
 kernel/kexec_file.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 78c0837..ec8b716 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -763,7 +763,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
 		ret = crypto_shash_update(desc, ksegment->kbuf,
 					  ksegment->bufsz);
 		if (ret)
-			break;
+			goto out_free_digest;
 
 		/*
 		 * Assume rest of the buffer is filled with zero and
@@ -777,32 +777,26 @@ static int kexec_calculate_store_digests(struct kimage *image)
 				bytes = zero_buf_sz;
 			ret = crypto_shash_update(desc, zero_buf, bytes);
 			if (ret)
-				break;
+				goto out_free_digest;
 			nullsz -= bytes;
 		}
 
-		if (ret)
-			break;
-
 		sha_regions[j].start = ksegment->mem;
 		sha_regions[j].len = ksegment->memsz;
 		j++;
 	}
 
-	if (!ret) {
-		ret = crypto_shash_final(desc, digest);
-		if (ret)
-			goto out_free_digest;
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
-						     sha_regions, sha_region_sz, 0);
-		if (ret)
-			goto out_free_digest;
+	ret = crypto_shash_final(desc, digest);
+	if (ret)
+		goto out_free_digest;
 
-		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
-						     digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
-	}
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha_regions",
+					     sha_regions, sha_region_sz, 0);
+	if (ret)
+		goto out_free_digest;
+
+	ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
+					     digest, SHA256_DIGEST_SIZE, 0);
 
 out_free_digest:
 	kfree(digest);
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUIV3-0007C3-3x
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 18:31:26 +0000
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 13 Feb 2016 00:01:00 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CIUvtC45809838
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:00:57 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CIUodn031586
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:00:53 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 07/19] ima: calculate the hash of a buffer using
 aynchronous hash(ahash)
Date: Fri, 12 Feb 2016 13:29:19 -0500
Message-Id: <1455301771-7703-8-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

Setting up ahash has some overhead.  Only use ahash to calculate the
hash of a buffer, if the buffer is larger than ima_ahash_minsize.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
---
 security/integrity/ima/ima_crypto.c | 75 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index fccb6ce..38f2ed8 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -519,6 +519,63 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 	return rc;
 }
 
+static int calc_buffer_ahash_atfm(const void *buf, loff_t len,
+				  struct ima_digest_data *hash,
+				  struct crypto_ahash *tfm)
+{
+	struct ahash_request *req;
+	struct scatterlist sg;
+	struct ahash_completion res;
+	int rc, ahash_rc = 0;
+
+	hash->length = crypto_ahash_digestsize(tfm);
+
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	init_completion(&res.completion);
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG |
+				   CRYPTO_TFM_REQ_MAY_SLEEP,
+				   ahash_complete, &res);
+
+	rc = ahash_wait(crypto_ahash_init(req), &res);
+	if (rc)
+		goto out;
+
+	sg_init_one(&sg, buf, len);
+	ahash_request_set_crypt(req, &sg, NULL, len);
+
+	ahash_rc = crypto_ahash_update(req);
+
+	/* wait for the update request to complete */
+	rc = ahash_wait(ahash_rc, &res);
+	if (!rc) {
+		ahash_request_set_crypt(req, NULL, hash->digest, 0);
+		rc = ahash_wait(crypto_ahash_final(req), &res);
+	}
+out:
+	ahash_request_free(req);
+	return rc;
+}
+
+static int calc_buffer_ahash(const void *buf, loff_t len,
+			     struct ima_digest_data *hash)
+{
+	struct crypto_ahash *tfm;
+	int rc;
+
+	tfm = ima_alloc_atfm(hash->algo);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = calc_buffer_ahash_atfm(buf, len, hash, tfm);
+
+	ima_free_atfm(tfm);
+
+	return rc;
+}
+
 static int calc_buffer_shash_tfm(const void *buf, loff_t size,
 				struct ima_digest_data *hash,
 				struct crypto_shash *tfm)
@@ -550,8 +607,8 @@ static int calc_buffer_shash_tfm(const void *buf, loff_t size,
 	return rc;
 }
 
-int ima_calc_buffer_hash(const void *buf, loff_t len,
-			 struct ima_digest_data *hash)
+static int calc_buffer_shash(const void *buf, loff_t len,
+			     struct ima_digest_data *hash)
 {
 	struct crypto_shash *tfm;
 	int rc;
@@ -566,6 +623,20 @@ int ima_calc_buffer_hash(const void *buf, loff_t len,
 	return rc;
 }
 
+int ima_calc_buffer_hash(const void *buf, loff_t len,
+			 struct ima_digest_data *hash)
+{
+	int rc;
+
+	if (ima_ahash_minsize && len >= ima_ahash_minsize) {
+		rc = calc_buffer_ahash(buf, len, hash);
+		if (!rc)
+			return 0;
+	}
+
+	return calc_buffer_shash(buf, len, hash);
+}
+
 static void __init ima_pcrread(int idx, u8 *pcr)
 {
 	if (!ima_used_chip)
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

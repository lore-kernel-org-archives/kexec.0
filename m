Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aR2n2-00035T-T4
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 19:08:38 +0000
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 05:08:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5F0BD3578056
 for <kexec@lists.infradead.org>; Thu,  4 Feb 2016 06:08:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13J7wgR65142926
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:08:06 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13J7X8a009571
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:07:34 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 09/22] ima: provide buffer hash calculation function
Date: Wed,  3 Feb 2016 14:06:17 -0500
Message-Id: <1454526390-19792-10-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-modules@vger.kernel.org, fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Kees Cook <keescook@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Dmitry Kasatkin <d.kasatkin@samsung.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@huawei.com>

From: Dmitry Kasatkin <d.kasatkin@samsung.com>

This patch provides convenient buffer hash calculation function.

Changelog v3:
- fix while hash calculation - Dmitry
v1:
- rewrite to support loff_t sized buffers - Mimi
  (based on Fenguang Wu's testing)

Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_crypto.c | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b7e7935..2c5262f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -107,6 +107,8 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
+int ima_calc_buffer_hash(const void *buf, loff_t len,
+			 struct ima_digest_data *hash);
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
 			      struct ima_template_desc *desc, int num_fields,
 			      struct ima_digest_data *hash);
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index fb30ce4..fccb6ce 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -519,6 +519,53 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
 	return rc;
 }
 
+static int calc_buffer_shash_tfm(const void *buf, loff_t size,
+				struct ima_digest_data *hash,
+				struct crypto_shash *tfm)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+	unsigned int len;
+	int rc;
+
+	shash->tfm = tfm;
+	shash->flags = 0;
+
+	hash->length = crypto_shash_digestsize(tfm);
+
+	rc = crypto_shash_init(shash);
+	if (rc != 0)
+		return rc;
+
+	while (size) {
+		len = size < PAGE_SIZE ? size : PAGE_SIZE;
+		rc = crypto_shash_update(shash, buf, len);
+		if (rc)
+			break;
+		buf += len;
+		size -= len;
+	}
+
+	if (!rc)
+		rc = crypto_shash_final(shash, hash->digest);
+	return rc;
+}
+
+int ima_calc_buffer_hash(const void *buf, loff_t len,
+			 struct ima_digest_data *hash)
+{
+	struct crypto_shash *tfm;
+	int rc;
+
+	tfm = ima_alloc_tfm(hash->algo);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	rc = calc_buffer_shash_tfm(buf, len, hash, tfm);
+
+	ima_free_tfm(tfm);
+	return rc;
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

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CACFC77B76
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 12:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L7553dKrqxbzpgg1HPFEWe0Picc0gzg2q0jTFSz2xBc=; b=Xl+I0ERYrcV5Q7
	Pm6/ECcmjfCR0SiGfsPWgSOTsVd7YCzIsbdDFrNCpnuHCYBfAlc3/JctFs3ZcKG4pPWxe9RBde5pz
	N6t8k9p305Bg5G7bL0mvMpeeBEiYbY9sB/+vRJQZO27pfFtfUHwC//10Q8IevFs6Z/PxjzhgzD2LC
	DsGtcadC9ymMF9I3bmI1G4uTSg2Q4QuAp8Sja8EetyXwrJx0ReNd+jLtOWLIpzFGlaW8cnulgsPP6
	zppI0c6tO/O8CPT4AnvAHAq7TnwnZqP+JWs1bM8D9yqBRmUIJZBYDrd/F7C8F5tjesElzEJqnJ4xZ
	4KCdX9mGWMSZgzV2moxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poknx-002BZF-29;
	Tue, 18 Apr 2023 12:51:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poknv-002BY2-00
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 12:51:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5F23C63439;
	Tue, 18 Apr 2023 12:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A09C433EF;
	Tue, 18 Apr 2023 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1681822285;
	bh=awSbJMtl69icfKm+n181Xun+4k6pIOSZgtNyGGaUfOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JiS29D3Yq23WhJXQun2UH14NPv1QRz8JaNngyqeEgudR0zFRwtZyaSeqmz51rYsrq
	 /KKraU1dTtu1qCdIWahOW/zFpOYU3rGdRfQnCdwHxUr9G1uen4hMLpnWzgD/jSN6Nj
	 hMIWdaS1r/nit0qVxqRwei740J9r6Bfz2pTCPGiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robbie Harwood <rharwood@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 092/139] asymmetric_keys: log on fatal failures in PE/pkcs7
Date: Tue, 18 Apr 2023 14:22:37 +0200
Message-Id: <20230418120317.240100647@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418120313.725598495@linuxfoundation.org>
References: <20230418120313.725598495@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_055127_124691_6FFFDD72 
X-CRM114-Status: GOOD (  15.16  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Robbie Harwood <rharwood@redhat.com>

[ Upstream commit 3584c1dbfffdabf8e3dc1dd25748bb38dd01cd43 ]

These particular errors can be encountered while trying to kexec when
secureboot lockdown is in place.  Without this change, even with a
signed debug build, one still needs to reboot the machine to add the
appropriate dyndbg parameters (since lockdown blocks debugfs).

Accordingly, upgrade all pr_debug() before fatal error into pr_warn().

Signed-off-by: Robbie Harwood <rharwood@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: Eric Biederman <ebiederm@xmission.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: keyrings@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: kexec@lists.infradead.org
Link: https://lore.kernel.org/r/20230220171254.592347-3-rharwood@redhat.com/ # v2
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/asymmetric_keys/pkcs7_verify.c  | 10 +++++-----
 crypto/asymmetric_keys/verify_pefile.c | 24 ++++++++++++------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index f6321c785714c..3da32813e4412 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -79,16 +79,16 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 		}
 
 		if (sinfo->msgdigest_len != sig->digest_size) {
-			pr_debug("Sig %u: Invalid digest size (%u)\n",
-				 sinfo->index, sinfo->msgdigest_len);
+			pr_warn("Sig %u: Invalid digest size (%u)\n",
+				sinfo->index, sinfo->msgdigest_len);
 			ret = -EBADMSG;
 			goto error;
 		}
 
 		if (memcmp(sig->digest, sinfo->msgdigest,
 			   sinfo->msgdigest_len) != 0) {
-			pr_debug("Sig %u: Message digest doesn't match\n",
-				 sinfo->index);
+			pr_warn("Sig %u: Message digest doesn't match\n",
+				sinfo->index);
 			ret = -EKEYREJECTED;
 			goto error;
 		}
@@ -478,7 +478,7 @@ int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
 			       const void *data, size_t datalen)
 {
 	if (pkcs7->data) {
-		pr_debug("Data already supplied\n");
+		pr_warn("Data already supplied\n");
 		return -EINVAL;
 	}
 	pkcs7->data = data;
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index fe1bb374239d7..22beaf2213a22 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -74,7 +74,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 		break;
 
 	default:
-		pr_debug("Unknown PEOPT magic = %04hx\n", pe32->magic);
+		pr_warn("Unknown PEOPT magic = %04hx\n", pe32->magic);
 		return -ELIBBAD;
 	}
 
@@ -95,7 +95,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 	ctx->certs_size = ddir->certs.size;
 
 	if (!ddir->certs.virtual_address || !ddir->certs.size) {
-		pr_debug("Unsigned PE binary\n");
+		pr_warn("Unsigned PE binary\n");
 		return -ENODATA;
 	}
 
@@ -127,7 +127,7 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
 	unsigned len;
 
 	if (ctx->sig_len < sizeof(wrapper)) {
-		pr_debug("Signature wrapper too short\n");
+		pr_warn("Signature wrapper too short\n");
 		return -ELIBBAD;
 	}
 
@@ -142,16 +142,16 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
 	 * rounded up since 0.110.
 	 */
 	if (wrapper.length > ctx->sig_len) {
-		pr_debug("Signature wrapper bigger than sig len (%x > %x)\n",
-			 ctx->sig_len, wrapper.length);
+		pr_warn("Signature wrapper bigger than sig len (%x > %x)\n",
+			ctx->sig_len, wrapper.length);
 		return -ELIBBAD;
 	}
 	if (wrapper.revision != WIN_CERT_REVISION_2_0) {
-		pr_debug("Signature is not revision 2.0\n");
+		pr_warn("Signature is not revision 2.0\n");
 		return -ENOTSUPP;
 	}
 	if (wrapper.cert_type != WIN_CERT_TYPE_PKCS_SIGNED_DATA) {
-		pr_debug("Signature certificate type is not PKCS\n");
+		pr_warn("Signature certificate type is not PKCS\n");
 		return -ENOTSUPP;
 	}
 
@@ -164,7 +164,7 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
 	ctx->sig_offset += sizeof(wrapper);
 	ctx->sig_len -= sizeof(wrapper);
 	if (ctx->sig_len < 4) {
-		pr_debug("Signature data missing\n");
+		pr_warn("Signature data missing\n");
 		return -EKEYREJECTED;
 	}
 
@@ -198,7 +198,7 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
 		return 0;
 	}
 not_pkcs7:
-	pr_debug("Signature data not PKCS#7\n");
+	pr_warn("Signature data not PKCS#7\n");
 	return -ELIBBAD;
 }
 
@@ -341,8 +341,8 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
 	digest_size = crypto_shash_digestsize(tfm);
 
 	if (digest_size != ctx->digest_len) {
-		pr_debug("Digest size mismatch (%zx != %x)\n",
-			 digest_size, ctx->digest_len);
+		pr_warn("Digest size mismatch (%zx != %x)\n",
+			digest_size, ctx->digest_len);
 		ret = -EBADMSG;
 		goto error_no_desc;
 	}
@@ -373,7 +373,7 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
 	 * PKCS#7 certificate.
 	 */
 	if (memcmp(digest, ctx->digest, ctx->digest_len) != 0) {
-		pr_debug("Digest mismatch\n");
+		pr_warn("Digest mismatch\n");
 		ret = -EKEYREJECTED;
 	} else {
 		pr_debug("The digests match!\n");
-- 
2.39.2




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

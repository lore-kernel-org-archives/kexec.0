Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBADCC76196
	for <kexec@archiver.kernel.org>; Sat,  1 Apr 2023 01:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ThE/5cNYWcDnNCvdo0/+XsRWRbMZVlrJl9u5cg4X0pk=; b=eQsEi3xGGdY7lK
	6azPhkEdhMpvh0F5gZPyhlMyrYYuyC/r1cReFNRflEnirT+MrF3znpMlmfVpKpAXLOvMeGQrfy3PI
	bTdx1iLxmOn0QpfVlAkKBSH/C8lP6Qy0A8Ri3OBRcDedhkGguApMjzUxyuzlwzKO2M3Wh0PFsRuTm
	SBHJzoPsTQUzZAnwOrfk+w1m83IMoc6pMtOt2fVc6sDmgiBzYkHlWKhuueca4a4TslU6h7KeR5xYp
	DZZQDKjoS6sUaLDkqeiNKhzdSL1gPwK6sXH7Bts6VlSe/ZQB22fiH5/y4pvtHYA8Rmi0Tbu0APRHc
	QEWu1+QX8GYMn/nGpxGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piQFj-009ThD-30;
	Sat, 01 Apr 2023 01:41:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piQFg-009Tfn-1T
	for kexec@lists.infradead.org;
	Sat, 01 Apr 2023 01:41:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 953AD62CE9;
	Sat,  1 Apr 2023 01:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95C5C433EF;
	Sat,  1 Apr 2023 01:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680313315;
	bh=VCwMMj2q4qUoHuODRqKDgoLte/T7yupow6Vv8LVr/gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laM+NLec8+ztdkWgy+jyzT5lINCrpm4fODUsL4hJEfRaot+CypA9GnOXziEWS7jwo
	 YL/xlpGQBl51KWiYhVgsNmaIn61w2OfqWpgumpVXKbWd5XX2bgmjadV9eE2GJO5RkH
	 TJAwrdYwSAHBLFuAecoEviu5nzivk7dyH4+EWXkY7Rv4b+0e5w8HwZLGszUC0vAsIh
	 mJj5OiUgkfXr7D7Qs5uncHhQOZU0w0yGTI4xRUPvpdD8orHYQmLB85iH3IcgbBeBHY
	 Kg4WA15d+4Nj94qzqXP/x7BEunuCJv74b7Bb+J29YW2nd4kG4G1rtrPPXN0xmxdgYF
	 OjkBqv0XFXWOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robbie Harwood <rharwood@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net
Subject: [PATCH AUTOSEL 6.2 17/25] verify_pefile: relax wrapper length check
Date: Fri, 31 Mar 2023 21:41:15 -0400
Message-Id: <20230401014126.3356410-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230401014126.3356410-1-sashal@kernel.org>
References: <20230401014126.3356410-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_184156_572908_2787C75B 
X-CRM114-Status: GOOD (  13.57  )
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

[ Upstream commit 4fc5c74dde69a7eda172514aaeb5a7df3600adb3 ]

The PE Format Specification (section "The Attribute Certificate Table
(Image Only)") states that `dwLength` is to be rounded up to 8-byte
alignment when used for traversal.  Therefore, the field is not required
to be an 8-byte multiple in the first place.

Accordingly, pesign has not performed this alignment since version
0.110.  This causes kexec failure on pesign'd binaries with "PEFILE:
Signature wrapper len wrong".  Update the comment and relax the check.

Signed-off-by: Robbie Harwood <rharwood@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: Eric Biederman <ebiederm@xmission.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: keyrings@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: kexec@lists.infradead.org
Link: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format#the-attribute-certificate-table-image-only
Link: https://github.com/rhboot/pesign
Link: https://lore.kernel.org/r/20230220171254.592347-2-rharwood@redhat.com/ # v2
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/asymmetric_keys/verify_pefile.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 7553ab18db898..fe1bb374239d7 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -135,11 +135,15 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
 	pr_debug("sig wrapper = { %x, %x, %x }\n",
 		 wrapper.length, wrapper.revision, wrapper.cert_type);
 
-	/* Both pesign and sbsign round up the length of certificate table
-	 * (in optional header data directories) to 8 byte alignment.
+	/* sbsign rounds up the length of certificate table (in optional
+	 * header data directories) to 8 byte alignment.  However, the PE
+	 * specification states that while entries are 8-byte aligned, this is
+	 * not included in their length, and as a result, pesign has not
+	 * rounded up since 0.110.
 	 */
-	if (round_up(wrapper.length, 8) != ctx->sig_len) {
-		pr_debug("Signature wrapper len wrong\n");
+	if (wrapper.length > ctx->sig_len) {
+		pr_debug("Signature wrapper bigger than sig len (%x > %x)\n",
+			 ctx->sig_len, wrapper.length);
 		return -ELIBBAD;
 	}
 	if (wrapper.revision != WIN_CERT_REVISION_2_0) {
-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

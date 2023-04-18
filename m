Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E56C6FD18
	for <kexec@archiver.kernel.org>; Tue, 18 Apr 2023 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PUzX5rdR3fvLuWi19bql99+WqgprwRTXJY0CZymX5G8=; b=DWWewtsePXl/ac
	u93LKL0cs3dHHcpzRU4R7WcHUbzmRZb1ED5elVHWpPjDY3cWWzlplT6XJZiKP73wk2C+WpbCeKg0N
	JBfdV4zIyaSKz9QWtb06VWN+TufP5cA/FAnPxlRAsBZdhGUtvDxvnhqfY9t5+d0B1M2Z7U+6QWhqu
	EMqx0DCPlXyCJHMzNel/qbUZ2MdiYDfQrFi0yNoCFgzEbkHVrCfjb8g5+W6qXTiIkcyfZrxUMysBq
	Ciy8tw8s++bekrvJ0quKRGGOM/u6oOj1bBLYJZaHrcADxvu19tno3cojfj3iO7qo6RSUbhSdq5mGW
	YH2BBf4229QK9fcouvQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pokQM-0027x3-36;
	Tue, 18 Apr 2023 12:27:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pokQK-0027vn-0S
	for kexec@lists.infradead.org;
	Tue, 18 Apr 2023 12:27:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A8E8763186;
	Tue, 18 Apr 2023 12:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F5AC433D2;
	Tue, 18 Apr 2023 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1681820823;
	bh=COtBPWd792pj4wDo6QCmYmv27EpEeD8uoH4fJakfhLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PbotKGOYKw7sNKZeahCZW0LgeRiiixVX5nW0ybMeamx+GHro366gUxPkL92TQUQbi
	 mbk/YHgKhDWKduXodEmnSVH1+JJOhKA4Q1uurAamQiZMB9x7VZcESXUnPu63IrpChT
	 K6B9ZY75h9yfbqnXIkXrIyMjcBYto+L1fLPIDgkQ=
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
Subject: [PATCH 4.19 45/57] verify_pefile: relax wrapper length check
Date: Tue, 18 Apr 2023 14:21:45 +0200
Message-Id: <20230418120300.309593262@linuxfoundation.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418120258.713853188@linuxfoundation.org>
References: <20230418120258.713853188@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_052704_258688_FA155FC6 
X-CRM114-Status: GOOD (  14.93  )
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
index d178650fd524c..411977947adbe 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -139,11 +139,15 @@ static int pefile_strip_sig_wrapper(const void *pebuf,
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

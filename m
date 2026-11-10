Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F56606A325
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b/XxK+eg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFNwqN7j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=twr1F7RT5a9JBrrnNWYyZCb/wBzQ0slZtLD1iS/o1lc=; b=b/XxK+egQxPCUF
	UAkoIg8SRDm9yfRYzAMsdbD0rdw3icLFjhp/5SDrUImRH87hLrIlInCSlOcdfOp/dbbpcypOwh6jH
	3Ku+1hkh9G57HiKgnwQQwAVWPMb/UE5Z+/nYZ4G4pnEKnh8munwWX1Ubijx4Xnzi0teRKr2528WsF
	GJntPp78Qfmz/koFnm4p304W1hRqNqglRfNu+nCYxC9I/xCOjyIKoAFGakGPap3oKXCotygZSDB3s
	V//OYUOgJ900QtQiEAwQ6+c4LbZZxoiFbk0TK+77Ea92aPcroTwN3WQSyt/tyh+Opa8J3Ji0IFN0W
	nIGA8vdF4T8jeOKA1P3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8O-00000003eNe-1lUl;
	Tue, 10 Nov 2026 11:35:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8N-00000003eNJ-1CeP
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 11:35:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B94E45C15;
	Tue, 10 Nov 2026 11:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52361F008A1;
	Tue, 10 Nov 2026 11:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310526;
	bh=twr1F7RT5a9JBrrnNWYyZCb/wBzQ0slZtLD1iS/o1lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FFNwqN7jx9gEscRubNx2UdmLDI9XpPkSNGxwNrYBbHOvSqGKzYSHpLAI1moeufNfM
	 l93Q9frxuVR8Lhms5RAheBXFDMpxHZq9/VnHb3bs4SedqfONgjOG0D6DrtLDpv5vi9
	 2Z4lQlS7xaLcNG8AXLr2SCrO5MapsJMQ8/uQmrTKuvRWBfIp/Q74hMyNP+DGkjA+Gu
	 IAanh3VBjpqYedAAx8TCDXASvlJ8d1wdMw0d2V38sU9mmba9bPcBNDSySviuzxZ7+H
	 yoNCObSxgt4oveSQSdeq4Ah66f2i6ya/Kp3tHqbPEhegvEQR4eLQH8TwwlTx6lO/kZ
	 v3awN0CKhxMoQ==
From: Simon Horman <horms@kernel.org>
Date: Tue, 10 Nov 2026 11:35:16 +0000
Subject: [PATCH kexec-tools 1/3] uImage: use goto for unwind in
 uImage_gz_load
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-2x-overflow-v1-1-8f3598b31a43@kernel.org>
References: <20261110-2x-overflow-v1-0-8f3598b31a43@kernel.org>
In-Reply-To: <20261110-2x-overflow-v1-0-8f3598b31a43@kernel.org>
To: kexec@lists.infradead.org
Cc: Tristan <TristanInSec@gmail.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.3
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the case where an error requires uncmp_buf to be freed,
which is many cases, use a goto label rather than repeatedly
open-coding this clean-up.

This is in preparation for adding more such cases.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 kexec/kexec-uImage.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/kexec/kexec-uImage.c b/kexec/kexec-uImage.c
index 016be105646b..76b8c73a3494 100644
--- a/kexec/kexec-uImage.c
+++ b/kexec/kexec-uImage.c
@@ -157,16 +157,13 @@ static int uImage_gz_load(const char *buf, off_t len,
 	skip = 10;
 
 	/* check GZ magic */
-	if (buf[0] != 0x1f || buf[1] != 0x8b) {
-		free(uncomp_buf);
-		return -1;
-	}
+	if (buf[0] != 0x1f || buf[1] != 0x8b)
+		goto err_free;
 
 	flags = buf[3];
 	if (buf[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
 		puts ("Error: Bad gzipped data\n");
-		free(uncomp_buf);
-		return -1;
+		goto err_free;
 	}
 
 	if (flags & EXTRA_FIELD) {
@@ -190,10 +187,8 @@ static int uImage_gz_load(const char *buf, off_t len,
 
 	/* - activates parsing gz headers */
 	ret = inflateInit2(&strm, -MAX_WBITS);
-	if (ret != Z_OK) {
-		free(uncomp_buf);
-		return -1;
-	}
+	if (ret != Z_OK)
+		goto err_free;
 
 	strm.next_out = uncomp_buf;
 	strm.avail_out = mem_alloc;
@@ -211,17 +206,15 @@ static int uImage_gz_load(const char *buf, off_t len,
 			new_buf = realloc(uncomp_buf, mem_alloc);
 			if (!new_buf) {
 				inflateEnd(&strm);
-				free(uncomp_buf);
-				return -1;
+				goto err_free;
 			}
 
 			uncomp_buf = new_buf;
 			strm.next_out = uncomp_buf + mem_alloc - inc_buf;
 			strm.avail_out = inc_buf;
 		} else {
-			free(uncomp_buf);
 			printf("Error during decompression %d\n", ret);
-			return -1;
+			goto err_free;
 		}
 	} while (1);
 
@@ -229,6 +222,10 @@ static int uImage_gz_load(const char *buf, off_t len,
 	image->buf = (char *)uncomp_buf;
 	image->len = mem_alloc - strm.avail_out;
 	return 0;
+
+err_free:
+	free(uncomp_buf);
+	return -1;
 }
 #else
 static int uImage_gz_load(const char *UNUSED(buf), off_t UNUSED(len),

-- 
2.56.0



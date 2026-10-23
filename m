Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107660A2607
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SX7Iy8OH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkuXtjy1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Cc:To:In-Reply-To:References:Message-Id:
	Content-Type:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KUj2wD1kfsmWk13djYVHAZbCTEuU9wsxHyV80zm6Q7M=; b=SX7Iy8OHFJUfj2lSdWEReS4U1r
	SrMuouAc1Wc6huBBl5Zpc09OOt2Jo2d2it6zHAckjtdYAuSh1Y+96L25VGl39LFW63PDPbssg/Sys
	9CvQ0ScUpKKqBU5HVkBlAZRu1REeMAT7ERJOAyqccgEQ9ym5gQlsAKgIOeSp9H3wb5os3m+6jwd5y
	M7xXRrjXlBg1D/pGdCQkHdLx6BVPgXjTugW/HiSDTYExK9HYTlyldip0vO5ToJj6eXRQuHnnGM1yk
	1tClULCdRIWTq4Svi8dNnFXVVXKB3OOVlX0DS8/9OF8yStF+w0wRgY/FHThWDUvyLDZwrGLAbGnMy
	Q/84HB7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mF-0000000Fl7V-11n6;
	Fri, 23 Oct 2026 07:33:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mD-0000000Fl4j-14DN;
	Fri, 23 Oct 2026 07:33:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 51B3960A80;
	Fri, 23 Oct 2026 07:33:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792740799;
	b=QwzEhnGzAyaOj5mIr7jiYBIlo5ngKCq2wCE69zr9mOB1a1h3Fq2fMMKNLNRnYFVGAIG7
	 Q61v3EPch0vmGrniKZLyJqFWdla5vv5GqOZgWXEGq3ck9A+7Mq7+dStJlNC1lqnIa/KbK
	 d3njWXi2Q2HfmpwoYbrvLaAXnk6iT6Fisks80V0fB5zEp4NbYqOTk//hdAOnx9yshFDro
	 3FhqlYkSSQlTQm1qLWZimMx3LtMgcdmrmZZ139DkmpOqFa9hTMONRppYAl9/nXMdgt9J1
	 agK1UpQk7eMu3duGvUuysaJSNwMnA/TM7fuykSHC3RFnueEY2g83OKcRk+O5wOMLJ1w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792740799;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KUj2wD1kfsmWk13djYVHAZbCTEuU9wsxHyV80zm6Q7M=;
	b=WScygSanCYIH5/fmkHwhaOroi9Frtludr+C1GOu8ZMF5tEJtBcRfLl4BEPFomumKRdHO
	 iRdYYWaqy2MMYjNxwpanMXPQyXz9x3onevNxVBuL9aAdJPKvBb6mSgb88z8Jr7/CTGN3Z
	 2Me4oAFt/RsCTK06sTXIsdGojRwXQ3Xbym7uC60iNr1GlMWLF7E3k42y5VwrZmugdc2hy
	 nsol3no48/CnLFB2WXNFNioYWnlpZyAiJ9s3YrpIloVTtjkErFDxI+EumtKdumjWsM8a+
	 xRFUMWowPaizCKxxzavnpYik50uNWP5lM6D50HU1H9abyZVEU9tWYJm05WPEhDPkxWw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF1DD1F031E1;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740799;
	bh=KUj2wD1kfsmWk13djYVHAZbCTEuU9wsxHyV80zm6Q7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MkuXtjy1qcLNm4KOIX0Un8yaV7ALrVBccEi1dic/3zTwfAPdIDFW2U4JIojjIN912
	 bChLfVpknqmtKeZ0+LRUNYCDdTV/dHUHYrv3T6bK8KdbuWqsN0QyiXItwdbRDUqJY0
	 LSv4Bz0HXTz3Qp352AsT5Cqju+2ktGSkk8BxrKs1c5IPkV815zlvQcnURtxEA5cICl
	 p0AqAaBr/IVtztIuWmfLNfKoZqTl3qihy+LYG9M1iRYGWfc+/n/AlGA+fwWEegqUpo
	 d2FDZKHoRmTKbhIJvOtGp5l5cHsUfwer2wd8L8Qzxu4LIDdKi6DRQA2xg5bA7Bb8hA
	 NXn0A/mVJyY9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 63515443F2;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Fri, 23 Oct 2026 15:33:17 +0800
Subject: [PATCH 4/5] kexec_core: Clear the unused part of CMA segments
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-riscv-kexec-cma-fixes-v1-4-825b90ea23c4@iscas.ac.cn>
References: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
In-Reply-To: <20261023-riscv-kexec-cma-fixes-v1-0-825b90ea23c4@iscas.ac.cn>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Yao Zi <me@ziyao.cc>
Cc: Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kexec@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792740795; l=1247;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=WsDVC64bHfydftrHjB9ROmcnpvLdDMLm7LAG2iAtKWU=;
 b=DHa8l1upqFe8GF0mr/wI7BJo0OZLh4M+VDC9vtw7ebm3LQOk9dhQ/R3IcFgCVQ3BmqCnUxdFj
 9V4k04q5zHwBlic6h3xu2XScMsBcX0ln1yqzAgLHbr//OOGGibK8100
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: gaohan@iscas.ac.cn
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Han Gao <gaohan@iscas.ac.cn>

kimage_load_cma_segment() copies the source data into pages that are not
cleared, but zeroes nothing after it: the final memset() runs once the
loop has consumed all of memsz. The tail of the last source page and
every page beyond bufsz keep stale data, while the purgatory digest
covers them as zeroes.

A kexec_file reboot then stops in purgatory on a digest mismatch, for
instance when the DTB lands in a reused CMA page.

Zero the remainder of each page instead.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 kernel/kexec_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..0d6e10bea4e4 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -780,15 +780,15 @@ static int kimage_load_cma_segment(struct kimage *image, int idx)
 			goto out;
 		}
 
+		/* CMA pages are not cleared: zero the part without source data */
+		memset(ptr + uchunk, 0, mchunk - uchunk);
+
 		ptr    += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
 	}
 
-	/* Clear any remainder */
-	memset(ptr, 0, mbytes);
-
 out:
 	return result;
 }

-- 
2.55.0




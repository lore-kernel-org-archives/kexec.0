Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AB2606A335
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FFurO4Me;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WwmQQf6v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=lZk0hxrj7GeGxYuNVNJ+4sQvcVpA6unwQ9xAw4Q2D3A=; b=FFurO4Med3CJfIiBlqDwkZfZkq
	6rhHTOo3VL6JcFdaSmq8vBerGbeTkJJ7cU+u6yFemF/WTve0suNZ6NfCQDJ10uxQ2BeRSAeKP8iC7
	upZpsp6Ob3Op0DQPJ1XLNr6La6dLJMcXHbHGPMV9+G5GUGRBhuBCajMuFr6oEy/ipER01LK3Rqg9i
	HLNowC1Lz/JSwfWU0ySnQz1w9z3FUu7tR23WpiqKMwfYcyZE0WLRbky7WQD7uqApWc1C+/JXNdWXT
	x/ihRznFBN/S6pye6ZUABvIdycc3q7nMFa/MXtWiuXCUhqY3ivMous71vR4aF/tKWv6FS2a1h/h4h
	kRV04wXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8O-00000003eNY-1U8Q;
	Tue, 10 Nov 2026 11:35:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8M-00000003eND-1vXO
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 11:35:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB1AA638B0;
	Tue, 10 Nov 2026 11:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0D81F008A2;
	Tue, 10 Nov 2026 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310525;
	bh=lZk0hxrj7GeGxYuNVNJ+4sQvcVpA6unwQ9xAw4Q2D3A=;
	h=From:Subject:Date:To:Cc;
	b=WwmQQf6vB6XWb8WsjWZPAQPSehzqrA+Hr/pUGrTLfPBaHu4B6PuaBq/w0+K7c968q
	 IXFCsTYJQyyT7OkFrT4sMrFZOno2fv+IzRzsOW2+xZAOcf36iMIwfioFsbXRy3Z6No
	 /jypBYMFCRmwoD0XvfkVhOi7+DQF8/9cZ1/AExN3I2Un+31yjH9dMa7OGK1gM90MVh
	 mPvWMe7EZaAo3NEZ72KfzvbXGfPsNk4ZvwxqPAC+/KPtciBOkzYGPSiEQW3EY/RJWP
	 FMBrkTIUH1s8QL4xU7V2TUMWJ2MshObeGcSbUcVOnS9rCjIx444xnx5Bymj7DN/8T1
	 1O9V6stMllakQ==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH kexec-tools 0/3] kexec: bounds and validation fixes for
 uImage and PE zboot
Date: Tue, 10 Nov 2026 11:35:15 +0000
Message-Id: <20261110-2x-overflow-v1-0-8f3598b31a43@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMBAF0atIr20wITjqVcSF6M9Mo9iSiAbEu
 xtm+RZVN0UEQaSuuCnglCi6ZZiyoOk3bl+wzNlkK1sbYyq2ifVE8Kte3PixRf1B46yjXOwBXtL
 /1tOChIkP1TXS8DwveJl+eGoAAAA=
X-Change-ID: 20261110-2x-overflow-8fa9e67e8424
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series addresses two bounds validation issues reported by Tristan
when processing untrusted or corrupted kernel images in kexec-tools:

1. In uImage_gz_load(), optional gzip header fields (EXTRA_FIELD,
   ORIG_NAME, COMMENT, HEAD_CRC) were parsed using unbounded scans and
   offset arithmetic without verifying whether the computed offset stayed
   within the input buffer. This could lead to out-of-bounds heap reads
   or buffer length underflow, crashing kexec.

   Patch 1 first refactors uImage_gz_load() to use a common goto unwind
   path for freeing the decompression buffer on error.
   Patch 2 adds the necessary bounds and length checks.

2. In pez_prepare(), payload_offset and payload_size are 32-bit values
   read from untrusted PE zboot headers. Adding them directly could wrap
   around, bypassing the bounds check and causing an out-of-bounds read
   when staging the payload.

   Patch 3 checks that the buffer is large enough for the header and
   avoids wrap-around by using defensive subtraction.

---
Simon Horman (3):
      uImage: use goto for unwind in uImage_gz_load
      uImage: add bounds checks when parsing gzip headers in uImage_gz_load()
      pe-zboot: fix integer overflow in payload bounds check in pez_prepare()

 kexec/kexec-pe-zboot.c |  6 ++++-
 kexec/kexec-uImage.c   | 61 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 22 deletions(-)

base-commit: 0fd0d8e9ea975696fdc05ad267a65f3efd415612



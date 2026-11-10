Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2299606A321
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FYpddMa3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHTiUZdN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Nii9+woBobFNzWI2zsiCQL6n12SwB6EKdsqGbp7DAw8=; b=FYpddMa3/28hzd
	hf1/WqDe7/hRnM6kRqrtLXT2eztHPFmhNyZrYcI83kB3knPnhVsR8BGHHtMEZFgtimvm2H48XbLY2
	YVB7OlgVL/tlUFj9Ubb/QDxqokvbQE3pqZlQy0TngOyS21e8RdQo7sOCCiA+xpVtbjof6vxfGWM5g
	kJsiDrUoghgMUfIyLD5i9vTizdyFKuwti7drGF3h6YfN+DrhofgBvVluSRgVcLSi6PYg7cSvAd1oE
	kBe0Td5XoJL8Mm62zdmI2yHWrY/s5l3LLpN2M9wfs9TuvRDB4EScJrUB/ojOsLZqTFyJpbu4PgRVm
	6QM7BEd3XQs4Pn+RGDnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8R-00000003ePS-2RP2;
	Tue, 10 Nov 2026 11:35:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQk8O-00000003eNz-3ebD
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 11:35:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F4C641A9E;
	Tue, 10 Nov 2026 11:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCFA1F008A1;
	Tue, 10 Nov 2026 11:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310528;
	bh=Nii9+woBobFNzWI2zsiCQL6n12SwB6EKdsqGbp7DAw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZHTiUZdNwNU3z79VuulnqfAE7FkXTKDJX9gmgFkuU0SrhtWfzUcCzHbzkA7QK2Ach
	 eySP7O2/4m6dh0FQ5oXiKICNDTZ4yDB4i1PXMxypbL09dPozn76NkjC0/gmG4wDD1n
	 AiHvK+o0ly4xyV+0OuMBAiGRJQYvWSxU+1Y0Jmlq78b8pwM4sQwcvUVPs9xkfDDDtM
	 lUu2AMjUJ3Xo7pXgB10IsXG8uwq1XleehddxNcxwhrwF5M/7bhyZosh2XjNP2Fuylf
	 9ch1ZnZ/j5/R9nNPpou2uv8Vg85bzk9N/dc4KpPyOuFGXblt7QDWitmuFEAy7alVCY
	 xVUFpVuXxIHvw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 10 Nov 2026 11:35:18 +0000
Subject: [PATCH kexec-tools 3/3] pe-zboot: fix integer overflow in payload
 bounds check in pez_prepare()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-2x-overflow-v1-3-8f3598b31a43@kernel.org>
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

In pez_prepare(), z->payload_offset and z->payload_size are uint32_t
values read from the untrusted file header. The validation check:

    if (buf_sz < z->payload_offset + z->payload_size)

performs 32-bit unsigned addition. If the sum wraps around, the bounds
check succeeds, causing a subsequent out-of-bounds heap access when
writing the payload to the temporary decompression file.

Also, ensure buf_sz is large enough to contain the zboot header before
dereferencing its fields.

Prevent the overflow by checking that z->payload_offset does not exceed
buf_sz and that the remaining buffer (buf_sz - z->payload_offset) is at
least z->payload_size.

Patch written with LLM assistance.

Reported-by: Tristan <TristanInSec@gmail.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 kexec/kexec-pe-zboot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec-pe-zboot.c b/kexec/kexec-pe-zboot.c
index c09f2ae7714b..c60e543b68e3 100644
--- a/kexec/kexec-pe-zboot.c
+++ b/kexec/kexec-pe-zboot.c
@@ -51,6 +51,9 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
 	struct pe32plus_opt_hdr *opt_hdr;
 	struct data_directory *dir;
 
+	if (buf_sz < (off_t)sizeof(*z))
+		return -1;
+
 	z = (const struct linux_pe_zboot_header *)(crude_buf);
 
 	if (memcmp(&z->image_type, "zimg", sizeof(z->image_type))) {
@@ -69,7 +72,8 @@ int pez_prepare(const char *crude_buf, off_t buf_sz, int *kernel_fd,
 		return -1;
 	}
 
-	if (buf_sz < z->payload_offset + z->payload_size) {
+	if ((uint64_t)buf_sz < z->payload_offset ||
+	    (uint64_t)buf_sz - z->payload_offset < z->payload_size) {
 		dbgprintf("%s: PE too small to contain complete payload.\n", __func__);
 		return -1;
 	}

-- 
2.56.0



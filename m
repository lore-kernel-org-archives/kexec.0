Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BD606A337
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PKwWY5ne;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNfQvBY2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Cc:To:In-Reply-To:References:Message-Id:
	Content-Type:MIME-Version:Subject:Date:From:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DXlkibDr0eUyUlFexrKUMNsRMFOBJ97mIZORHlS7eX0=; b=PKwWY5neJ5YpJL1GFMSZmSACeq
	4OoQJnIBzw/c76GEFP2dlzdzd2y7kLUz7D7wj7mhUt9ok1TnPCngv5Gr9NYWLJT18ycIHyUeHWOX+
	LmS+uL0A5XasgmTUxxI0KgnwtFSc5u/9IYKXIrdpF6TARUsz/l4iuaMeP/lmoMMKVs2Q6lj1RCGQt
	U3XOBsdeoKdENgTCHhURql/J4pbB819QD+eEyTo+PLqP+5W/6Af64GfS+t94Qx4g4S6tg1q0kpSpl
	w2FXzajzSVSc7KqjrLEampT+BtnT/RdQ2LLEzAUW9pePM+n2pSl0KDr7wJsurPucG9VlTIz3xetop
	1I01r/8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mD-0000000Fl4q-0Ku4;
	Fri, 23 Oct 2026 07:33:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9mB-0000000Fl4D-2SI5;
	Fri, 23 Oct 2026 07:33:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 40BFA43F12;
	Fri, 23 Oct 2026 07:33:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792740799;
	b=rd7ue05xxdSpH4/mCZSXwKw66p1zO4BLOzmEWnMfSZkBKTVSdDoZxM0owAnUmhJy9gZc
	 +t2gALfQ5IY6uiVFWgogQyvvMf97UHQVvtOutfs2csrwsxivmaenpJMHzwOJ2rLJkYifA
	 WvfA+IFE+byaUYj39I/VoeFyn+V5PiBDbSpoURVrn/8AlNg7HicKo0sTdnH6F7UcDi6LA
	 Yh7F3DjVH1+r3aNM3ynfUCRHTYJzWc/c2/07R7vMXvJ3/NK0lhxYY7UZru7NadmPJ7u09
	 iZdOK00fhVnqF0hRzNmcazSZgltsWZXVbqxarFy0zicjA4URs0FjC1Ap6Z4qrcTmXjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792740799;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DXlkibDr0eUyUlFexrKUMNsRMFOBJ97mIZORHlS7eX0=;
	b=MIo5Bm1knn8mQVToCCMd4Jn3pzQxoPhOWW29I9ErcfFKlcLWM+hm63lF1+MeKEva1Qd6
	 NCzS4qBqAWGxe5c20Ri2wx6My9peuNvxUOGlah4VXZDXa8JJzpJ9oB8TVRgv8juL+QZCG
	 68sqlFA8oAszWLYc8MO5rC67HN94oqZPtEenoSm2nz+SST4U8UPZdsgDPS5Eb7roOVWQw
	 APV6sUe9kh5IFgBh9a8lkzfxyiwjiX2QubNlT4N75taFTvDyDUufMEChEXcczGs50Khhv
	 Z4ISzpJWImX5QCqtyJ+m5l15KDEqyYX1osgG+tZuBuYjsccqWk4vzfN1dryos0UlSmw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DF2971F031E2;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792740799;
	bh=DXlkibDr0eUyUlFexrKUMNsRMFOBJ97mIZORHlS7eX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZNfQvBY2vmAQxxDMUzg3DBouLY9zqbB9yRtJuBS913YQL7RJZ8HKzQyrDDZM+72Pu
	 ujvLKC7nkfPZUrLE2hpWBpUB0aNy1oVsyetC1Bo5OfhGumjbldEDv8a1JH3eqE1A2v
	 buTwZ4TtFqvfmU1wFsiLXUbK6tC07yJRA7yzqUCjf1a/R8Lm6ttPHl00Emuyab9EPE
	 v3ok1tvJapb3dRtG1PTdtpy733a3xI4RAluumV0vmQj2moqfNh7dxX8EVcNBctCd0J
	 ypCnbMddeEXK6gh1C/znp9o0CD+grXlOuIPJTGLZrfx0O1ZZ0hNfQpHSHh/tCPOfWT
	 kb/1MFbLb6+XQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5AC29443EE;
	Fri, 23 Oct 2026 07:33:17 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Fri, 23 Oct 2026 15:33:16 +0800
Subject: [PATCH 3/5] kexec_file: Honor the segment alignment for CMA
 allocations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-riscv-kexec-cma-fixes-v1-3-825b90ea23c4@iscas.ac.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792740795; l=1480;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=qJEDPA0ppewD/2akK6SOlKkXPbYM3Y6vYk6RoryMxR0=;
 b=k2WWS6RTJ6LmCg0h1zKhwYN75d0Cz5RFyTNujkDVbhWiDu1L84xl9pr9j0UyBeqXCXktEAl1S
 b8+pMaOPh4vB3By4HbvwIG+rIw9MQ2jqBYyRbEonik0/PRAt8W4WIsi
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Han Gao <gaohan@iscas.ac.cn>

dma_alloc_from_contiguous() limits the requested alignment to
CONFIG_CMA_ALIGNMENT without reporting it. kexec_alloc_contig() can
therefore place a segment at a less aligned address than buf_align. On
RISC-V with 4 KiB pages, the default 1 MiB limit is below the 2 MiB
kernel alignment, and the new kernel stops at the setup_vm() BUG_ON for
a misaligned physical address.

Release such a block and fall back to the regular memory hole search,
which honors the alignment.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
 kernel/kexec_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 59fb9d71e9d8..6ce10e01414e 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -690,6 +690,13 @@ static int kexec_alloc_contig(struct kexec_buf *kbuf)
 
 	mem = page_to_boot_pfn(p) << PAGE_SHIFT;
 
+	/* dma_alloc_from_contiguous() caps the alignment at CONFIG_CMA_ALIGNMENT. */
+	if (!IS_ALIGNED(mem, kbuf->buf_align)) {
+		pr_debug("CMA block 0x%lx is not aligned to 0x%lx\n", mem, kbuf->buf_align);
+		dma_release_from_contiguous(NULL, p, nr_pages);
+		return -EINVAL;
+	}
+
 	if (kimage_is_destination_range(kbuf->image, mem, mem + kbuf->memsz)) {
 		/* Our region is already in use by a statically defined one. Bail out. */
 		pr_debug("CMA overlaps existing mem: 0x%lx+0x%lx\n", mem, kbuf->memsz);

-- 
2.55.0




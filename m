Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5B606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fCnoDfp9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EaLh/6q+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5VB5qhCoF+hKw7FRYHj35iqxhNrTooXTPp5tmOWH1Uw=; b=fCnoDfp9mVhVZ296/C7i4PRM5y
	UqJmw7ZUlDqaGhvSY/T1hxerpGqVprdCBbdYj7n0ogZ1q0/NuoOoZD94YnN5FXgZ5dOpy4Hui1DBR
	5ayJEeFi0bK0pvzxS3tFo4rYwV7FATMsePvY34Lqdi5CGtxlqOk9zn7UGNsAaOdYISTueQ3EKsGpY
	Be5looByIcf6RMVnMc621u+q9MWNbCLClrYK7CFISiimW3ALi2RSfs3+QWCkVNKSUw6UCAfenZVQa
	dQX19N3Kt6tq84ISgOe74opBrIt6c2eAoCbMM1eUqk+jzZ7bfCbqP8FvoBYkRdvDzYpnyF9/2kZUn
	vDy+sD0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOds2-00000005z7i-1bnI;
	Wed, 04 Nov 2026 16:29:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOds1-00000005z6V-1f2L
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:29:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A9A341821;
	Wed,  4 Nov 2026 16:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2790B1F00A02;
	Wed,  4 Nov 2026 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809793;
	bh=5VB5qhCoF+hKw7FRYHj35iqxhNrTooXTPp5tmOWH1Uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EaLh/6q+0Er1AD1ClCQ9rnenl5yFzX562DfhFLhTWDB6zAi/rdEjN23zyW/+++V3y
	 bwzupo2BS+Slh8PHZfsUJEFdpHP/0Wni45DyouDUq9rHKOZva1NQO1z2ge+PvkcrRL
	 4XpN8CprCzvwtlXwIEOeE+Zl7ologB/Vf+fhmjg17GxotypG5019R7qccSeyT+2/E9
	 mLpCDTu3ofnBNf2uwq23HfUgW1JaLNNz0ipqvxo4qb7PjpAotDJOQgU9QWqlcZIs05
	 +lA7JuiNmU+WCdIBwbHYH0SvNK4KGxuIe3VwYLEgQ/WfGXtV/TSd7h/5tvGxfYNpZn
	 JEKQx7WG2rZbQ==
Message-ID: <sashiko-outbox-197615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] mm/cma: drop the duplicate alignment check in
 rmem_cma_setup()
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>, robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, m.szyprowski@samsung.com, robin.murphy@arm.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20261103162429.2053989-5-radhey.shyam.pandey@amd.com>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
 <20261103162429.2053989-5-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:29:51 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> cma_init_reserved_mem() already refuses a base or size that is not aligned
> to CMA_MIN_ALIGNMENT_BYTES, so the identical test in rmem_cma_setup() only
> repeats it one call earlier. Remove it and report the failure from
> cma_init_reserved_mem() instead, where the area name is available: the
> message now says which pool is misaligned, and every caller gets the
> diagnostic rather than just the device-tree path.
>=20
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103162429.2053=
989-1-radhey.shyam.pandey@amd.com?part=3D4



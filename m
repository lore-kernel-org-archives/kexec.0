Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925F606A33D
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cKCb2JBl;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OR6W0S/T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cc+V/MWt8aL7QEW7GFPqVnPFR4jam1MuxesGjzwXo4M=; b=cKCb2JBlV12+I4LEfEs2ewYfPE
	gDRA9Se+RTpRn28scvfZ+/8o7lpZ0DPg58JMH1mF17ZvJAtPbsAfmXjwck9WZ+fE8OD8SH6ffRf8l
	ejx3eBIDy3QkXAubaMZRMVwWsE15LsxkXac3jXY5PJaAfEzu+Xufka1M8xiBHBin/OJUkGxIXLOgO
	geWqQ5zjuNZIoGSARBaYAJReFdl4pPOljbpujvCpCAuu/kbObziSJYooGaQLj2jdXID1ip+taaC3P
	5pi0at7EErsV3XGWNXRhtNdADClZgQoZyTJTqmJdMBsMVWbtd1h69Ze9TNJT6aSv+ltC81txI9cx4
	cJkVvOXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOds0-00000005z54-09RP;
	Wed, 04 Nov 2026 16:29:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdry-00000005z40-3cwQ
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:29:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5854541763;
	Wed,  4 Nov 2026 16:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E991F000C1;
	Wed,  4 Nov 2026 16:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809790;
	bh=cc+V/MWt8aL7QEW7GFPqVnPFR4jam1MuxesGjzwXo4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OR6W0S/Thrpal/mIQXK2yR37/HM0IiF1dd845frkfVLimAHPVtJ9vjT3ci891pvaA
	 uJuDHN0ArZUsTStk3K/Xur8CKFmezWyxa03Wi7BjVmicu6Ta4KNUa16YKK+nMZab9I
	 vgDIlmP4f9ab/9s4mCAOZ5zd6GW8hkVsxLFvSXQvmucLvoCVS3co0dcIWc11dMxuME
	 KAbjLMF5UOGv0E8XJWDwNGXA7xTkHesSN0cp0437k0/YmGSp/4g9rpHlu3ud+9+K97
	 d0Qn4kVg0uV9skuGahaX4xsbDULfgv9pg3ElgXiOLlwg2YkpT/uxKwNILC9wD//OLo
	 XHp6Mh6uGIlSg==
Message-ID: <sashiko-outbox-197613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] of: reserved_mem: keep the reservation when
 node_init returns -EBUSY
To: "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>, robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, m.szyprowski@samsung.com, robin.murphy@arm.com, baoquan.he@linux.dev, pasha.tatashin@soleen.com, pratyush@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20261103162429.2053989-3-radhey.shyam.pandey@amd.com>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
 <20261103162429.2053989-3-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:29:46 +0000
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

> fdt_init_reserved_mem_node() treats any error from a region's init functi=
on
> as "this node is unusable" and calls memblock_phys_free() on the whole
> range, although the range was reserved earlier during the FDT scan by code
> unrelated to that init function. Give -EBUSY the meaning "cannot be used =
as
> described, but must stay reserved" and skip the release for it. Nothing
> returns -EBUSY from node_init today. The next patch does, to refuse a CMA
> pool overlapping the kernel image, which without this would free
> [_text, _end) rather than protect it.
>=20
> Suggested-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103162429.2053=
989-1-radhey.shyam.pandey@amd.com?part=3D2



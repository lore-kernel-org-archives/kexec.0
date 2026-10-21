Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFC606A32F
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ot74G5cw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mt3hXrxe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pAAU30bwGvhgKc2fcWmaPUnM+q1nxRImGaxZJ4BonqU=; b=ot74G5cwQrVVqSnN/ePbkW9RPW
	oCin4oOu2IYdeVnODqSi+8WwWEysCAE6W6zvY4XYq6+sZfh6rCKXHSrXxrg3XVEiFpC0T/Wm1uGkf
	d/DuvSWxeS0Cr+6Qvr0tOnPKPeYkSg1aeSw4E4ErxvLpXN8tDD9zGjGPtAQyiN+KDRrV5P8n9A5jH
	uQw9OKBo7o2iepChiUvA8obR05ms709/0PJDPdKL/qjdEfVTtbe28k6IGdEzp971LYhY2anluluXe
	aLGIQvCfHM/wup00yKKML4H3OBpJBumRvWmaMZwE2AUGyisy6uoaefyJCVviMe78PEk0A5U3ynojH
	Tfffln1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJWHg-0000000Btds-3bJ2;
	Wed, 21 Oct 2026 13:23:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJWHf-0000000Btdb-2TOp;
	Wed, 21 Oct 2026 13:23:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 89ACA601F1;
	Wed, 21 Oct 2026 13:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039AE1F000C4;
	Wed, 21 Oct 2026 13:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588990;
	bh=pAAU30bwGvhgKc2fcWmaPUnM+q1nxRImGaxZJ4BonqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mt3hXrxeKJoJfLibADZIcsXR7rI+NO9d5jFB7CsWQi7wKkA7Ivi+NuujoLsu6N0Sj
	 xeAk+R1NrRVYx1sYEncPNYK1tOB4gOmoV/soXvOeMmPj9evSIL4UZE8ME5ru4NQo5h
	 rdmao/ez90tKUwo3/XUgCH2iLLiz95UkX5/e2YrP1miGaCfo8O/R8cfIYLVig3VVnr
	 r1iNDVPFLS7bpM7kU7EAqqH+8hkxOiLRbqqi3tb+hZaOnZwWSQEHk7khqjrR4q7t3A
	 S0lU2etMBYUN25UboD24fjrlEjMmDt+fIwEsaB4T+GmpTzCmxcQVMevggk/I2FaJ6K
	 4dRr3m+UTBq7A==
Date: Wed, 21 Oct 2026 08:23:08 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	saravanak@kernel.org, akpm@linux-foundation.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v9 0/8] kdump: reduce vmcore size and capture time
Message-ID: <20261021132308.GB3667411-robh@kernel.org>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 04:30:03PM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU,
> camera ISP, ...), kdump currently dumps those carveouts as part of
> system RAM even though their contents are firmware state that is not
> useful for kernel crash analysis.
> 
> ACPI systems already filter reserved memory out of the vmcore through
> their existing path: firmware reports those carveouts as unusable in
> the EFI memory map, they get MEMBLOCK_NOMAP set in memblock.memory
> (is_usable_memory(), efi-init.c), and the ELF header builder has
> always skipped nomap regions; only DT-based systems currently fail
> to filter these regions, which is what this series addresses.
> 
> This series introduces a MEMBLOCK_NODUMP flag (suggested by Rob) in
> memblock to filter reserved memory on DT-based architectures. A new
> flag is needed because MEMBLOCK_NOMAP can only express regions without
> a linear mapping, while MEMBLOCK_NODUMP can filter regions that are
> linearly mapped. Reserved regions are marked MEMBLOCK_NODUMP by default
> so kdump omits them; reusable CMA regions are different because their
> pages are handed back to the buddy allocator and may carry crash-relevant
> data.

There is little point in continuing to send new versions until Mike 
agrees with MEMBLOCK_NODUMP being added. You didn't answer him on v7.

Also, I intend to apply this[1] before any further reserved memory 
changes which will greatly simplify the code.

Rob

[1] https://lore.kernel.org/all/20261015082315.56876-1-m.szyprowski@samsung.com/


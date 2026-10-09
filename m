Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A555CA9EBD
	for <kexec@archiver.kernel.org>; Fri,  9 Oct 2026 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kAD7jZL3WT2oDggDD/W1Uk0YnF3NERQV17t5J8hJ8+M=; b=HbZvTFiuULsJI5+oXbM6dmEJpG
	Jl+TFsE98FtSjK6RVWxIUWQ8csdOjlkayvWtH/0V7+N8ERwEepD5q4BpIKDDSeYhJCGunAa22iaBr
	OYtxu2jeSewEsAWlQ7I/MoyREDB8aEDymkEw1jx1HctGgI6iwE6DaKpiwTbWyAIgn5M+vD6MelGI/
	08MW6RuplKgZtArurIu+T0piXpAq5/EgsqenVz6eEVKrX4/JdbeZrct4CcFOle132bLkIZLENRXtj
	u4RBlR5oV9kd9AqFfxCE68dWvXIUBMCGDPdKj6GvUivNxdzQdJ9Q00hHXg8ND0hq941oWcc9VEoAM
	0vIhmVAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFE73-00000006lYT-2Hn3;
	Fri, 09 Oct 2026 17:10:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFE72-00000006lY7-2T3J;
	Fri, 09 Oct 2026 17:10:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E468243F04;
	Fri,  9 Oct 2026 17:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F951F000FF;
	Fri,  9 Oct 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565827;
	bh=kAD7jZL3WT2oDggDD/W1Uk0YnF3NERQV17t5J8hJ8+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q1Nhseaoa+rDmPgv3RV88Xq/keczcbIu4FLYepJnBvD2cRWQ9lipkpUB7/oP4GWM2
	 FtecI4n/MNfujCQ2qyTF3wHtE8IruMwItFTLmIBKKeC3vlmY0G1hsyyVZAtoiwWou8
	 P3DbUqJp9Xmpt/k5D8+TZwqQdKWqiN19Lf+AJ3W0+6UWmvY9NsCpCPQCR2qUhmOLIC
	 8Ojr7flTBUGp+qSaJwC9QVMRhzWedJSGwa8czVneuywDeGOD4MwdC3oFvmjdVrC/MQ
	 pQQu6ro5HclX1M3k8qO/i9gCSAbnfYwfDkfc5jGddIzvabPGzItOqeLhZ1tE9Uequ/
	 TaRWxOs50oK2g==
Date: Fri, 9 Oct 2026 12:10:27 -0500
From: Rob Herring <robh@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wandun <chenwandun1@gmail.com>, baoquan.he@linux.dev,
	m.szyprowski@samsung.com, catalin.marinas@arm.com, will@kernel.org,
	mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	saravanak@kernel.org, akpm@linux-foundation.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH v7 0/9] kdump: reduce vmcore size and capture time
Message-ID: <20261009171027.GA2734758-robh@kernel.org>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <ar9ogXc12cLjziHS@kernel.org>
 <80af60db-8c39-461c-a488-3dfee990bce8@gmail.com>
 <askVvEPHyrhpF8aw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <askVvEPHyrhpF8aw@kernel.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Oct 09, 2026 at 06:26:36PM +0200, Mike Rapoport wrote:
> On Fri, Oct 09, 2026 at 11:04:47AM +0800, Wandun wrote:
> > On 10/2/26 16:17, Mike Rapoport wrote:
> > > Hi Wandun,
> > > 
> > > On Tue, Sep 22, 2026 at 04:42:47PM +0800, Wandun Chen wrote:
> > >> From: Wandun Chen <chenwandun@lixiang.com>
> > >>
> > >> On SoCs that carve out large firmware-owned reserved memory (GPU,
> > >> camera ISP, ...), kdump currently dumps those carveouts as part of
> > >> system RAM even though their contents are firmware state that is not
> > >> useful for kernel crash analysis.
> > >>
> > >> This series introduces a MEMBLOCK_NODUMP flag in memblock to filter
> > >> reserved memory on DT-based architectures (arm64, riscv, loongarch).
> > >> Reserved regions are marked MEMBLOCK_NODUMP by default so kdump omits
> > >> them; reusable CMA regions are different because their pages are handed
> > >> back to the buddy allocator and may carry crash-relevant data.
> > >>
> > >> ACPI systems already filter reserved memory out of the vmcore through
> > >> their existing path; only DT-based systems currently fail to filter these
> > >> regions, which is what this series addresses. The flag lives in memblock
> > >> itself rather than in a DT-only structure, so both ACPI and DT systems
> > >> can benefit from it (suggested by Rob, thanks).
> > > 
> > Hi Mike,
> > 
> > Thanks for the review.
> > 
> > > Can you elaborate how ACPI systems filter their reserved memory?
> > 
> > In the EFI memory map, firmware carveouts are reported with the type
> > EFI_RESERVED_TYPE. This type of memory gets the nomap flag set in
> > memblock.memory (is_usable_memory() returns false in reserve_regions()
> > and mark these regions with nomap flag), during prepare_elf_headers(),
> > for_each_mem_range() filters out these nomap regions. Therefore, the
> > memory reserved on ACPI based systems will not be dumped into the vmcore.
> > 
> > I will add these description in next version.
> > 
> > > With your patches, the memblock flag becomes a part of DT-only
> > > infrastructure, so that claim that both ACPI and DT benefit from it does
> > > not hold, doesn't it?
> > 
> > You are right, the wording was misleading. Let me clarify what I meant.
> > 
> > In this series only DT marks regions as MEMBLOCK_NODUMP:
> > /reserved-memory and /memreserve/ entries are tagged in the OF
> > paths (of_reserved_mem.c, fdt.c). ACPI does not set the flag and
> > keeps filtering its reserved memory through the existing path, as
> > described above.
> > 
> > 
> > What I intended to convey is that the flag itself lives in memblock
> > rather than on the DT-only struct reserved_mem, so it is available
> > for reuse. If an ACPI system ever needed to exclude a firmware-owned
> > region from the vmcore, it could mark that region with MEMBLOCK_NODUMP
> > the same way DT does, instead of having to invent a parallel mechanism.
> > That is a future option, not something this series enables for ACPI
> > today.
> 
> So, EFI uses NOMAP for the same purpose, right?
> Why when we need a new memblock flag then?

IIUC, NOMAP implies NODUMP (for EFI and DT), but NODUMP is needed for 
some mapped (!NOMAP) regions.

Rob


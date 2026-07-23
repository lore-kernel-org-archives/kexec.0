Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572E7C531D0
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aTz69KdUrI3yfZjC00J0USCMLwe6vP8ekewkBIJx+Jo=; b=W4ZrItD6zyEI9h/w7StIKzLJNK
	sIrZKawgPDFA78HMrlq7SJ6GGGX+N6K3N0+d/pddBNfhbgZVPI8JShmRDqbTQeL26Vsmw35ZVmbNm
	Zuzm+T7aFUCaZK4ASuEMOH/cVFbQf2+i9iusdd9jvauhdUVzyHHzERYF694s+05Ympbe9aPdvsnSw
	PAztbSR4SA0Mkn9nvOE7PJlJMWqaxOQN23GjgBYoDpTYqtNWrV1JRkrtTR77lUqs4mjB52iMBd9ME
	ePqyGwBUddYXa3XHmN8LV2jgQyXChCw0+OrqO5b/n5R/NkCwFxJtdTY666Mh0XB6/K7Xrj2k+ItLn
	UC1vkeWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn32f-0000000FGZH-0dd9;
	Thu, 23 Jul 2026 23:41:29 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn32d-0000000FGZ2-3yxG;
	Thu, 23 Jul 2026 23:41:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57D0743C22;
	Thu, 23 Jul 2026 23:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB031F000E9;
	Thu, 23 Jul 2026 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784850087;
	bh=aTz69KdUrI3yfZjC00J0USCMLwe6vP8ekewkBIJx+Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kpEjksWjdQXtZwWWaMoVcRqzfxVl8o/AELIT483th2iPV4PHPE/tXzOrxye73GGrd
	 0BduEfPAauWn/khDpp+SpMMp5BWZvjrO1h6Lrojf3nqUJGzS/WLpuRDW/gTlJmL4Vg
	 +Zd57H+BfepSW0VaRvrbPBkJ909SGIvyXaANU5sn/1GxbMrwPXrtbu5drYbbCKzDM2
	 IGVmciX6iYsLqEMnwMp03bZa5ucXZSmDr4/K8XqYsjTBbHYyB1gofwdafgzCkK5TkZ
	 OdF0R/ZVRPfKlT8yEMf2WRFGE10m8S8sEtQmLe04rNEvyhBP35pujz6Rl6lppsYd1Y
	 ua08B36pmYRYg==
Date: Thu, 23 Jul 2026 18:41:26 -0500
From: Rob Herring <robh@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, saravanak@kernel.org,
	bhe@redhat.com, rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, will@kernel.org, alex@ghiti.fr,
	akpm@linux-foundation.org, pasha.tatashin@soleen.com,
	pratyush@kernel.org, ruirui.yang@linux.dev,
	m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: Re: [PATCH v4 00/10] kdump: reduce vmcore size and capture time
Message-ID: <20260723234126.GA3253409-robh@kernel.org>
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630074715.4126796-1-chenwandun1@gmail.com>
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

On Tue, Jun 30, 2026 at 03:47:04PM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU
> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> those carveouts as part of system RAM even though their contents are
> firmware state that is not useful for kernel crash analysis.

What about reserved regions on ACPI based systems?

> This series introduces an opt-in 'dumpable' flag [1] on struct
> reserved_mem and uses it to filter the elfcorehdr PT_LOAD ranges on
> DT-based architectures (arm64, riscv, loongarch). By default reserved
> regions are treated as non-dumpable; CMA regions are explicitly opted
> in because their pages are returned to the buddy allocator and may
> carry key crash-analysis data.

I never like seeing the same change being made to each architecture. 
That's generally a sign of restructuring needed. loongarch and arm64 
prepare_elf_headers() look about the same. riscv version uses 
walk_system_ram_res() for some reason. 

Perhaps the dumpable flag belongs in memblock instead? Then at least we 
wouldn't need more DT APIs exposed to the arch code, and the code stays 
independent of the firmware API.

I'd really like Marek's review on the reserved memory code changes.

Rob


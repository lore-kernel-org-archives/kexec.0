Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C50EC369B2
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pFdJS1Ku9jpxjGSHmnlwzJMEcNPUTY8NF/s7bkpHAXw=; b=ARXpybQEvMypVIgbe32rL7dTES
	pDzyea4zozvUn5Gn6raokU0E88u4p6ozEEgxM2oZp8gfP79C1meI7mSSw5GfNXAT4T79XzRB7ovj3
	ZBe4166K3edz4nW/cIDdA4zBrARfcwAr458egXslfzLFY5hPubPQiHGYDJbZv3ynxpmjYMmSzoKIT
	1ZDmm0qpEZuia6dwqRZQLbPTE+eC4nLJDhiStVgaKa/ncsDPokSslj+ocMQFVPBBlj6VLTZ3DxduT
	790xLjuI0SF0S4Y8ESYgeeV3lqI0YeqehhRzmh68igEDxudDi/oT4NfobL1KvcTS0hT2NDATNW+P/
	6ajBzh2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FMu-000000018h4-2qzX;
	Mon, 14 Apr 2025 08:40:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4FMs-000000018gU-3UH8;
	Mon, 14 Apr 2025 08:40:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AECBA61141;
	Mon, 14 Apr 2025 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35A6C4CEE2;
	Mon, 14 Apr 2025 08:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744620037;
	bh=1WLjhU62qts6OOD8ye1YCi8KydIv3r4YnaWoDD7MFoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvdiZUAmShJiXgi2JdweGIv+56B6MrRRZG6A7OFE2EfFOz2VNDI2oIeIU7RQaj5El
	 4aA9h2FAcy13IpILJO5xVz84RKLEHpRXTTv73t4VsmG8sHAa4MBBfwEUa8w5BZoms4
	 td7t3HWHPJbq00dUVI5Sg7hxtJO4ukSzXov1p0FVKkLTm9xgRi9URTpIBTv1Anf3wn
	 YCfH5erg23joCti8uVBsTPMgSk4oO6IcIJ/93QnZfSWd25vJCY5pA7rrYSJI3BGPc0
	 97+DGFJEHNtwY+ScWCw11OJaqbgfPAIIN7neb+8GtU8Haz30Wt1dij2uZtMB2c9cVf
	 OteBHGjqj4iIw==
Date: Mon, 14 Apr 2025 09:40:33 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Nick Kossifidis <mick@ics.forth.gr>,
	Song Shuai <songshuaishuai@tinylab.org>,
	Li Zhengyu <lizhengyu3@huawei.com>, kexec@lists.infradead.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Dave Young <dyoung@redhat.com>, Yixun Lan <yixun.lan@gmail.com>,
	Xianting Tian <xianting.tian@linux.alibaba.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/4] kexec-tools RISC-V port
Message-ID: <20250414084033.GA1480036@horms.kernel.org>
References: <20250409201428.648717-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409201428.648717-1-bjorn@kernel.org>
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

On Wed, Apr 09, 2025 at 10:14:22PM +0200, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Hi!
> 
> This is an attempt to finally get the RISC-V patches for kexec-tools
> upstream.
> 
> Simon suggested in [1] that:
> 
> > In my mind the big question is how to move RISC-V support from that
> > branch, to being merged into main.
> >
> > IIRC there were some issues that needed to be addressed. Perhaps they
> > are all addressed by this series, and with some appropriate squashing
> > we can move forwards with a series based on main?
> 
> I talked to Nick last week, and he suggested that we'd work the RISC-V
> collab Github [2], but I think it's just easier to do it on the list.
> 
> I've been collecting a number of different trees out there, and tried
> to group them in a series.
> 
> Given that there is not support for RISC-V upstream yet, I didn't see
> the need to carry all the fixes/updates ("development history") as
> separate commits -- it doesn't help bugtracking/bisectability.

Thanks Björn,

I haven't looked over the patches yet.
But in principle I agree with this approach.

> 
> Instead the first commit message is a big one, and tries to give
> attribution to all involved parties. Input/thoughts are very much
> welcome!
> 
> To properly test this on RISC-V, the upstream Linux kernel has most
> things in 6.15-rc1, e.g.:
> commit 28093cfef5dd ("riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator")
> commit 3f7023171df4 ("riscv/purgatory: 4B align purgatory_start")
> 
> To cross-build kexec-tools:
>   | ./bootstrap 
>   | ./configure --host=riscv64-linux-gnu
>   | make
> 
> For some tests, additional kernel patches are needed, that as of today
> is not in 6.15-rc1:
>  * To test "kexec -s -l Image", kexec_file_load with Image support is
>    needed [3]
>  * To test "kexec -c -l vmlinux" with CONFIG_RELOCATABLE, a kbuild fix
>    is needed [4]
>  * Typically if you load initrd, or a large kernel [5] (since a bunch
>    of Reserved regions are not properly exposed).
> 
> I've tested combinations with crashkernel (-p), and regular (-c/-s + -e) for:
>  * ACPI/UEFI
>  * DT/UEFI
>  * DT
>  * w/ initrd
>  * w/o initrd
>  * ELF (userland loader + kexec_load, and kexec_file_load)
>  * Image (userland loader + kexec_load, and kexec_file_load)
> 
> I'm sure there are combinations I've missed, but at least from my POV
> we're in a pretty good shape.
> 
> All authors: Please let me know if you prefer another split of the
> patches. Or something else for that matter! ;-)
> 
> 
> Let's get the ball rolling!
> Björn

...


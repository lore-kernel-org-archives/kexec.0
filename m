Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5059DD39418
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLAllxmpQBHyjEZUnJBbo0v6FSDjNIHjm4dscAKVh54=; b=iBNKSsNSvxBYIcuvAC0NfNZX0e
	TF9TI5HkYFUoWXI/9cWT2qPBZOTn/ENtRuJrbEQ7aySRtwKBvNZHg7mrim10nuLepsy2eyeutws72
	jbwhSvgZGWr88y2eFvnZM7QJT74UD8hpKRtFolHXwyx88JaLvEYBwIXl5Whbr96NsT+56M4KbPicy
	Xn7K8Hj2Hc6Xqg/XH/sY2kpZUQFl3MCfxUgRMdOGaYu0CXazFeNuDCBT4Pyz/IUbjSnHDRRico8Q+
	aHmTXG0rOtKd7jHO7b1fq+WI6fJQzBjAVXmR5UkmSlR37Ym7xpwMbGhQVCyqqy6Gf3iSM3Ma8TUc5
	GwTe9/JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HFh-000000003oR-2Tkv;
	Thu, 02 Apr 2026 12:34:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1AVC-00000001FSa-3Y7i;
	Fri, 13 Mar 2026 21:57:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FEB56183F;
	Fri, 13 Mar 2026 21:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE5AC19421;
	Fri, 13 Mar 2026 21:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439021;
	bh=BwGIzF3Y1kGJ7LSzEz+7QIlkvRAEX1ybLPLbwYlypHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8LFC/Y2BvExaUUaQwCZ1enN784C4eGC3QLIYlLXoQRLLoZbcIPAW+9UHxunos89u
	 W2FcjOgbPlul4rkrHWNMnWcebVKNCNJBcZAC9W9bHqSllID/Yx8/g7Pg0waFNdbV1F
	 PZkKpvhQhygkjCvndRt4AGAp3O3ce5dB8Hf9tYRkl1Yd2G1/EC1V7ihRTEFOlFWtJD
	 TVRWH74L5h1udZNpGw4w/HeSz46hbFXg77yqFlXWTNDJcGX7icfPbrJEmetdc7x+30
	 MorgajnbJ3XPvDp3w4FMrauooCX4QG0hYbWRVYVLx7aMFlZXvlf6/A/GVpusGs1ME1
	 T/VOcVRh6Fn9Q==
Date: Fri, 13 Mar 2026 16:56:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: loongarch@lists.linux.dev, cfsworks@gmail.com, alex@ghiti.fr,
	skhan@linuxfoundation.org, liaoyuanhong@vivo.com,
	ritesh.list@gmail.com, linux-arm-kernel@lists.infradead.org,
	kees@kernel.org, leitao@debian.org, lirongqing@baidu.com,
	corbet@lwn.net, pmladek@suse.com, jbohac@suse.cz,
	eajames@linux.ibm.com, sourabhjain@linux.ibm.com,
	palmer@dabbelt.com, vishal.moola@gmail.com, npiggin@gmail.com,
	dapeng1.mi@linux.intel.com, brgerst@gmail.com, will@kernel.org,
	paulmck@kernel.org, tglx@kernel.org, rdunlap@infradead.org,
	hbathini@linux.ibm.com, kexec@lists.infradead.org, bhe@redhat.com,
	dyoung@redhat.com, x86@kernel.org, pjw@kernel.org, rppt@kernel.org,
	linux-doc@vger.kernel.org, kernel@xen0n.name,
	dave.hansen@linux.intel.com, catalin.marinas@arm.com,
	saravanak@kernel.org, samuel.holland@sifive.com,
	songshuaishuai@tinylab.org, coxu@redhat.com,
	fuqiang.wang@easystack.cn, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, osandov@fb.com, chenhuacai@kernel.org,
	aou@eecs.berkeley.edu, tangyouling@kylinos.cn, hpa@zytor.com,
	chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, bp@alien8.de,
	vgoyal@redhat.com, fvdl@google.com, kevin.brodsky@arm.com,
	mingo@redhat.com, maddy@linux.ibm.com, akpm@linux-foundation.org,
	junhui.liu@pigmoral.tech, ardb@kernel.org, mpe@ellerman.id.au,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 4/5] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <177343901948.3415566.6726187926870600451.robh@kernel.org>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
 <20260302035315.3892241-5-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302035315.3892241-5-ruanjinjie@huawei.com>
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:23 -0700
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


On Mon, 02 Mar 2026 11:53:14 +0800, Jinjie Ruan wrote:
> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
> 
> Crash kernel memory reservation wastes production resources if too
> large, risks kdump failure if too small, and faces allocation difficulties
> on fragmented systems due to contiguous block constraints. The new
> CMA-based crashkernel reservation scheme splits the "large fixed
> reservation" into a "small fixed region + large CMA dynamic region": the
> CMA memory is available to userspace during normal operation to avoid
> waste, and is reclaimed for kdump upon crash—saving memory while
> improving reliability.
> 
> So extend crashkernel CMA reservation support to arm64. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> arm64 architecture.
> 
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v7:
> - Correct the inclusion of CMA-reserved ranges for kdump
>   kernel in of/kexec.
> v3:
> - Add Acked-by.
> v2:
> - Free cmem in prepare_elf_headers()
> - Add the mtivation.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  arch/arm64/kernel/machine_kexec_file.c          | 2 +-
>  arch/arm64/mm/init.c                            | 5 +++--
>  drivers/of/fdt.c                                | 9 +++++----
>  drivers/of/kexec.c                              | 9 +++++++++
>  5 files changed, 19 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>



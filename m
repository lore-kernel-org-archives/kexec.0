Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74ABC5B572
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 14:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d2KLTKX4fDki47VghM+pM2vlCNFRWOwwU4DWIY324Xw=; b=157D2dXWTBW3TzNtbeFxrAHOE1
	yqo81TdV7eS5JhBluEcCvnUVVeR8f9WLcJuFwITxH/MscUOVYHrcUyUwKZNKr0yZn46DMGiBnRvAT
	yl0ZPN3yB18DXhHNjt/zibF4I2fb3RRhcXeaLH4cWBU4WjtvngkaRFg5E6pzhnOT/aHDWy56hbav0
	tbyfd2zRnZ3HoIYE6AOMYVaWsP6cGpaYSy5QrURsYkyeIEjmrEE8K/MBJpCOA54Gj28qgsPhl4lX6
	26X25q/0Xtn7oYryb/3HgV62TGoGW7HwP8BkpaD9Sn5gOvQvu3MdG+KWuBbew+kr9taRjJGHfQ9B/
	WLb3HMyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuWcJ-00000000rUn-1ytS;
	Thu, 13 Aug 2026 14:41:11 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuWcH-00000000rS2-18ry;
	Thu, 13 Aug 2026 14:41:10 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB621BA8;
	Thu, 13 Aug 2026 07:41:02 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7034E3F632;
	Thu, 13 Aug 2026 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786632066; bh=EtxmNm8vFCrBIkDwkOud1SWz71Jk30UCcr/d3R4pqe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdPyQS3P/Xz/KroKir1M6zntDEwENUP9KsIvs+g6aaNE12xL47VCX5XnepuxSgCCJ
	 HQHH9SFNApnVXMyFqbIq7PQm/agOMIdWAEqSMRIowCGQMm4djMbrfR0gc+uVgvo+4b
	 TYuDfLGz9vqK0l2bHZwzwcFvuSj8z52ppxhySXVg=
Date: Thu, 13 Aug 2026 15:40:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: will@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev,
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
	thuth@redhat.com, mark.rutland@arm.com, jic23@kernel.org,
	james.morse@arm.com, ardb@kernel.org, leitao@debian.org,
	yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, robh@kernel.org,
	kees@kernel.org, coxu@redhat.com, makb@juniper.net,
	piliu@redhat.com, graf@amazon.com, ebiggers@kernel.org,
	jbouron@amazon.com, bgwin@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 0/5] arm64: crash: Add crash hotplug support
Message-ID: <an3Xe_5-B4qdiN8o@arm.com>
References: <20260729031235.2840255-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729031235.2840255-1-ruanjinjie@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_074109_353546_012135DB 
X-CRM114-Status: GOOD (  16.12  )
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

On Wed, Jul 29, 2026 at 11:12:30AM +0800, Jinjie Ruan wrote:
> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
> image becomes stale, potentially leading to incomplete crash dumps.
> 
> Currently, userspace udev rules reload the entire kdump image upon such
> events, which is inefficient and leaves kdump inactive for a long time.
> 
> Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
> support") introduced a kernel mechanism to update only the elfcorehdr.
> This patch set implements crash hotplug support for arm64.
> 
> As Baoquan suggested, it also addresses and fixes several
> pre-existing code issues and Sashiko AI review findings extracted
> from the previous patch set.
> 
> The major improvements and fixes included in this series are:
> - Fix several memory leaks for arm64.
> - Simplify arm64 load_other_segments().
> - Implement infrastructure for arm64 crash memory hotplug support.
> 
> This patch set is rebased on liveupdate/crashkernel-cma.
> 
> Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/

Is there any dependency for the first 3 patches on the above branch?
Patches 2/3 look like fixes and they depend on patch 1. Not sure about
cc stable, maybe patch 2.

[...]

> Jinjie Ruan (5):
>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>   arm64: kexec_file: Fix image->elf_headers memory leak in retry loop
>   arm64: kexec_file: Simplify load_other_segments()
>   arm64: crash: Add crash hotplug support

-- 
Catalin


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E083C61DD3
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYAL/uAoi+EN4roiOHSrXabP2vbnl7qcOw3MP41npbU=; b=UFI153lCLZY+rjEwdJZNXX98fP
	OCsmURbI4PaRu+S4nJC07DhfrSsb1p5GdPB657PlWBv152FGKf6Qbfl8eOdbMjfYeA4fEL94N4e6H
	uiUf8fvrY742NHn3Mb4iYYdCPhF+ZwKe4TBax8xbJn93jhXfgUXOjZzCy5q4UqdRjpfFrHckrTsyb
	xyDP7s5R2GkDWMwU+1WGzWR6V37coAiRn+MaDirC6caxsIQpP3lsgAw4UOUBIbAVuU1JRHQJwY7OV
	mHlzmFVeqQ4+218RXjPvFhJIOiFz8KUJ93h7X+koKTRKmNmDom2G+tNER+DC8fDUCx2X/xg/n5BBG
	PKzs0OKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1UsX-0000000DIzd-3twg;
	Tue, 01 Sep 2026 20:14:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1UsW-0000000DIyt-2c4T;
	Tue, 01 Sep 2026 20:14:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D443760232;
	Tue,  1 Sep 2026 20:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30A11F000E9;
	Tue,  1 Sep 2026 20:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293683;
	bh=XYAL/uAoi+EN4roiOHSrXabP2vbnl7qcOw3MP41npbU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=oK7KIXR6KUMFaGOJIUsL9dZOFAkwrVf2yKPCXU01KHGex01sBreWT258WZzUfcFn5
	 N93Z1YC0ijmCWwzdoNGAU4G9utTIZGp5IgWf8X4H4hbfF5zVWFBqKBg4YeUMPjN0IR
	 GRqaT6bQ/HcAeFBzveARB1bTlhtt6tGhp5xI9YMBwzO/d1SEgK960i+4ONjpEjdAwa
	 7tG2nwlX09g2Zqlhw5BescVjXG5aZz+VId6dbPlddwI3F+7kLFJCguutYFwbYGa2Rb
	 BvAnrQEVhQOr9OmQCQw70saSaDN2Yet3d9/+LJIvw+JtUjv3/nv6xht6k1tPEvBw4K
	 3vqUArPhf7QvA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 08/17] crash: Extract crash_get_memory_ranges()
 helper
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 kees@kernel.org, thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, 
 james.morse@arm.com, ardb@kernel.org, leitao@debian.org, 
 yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, coxu@redhat.com, 
 tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
 ionut.nechita@windriver.com, liaoyuanhong@vivo.com, seanjc@google.com, 
 fuqiang.wang@easystack.cn, makb@juniper.net, piliu@redhat.com, 
 ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
 me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
 takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260826092541.3905933-9-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-9-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364020.3691424.10343800427604677653.b4-review@b4>
X-Mailer: b4 0.17-dev
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

Hi,

> Factor out the crash memory range collection logic from
> crash_prepare_headers() into a separate function. This allows
> the memory hotplug path to obtain and modify the range list
> (e.g. remove offlined memory) before generating the elfcorehdr.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index bc087124cd78e..619af312bd9a5 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -62,6 +62,7 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
>  extern int crash_prepare_headers(int need_kernel_map, void **addr,
>  				 unsigned long *sz, unsigned long *nr_mem_ranges);
>  extern int crash_exclude_core_ranges(struct crash_mem **cmem);
> +extern int crash_get_memory_ranges(struct crash_mem **mem_ranges);

No need for extern here as well.

-- 
Sincerely yours,
Mike.



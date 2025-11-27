Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B06D111A8
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yb5O61brOXNx5cnFLPLNFtBKkHZFWE66/2wPBrCgz5c=; b=CgntqPbvaJ0EEFoawIBGZkFzcB
	0720Md2o1/wFMo/FW9c9gXSfMk6hyRungj1lIR6kdZNmZSb9OifIH+MtbqXC22uk4f+WnRo63T6lm
	For/u0IXZbaP+qMuytWiFzg8W6Id2cMLh59M4RGMXqNb9vyR2+1YOsev27tQaQyuIB69Qs6EgTtR1
	H894KO/goW83GuG7GJDyIF9BYc58386SS+F/tWEcsn9UzazznxImLOAEWxyGHGl2tosxSYoMJparL
	dx9YO2VJNqG+ycDK6dXfTllCFCijaRQW7DIOtPO8/dFqCVosMEvTjHF0lhHnOTt4rJocJTIDC/z5p
	6Y/fKjOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOejD-0000000Gv4B-3dFr;
	Thu, 27 Nov 2025 16:20:19 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOejD-0000000Gv45-0G9v
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 16:20:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 23A3960153;
	Thu, 27 Nov 2025 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240AFC4CEF8;
	Thu, 27 Nov 2025 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764260417;
	bh=avZf9Vu6ylIFB1LxLASnCOKBE9sB2MGp7u47/NpKjkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=enT7i+QGeF5nMmfGvskWHyOmourYf9rryiYO17BNruJNNuOE3iYx0zIYavhZ3/6o8
	 0LeogTw+IqzuEAPVdEnA0B0qsUL6U3wSLD6fXyZCATBp73Z8UbUquCNIHwtlu0S8i1
	 ovyrsz2rMipXJIp3sP1/Ezn9ku7QE6ujpTyCbf5/o1yk/FkgNgEGa2NabB7ypXIMro
	 /5+hOa5C2wFoefcDYmrW1oFyAPJ2HSCWxMyDLVKhy3S4x5G6I9wHGUcOt4y0KlDs5N
	 uN3JYWaveYxh0o+R0dceTbU3iVHXvXP6oMVbvOyn4hVqnB37G8EzogSO5I8YFXZhPH
	 6KsRQiXRcv52g==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: rppt@kernel.org,  akpm@linux-foundation.org,  catalin.marinas@arm.com,
  changyuanl@google.com,  graf@amazon.com,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  ran.xiaokai@zte.com.cn
Subject: Re: [PATCH v4] KHO: Fix boot failure due to kmemleak access to
 non-PRESENT pages
In-Reply-To: <20251127122700.103927-1-ranxiaokai627@163.com> (ranxiaokai's
	message of "Thu, 27 Nov 2025 12:27:00 +0000")
References: <20251127122700.103927-1-ranxiaokai627@163.com>
Date: Thu, 27 Nov 2025 17:20:14 +0100
Message-ID: <mafs07bvbwipt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Nov 27 2025, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> When booting with debug_pagealloc=on while having:
> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n
> the system fails to boot due to page faults during kmemleak scanning.
>
> This occurs because:
> With debug_pagealloc is enabled, __free_pages() invokes
> debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
> freed pages in the kernel page table.
> KHO scratch areas are allocated from memblock and noted by kmemleak. But
> these areas don't remain reserved but released later to the page allocator
> using init_cma_reserved_pageblock(). This causes subsequent kmemleak scans
> access non-PRESENT pages, leading to fatal page faults.
>
> Mark scratch areas with kmemleak_ignore_phys() after they are allocated
> from memblock to exclude them from kmemleak scanning before they are
> released to buddy allocator to fix this.
>
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Thanks!

[...]

-- 
Regards,
Pratyush Yadav


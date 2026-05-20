Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D87CD4F54
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmaTJ2ofJAdTGRJ/goPWjEeX1duwQNgqHB4N806cLfw=; b=UrhCWSWAWVeDmoEMUn8O9HD70Z
	YYe/FIjiUdKkVZiNYMf43H9L+MzzR9ys7xatOqTQYqD2bZmMkgCkwZGHQulzFYc3xwxkyqUl1WLs2
	1L+Hwm0z4KokXcjpfLDghm85pC2cfbvVZqRLdnCFgi3zMxIO0xxsJmxHaQ7oqTgJ7b2XZHhRoQKpm
	M8O3zPAOZzrR5qecqcGqgxcbNfNYtacBGiJawuEFK3ofNEyPUBlwgG0Oaac+AsHlF7vHrMvJ//z7M
	L2AsCRGKnY6YlDtlBhpZq1Vh8ockfapOmOwX8jFqw6FpczJBHxYdC+HDv2sVamXFxCJ23uLvILl3T
	slxIhYzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPdFn-00000004AyG-3IUj;
	Wed, 20 May 2026 09:30:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPdFm-00000004Ay6-2YQ2
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 09:30:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F2D33600CB;
	Wed, 20 May 2026 09:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9144F1F000E9;
	Wed, 20 May 2026 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779269413;
	bh=TmaTJ2ofJAdTGRJ/goPWjEeX1duwQNgqHB4N806cLfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LRTz/xyqdxkshBx8b6fmFM0piRP0+u1nAtkwFXseX2QOzxvoQ1TeWXjRmaIJiIWXb
	 fDH5e9mVsLORLwjrNDlDxg4T/Dpk7ij/oc2RYnhoR7hQTkJ0CLyGJT/Tdt+3/KkuPk
	 q6OlAPzsAdbDWrfR5X63mJN/9+JZFd92GO6zYAOixGB+QBbR2MPTQiv4G2zspDQG5Y
	 efxc/gecneUjiLmBbHJUvlVG6p00y6r7/tF+0l18xfqK3fuuC0xgSfiEHE5NrghDWy
	 xHuB5ba7b6RqEcizljkqgafiqhKQfi77fM8ROCQNlJ32zWKP1RNPbMfnxk5giAAPDU
	 TJPtrjHMZZHDw==
Date: Wed, 20 May 2026 10:30:10 +0100
From: Simon Horman <horms@kernel.org>
To: hu.shengming@zte.com.cn
Cc: kexec@lists.infradead.org, luo.haiyang@zte.com.cn, zhang.run@zte.com.cn,
	yang.tao172@zte.com.cn
Subject: Re: [PATCH 3/3] RISC-V: add bss section to kernel text elf header
Message-ID: <20260520093010.GA296581@horms.kernel.org>
References: <20260519124412.GB227450@horms.kernel.org>
 <20260520153520587dSDah6BTNL9aPVMV_nsAo@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520153520587dSDah6BTNL9aPVMV_nsAo@zte.com.cn>
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

On Wed, May 20, 2026 at 03:35:20PM +0800, hu.shengming@zte.com.cn wrote:
> horms@kernel.org wrote:
> > On Mon, May 18, 2026 at 03:01:40PM +0800, hu.shengming@zte.com.cn wrote:
> > > From: Luo Haiyang <luo.haiyang@zte.com.cn>
> > > 
> > > The kdump service reported the following error:
> > > 
> > >   No program header covering vaddr 0xffffffff819fa200 found kexec bug?
> > >   saving vmcore-dmesg.txt failed
> > > 
> > > prb stores the address of printk_rb_dynamic. Since printk_rb_dynamic
> > > resides in the bss segment and the PHDR (Program Header) does not include
> > > the bss segment address. Therefore,  add the bss segment to the Kernel text.
> > > 
> > > Signed-off-by: Luo Haiyang <luo.haiyang@zte.com.cn>
> > 
> > Hi,
> > 
> > I am wondering if to_be_excluded() also needs to be updated.
> > And, if so, should that change also be made for ARM64.
> > 
> > Review assisted by gemini-3-pro-preview
> 
> Thanks for taking a look.
> 
> On arm64, the kernel code contains text and rodata section, and the kernel data 
> contains data and bss section. Therefore, the arm64 architecture does not have
> a similar issue.
> 
> Yes, on RISC-V, the to_be_excluded function does not properly handle the kernel
> memory range, it is still being excluded.
> 
>   cat /proc/iomem | grep Kernel
>     878a02000-87a8426e7 : Kernel image
>     878a02000-87944d309 : Kernel code
>     879c00000-87a1fffff : Kernel rodata
>     87a400000-87a7741ff : Kernel data
>     87a775000-87a8426e7 : Kernel bss
> 
> Maybe we can directly use the kernel image in iomem_range_callback, and only the
> reserved memory needs to be excluded, like this:
> 
>   static int iomem_range_callback(...)
>   {
>   	....
>   	else if (!strncmp(str, KERNEL_IMAGE, strlen(KERNEL_IMAGE))) {
>   			elf_info.kern_paddr_start = base;
>   			elf_info.kern_size = length;
>   	}
>   
>   	return 0;
>   }
> 
>   static bool to_be_excluded(...)
>   {
>    ...
>   	  if (!strncmp(str, IOMEM_RESERVED, strlen(IOMEM_RESERVED)))
>   		  return true;
>   
>   	  return false;
>   }
> 
> If you think this change is acceptable, I will resubmit patch v3 later.

Thanks, sounds good to me.


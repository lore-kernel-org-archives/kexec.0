Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25327C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 12:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPHwxj7cgfi/sRFO/JKzf12L/v93WRQC6iXrX/2UKjo=; b=so3Vi72iPWY60sf6m+y0xKnKt/
	WKZFii8OOT6VJtoqzX7ZY1bljp/nZTV3F9bY/6vOaqJXbdEeYaTJJnGdp495HRgDkawCbjiMel4mm
	VcLi9wgqkYn08uFeLKb7z4KzzHJFi2Y1LHu4XNc8jctGT64aauO84KaduLFIpklC8dT+Wqw7zJzNX
	5y739tC3n8WNAQ5YnH3I+owwUumWcXbMYqWYbKRM+8PwfiwVvVw5PV5DtvRTdla3MFqq8vqA5DoWn
	8eQESr72J9QwwuWhHaQPC4z+ZvJoC3mJehaZmhaARcZrX/FoI5vMh9z0FkAQeM4Lx/awEJPptXgcl
	rM7IGzbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNyB-0000000DGmm-3r2z;
	Fri, 21 Aug 2026 12:03:35 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNyA-0000000DGlN-2nvX
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 12:03:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D7A7408BD;
	Fri, 21 Aug 2026 12:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C4D1F000E9;
	Fri, 21 Aug 2026 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313814;
	bh=CPHwxj7cgfi/sRFO/JKzf12L/v93WRQC6iXrX/2UKjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FW9VNZWWcJRWeOTsfqG/VhlOIWFBxJVwe8qQ5oJ/6a+dgxXFiuOpleuNfo9Kkc0oN
	 fHUnbSoLU47lPBjGpbLd+GTnToWJMfgE8eYvsOwQyYGZoyeRKRZDW5gVfbv8ptCjeP
	 mJaQcjqZeExwsqMZ75PrZ4/GkUrYy5pePxw9k1XndOqQ2MTJN0p6wU8vJuqI5d6Z85
	 h9addDWDBzemyOtuPqhXh3Gw3q8MMCJie0Q6FJA1FuutruSnBMf5KBF7Ryb4po7Pba
	 R1geGg21BhmJ+PWE32ng98qsO9u0picoefL+3Pl3+RVNqPH4ZPWk+VylifnTNONXTY
	 zQtrFIATDMPbQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,  Ard Biesheuvel <ardb@kernel.org>,
  Ilias Apalodimas <ilias.apalodimas@linaro.org>,  Miaohe Lin
 <linmiaohe@huawei.com>,  Naoya Horiguchi <nao.horiguchi@gmail.com>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-efi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  rmikey@meta.com,
  riel@surriel.com,  kexec@lists.infradead.org,  kernel-team@meta.com
Subject: Re: [PATCH v2 2/6] efi: add the LINUX_EFI_POISONED_MEMORY
 configuration table
In-Reply-To: <aog7bwfMVpSy9LcY@thinkstation> (Kiryl Shutsemau's message of
	"Fri, 21 Aug 2026 12:51:34 +0100")
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
	<20260821-hwpoison-kho-v2-2-5743791e48e6@debian.org>
	<aog7bwfMVpSy9LcY@thinkstation>
Date: Fri, 21 Aug 2026 14:03:30 +0200
Message-ID: <2vxz5x13znn1.fsf@kernel.org>
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

On Fri, Aug 21 2026, Kiryl Shutsemau wrote:

> On Fri, Aug 21, 2026 at 03:06:02AM -0700, Breno Leitao wrote:
>> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
>> index 29e0729299f5b..69c0dc02bc112 100644
>> --- a/drivers/firmware/efi/Kconfig
>> +++ b/drivers/firmware/efi/Kconfig
>> @@ -263,6 +263,16 @@ config EFI_COCO_SECRET
>>  	  virt/coco/efi_secret module to access the secrets, which in turn
>>  	  allows userspace programs to access the injected secrets.
>>  
>> +config EFI_POISONED_MEMORY
>> +	bool "Carry hardware-poisoned pages across kexec"
>> +	depends on EFI_STUB && MEMORY_FAILURE && 64BIT
>> +	help
>> +	  Record page frames that are hardware-poisoned while this kernel runs
>> +	  into an EFI configuration table, and honor that table early on the
>> +	  next kernel so a kexec does not hand known-bad RAM back out.
>> +
>> +	  If unsure, say N.
>> +
>
> Do we want to make it conditional? Maybe just for everyone with EFI_STUB
> && MEMORY_FAILURE?

+1. Each config we add is a decision someone has to make when compiling
the kernel. If they rely on the default, they will miss out on this
fairly useful feature.

So, is there any downside to just doing this by default without any
config?

-- 
Regards,
Pratyush Yadav


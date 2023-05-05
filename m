Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECA4C77B75
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0nGLAL3z/PMUpyFMgCyOqjb9mrjq6GKaIhsv//Z1mbE=; b=dsgtr6NRRkfBZO
	JCkiLWQiCGqwriNfVOkXzuVtgE0QigTCoum3ffJjlYBGp0huEmJjlGwTMtVrqsrTi7NKCr2ZhsKMj
	o7RfB4ku39ee0+OwT0AutnYxpySeIHgmJGTv4jGoMGu5A4NmyiKZIUnGQJh9gk/Z54vDtsgXifMEl
	UHRhP54ijzAU1uE869bKAN2k3LH+YoHQoHD6qbh59MeYeIgiiuUO12YNHO7CaSjMVJF2MgVR6ysXt
	O5PQNFjoVAIrs+ypAB6ZXHN26o4WH7ZnTAeOOx6JDHGT+Nezlrmz/wD8Fe5AZtq8LVooOAaNVrxD/
	zQ5yEaa9Q07+UnG2uJiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv44K-00C03H-16;
	Fri, 05 May 2023 22:38:28 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv44I-00C02Y-0f
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 22:38:27 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13941FB;
	Fri,  5 May 2023 15:39:04 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49CDD3F64C;
	Fri,  5 May 2023 15:38:20 -0700 (PDT)
Message-ID: <cd7dfc7c-9108-f55e-d2e2-2b8b1856ecb2@arm.com>
Date: Fri, 5 May 2023 17:38:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/5] arm64: zboot support
Content-Language: en-US
To: Pingfan Liu <piliu@redhat.com>, kexec@lists.infradead.org
Cc: horms@verge.net.au, ardb@kernel.org
References: <20230505025438.11943-1-piliu@redhat.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20230505025438.11943-1-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_153826_310979_597ACA93 
X-CRM114-Status: GOOD (  25.11  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 5/4/23 21:54, Pingfan Liu wrote:
> As more complicated capsule kernel format occurs like zboot, where the
> compressed kernel is stored as a payload. The straight forward
> decompression can not meet the demand.
> 
> As the first step, on aarch64, reading in the kernel file in a probe
> method and decide how to unfold the content by the method itself.
> 
> The new designed probe interface returns two factors:
> 1. the parsed kernel_buf should be returned so that it can be used by
> the image load method later.
> 2. the final fd passed to sys_kexec_file_load, since aarch64 kernel can
> only work with Image format, the outer payload should be stripped and a
> temporary file of Image should be created.
> 

Well this is unfortunate. I pinged you a few days back but I guess it 
must have gotten lost in the noise.

I'm ok with dropping my set, but I don't see your 5/5, and it doesn't 
show up in the archive either. Which presumably is the core ZBOOT 
functionality. From what I can tell without that, this set then is all 
just cleanup. So did you do that on purpose, if so maybe its best then 
to just rebase on top of my set?


Given I'm not a regular contributor here I'm not sure my opinion matters 
much, but one of the things that bothered me when I was yak shaving my 
set, were the #ifdef aarch64 bits in the common code. I considered 
attempting to remove it but that was a bit more involved than I wanted 
to get. But, as Ard correctly points out, the zboot is being used by 
more than aarch64 at this point. So that is also a argument for assuring 
whatever the probe()/etc interface is, that its not #ifdefed.




> 
> To: kexec@lists.infradead.org
> Cc: horms@verge.net.au
> Cc: ardb@kernel.org
> Cc: jeremy.linton@arm.com
> 
> Pingfan Liu (5):
>    kexec: Adding missing free for kernel_buf
>    arm64/zImage: Remove unnecessary allocation for
>      kernel_uncompressed_buf
>    arm64: change the prototype of image probe function
>    arm64: Scatter the reading of kernel file into each probe
>    arm64: add support for zboot image
> 
>   kexec/arch/arm/kexec-arm.h            |   4 +-
>   kexec/arch/arm/kexec-uImage-arm.c     |   2 +-
>   kexec/arch/arm64/Makefile             |   3 +-
>   kexec/arch/arm64/kexec-arm64.c        |   1 +
>   kexec/arch/arm64/kexec-arm64.h        |  13 +-
>   kexec/arch/arm64/kexec-elf-arm64.c    |   7 +-
>   kexec/arch/arm64/kexec-image-arm64.c  |   6 +-
>   kexec/arch/arm64/kexec-uImage-arm64.c |  17 +-
>   kexec/arch/arm64/kexec-zImage-arm64.c |  23 +--
>   kexec/arch/arm64/kexec-zboot-arm64.c  | 261 ++++++++++++++++++++++++++
>   kexec/arch/arm64/zboot.h              |  26 +++
>   kexec/kexec.c                         |  48 +++--
>   kexec/kexec.h                         |   8 +
>   13 files changed, 377 insertions(+), 42 deletions(-)
>   create mode 100644 kexec/arch/arm64/kexec-zboot-arm64.c
>   create mode 100644 kexec/arch/arm64/zboot.h
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

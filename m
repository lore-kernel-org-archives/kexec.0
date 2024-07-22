Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE77C3DA5D
	for <kexec@archiver.kernel.org>; Mon, 22 Jul 2024 01:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BDsoXeqgXZ5tONEOhXcdMSUHFcBOicjLR1gWsEYoRs8=; b=ZtWq4+qrO1oBx3
	wj++WzgDSMqdfy3Anupk/i6swcyMnsLY1eTJaObMFzWEkXMMBudLOXuLBT6G/pGU66xnPpyRgyurI
	AWEjlvwbQGPPyukM4RulEv2xdVKZCQPC3PO9mOnWZK4PuGO50TCot7+97kVtTR5NkRN2FMRjW44gS
	A4kCgQQjCqKan6/y5AEucCBa6DnMK+C9W+hzm5OUeJKI0pFXW3D4Xh5Iqn5dqMYZnrMFpRmSVLEiO
	E2mqZZe3ly6nLKhy5opAOOsC7Gs0ViFiylY6Pdl62PyA3qvdmccm6ufDriZVmLYRRmY27sL8YJSWQ
	jC+FdkLajkAMquDEBqpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVi1A-000000080mo-279R;
	Mon, 22 Jul 2024 01:39:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVi0m-000000080hs-2hoK
	for kexec@lists.infradead.org;
	Mon, 22 Jul 2024 01:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721612325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+xayDydG/sjylytxGn8tGsAMMzGvzWoMbFBXwqY3+w=;
	b=fYNVPZwFF4aQIOjNRLF0qvbBa/4LT0vewytNXyJuiK0f+NkHhqgpW2DafXY9DTq1K8JwBZ
	uqTBhQ9QcweTwm03h9OkeshgV1gISXiIE9FwIqYW/VClqAyuLRU8ZkTnWaty/jnP1uuHu8
	/xQTj8A/2l0uPooP1ZJfcBgG6cAJ7JQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-2yqhrWR1OBiPlcNGBp9d1w-1; Sun,
 21 Jul 2024 21:38:41 -0400
X-MC-Unique: 2yqhrWR1OBiPlcNGBp9d1w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12B721955D45;
	Mon, 22 Jul 2024 01:38:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CC5B19560AE;
	Mon, 22 Jul 2024 01:38:23 +0000 (UTC)
Date: Mon, 22 Jul 2024 09:38:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, vgoyal@redhat.com, dyoung@redhat.com, arnd@arndb.de,
	afd@ti.com, akpm@linux-foundation.org, linus.walleij@linaro.org,
	eric.devolder@oracle.com, gregkh@linuxfoundation.org,
	javierm@redhat.com, deller@gmx.de, robh@kernel.org,
	thunder.leizhen@huawei.com, hbathini@linux.ibm.com,
	tangyouling@kylinos.cn, chenjiahao16@huawei.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] ARM: Use generic interface to simplify
 crashkernel reservation
Message-ID: <Zp24C4ZkWI4g21FK@MiWiFi-R3L-srv>
References: <20240719095735.1912878-1-ruanjinjie@huawei.com>
 <20240719095735.1912878-4-ruanjinjie@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20240719095735.1912878-4-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_183848_763404_08F4A9D3 
X-CRM114-Status: GOOD (  16.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 07/19/24 at 05:57pm, Jinjie Ruan wrote:
> Currently, x86, arm64, riscv and loongarch has been switched to generic
> crashkernel reservation, which is also ready for 32bit system.
> So with the help of function parse_crashkernel() and generic
> reserve_crashkernel_generic(), arm32 crashkernel reservation can also
> be simplified by steps:
> 
> 1) Add a new header file <asm/crash_reserve.h>, and define CRASH_ALIGN,
>    CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX in it;
> 
> 2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
>    reserve_crashkernel_generic();
> 
> 3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
>    arch/arm/Kconfig.
> 
> The old reserve_crashkernel() can be removed.
> 
> Following test cases have been performed as expected on QEMU vexpress-a9
> (1GB system memory):
> 
> 1) crashkernel=4G,high				// invalid
> 2) crashkernel=1G,high				// invalid
> 3) crashkernel=1G,high crashkernel=0M,low	// invalid
> 4) crashkernel=256M,high			// invalid
> 5) crashkernel=256M,low				// invalid
> 6) crashkernel=256M crashkernel=256M,high	// high is ignored, ok
> 7) crashkernel=256M crashkernel=256M,low	// low is ignored, ok
> 8) crashkernel=256M,high crashkernel=256M,low	// invalid
> 9) crashkernel=256M,high crashkernel=4G,low	// invalid
> 10) crashkernel=256M				// ok
> 11) crashkernel=512M				// ok
> 12) crashkernel=256M@0x88000000			// ok
> 13) crashkernel=256M@0x78000000			// ok
> 14) crashkernel=512M@0x78000000			// ok
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v4:
> - Remove the Tested-by as suggested.
> v3:
> - Update the commit message.
> ---
>  arch/arm/Kconfig                     |  3 ++
>  arch/arm/include/asm/crash_reserve.h | 24 +++++++++++
>  arch/arm/kernel/setup.c              | 63 ++++------------------------
>  3 files changed, 36 insertions(+), 54 deletions(-)
>  create mode 100644 arch/arm/include/asm/crash_reserve.h

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

By the way, you may need respost the parsed crashkernel value limitation
checking patch for arm32 and i386.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

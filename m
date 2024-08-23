Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21D5C531DF
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 01:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=75ukXXTCTMcLR9HdlWr8UyadfxGe8knjxJtjVEFuitg=; b=hZu0l+lpZkna2b
	g5F7Gjoh0SoMEOA6dN7q7aIV1hUtS19kAzRMgLC42IeqP6K2+1uVpNFTrVNKKDNeav7/uZtvWM91c
	VtHVsNmHLjrDjgTzGXve7W7Lord6eHO83scFFvfwUA/Ybh8gwz5YlC6tnjcTamzs5zJJtnFqVOZNh
	aavT03EOyLgqbnjSytuafZo5NevXd233VBoVSWfTxhlDaE28wKSWtmC1rjANw7JdYrMe+fQ3DcawK
	ez+7gSZ2P+NG8CQYmvSNVFsWKZhw3avUZQ7LpE5ETrHJKbZSGQQailmCuMZCGj1Hxydi1K+AQ2hbV
	t0xNhE40eTCA2v2mPWhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shJa0-0000000EsQo-0Xv6;
	Fri, 23 Aug 2024 01:59:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shJZx-0000000EsQE-17u4
	for kexec@lists.infradead.org;
	Fri, 23 Aug 2024 01:59:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724378343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vptUsTTd+Ahgj+G0OF7GYw9gEl0AVQwqRfpIh4Og1O8=;
	b=GyobN06LNOwfiV2lgTFom/We8gUDd1aHAeYRuZTSpFVJlcW7AMyxpyLF0rBnaPu9Wc5AIV
	Qh77pyCrdg9eTkWL4eYQVHDDF49YFzSW5Ya83IJJ3LPdzlrRZvDzIWn7TMlCUhAReDMsBl
	SYmcUHJta5JmN1k2cWFtWca/Q14KpKE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-soz-U4RROwaHLeJV3p9How-1; Thu,
 22 Aug 2024 21:59:02 -0400
X-MC-Unique: soz-U4RROwaHLeJV3p9How-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E6A61955D45;
	Fri, 23 Aug 2024 01:58:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E2AD1956053;
	Fri, 23 Aug 2024 01:58:54 +0000 (UTC)
Date: Fri, 23 Aug 2024 09:58:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	kexec@lists.infradead.org, debian-powerpc@lists.debian.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	akpm@linux-foundation.org, ebiederm@xmission.com,
	hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH linux-next v3 05/14] crash: clean up kdump related config
 items
Message-ID: <Zsfs2VhE0lTY2tpO@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-6-bhe@redhat.com>
 <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
 <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
 <c5e9996e4d2ba2a0849d65f68e3dce94fffc5828.camel@physik.fu-berlin.de>
 <ZsfR9rdMt8yn1+Bz@MiWiFi-R3L-srv>
 <768dfe3e-c437-40cc-96a5-6c5b34b2d19d@vasilevsky.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <768dfe3e-c437-40cc-96a5-6c5b34b2d19d@vasilevsky.ca>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_185905_468208_D3FC6C67 
X-CRM114-Status: GOOD (  22.99  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 08/22/24 at 08:41pm, Dave Vasilevsky wrote:
> On 2024-08-22 20:04, Baoquan He wrote:
> > If so, below patch possiblly can fix it. Can you help check if it's OK?
> =

> That removes the possibility of enabling CRASH_DUMP on PPC_BOOK3S_32, eve=
n when booting via other mechanisms. Maybe it would be best to just make it=
 not-default? Please take a look at this patch:
> =


This is a good mimic of ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG and the
correspondent KEXEC_IMAGE_VERIFY_SIG. It looks good to me, as long as no
one complain we introduce too many knobs.

Can you post this formally so that people can review it?

> =

> From d6e5fe3a45f46f1aa01914648c443291d956de9e Mon Sep 17 00:00:00 2001
> From: Dave Vasilevsky <dave@vasilevsky.ca>
> Date: Thu, 22 Aug 2024 20:13:46 -0400
> Subject: [PATCH] powerpc: Default to CRASH_DUMP=3Dn when Open Firmware bo=
ot is
>  likely
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
> =

> Open Firmware is unable to boot a kernel where PHYSICAL_START is
> non-zero, which occurs when CRASH_DUMP is on.
> =

> On PPC_BOOK3S_32, the most common way of booting is Open Firmware, so
> most users probably don't want CRASH_DUMP. Users booting via some
> other mechanism can turn it on explicitly.
> =

> Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> Reported-by: Reimar D=F6ffinger <Reimar.Doeffinger@gmx.de>
> Fixes: 75bc255a7444
> ---
>  arch/arm/Kconfig       | 3 +++
>  arch/arm64/Kconfig     | 3 +++
>  arch/loongarch/Kconfig | 3 +++
>  arch/mips/Kconfig      | 3 +++
>  arch/powerpc/Kconfig   | 4 ++++
>  arch/riscv/Kconfig     | 3 +++
>  arch/s390/Kconfig      | 3 +++
>  arch/sh/Kconfig        | 3 +++
>  arch/x86/Kconfig       | 3 +++
>  kernel/Kconfig.kexec   | 2 +-
>  10 files changed, 29 insertions(+), 1 deletion(-)
> =

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 54b2bb817a7f..200995052690 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1597,6 +1597,9 @@ config ATAGS_PROC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config AUTO_ZRELADDR
>  	bool "Auto calculation of the decompressed kernel image address" if !AR=
CH_MULTIPLATFORM
>  	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..43e08cc8204f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1558,6 +1558,9 @@ config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  	def_bool CRASH_RESERVE
>  =

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210b52..ce232ddcd27d 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -599,6 +599,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_SELECTS_CRASH_DUMP
>  	def_bool y
>  	depends on CRASH_DUMP
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 60077e576935..b547f4304d0c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2881,6 +2881,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config PHYSICAL_START
>  	hex "Physical address where the kernel is loaded"
>  	default "0xffffffff84000000"
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index d7b09b064a8a..0f3c1f958eac 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -682,6 +682,10 @@ config RELOCATABLE_TEST
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	bool
> +	default y if !PPC_BOOK3S_32
> +
>  config ARCH_SELECTS_CRASH_DUMP
>  	def_bool y
>  	depends on CRASH_DUMP
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..eb247b5ee569 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -880,6 +880,9 @@ config ARCH_SUPPORTS_KEXEC_PURGATORY
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool y
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
>  	def_bool CRASH_RESERVE
>  =

> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index a822f952f64a..05a1fb408471 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -275,6 +275,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
>  	  This option also enables s390 zfcpdump.
>  	  See also <file:Documentation/arch/s390/zfcpdump.rst>
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  menu "Processor type and features"
>  =

>  config HAVE_MARCH_Z10_FEATURES
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 1aa3c4a0c5b2..3a6338962636 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -549,6 +549,9 @@ config ARCH_SUPPORTS_KEXEC
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool BROKEN_ON_SMP
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_SUPPORTS_KEXEC_JUMP
>  	def_bool y
>  =

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 007bab9f2a0e..aa4666bb9e9c 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2087,6 +2087,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool X86_64 || (X86_32 && HIGHMEM)
>  =

> +config ARCH_DEFAULT_CRASH_DUMP
> +	def_bool y
> +
>  config ARCH_SUPPORTS_CRASH_HOTPLUG
>  	def_bool y
>  =

> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 6c34e63c88ff..4d111f871951 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -97,7 +97,7 @@ config KEXEC_JUMP
>  =

>  config CRASH_DUMP
>  	bool "kernel crash dumps"
> -	default y
> +	default ARCH_DEFAULT_CRASH_DUMP
>  	depends on ARCH_SUPPORTS_CRASH_DUMP
>  	depends on KEXEC_CORE
>  	select VMCORE_INFO
> -- =

> 2.34.1
> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

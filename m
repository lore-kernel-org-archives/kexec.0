Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C7C3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Oi9cM/uRnVc4mbDqO6AtnmiWVbwkj/ayxAcqxSsdho8=; b=vf2b5sZdjLgtTx
	/qMlHdCF++GROM5Bb4lbyw5YT1zuvOaGwdjNOKy5Wchxzyol/Ob1RF1ItuzpC2GcNIJSRDKEw5l6P
	AQb+XCwa3TVvne0uIk+qPqqth+7O3GZDlPXMaWsEfu0cm2wzA8UA1pX7KOTFUSc1qiIiniSZJn6fU
	sH9xd+8vInsxQpMpfjVqe7y1HhS3GAOxwUYDJwReXiAdmwhz83kkzJZQWirnrlqG1N3z+37KRuxlH
	hfwAakp8SjmsXmQDLjOgdkkyxQpXk8Fh2U9T/7py7MRIVgzN8K6S1qv0LRtPwVT1TxJIiE2BUUeMF
	gy19f7d9UGwxlNYYv75A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh2Kz-0000000BtLX-1IhA;
	Thu, 22 Aug 2024 07:34:29 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh2Ku-0000000BtGL-0PgO;
	Thu, 22 Aug 2024 07:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nsNs6OoEVbcw2LLEgSbDKi7BEPoPfsioIF+I1dRzjSQ=; t=1724312064; x=1724916864; 
	b=ZyeQlXOuie8km2baT013Y73HSBErh+sVmWVWk2cXJfM9sUmUltyemHffc5NWd9ZdlAMzXoJd1OQ
	Grv0eknRqwkJ6H2uSB3WI7tNnpvHJdxucnQx7MrhfiTWJvuOoVkQVI5RrlVx38m4tXkHrKtow93Da
	dQIQa24D9JpddUt2moNCvOT9NYipGxuUrNN/Ci943eczUlplpLLfNPSbPfdCN/dDtc3keJTa0hy2y
	QklGAX6vkv/6zIPS4FS3fUGAzsDh8//TZaP1VP/UuCyTtAetjlYM4sqloN9zFMApErr+soemQ4i3o
	79hIrZnY8990PMq6Z4rMYvPEs8sOji6VDHeA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sh2KT-000000008j9-3CbJ; Thu, 22 Aug 2024 09:33:57 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sh2KT-00000002vTy-29Tp; Thu, 22 Aug 2024 09:33:57 +0200
Message-ID: <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH linux-next v3 05/14] crash: clean up kdump related
 config items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: Dave Vasilevsky <dave@vasilevsky.ca>, Michael Ellerman
 <mpe@ellerman.id.au>,  kexec@lists.infradead.org,
 debian-powerpc@lists.debian.org, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org,  linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev,  akpm@linux-foundation.org,
 ebiederm@xmission.com, hbathini@linux.ibm.com,  piliu@redhat.com,
 viro@zeniv.linux.org.uk, Sam James <sam@gentoo.org>
Date: Thu, 22 Aug 2024 09:33:56 +0200
In-Reply-To: <20240124051254.67105-6-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
	 <20240124051254.67105-6-bhe@redhat.com>
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.191
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_003424_293718_B6E1F381 
X-CRM114-Status: GOOD (  15.34  )
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

Hi Baoquan,

On Wed, 2024-01-24 at 13:12 +0800, Baoquan He wrote:
> By splitting CRASH_RESERVE and VMCORE_INFO out from CRASH_CORE, cleaning
> up the dependency of FA_DMUMP on CRASH_DUMP, and moving crash codes from
> kexec_core.c to crash_core.c, now we can rearrange CRASH_DUMP to
> depend on KEXEC_CORE, and make CRASH_DUMP select CRASH_RESERVE and
> VMCORE_INFO.
> 
> KEXEC_CORE won't select CRASH_RESERVE and VMCORE_INFO any more because
> KEXEC_CORE enables codes which allocate control pages, copy
> kexec/kdump segments, and prepare for switching. These codes are shared
> by both kexec reboot and crash dumping.
> 
> Doing this makes codes and the corresponding config items more
> logical (the right item depends on or is selected by the left item).
> 
> PROC_KCORE -----------> VMCORE_INFO
> 
>            |----------> VMCORE_INFO
> FA_DUMP----|
>            |----------> CRASH_RESERVE
> 
>                                                 ---->VMCORE_INFO
>                                                /
>                                                |---->CRASH_RESERVE
> KEXEC      --|                                /|
>              |--> KEXEC_CORE--> CRASH_DUMP-->/-|---->PROC_VMCORE
> KEXEC_FILE --|                               \ |
>                                                \---->CRASH_HOTPLUG
> 
> KEXEC      --|
>              |--> KEXEC_CORE--> kexec reboot
> KEXEC_FILE --|
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  kernel/Kconfig.kexec | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 8faf27043432..6c34e63c88ff 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -9,8 +9,6 @@ config VMCORE_INFO
>  	bool
>  
>  config KEXEC_CORE
> -	select VMCORE_INFO
> -	select CRASH_RESERVE
>  	bool
>  
>  config KEXEC_ELF
> @@ -99,8 +97,11 @@ config KEXEC_JUMP
>  
>  config CRASH_DUMP
>  	bool "kernel crash dumps"
> +	default y
>  	depends on ARCH_SUPPORTS_CRASH_DUMP
> -	select KEXEC_CORE
> +	depends on KEXEC_CORE
> +	select VMCORE_INFO
> +	select CRASH_RESERVE
>  	help
>  	  Generate crash dump after being started by kexec.
>  	  This should be normally only set in special crash dump kernels

The change to enable CONFIG_CRASH_DUMP by default apparently broke the boot
on 32-bit Power Macintosh systems which fail after GRUB with:

	"Error: You can't boot a kdump kernel from OF!"

We may have to turn this off for 32-bit Power Macintosh systems.

See this thread on debian-powerpc ML: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

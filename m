Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D1DC3DA4A
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kQops3lKSw3af9O3Bt1MsrlNZUye5qrhX/Ot7y4c+EQ=; b=cuREzmA+TPoZk4
	oGhNcjLl0PXiA6g963om3rcWwajZvcXuWOd1srntWB942rZHuS0PRVz6ewCXlKIqo86wTIsFEYosc
	M60XgAhTG/TbIWWMeM/B/L9K2mvagfjUE8A+vigGSzq1Mak4js8xvYEQ/O/56gHBlY4lIjLn1/vJM
	9hlCA31er5bJdAny4rXU5ZaCexXe2EBFwHQWLv8ILg8vcRNBD3X0nWKlcpCnoZcrYMFLjMMxLcg9k
	FORVcIPTKoAP38fcJuQiZ5UnBQA4TfL0E8V3tpZRcuypYriSvTHfMx6iPtVNYnmspQySj93MbBW0g
	d74dnn8Hj/HDqDtW6eKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh3yQ-0000000CBpa-0DwC;
	Thu, 22 Aug 2024 09:19:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh3x5-0000000CBay-3Q7q
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 09:17:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724318273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TQYE68vcEgjS0sSHwEvda+5305YgNqXrXPbN5IkBuaU=;
	b=UY1Q5HwYWh3v/HAQG051COykZLBdUrl4gl4G2eetp+cjvuJnU8R6h2ijP5kqj9fVCTnipL
	VVd7ZLyrNn5+Gm8eMkJU3qbFReUaF8K48gI6YONQaTooqWYKChRa4gDUmg5eFoPcFza6bI
	WC3/oECWLfTeYNt/PLz8Iz7kqRKAfBo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-L0turdIFM4OQX6QvsCLAsw-1; Thu,
 22 Aug 2024 05:17:49 -0400
X-MC-Unique: L0turdIFM4OQX6QvsCLAsw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3C3B1955EB3;
	Thu, 22 Aug 2024 09:17:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A174E1956053;
	Thu, 22 Aug 2024 09:17:41 +0000 (UTC)
Date: Thu, 22 Aug 2024 17:17:36 +0800
From: Baoquan He <bhe@redhat.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, Dave Vasilevsky <dave@vasilevsky.ca>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	debian-powerpc@lists.debian.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev, akpm@linux-foundation.org,
	ebiederm@xmission.com, hbathini@linux.ibm.com, piliu@redhat.com,
	viro@zeniv.linux.org.uk, Sam James <sam@gentoo.org>
Subject: Re: [PATCH linux-next v3 05/14] crash: clean up kdump related config
 items
Message-ID: <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-6-bhe@redhat.com>
 <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_021755_963420_AFF05393 
X-CRM114-Status: GOOD (  24.32  )
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

On 08/22/24 at 09:33am, John Paul Adrian Glaubitz wrote:
> Hi Baoquan,
> 
> On Wed, 2024-01-24 at 13:12 +0800, Baoquan He wrote:
> > By splitting CRASH_RESERVE and VMCORE_INFO out from CRASH_CORE, cleaning
> > up the dependency of FA_DMUMP on CRASH_DUMP, and moving crash codes from
> > kexec_core.c to crash_core.c, now we can rearrange CRASH_DUMP to
> > depend on KEXEC_CORE, and make CRASH_DUMP select CRASH_RESERVE and
> > VMCORE_INFO.
> > 
> > KEXEC_CORE won't select CRASH_RESERVE and VMCORE_INFO any more because
> > KEXEC_CORE enables codes which allocate control pages, copy
> > kexec/kdump segments, and prepare for switching. These codes are shared
> > by both kexec reboot and crash dumping.
> > 
> > Doing this makes codes and the corresponding config items more
> > logical (the right item depends on or is selected by the left item).
> > 
> > PROC_KCORE -----------> VMCORE_INFO
> > 
> >            |----------> VMCORE_INFO
> > FA_DUMP----|
> >            |----------> CRASH_RESERVE
> > 
> >                                                 ---->VMCORE_INFO
> >                                                /
> >                                                |---->CRASH_RESERVE
> > KEXEC      --|                                /|
> >              |--> KEXEC_CORE--> CRASH_DUMP-->/-|---->PROC_VMCORE
> > KEXEC_FILE --|                               \ |
> >                                                \---->CRASH_HOTPLUG
> > 
> > KEXEC      --|
> >              |--> KEXEC_CORE--> kexec reboot
> > KEXEC_FILE --|
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  kernel/Kconfig.kexec | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 8faf27043432..6c34e63c88ff 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -9,8 +9,6 @@ config VMCORE_INFO
> >  	bool
> >  
> >  config KEXEC_CORE
> > -	select VMCORE_INFO
> > -	select CRASH_RESERVE
> >  	bool
> >  
> >  config KEXEC_ELF
> > @@ -99,8 +97,11 @@ config KEXEC_JUMP
> >  
> >  config CRASH_DUMP
> >  	bool "kernel crash dumps"
> > +	default y
> >  	depends on ARCH_SUPPORTS_CRASH_DUMP
> > -	select KEXEC_CORE
> > +	depends on KEXEC_CORE
> > +	select VMCORE_INFO
> > +	select CRASH_RESERVE
> >  	help
> >  	  Generate crash dump after being started by kexec.
> >  	  This should be normally only set in special crash dump kernels
> 
> The change to enable CONFIG_CRASH_DUMP by default apparently broke the boot
> on 32-bit Power Macintosh systems which fail after GRUB with:
> 
> 	"Error: You can't boot a kdump kernel from OF!"
> 
> We may have to turn this off for 32-bit Power Macintosh systems.
> 
> See this thread on debian-powerpc ML: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html

If so, fix need be made.

We may need change in ARCH_SUPPORTS_CRASH_DUMP of ppc, can you or anyone
post a patch? I don't know how to identify 32-bit Power Macintosh.

arch/powerpc/Kconfig:
===
config ARCH_SUPPORTS_CRASH_DUMP
        def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
        
config ARCH_SELECTS_CRASH_DUMP
        def_bool y
        depends on CRASH_DUMP
        select RELOCATABLE if PPC64 || 44x || PPC_85xx
......
config PHYSICAL_START
        hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
        default "0x02000000" if PPC_BOOK3S && CRASH_DUMP && !NONSTATIC_KERNEL
        default "0x00000000"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

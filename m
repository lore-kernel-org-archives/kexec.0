Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D7AC5320E
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 00:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YPy7XJvq22IAo03rRpEr/sLcJmogcq5mbdUL6VRzVzU=; b=zXxVQywneI0aiO
	aCPMVVjhbBBCwYFva2JQnGBJLFGLws4Du/IKziFa+Ak7fTJiZi8qfR4o0S9GwfP2JjhtAzYrlXboR
	BNpa8k2a/KoXw3ElQRxgB1D2zt9cCzSVqDwPv/xvPIQAbAlE0qvlxQ/Sm3G1vCK5NXqQytkCTFiRq
	I89LbqumA+R8GcRsTU2YS9r3aecUGfPH1i6L3E8sJ3rncRfSaJIQwRfH5azIj/JvE0rsXlH/cC8Bd
	QAW0+WC64CIlWjuI0osOIyU3Z0XasBqEUZxmFHyyVKZt+LLBQiWi+qqCGEAtUw8UFz7eSf/4oiufw
	AFwvU23HWE3gXF8j+G+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shHmz-0000000Eeas-0qKB;
	Fri, 23 Aug 2024 00:04:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shHmv-0000000EeYF-14FM
	for kexec@lists.infradead.org;
	Fri, 23 Aug 2024 00:04:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724371459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHqbq1AQSOY5EcS479bGVBSadv/yHMIWF28e/YV8WdA=;
	b=TkML4e/uurJjQBOYeTuxhTmcHPx4B1ATzR3NnAeTn9VCZhiUE9RF4dn90l8q/EL0jaGe+1
	0I9Zb8tTSrkeNOUN40g3rWe42CiwTd5ImTaGN65zQGBXlW8x3QXIntiFP2Kof6P74eHimF
	CQU9Rd05CTLMiGmqGbupMaUaxx+8I60=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-Q2zfLi0YMr2QKG2BabfBhQ-1; Thu,
 22 Aug 2024 20:04:18 -0400
X-MC-Unique: Q2zfLi0YMr2QKG2BabfBhQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0352B1955BF4;
	Fri, 23 Aug 2024 00:04:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACCC819560A3;
	Fri, 23 Aug 2024 00:04:10 +0000 (UTC)
Date: Fri, 23 Aug 2024 08:04:06 +0800
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
Message-ID: <ZsfR9rdMt8yn1+Bz@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-6-bhe@redhat.com>
 <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
 <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
 <c5e9996e4d2ba2a0849d65f68e3dce94fffc5828.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c5e9996e4d2ba2a0849d65f68e3dce94fffc5828.camel@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_170421_406357_69DD4C3E 
X-CRM114-Status: GOOD (  28.98  )
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

On 08/22/24 at 11:37am, John Paul Adrian Glaubitz wrote:
> Hi Baoquan,
> 
> On Thu, 2024-08-22 at 17:17 +0800, Baoquan He wrote:
> > > The change to enable CONFIG_CRASH_DUMP by default apparently broke the boot
> > > on 32-bit Power Macintosh systems which fail after GRUB with:
> > > 
> > > 	"Error: You can't boot a kdump kernel from OF!"
> > > 
> > > We may have to turn this off for 32-bit Power Macintosh systems.
> > > 
> > > See this thread on debian-powerpc ML: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
> > 
> > If so, fix need be made.
> > 
> > We may need change in ARCH_SUPPORTS_CRASH_DUMP of ppc, can you or anyone
> > post a patch? I don't know how to identify 32-bit Power Macintosh.
> > 
> > arch/powerpc/Kconfig:
> > ===
> > config ARCH_SUPPORTS_CRASH_DUMP
> >         def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
> >         
> > config ARCH_SELECTS_CRASH_DUMP
> >         def_bool y
> >         depends on CRASH_DUMP
> >         select RELOCATABLE if PPC64 || 44x || PPC_85xx
> > ......
> > config PHYSICAL_START
> >         hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
> >         default "0x02000000" if PPC_BOOK3S && CRASH_DUMP && !NONSTATIC_KERNEL
> >         default "0x00000000"
> 
> I think the architecture does support crash dumps, but I think the kernel has to
> be booted from kexec in this case. Booting a kernel with CRASH_DUMP enabled won't
> work from Open Firmware. So, I think CRASH_DUMP should just be disabled for
> PPC_BOOK3S_32 by default and users who want to use it on these systems, will have to
> enable it explicitly.

If so, below patch possiblly can fix it. Can you help check if it's OK?

From dd5318dc5dcd66521b31214f0e5921f258532ef8 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Fri, 23 Aug 2024 07:37:38 +0800
Subject: [PATCH] powerpc/crash: do not default to enable CRASH_DUMP for
 PPC_BOOK3S_32 system
Content-type: text/plain

Recently it's reported that PowerPC macMini system failed to boot up.
It's because CONFIG_CRASH_DUMP=y is set by default on the system since
kernel 6.9, and that makes CONFIG_PHYSICAL_START not equaling 0 any
more and causes failure of normal kernel bootup.

The link of error report can be found here:

https://lists.debian.org/debian-powerpc/2024/07/msg00001.html

And copy the code snippet here for reference:
arch/powerpc/Kconfig:
==================
config KERNEL_START
        hex "Virtual address of kernel base" if KERNEL_START_BOOL
        default PAGE_OFFSET if PAGE_OFFSET_BOOL
        default "0xc2000000" if CRASH_DUMP && !NONSTATIC_KERNEL
        default "0xc0000000"

So let's stop enabling CRASH_DUMP by default on PPC_BOOK3S_32.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7b09b064a8a..dc5ca58be1d6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -680,7 +680,7 @@ config RELOCATABLE_TEST
 	  relocation code.
 
 config ARCH_SUPPORTS_CRASH_DUMP
-	def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
+	def_bool PPC64 || PPC_85xx || (44x && !SMP)
 
 config ARCH_SELECTS_CRASH_DUMP
 	def_bool y
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

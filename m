Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBF9C5320E
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=agqZ95ngWXYTTMH6A651O5SI3MvJIygl6FXh42wfrU4=; b=1afaJ3xcjRr5KF
	d3eabqP1w24ywB45v0BgGwhbSTianAh5CggjULiO1vj51R9Tmec7H5U3oUbTPpzPkXJsaw5uKH+uh
	HfcPNYhHlIq4QFdWbpJmZG+fx/IZ+W+0223Fe1DHO6xwFpNgB4BlZ7onJ6cZRI7jVT3jmLK6jogUl
	pS+Z/Xdb9JexvcR/8TeIV8HYGWd4kNUskKV5nCmYNOWOsiBJ3slcT8A15EajfxSwVANvvZGAc6P9c
	BjPI6mh/L7ZIY0zxp1PnBf5ebvCGzyv9hbnTomGzKGgfDNu+v/9JOGt8qaOYEWbuy1eW2DQr2XdZ/
	CmzziyTG+RTOwOqLrumg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh4G4-0000000CGgz-3Xra;
	Thu, 22 Aug 2024 09:37:32 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh4Fr-0000000CGcz-34tg;
	Thu, 22 Aug 2024 09:37:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ew4XJV0bOTsY5qn2+zYb5/OFku83Mlpg9puNUd46LUI=; t=1724319439; x=1724924239; 
	b=SMewXOvNU+uSq1xs8savaRRvsM0g4SpeIvbtCBLfOW0gG1pAyl9aTve+cWGtqpw95QsC5l5PAj5
	c2Jz0GT9ry49P9eLvv6tBt/P3HFaVIqXrk1BUMLf2PeoiVeEq5XP78g7HZ+NocVAoT7ksLf7KwP/S
	7Fp1sjV06ZlRHg48NHFCagJ1UyDDr6QH9gUcURAxpdaHwhprlZafrKZIdw0MPeiGa6CrGNm3FoQef
	DYTxzfzCyyeDxkI23HIjLx3fJjMEFHHPbbiX61pOlc6fgBDuLqGETZZAlLuiU5dizM0J3YTJ6mtyO
	gLcwynepmrEkH+/+73bAYa+1B5omyDNZ25FA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sh4Fi-000000011Jg-3QjS; Thu, 22 Aug 2024 11:37:10 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sh4Fi-00000003DQ3-2PLa; Thu, 22 Aug 2024 11:37:10 +0200
Message-ID: <c5e9996e4d2ba2a0849d65f68e3dce94fffc5828.camel@physik.fu-berlin.de>
Subject: Re: [PATCH linux-next v3 05/14] crash: clean up kdump related
 config items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Dave Vasilevsky <dave@vasilevsky.ca>, 
 Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
 debian-powerpc@lists.debian.org, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org,  linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev,  akpm@linux-foundation.org,
 ebiederm@xmission.com, hbathini@linux.ibm.com,  piliu@redhat.com,
 viro@zeniv.linux.org.uk, Sam James <sam@gentoo.org>
Date: Thu, 22 Aug 2024 11:37:09 +0200
In-Reply-To: <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
	 <20240124051254.67105-6-bhe@redhat.com>
	 <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
	 <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.191
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_023719_948590_C494EB6D 
X-CRM114-Status: GOOD (  13.65  )
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

On Thu, 2024-08-22 at 17:17 +0800, Baoquan He wrote:
> > The change to enable CONFIG_CRASH_DUMP by default apparently broke the boot
> > on 32-bit Power Macintosh systems which fail after GRUB with:
> > 
> > 	"Error: You can't boot a kdump kernel from OF!"
> > 
> > We may have to turn this off for 32-bit Power Macintosh systems.
> > 
> > See this thread on debian-powerpc ML: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
> 
> If so, fix need be made.
> 
> We may need change in ARCH_SUPPORTS_CRASH_DUMP of ppc, can you or anyone
> post a patch? I don't know how to identify 32-bit Power Macintosh.
> 
> arch/powerpc/Kconfig:
> ===
> config ARCH_SUPPORTS_CRASH_DUMP
>         def_bool PPC64 || PPC_BOOK3S_32 || PPC_85xx || (44x && !SMP)
>         
> config ARCH_SELECTS_CRASH_DUMP
>         def_bool y
>         depends on CRASH_DUMP
>         select RELOCATABLE if PPC64 || 44x || PPC_85xx
> ......
> config PHYSICAL_START
>         hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
>         default "0x02000000" if PPC_BOOK3S && CRASH_DUMP && !NONSTATIC_KERNEL
>         default "0x00000000"

I think the architecture does support crash dumps, but I think the kernel has to
be booted from kexec in this case. Booting a kernel with CRASH_DUMP enabled won't
work from Open Firmware. So, I think CRASH_DUMP should just be disabled for
PPC_BOOK3S_32 by default and users who want to use it on these systems, will have to
enable it explicitly.

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

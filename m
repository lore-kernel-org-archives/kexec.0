Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757D2C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 21:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ST9igBSaBfoTIQg0s+dzL2iD4rhlINLCj/Kc7GkqWng=; b=uP0OTHN2QnzHP6jx8z20hsLWBe
	wqJfGMCWzyIXEfB4VZqtPyqeQWJBAnG3CD89r13v52eMWVLDx0kIDqs5BocKGQmcEAdeq7nc2qBUs
	0hknMA89sexDsbODbpFzc7nASh6vcI/7aLTGKOGQ3zibUDQ3j5HbNXOo1svJxJypI3f9EGCezSowr
	t/tSB3oxxZvIhihTMCkLzfdmfbg+8SGe2OeFOeP3uyovrZ1SVBsLbHbyqHXFqsS5WrzZ/5vRGm+Vt
	70IdLN9JnoDPHkEj1cARyQsfP+OqGxD1c0CWgXT63Ald6kDqic37FppWmvZ9ptbM9+fHLjvrNi0pD
	DSh8DrLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzjyR-000000064wc-1OKX;
	Wed, 24 Apr 2024 21:16:15 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzirW-00000005oKt-2HnM
	for kexec@bombadil.infradead.org;
	Wed, 24 Apr 2024 20:05:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Content-Type:MIME-Version:
	Message-ID:In-Reply-To:Date:References:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QGB3Hm5N9tIt/JopFuN5abL1qbtrIgZ1FufbserQwyU=; b=ZCosrRqoUa+ChdHeXCvFPe1sHR
	d9CUiw2hupUWyflxnbW8CbCxLru+7S14eIly1yDe9M3iotf6NK1NgZrshO9JpsdR7bxVIk+8spxGr
	/KbZIN1uCQlNkBij30S7GHdUbULlhCKMrxd7K0H/LmJ2pZdlFWWGyWAMzTe3cx054xHnR530AAPAi
	dBbgpeGg9ycrADmaamuMrHvb/AKfY3KkxByxpStIvAYQeI11ubp0myorYi0968XDON4U0Wn+CRwgp
	TWIxCN2/mXi4U1HfBHL9KVXf/SYA//PzkoAAovSisSQrwqoKN0/ClKuQdsCPHkxYsQ0k7hOr97bg0
	eI4ubIkQ==;
Received: from out01.mta.xmission.com ([166.70.13.231])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzirR-0000000EYKw-1VeQ
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 20:05:01 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:44578)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rzir3-00CtOb-8V; Wed, 24 Apr 2024 14:04:33 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:56944 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rzir2-00BaKD-48; Wed, 24 Apr 2024 14:04:32 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org,  x86@kernel.org,  Ard Biesheuvel
 <ardb@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  kexec@lists.infradead.org,  Nathan Chancellor <nathan@kernel.org>,  Nick
 Desaulniers <ndesaulniers@google.com>,  Kees Cook <keescook@chromium.org>,
  Bill Wendling <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,
  Masahiro Yamada <masahiroy@kernel.org>
References: <20240424155309.1719454-11-ardb+git@google.com>
Date: Wed, 24 Apr 2024 15:04:02 -0500
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com> (Ard Biesheuvel's
	message of "Wed, 24 Apr 2024 17:53:10 +0200")
Message-ID: <87bk5yv87h.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rzir2-00BaKD-48;;;mid=<87bk5yv87h.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/ePpyQ5pyFK6twschP4ln4lEVPApbMIwA=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 0/9] kexec x86 purgatory cleanup
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_210457_928846_09134BE8 
X-CRM114-Status: GOOD (  29.50  )
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

Ard Biesheuvel <ardb+git@google.com> writes:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> The kexec purgatory is built like a kernel module, i.e., a partially
> linked ELF object where each section is allocated and placed
> individually, and all relocations need to be fixed up, even place
> relative ones.
>
> This makes sense for kernel modules, which share the address space with
> the core kernel, and contain unresolved references that need to be wired
> up to symbols in other modules or the kernel itself.
>
> The purgatory, however, is a fully linked binary without any external
> references, or any overlap with the kernel's virtual address space. So
> it makes much more sense to create a fully linked ELF executable that
> can just be loaded and run anywhere in memory.

It does have external references that are resolved when it is loaded.

Further it is at least my impression that non-PIC code is more
efficient.  PIC typically requires silly things like Global Offset
Tables that non-PIC code does not.  At first glance this looks like a
code passivization.

Now at lot of functionality has been stripped out of purgatory so maybe
in it's stripped down this make sense, but I want to challenge the
notion that this is the obvious thing to do.

> The purgatory build on x86 has already switched over to position
> independent codegen, which only leaves a handful of absolute references,
> which can either be dropped (patch #3) or converted into a RIP-relative
> one (patch #4). That leaves a purgatory executable that can run at any
> offset in memory with applying any relocations whatsoever.

I missed that conversation.  Do you happen to have a pointer?  I would
think the 32bit code is where the PIC would be most costly as the 32bit
x86 instruction set predates PIC being a common compilation target.

> Some tweaks are needed to deal with the difference between partially
> (ET_REL) and fully (ET_DYN/ET_EXEC) linked ELF objects, but with those
> in place, a substantial amount of complicated ELF allocation, placement
> and patching/relocation code can simply be dropped.

Really?  As I recall it only needed to handle a single allocation type,
and there were good reasons (at least when I wrote it) to patch symbols.

Again maybe the fact that people have removed 90% of the functionality
makes this make sense, but that is not obvious at first glance.

> The last patch in the series removes this code from the generic kexec
> implementation, but this can only be done once other architectures apply
> the same changes proposed here for x86 (powerpc, s390 and riscv all
> implement the purgatory using the shared logic)
>
> Link: https://lore.kernel.org/all/CAKwvOd=3Jrzju++=Ve61=ZdeshxUM=K3-bGMNREnGOQgNw=aag@mail.gmail.com/
> Link: https://lore.kernel.org/all/20240418201705.3673200-2-ardb+git@google.com/
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
>
> Ard Biesheuvel (9):
>   x86/purgatory: Drop function entry padding from purgatory
>   x86/purgatory: Simplify stack handling
>   x86/purgatory: Drop pointless GDT switch
>   x86/purgatory: Avoid absolute reference to GDT
>   x86/purgatory: Simplify GDT and drop data segment
>   kexec: Add support for fully linked purgatory executables
>   x86/purgatory: Use fully linked PIE ELF executable
>   x86/purgatory: Simplify references to regs array
>   kexec: Drop support for partially linked purgatory executables
>
>  arch/x86/include/asm/kexec.h       |   8 -
>  arch/x86/kernel/kexec-bzimage64.c  |   8 -
>  arch/x86/kernel/machine_kexec_64.c | 127 ----------
>  arch/x86/purgatory/Makefile        |  17 +-
>  arch/x86/purgatory/entry64.S       |  96 ++++----
>  arch/x86/purgatory/setup-x86_64.S  |  31 +--
>  arch/x86/purgatory/stack.S         |  18 --
>  include/asm-generic/purgatory.lds  |  34 +++
>  kernel/kexec_file.c                | 255 +++-----------------
>  9 files changed, 125 insertions(+), 469 deletions(-)
>  delete mode 100644 arch/x86/purgatory/stack.S
>  create mode 100644 include/asm-generic/purgatory.lds

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

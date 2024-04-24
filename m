Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44044C4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 20:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PfMewO37zRRWE8jMIHcUS9DW1OaIMDOqfy4xZ6dZXJw=; b=d7hyt8voYwqKM2
	jvOya2WGYfTj/2XLGX+uFB2OtLbMQacApDahYcsxmm0r21g5R+J3MKEOvEJltv1NjoFVsjFJPz4hq
	I8LYOU0T2etQmrba5oH21mAuiGYRRBR/eNJB85odY4XJo6M6YbyDsIvUOrUbl5pMqolkwc9KIpfmq
	LUisq841oEq4wDDkzY9jkr6buA2MQSpLteBTdK34XWBrIrsNx4fWucmXyjzVykiecei4TWYh3c6Ws
	AoTyhG0yoJbD5DA7dhr1RaBfHZcVphDEOpSeK/c5keT9DkHEmPg51lxvAC0udhTUwrbXnkBdTa0ab
	JArPMvZV6NrvcHMy7pLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzjbS-000000060ud-1TMZ;
	Wed, 24 Apr 2024 20:52:30 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzjbP-000000060tX-1kCe
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 20:52:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E6FD1CE1665
	for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 20:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1942FC32781
	for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713991944;
	bh=U8vN6+xOk4zyZdpad0pX9zdS4fQ6q9OQDwYM3NEU+dI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bdOX6C31ndrm0+qVhx83jYqY8oK3lKPL5yadH+mG8ffz2nqDG6FBEFw/dNMlUlOx0
	 Y76MZ2tSpfI/PlunIZEUjuttngRtLYoor/Jkk+NCqhhAkKqYJILZ36PyEJw66Ercw1
	 JePD7F0JP9/j1+waJMlAt+TrvZcErX5XwkFgChTclNH7Br6OfeJihaJMFWoi27CcL1
	 ONV0xL9fSDaQwh+SRK6waU3qMM7deu4llwH/A9Jju4jbWKmnHsdgU90F7J08gZyLTz
	 9wGBnxHdyobajpPZX6nwdKvnyxiVsCj40JaxbbXrbsO3HyunadrrLejtaVizeDrfeX
	 oeGOOUygraOUg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d8b194341eso2613721fa.3
        for <kexec@lists.infradead.org>; Wed, 24 Apr 2024 13:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUln7jvwYImx0rG1EV7iEjQ8rHjKLbOlfjPHtHxLzIzeSkDM3LT+g5Z2MhW2OdyIMVmFjSueptSymNDo7gLocSokwkqK3UBjbfU
X-Gm-Message-State: AOJu0Yzb/j73BtpAlvHEmB3RT2m35YQCwUlPCWUIYIFnHRqEdxUaPkNW
	Dd2pRnsnZvKrbMjDbUv7uTsY5tEFh/xSfdOND3/7RL5BEbYNn9abe2v75KVeQ1tkm2MR7V6RQzC
	Is30IuvFuRNfVWLthX+NOT/F4E64=
X-Google-Smtp-Source: AGHT+IFdjbva3NaWtea+JO3rX/Y+cVtJkd5mRpOVE9YOqsXQty/XHSlBB7+pr5gcfEE+ImdpEafECDGHtrmfkfuJYOg=
X-Received: by 2002:a2e:9d06:0:b0:2d8:6b0c:d91c with SMTP id
 t6-20020a2e9d06000000b002d86b0cd91cmr1948042lji.47.1713991942394; Wed, 24 Apr
 2024 13:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com> <87bk5yv87h.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bk5yv87h.fsf@email.froward.int.ebiederm.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Apr 2024 22:52:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGsmaEiZAOUnn+Eh7-_VP0PHU+=0KoD-SNvqkvcZ1_7FA@mail.gmail.com>
Message-ID: <CAMj1kXGsmaEiZAOUnn+Eh7-_VP0PHU+=0KoD-SNvqkvcZ1_7FA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] kexec x86 purgatory cleanup
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_135227_823761_87225C2F 
X-CRM114-Status: GOOD (  37.59  )
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

On Wed, 24 Apr 2024 at 22:04, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ard Biesheuvel <ardb+git@google.com> writes:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The kexec purgatory is built like a kernel module, i.e., a partially
> > linked ELF object where each section is allocated and placed
> > individually, and all relocations need to be fixed up, even place
> > relative ones.
> >
> > This makes sense for kernel modules, which share the address space with
> > the core kernel, and contain unresolved references that need to be wired
> > up to symbols in other modules or the kernel itself.
> >
> > The purgatory, however, is a fully linked binary without any external
> > references, or any overlap with the kernel's virtual address space. So
> > it makes much more sense to create a fully linked ELF executable that
> > can just be loaded and run anywhere in memory.
>
> It does have external references that are resolved when it is loaded.
>

It doesn't today, and it hasn't for a while, at least since commit

e4160b2e4b02377c67f8ecd05786811598f39acd
x86/purgatory: Fail the build if purgatory.ro has missing symbols

which forces a build failure on unresolved external references, by
doing a full link of the purgatory.

> Further it is at least my impression that non-PIC code is more
> efficient.  PIC typically requires silly things like Global Offset
> Tables that non-PIC code does not.  At first glance this looks like a
> code passivization.
>

Given that the 64-bit purgatory can be loaded in memory that is not
32-bit addressable, the PIC code is essentially a given, since the
large code model is much worse (it uses 64-bit immediate for all
function and variable symbols, and therefore always uses indirect
calls)

Please refer to

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/build&id=cba786af84a0f9716204e09f518ce3b7ada8555e

for more details. (Getting pulled into that discussion is how I ended
up looking into the purgatory in more detail)

> Now at lot of functionality has been stripped out of purgatory so maybe
> in it's stripped down this make sense, but I want to challenge the
> notion that this is the obvious thing to do.
>

The diffstat speaks for itself - on x86, much of the allocation and
relocation logic can simply be dropped when building the purgatory in
this manner.

> > The purgatory build on x86 has already switched over to position
> > independent codegen, which only leaves a handful of absolute references,
> > which can either be dropped (patch #3) or converted into a RIP-relative
> > one (patch #4). That leaves a purgatory executable that can run at any
> > offset in memory with applying any relocations whatsoever.
>
> I missed that conversation.  Do you happen to have a pointer?  I would
> think the 32bit code is where the PIC would be most costly as the 32bit
> x86 instruction set predates PIC being a common compilation target.
>

See link above. Note that this none of this is about 32-bit code - the
purgatory as it exists today never drops out of long mode (and no
32-bit version appears to exist)

> > Some tweaks are needed to deal with the difference between partially
> > (ET_REL) and fully (ET_DYN/ET_EXEC) linked ELF objects, but with those
> > in place, a substantial amount of complicated ELF allocation, placement
> > and patching/relocation code can simply be dropped.
>
> Really?  As I recall it only needed to handle a single allocation type,
> and there were good reasons (at least when I wrote it) to patch symbols.
>
> Again maybe the fact that people have removed 90% of the functionality
> makes this make sense, but that is not obvious at first glance.
>

Again, the patches and the diffstat speak for themselves - the linker
applies all the relocations at build time, and emits all the sections
into a single ELF segment that can be copied into memory and executed
directly (modulo poking values into the global variables for the
sha256 digest and the segment list)

The last patch in the series shows which code we could drop from the
generic kexec_file_load() implementation once other architectures
adopt this scheme.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

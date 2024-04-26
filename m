Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF522C4345F
	for <kexec@archiver.kernel.org>; Fri, 26 Apr 2024 21:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NCjth7BDddwbGinskPLLhAv2xL1PJehNxezNjyyg55Q=; b=PXIZI6cB9HpYE6
	lyGbEsDMom1IVEucoorF0Pq3CgjoLnRzNm1oMwRGa57jGTqY2YgrI1Jx/uTJgh+rSzlMb9ncXSZYi
	4fZ/vFQbGBxapzNmhlI+haZHKauGk5F8qJRu5LJ3pyCw/i9W8kGw0sKIMXnwM+L0XqX6Eqk/3lLRI
	AEeQVeuYO99fdqG20EPoxqWQjFJ5LVvejG7OarlKGotd5kQr7nwuWASy2t9cZMcYh2+p6GIJ/SuqY
	lvsZg0UkXjfEVFNkPL+veN+6BaSKJYQKrrc5WesBS9CLU61jgolkEztq+i5qZi/Tas71o4MKCxqdz
	MzsiBmh3uv9X3ZxBnwVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0TW3-0000000E9QG-0aUr;
	Fri, 26 Apr 2024 21:53:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0TVz-0000000E9PX-37UW
	for kexec@lists.infradead.org;
	Fri, 26 Apr 2024 21:53:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8422762152;
	Fri, 26 Apr 2024 21:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B45C113CD;
	Fri, 26 Apr 2024 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714168434;
	bh=JmkU59HQtS7Nf9V3I23Kr43ZjpzMetcH9MCG6rKL23I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZKpNuJ7vvkN57xMlCriC/RrwkAnMLBTbGbOTwmtM7QvA5LjMXDNx3ivIPKkWVMFQ
	 UDkMdL2wsxzB7WrOq1m55tv+cx2UXJCmxU6FT6XGxZofQEZ7BAJN+ASYrCljZTeUii
	 JUaaljLuZAA6CgFBQl78jBoFG6lyfM+fpV13umLygKdUTETMvS4UPUNnBIfPRbtzlR
	 /P7BeBu5LRrBrAfiVBfnodi/LhDJI4DBTdYWXi9O2hCZ+l9FbI/iNe0OlIUSSVKbCy
	 7uMXYi6KF2BC4YA6WIAlNm+g/G7Y1qFab0Ym9VgSvjSdjyeW6ImLNr6CuPRXY8gK+C
	 devVKdiJ1RSog==
Date: Fri, 26 Apr 2024 14:53:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
Message-ID: <20240426215351.GA3278657@dev-arch.thelio-3990X>
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com>
 <20240424182659.GA2126602@dev-arch.thelio-3990X>
 <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <pgsqflimo7d2ozhpmdrmscx25mxs5lypcvwq6mgjs7uixsxvsl@5papnq46mwbs>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_145355_857048_09A20291 
X-CRM114-Status: GOOD (  15.90  )
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

On Fri, Apr 26, 2024 at 09:32:52PM +0000, Justin Stitt wrote:
> Hi,
> 
> On Wed, Apr 24, 2024 at 11:26:59AM -0700, Nathan Chancellor wrote:
> > On Wed, Apr 24, 2024 at 05:53:12PM +0200, Ard Biesheuvel wrote:
> > >  arch/x86/purgatory/stack.S        | 18 ------------------
> > 
> > This needs a small fix up to build.
> > 
> >   make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.
> > 
> 
> I was trying to reproduce this build failure, but to no avail. I am
> curious what your build target / build command was.
> 
> It is clear that stack.S has been removed so your change makes sense, I
> don't doubt that -- I just cannot get that specific error message you

Odd, I was using my distribution configuration for the test but it is
easily reproducible with allmodconfig:

  $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 allmodconfig arch/x86/purgatory/
  make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.
  ...

> encountered (what is a .ro file supposed to be, anyway?).

Read only? Relocatable object? *shrug*

Cheers,
Nathan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

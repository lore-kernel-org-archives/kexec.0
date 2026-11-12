Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601E0606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r2//7bhu;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONvgcakO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b/D0zsBG3kAacs0MLKSIQPr52pQwnIYsnGcp9zQ980E=; b=r2//7bhuoSTrAJAqp7q9Dv1nez
	XfqzmbwHzXHrYM8JSsFGl3O2QVZR5GsaxBf5I1P2u1hX7hM29T3kC8ZlwP6N+tV0I44YaXNMe1sd8
	U1pEOJatY/d9NVaiIP+PB+wc5Sqpvfou2p8CAvkezga0WIPWsiTHLDFDwEa9BOCX0b0ObtKvHOS19
	tXbDJoOXS5f3xvfMBBWM0R8sRjHvogkoGJpZ84J0kq1AgFiYskxyXqwZVOVfEeExrnF08abemN0AP
	ePbMihKFZY9r4bjlLWiJjkka6hqVUzaMvU+t+CeDKUq/E449b+sL+WG9dp0sRZB0mVNHXGaVrl8oT
	qNXTKAKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRNqK-00000008mmS-3erm;
	Thu, 12 Nov 2026 05:59:28 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRNqI-00000008mmL-3nHg
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 05:59:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5378444FBE;
	Thu, 12 Nov 2026 05:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390B91F00A05;
	Thu, 12 Nov 2026 05:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794463166;
	bh=b/D0zsBG3kAacs0MLKSIQPr52pQwnIYsnGcp9zQ980E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ONvgcakO68YiyNkoeqwhUmFwhdjMLaLuDY9EACrjI0EIFNKVfr21hfsPGRZS+jJMM
	 NpXGoZ+n2iUSmrN1x6AFw7JZLXx4c3bBrr41G8IduJVSc80OptIMNtlUrwNvoi7EkH
	 k4jPNsDDpn/qquzUiQbpLscvhVq53u578vDCreLJZJWWIh/9OXD4IAdUJB6gahqe5B
	 QRbyIZh6Hx1u12MiZKkcP7kZqn6gbTIdh8CuCzhFo4nP3YbVGS4H9bdhTDmQVp0mnj
	 1Coup66T5tkN2kWTAsJxMeMatIFOF/suutt7dX7zllow6MUXxG1vrbi+wOlgIFp35T
	 g+YM1lcCIm6gA==
Date: Wed, 11 Nov 2026 21:59:23 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ben Cressey <ben@cressey.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>, 
	kexec@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] x86/kexec: Type relocate_kernel() to drop __nocfi
Message-ID: <avVUv4_eeOOr7ZX_@jpoimboe>
References: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:26:59PM -0800, Ben Cressey wrote:
> machine_kexec() calls the control page's copy of relocate_kernel()
> indirectly. The routine has no kCFI type, so all of machine_kexec() is
> exempt since commit 2114796ca041 ("x86/kexec: Mark machine_kexec() with
> __nocfi"), and ANNOTATE_NOCFI_SYM() silences objtool.
> 
> No other call there loses its check today, but one added later would.
> Review of that mark on arm64 preferred a typed entry, and objected to
> covering a whole function, on x86 too [1].
> 
> Typing the routine was set aside in 2025 as not worth it [2]: a type
> from the caller cannot catch a prototype that drifts, and
> machine_kexec() seemed unlikely to follow a stray pointer.
> 
> Type the routine with SYM_TYPED_START(), emit an ENDBR only under
> CONFIG_FINEIBT, whose boot-time rewrite skips a function without one,
> and drop both exemptions, along with kexec as a valid use in annotate.h.
> 
> The check guards only the pointer, and not reliably under plain FineIBT,
> which checks in the callee with IBT off. A failed check panics or hangs
> with no CFI report, since load_segments() has reset GS.
> 
> Link: https://lore.kernel.org/202609241804.BB23BF10@keescook # [1]
> Link: https://lore.kernel.org/9c41ab61efc573e3ab5a75b6e4031f81db84a846.camel@infradead.org # [2]
> Signed-off-by: Ben Cressey <ben@cressey.dev>
> ---
> This follows Kees Cook's review [1] of the arm64 kexec fix, which goes
> separately. It is not a security fix, and nothing faults here today.
> The copy gains a type hash and, with CONFIG_FINEIBT=y, an ENDBR, bare
> under cfi=kcfi or cfi=off. SYM_TYPED_FUNC_START() is not used, since it
> would put an ENDBR in every IBT build. Code built with CONFIG_CFI=n is
> unchanged. A failed check stops crash kexec too.
> 
> An LLM wrote the patch and drafted the changelog.

No objection to the change itself, but PLEASE no LLM-written changelogs
or comments, they tend to read like Rube Goldberg machines and these are
no exception...

-- 
Josh


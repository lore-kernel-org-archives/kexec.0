Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA1606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ob9+toIk;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=NB8DUBSN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Cm7AtxdM5CH1FUBVqHh5yaMh1nV0eZJjc/Ip3saInLw=; b=ob9+toIk2mP22L+eY1omM8G/Lp
	gMhlpTHIpw/FXCn2h1rCi83ltZcW6DpSXZD/q9LF0WXKzEzlXnMQ1RnQCXLkp9BkXMMcuE/tf8mfx
	d3V3bFDwpA458XIrnHC+J4WHRkMekjIVw9j0il+4h4SDKTqapXdEhRXzjQPKYrqk1eQRtimWI/e74
	mnDMlzLASu9A3ZXGJMQ2Uyec4rdTDnlADL3YWNMMtG0OQz4OBztxo09gAWCVDxJ2JdpyD218QrqSx
	3TgYhwemyHbTJ8AdqeDbYI4dBsw8hTNz5YZ6vOFztNZYSQuONVmD/KsqwYvTtC2JcXG72/qY9BUWm
	F/bye9Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPkX-000000090Zo-1iPz;
	Thu, 12 Nov 2026 08:01:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPjp-000000090UH-1jWe
	for kexec@bombadil.infradead.org;
	Thu, 12 Nov 2026 08:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cm7AtxdM5CH1FUBVqHh5yaMh1nV0eZJjc/Ip3saInLw=; b=NB8DUBSNjgFxHyXncVqzp3mDq8
	Bep8qNMh2Xthp+6jkWveq7/mcgyypw/bmfycCoczUI20lvNEve2Qcl0sVhf3pcFPYVXoP31bnpzBj
	YYmsFQaRNEX50h+zYSqlxkhq+JyTBB5Ha8n+yb4ZpdlR2TQnH2DvONHkmfvUHYStUD9uUtczYCEug
	br+gVQGOcwr1f9GxpBD7q3cLPqUfOW+zIiCAO+Cu3f6szwPjoDuEuaQnmUF+Ys0kBFctgXawFay97
	XzUBdac1pA6lt07IJiQx7RbsvADFN6t/yjyDt8npZoPqBb4yi5Q0eoxXdsJ0hSrD67oZxQhMtgjO7
	o0YmBSXA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPjn-00000004nAB-1Aql;
	Thu, 12 Nov 2026 08:00:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2AA9130066A; Thu, 12 Nov 2026 09:00:50 +0100 (CET)
Date: Thu, 12 Nov 2026 09:00:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ben Cressey <ben@cressey.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	llvm@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
	kexec@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] x86/kexec: Type relocate_kernel() to drop __nocfi
Message-ID: <20261112080050.GZ2668804@noisy.programming.kicks-ass.net>
References: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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

I don't understand this; what?


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18667606A327
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JAdBtG1n;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFX0oUvX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kcLQLePRECmW/OukG6ShdGIS6F+D+KlfSzofEC+RGPM=; b=JAdBtG1nukrF0edsYjyemaLfWy
	qnBUvuWTwDmsgR7BrLAGezZH/l498ILLM3BFSo1xdj3tNPGh5/E4uUqBr7AfZoKhuNS/Hj2J8ilJv
	OYeMKQhh7v1Dl82qdbhm7h44V4FofcCAHfDwzA31nhplSuoUNHZUe0ILAeteC308a79Md36z9oCMl
	P8vVQdX5QTUrcifwHgHaHKEN4d7Kddel/85JmP11kb/Fh69XuqFU+cXRQgnpaZEsawbosukRAfjBw
	9eqd+8Qj5rWlE+1+9oNcr9d/2sdh2ta25fy+3vzLkSJIE3MI8lUi7VYP9juUCU8Vql77QWi786CMi
	IeBGcHvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIEf-00000008CaX-2jdZ;
	Thu, 12 Nov 2026 00:00:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIEd-00000008CaN-3joO
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:00:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4860945D20;
	Thu, 12 Nov 2026 00:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789FE1F00A05;
	Thu, 12 Nov 2026 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441611;
	bh=kcLQLePRECmW/OukG6ShdGIS6F+D+KlfSzofEC+RGPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFX0oUvXLH6M1+stGvR8q7GSrkkpuYXh42bB/2n1N00IE83twYwY1D356M8NwNlhL
	 Pm/BtVQLZ4iPjXkJ3AMktrMFZrm9m0WkR9zjsEI6Wg8Hm9KeKdtx7uZVv4hc9REXB0
	 Wc/pH0DcGaj3cXfpwlqhKz1PCkPp1Vc2enTJIdURiEOm+XgKtr7Af22xj2kKuUBSn0
	 CcN6siZxUiqwWCi+gvj9Z93nHQXWjEHPi1ypiPwdWLi2TTfV+h7oOiLWvXvnNvyDmy
	 Ju7PSlR+k6/YMHYFyu0qnwOV1Kjly8Gwhm6s2kHXeulgUqsVzekpM1Gn7FjDuSeoaj
	 oaC96YTT9ydrg==
Message-ID: <sashiko-outbox-209872@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/kexec: Type relocate_kernel() to drop __nocfi
To: "Ben Cressey" <ben@cressey.dev>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, "Sami Tolvanen" <samitolvanen@google.com>, "Kees Cook" <kees@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, "David
 Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
References: <20261111-x86-kexec-kcfi-v1-1-b4d41ea14deb@cressey.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:00:09 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> machine_kexec() calls the control page's copy of relocate_kernel()
> indirectly. The routine has no kCFI type, so all of machine_kexec() is
> exempt since commit 2114796ca041 ("x86/kexec: Mark machine_kexec() with
> __nocfi"), and ANNOTATE_NOCFI_SYM() silences objtool.
>=20
> No other call there loses its check today, but one added later would.
> Review of that mark on arm64 preferred a typed entry, and objected to
> covering a whole function, on x86 too [1].
>=20
> Typing the routine was set aside in 2025 as not worth it [2]: a type
> from the caller cannot catch a prototype that drifts, and
> machine_kexec() seemed unlikely to follow a stray pointer.
>=20
> Type the routine with SYM_TYPED_START(), emit an ENDBR only under
> CONFIG_FINEIBT, whose boot-time rewrite skips a function without one,
> and drop both exemptions, along with kexec as a valid use in annotate.h.
>=20
> The check guards only the pointer, and not reliably under plain FineIBT,
> which checks in the callee with IBT off. A failed check panics or hangs
> with no CFI report, since load_segments() has reset GS.
>=20
> Link: https://lore.kernel.org/202609241804.BB23BF10@keescook # [1]
> Link: https://lore.kernel.org/9c41ab61efc573e3ab5a75b6e4031f81db84a846.ca=
mel@infradead.org # [2]
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-x86-kexec-=
kcfi-v1-1-b4d41ea14deb@cressey.dev?part=3D1



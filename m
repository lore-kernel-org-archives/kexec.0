Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DCAC9831E
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nh3O0D9pRfCwyQ/BjHS9Yn4M6TnCj2AEPaNpep0MKJA=; b=yjSzvXHae6CJrTe/PbT42ezWj+
	pGJCSlUL9DWaFt3bXXEWt1YhR+IG3skVdBYNzY1tGdBUPT/qVhzrtqrY8PY5GSphUbP3nhH8FWBp1
	26RTOT/NvHeFuPk27A8fTg2r1Y8xeAN+BMNIypzgtK8O0Q+W9571rrplQGtdblao64IgUIeign822
	BtLTcjb48oqu9YEBZrLHGvm41bkuus5eP+auh2KS7CLHDKo4ZsaYwFD6mMjRB1SJJvjsws4xEB9ke
	LbROPa5bLEQy3+IKMVwuypDlRfRmbk1wkZ+dzTKcq/SNA3GCcDErpkVbuWkplboP8LQ3qjnSYM10M
	Kh68cwlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9sEe-0000000CJsy-0ZHt;
	Thu, 24 Sep 2026 22:48:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9sEZ-0000000CJsn-1ct3;
	Thu, 24 Sep 2026 22:48:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D0D5F43C80;
	Thu, 24 Sep 2026 22:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6151F00893;
	Thu, 24 Sep 2026 22:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290086;
	bh=nh3O0D9pRfCwyQ/BjHS9Yn4M6TnCj2AEPaNpep0MKJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdOGpzq++UzFdtMn/UBoRs75lMKPOd+yAyleR5pHmEvUSEb+tz22XB+AYUYKzmTz2
	 n1DlbhO+0HkA9+53shLK90yU9MUPKgIsLD1rgnr7BAanOXfVY0cuLyxSy+aVxDhJ2y
	 ApWSW1nV4Bj6KGfs7Bh3IjQGruwEFhbu6v0gAX5g7gjRjownnhn41jqfMD1hw0dtD9
	 ckdd6qU1vbRyy+5WERLa5EXxJ6JLol5nwCUX2vi8lNM36+7YafZyyRJ1jIlC74CuKN
	 01tAhWsvNRIEOSdKBrANGYJUK03AkzdMuzitibDm3gB20uQmnlV95h8+NFmWaYYe7G
	 ENMZSt/it0aqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64: kexec: mark machine_kexec() __nocfi
To: "Nick Desaulniers" <ndesaulniers@google.com>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Bill
 Wendling" <morbo@google.com>, "Ben Cressey" <ben@cressey.dev>, "Mark
 Rutland" <mark.rutland@arm.com>, "Justin Stitt" <justinstitt@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>
Cc: llvm@lists.linux.dev, stable@vger.kernel.org, kexec@lists.infradead.org, "David
 Woodhouse" <dwmw@amazon.co.uk>, linux-arm-kernel@lists.infradead.org, "Sami
 Tolvanen" <samitolvanen@google.com>, linux-kernel@vger.kernel.org, "Kees
 Cook" <kees@kernel.org>
In-Reply-To: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
References: <20260924-arm64-kexec-nocfi-v1-1-bbae2e2eadc8@cressey.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 22:48:05 +0000
Message-Id: <20260924224805.DC6151F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> When the loaded image needs relocation, machine_kexec() makes an
> indirect call into the copy of arm64_relocate_new_kernel in the control
> page:
>=20
> 	kernel_reloc =3D (void *)kimage->arch.kern_reloc;
> 	kernel_reloc(kimage);
>=20
> With CONFIG_CFI=3Dy the kCFI check on this call loads a type hash from
> kern_reloc - 4. arm64_relocate_new_kernel is SYM_CODE_START and carries
> no hash. Its copy also sits at the start of the control page, which is
> all that TTBR0 maps at this point, so the load faults and the kernel
> oopses after "Bye!" instead of entering the new kernel:
>=20
>  Unable to handle kernel paging request at virtual address 00000000544bff=
fc
>  Internal error: Oops: 0000000096000007 [#1]  SMP
> [ ... ]
> ("x86/kexec: Mark machine_kexec() with __nocfi") did on x86.
>=20
> Fixes: efc2d0f20a9d ("arm64: kexec: keep MMU enabled during kexec relocat=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Cressey <ben@cressey.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-arm64-kexe=
c-nocfi-v1-1-bbae2e2eadc8@cressey.dev?part=3D1



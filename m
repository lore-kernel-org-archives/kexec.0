Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858ECE77188
	for <kexec@archiver.kernel.org>; Thu, 26 Dec 2024 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:To:From:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iBy8N9yXm5sqxWY6jIPUsuLOIE0N1V5MH09U+V1qcEI=; b=Y0HUs3tKXRKYS8qRKS/Y+s/fgA
	i5W99jA4l0flcW6kkNLBp2ThOI3wW08dw1hosceO794k85jQKHCcHoTPh2tlR2+dKs+EqHBZjUSpw
	gUcLpiI0dnpHlKidlYAy3jc5P6tYyVGb5izCZ8Sn/R3TbajU/ZduxSkkcok4j/WWt9Td7G3u1eg72
	P8YncSgZJXn3XcEuIsK1pGEIWgOEzkAjy/QCiefaNtOdZK4+wQ31f/n3oya39T3ZAMI5kH/xQRoPg
	j4/D8Tu3KR5epDuB1KaM0kRFJNnrAiLFJvm4K3gTLBO/Nf/+drf+69EoFxmmE4DyH+uGhOAeTXVMj
	a6zBibQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQjNx-0000000FTsw-0mC7;
	Thu, 26 Dec 2024 08:38:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQjNv-0000000FTsi-2JfY
	for kexec@bombadil.infradead.org;
	Thu, 26 Dec 2024 08:38:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=iBy8N9yXm5sqxWY6jIPUsuLOIE0N1V5MH09U+V1qcEI=; b=Jn4QD23IRVnZB+9lBttBnLtGRQ
	pFFLsZnHPivQm8aw0jlDS6J9PkQA0olZq+LVrecsL8/9pDMS1Wni5YCLerNck2OaH1S/ghn2YnYqA
	pv+XMrbl09WQGrat+ALoENa+2VTnvpZjYu5284SOUr5q7QayJOixnmBoX6nvKEfj2mOPcgygA+MAO
	5bi6l0a+M13qAT/Hw32qBGe36zgkAGmkLkVqhLI/vFMFEnlJRvJ5MRkG2ByBPQoXB+7yEPyYZHN6W
	U6AXD3+CMHvgU1nzVA1IKQj8zdfvznqqUM6tuhNU2X79CLeZ+d2DKurwvGxzJBgBSXUYPdY35Xkfz
	brOC5t/A==;
Received: from [2001:8b0:10b:5:6f8f:ec3c:afd9:64dd] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tQjNo-00000006toc-3G6b;
	Thu, 26 Dec 2024 08:38:17 +0000
Date: Thu, 26 Dec 2024 08:38:17 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 bsz@amazon.de, nathan@kernel.org
Subject: Re: [PATCH 0/9] x86/kexec: Fixes for tip/x86/boot
User-Agent: K-9 Mail for Android
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
Message-ID: <152ECA1E-45CF-437D-8BA5-E3D85CD16FA6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 16 December 2024 23:24:07 GMT, David Woodhouse <dwmw2@infradead=2Eorg> w=
rote:
>Fix a few bugs introduced by the recent rework of the relocate_kernel()
>code, and one which has been there in the kjump code from the beginning=
=2E
>
> =E2=80=A2 Global read-only TLB entries made relocate_kernel() crash when=
 writing
>   to its own page after the %cr3 switch should have made it writeable=2E
> =E2=80=A2 The preserve_context flag was lost when invoking swap_pages on=
 the way
>   back, causing pages not to be swapped=2E
> =E2=80=A2 The wrong page was being used as the swap page=2E
> =E2=80=A2 The ABI for the kjump call asks the callee to put its entry ad=
dress for
>   next time at %rsp+8 before returning, but we set %rsp to the top of th=
e
>   available page, such that the entry address is at the start of some
>   other page=2E
> =E2=80=A2 The relocate_kernel() function lacked Clang CFI information, b=
ut is now
>   called via a function pointer, leading to a crash=C2=B9=2E
> =E2=80=A2 The relocate_kernel() code and data could end up being linked =
into the
>   wrong place for a LTO / -ffunction-sections build=2E
>
>Thanks to Nathan for reporting many of the above=2E
>
>Also a few minor cleanups, including a comments-only patch from Rafael=20
>on the suspend-like part of kjump as a prelude to actually cleaning that=
=20
>up=2E
>
>=C2=B9 Fixed by just adding __nocfi=2E Actually providing the CFI informa=
tion=20
>for relocate_kernel() will need a bit more work, so let's just do the=20
>simple fix for now=2E
>
>David Woodhouse (7):
>      x86/kexec: Disable global pages before writing to control page
>      x86/kexec: Ensure preserve_context flag is set on return to kernel
>      x86/kexec: Use correct swap page in swap_pages function
>      x86/kexec: Fix stack and handling of re-entry point for ::preserve_=
context
>      x86/kexec: Mark machine_kexec() with __nocfi
>      x86/kexec: Cope with relocate_kernel() not being at the start of th=
e page
>      x86/kexec: Use typedef for relocate_kernel_fn function prototype
>
>Nathan Chancellor (1):
>      x86/kexec: Fix location of relocate_kernel with -ffunction-sections
>
>Rafael J=2E Wysocki (1):
>      kexec_core: Add and update comments regarding the KEXEC_JUMP flow
>
> arch/x86/include/asm/kexec=2Eh         | 26 ++++++++--------
> arch/x86/kernel/machine_kexec_32=2Ec   |  7 +----
> arch/x86/kernel/machine_kexec_64=2Ec   |  8 ++---
> arch/x86/kernel/relocate_kernel_64=2ES | 57 ++++++++++++++++++++++++----=
--------
> arch/x86/kernel/vmlinux=2Elds=2ES        |  4 +--
> kernel/kexec_core=2Ec                  | 23 +++++++++++----
> 6 files changed, 74 insertions(+), 51 deletions(-)
>
>

Ping? I made sure I got this series out quickly as it deals with regressio=
ns in tip/x86/boot=2E Aside from potentially being able to save a byte on o=
ne instruction, I think the rest of the discussion has been resolved withou=
t changing the patches=2E

I'll resend the follow-on parts which add the debugging support when I'm b=
ack at a real keyboard=2E


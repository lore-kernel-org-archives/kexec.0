Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB97BE7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=viJ3SXPD1LnkwtHDPOYKSYf5CUuSn3gFa8laD6bjXwo=; b=zllVWMDrbxvT+7ggOgLc+qv/ng
	TUxa3UfZrJb4Hr3Kgbdq0Enka/uMHxCsjFPtjdm1LfnKep985DfibmjNQ8PsjjF0bYCRpXeeXjx00
	d9AVvIAIDPAK/iJSAIIF8Fi8UyANK0oxqTtSRlSO41/Xudavux4Fm/KAF00L/+IgJoJH879iNbLIr
	su2+/DrgHZ/SFXXg2uHbKhCafzg+PvaW5TRjhylwAk5d5yzg/+KrfniYJwMrAGvH7WawfR3EeRvlC
	T8vRgUZIJ17S2oZ+i0mkySDJte1oRsCMhJA57ZSirV+8KuXjecA6v4LZzXoAT0aWjegdcTutV2nPV
	HxW/sC0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUQf-0000000D2YP-11fD;
	Tue, 17 Dec 2024 10:03:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNU6G-0000000Cy59-0uXw
	for kexec@bombadil.infradead.org;
	Tue, 17 Dec 2024 09:42:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=viJ3SXPD1LnkwtHDPOYKSYf5CUuSn3gFa8laD6bjXwo=; b=Ao5xUT3xNCPmARMm88nQpzByti
	uogIaRvr0YNYVXLA0aYt27bLQOwbhstDTMM3kNbSpARtQp0+7PNjVG3KQAUnJzu02yYdFCQrmf0Iu
	w0jQOZYaS4KEwQvJHeNCDbC80IFVGFSJDBXjla95/+hql+Q8sNeqK0orfTFJbJ1brwMEs7tuH1te+
	8l8YnldAWAsGyLLyKY8eVb+Rwo25QRMvexQ5X7pJlBgtfNNFW92B2bYyZXfC6RN3AsRb5uEJFQ+hX
	Cm5ZYnOp1YEXlUfKzC6cwAricivYHLS34dXuYAZ6vCv3+vfPBsXRb8wOHQtHIfI9197RQ5kIYlMEc
	fudb6GUg==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNU6D-000000053VD-0SCm;
	Tue, 17 Dec 2024 09:42:41 +0000
Date: Tue, 17 Dec 2024 10:42:41 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>,
 Rong Xu <xur@google.com>,
 =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_9/9=5D_x86/kexec=3A_Use_typedef_f?=
 =?US-ASCII?Q?or_relocate=5Fkernel=5Ffn_function_prototype?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org> <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com> <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org> <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
Message-ID: <27388506-9BE8-4540-A444-166C49133295@infradead.org>
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

On 17 December 2024 10:29:21 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Tue, 17 Dec 2024 at 10:21, David Woodhouse <dwmw2@infradead=2Eorg> wro=
te:
>>
>> On 17 December 2024 09:49:04 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wr=
ote:
>> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead=2Eorg> =
wrote:
>> >>
>> >> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> >>
>> >> Both i386 and x86_64 now copy the relocate_kernel function into the =
control
>> >> page and execute it from there, using an open-coded function pointer=
=2E
>> >>
>> >> Use a typedef for it instead=2E
>> >>
>> >> Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> >> ---
>> >>  arch/x86/include/asm/kexec=2Eh       | 26 +++++++++++++------------=
-
>> >>  arch/x86/kernel/machine_kexec_32=2Ec |  7 +------
>> >>  arch/x86/kernel/machine_kexec_64=2Ec |  6 +-----
>> >>  3 files changed, 15 insertions(+), 24 deletions(-)
>> >>
>> >> diff --git a/arch/x86/include/asm/kexec=2Eh b/arch/x86/include/asm/k=
exec=2Eh
>> >> index 48e4f44f794f=2E=2E8ad187462b68 100644
>> >> --- a/arch/x86/include/asm/kexec=2Eh
>> >> +++ b/arch/x86/include/asm/kexec=2Eh
>> >> @@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_=
regs *newregs,
>> >>  }
>> >>
>> >>  #ifdef CONFIG_X86_32
>> >> -asmlinkage unsigned long
>> >> -relocate_kernel(unsigned long indirection_page,
>> >> -               unsigned long control_page,
>> >> -               unsigned long start_address,
>> >> -               unsigned int has_pae,
>> >> -               unsigned int preserve_context);
>> >> +typedef asmlinkage unsigned long
>> >> +relocate_kernel_fn(unsigned long indirection_page,
>> >> +                  unsigned long control_page,
>> >> +                  unsigned long start_address,
>> >> +                  unsigned int has_pae,
>> >> +                  unsigned int preserve_context);
>> >
>> >linkage is not part of the type=2E 'asmlinkage' is #define'd to the
>> >empty string today, so it doesn't matter, but better to omit it here=
=2E
>>
>> This is the i386 version=2E I thought ut was something like regparm(3) =
there?
>>
>> And=2E=2E=2E WTF? How is the calling convention not part of the fundame=
ntal type of the function? If I have a pointer to such a function, using th=
is typedef to ensure we all share the same prototype, are you telling me al=
l the users of the typedef have to remember to tag that part on for themsel=
ves?
>
>No=2E I am talking about linkage not the calling convention=2E

Hm, I am perfectly happy to believe that my memory is failing me, especial=
ly when it comes to specifics of i386 assembler code=2E But are you also te=
lling me that=20
<https://kernelnewbies=2Eorg/FAQ/asmlinkage> is a lie?



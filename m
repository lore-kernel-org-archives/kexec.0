Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BA1E7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 09:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4Kq1ApCTlotm3kGOsN5CuO5LU5x9azOwncXT/pe8tY=; b=do//EsHlimo2M9vmd6KrOwyi7F
	uTDzpG3vs7DB+b1laKGFDofWamfhLKWbZRePuOp3CI3w2WD9E2srxxy+QWRU9LpTCNcZPfw2rMLe6
	zWjGVBCjESeOd342oXd3mfZwbDV6+Alu9liTLkLE+/O28NR6Aa+zs/eWBfyM1wG+skJCm+lyPyQhJ
	ZjcT/1qDMsUlLNq/GGv5/mW+wGCTxC2TdMJdrAF21aBcu+9cvdJV6Geiy/+f4ue+Dxsr9TPiwVyMA
	v7MEK3oiHzjOwMvoF1vyiNHwrCJ/7lSPHku9vIkzsQMiszeeS30M9BdFbSFjuIqOn60WjIiCGMOS9
	l6VTiMiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNULN-0000000D1d6-1heF;
	Tue, 17 Dec 2024 09:58:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTzt-0000000Cwqr-3oui
	for kexec@bombadil.infradead.org;
	Tue, 17 Dec 2024 09:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=x4Kq1ApCTlotm3kGOsN5CuO5LU5x9azOwncXT/pe8tY=; b=DjhXm7HRsnmyAQ13PT8NE0U5hC
	5NeyC1gq0vPhkhGp//zZmyr/3s5zc3sIEj6nZlf/wmJQs54ukBUu0IOMi2kAmAFEjRbgPK6IdHP8u
	jBEAfvERHncEye0MG5Wtdx9To8HAgqer5pyJNJ8vCSdpqOITxYFP4Ja9LWtOJim1qTRJam00jzjqJ
	ccEP9T/IbHn9a9F6rKcIe/MocE0bJS53d8VL0ZZt+W22Gphe0XRx2plwGCUx2YPnN1WNVyb6ogDEt
	6pri9GfL52N0KngLGZYOGGGj6J0qauIyiYZCsdL7PNn95RMZ6s+sur8LlbDOI4mNgijv4sN18LYaH
	6T1YyMzw==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTzp-000000053Ry-46wr;
	Tue, 17 Dec 2024 09:36:06 +0000
Date: Tue, 17 Dec 2024 10:36:05 +0100
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_8/9=5D_x86/kexec=3A_Cope_with_relocat?=
 =?US-ASCII?Q?e=5Fkernel=28=29_not_being_at_the_start_of_the_page?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org> <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com> <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org> <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
Message-ID: <FF6D6B84-58BC-4768-A112-C5B9A684F1A5@infradead.org>
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

On 17 December 2024 10:25:56 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Tue, 17 Dec 2024 at 10:17, David Woodhouse <dwmw2@infradead=2Eorg> wro=
te:
>>
>> On 17 December 2024 09:47:36 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wr=
ote:
>> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead=2Eorg> =
wrote:
>> >>
>> >> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> >>
>> >> A few places in the kexec control code page make the assumption that=
 the
>> >> first instruction of relocate_kernel is at the very start of the pag=
e=2E
>> >>
>> >> To allow for Clang CFI information to be added to relocate_kernel(),=
 as
>> >> well as the general principle of removing unwarranted assumptions, f=
ix
>> >> them to use the external __relocate_kernel_start symbol that the lin=
ker
>> >> adds=2E This means using a separate addq and subq for calculating of=
fsets,
>> >> as the assembler can no longer calculate the delta directly for itse=
lf
>> >> and relocations aren't that versatile=2E
>> >>
>> >
>> >You can still avoid the absolute relocations though, =2E=2E=2E
>> =2E=2E=2E
>> >> +       addq    $identity_mapped, %rsi
>> >> +       subq    $__relocate_kernel_start, %rsi
>> >
>> >=2E=2E=2E if you turn this into
>> >
>> >0:     addq    $identity_mapped - 0b, %rsi
>> >       subq    $__relocate_kernel_start - 0b, %rsi
>>
>> Is there any benefit to doing so? Are absolute relocations problematic?
>
>Every absolute relocation produces an entry in the relocation table
>that needs to be applied at every boot when KASLR is in effect=2E Beyond
>that, it doesn't matter=2E
>
>I've looked into PIC codegen/PIE linking for the core kernel, which is
>why this caught my eye=2E If that effort ever advances, I'll need to
>revisit this code as well and apply the change I suggested=2E

Ack, I'll roll it in to the next revision if Ingo hasn't rounded this set =
up of fixes up already=2E (On which topic, since I took the easy way out of=
 the CFO thing, this patch isn't strictly needed to fix a regression in tip=
/x86/boot so can be dropped for now too=2E)

Thanks=2E



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3E4E7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dnOfrSXu0JD2nOetxwQoi6738KkFF17+szDt2emi6Bs=; b=dHURUr4Hv8n5POHta6Ka1S2ZYM
	0acacHgppIqdToOf1wYf29bkM2OgTvfNt5psEEDLPDYfPKEGYPPTlfMhEPuzUiWlGolcmCXYZewQJ
	JZp574iy1XPKYSCXA3tpFznDoN7a0axAd5Pz54dKrHWte4fRDm10vuX2hXMKpKxvzSN7OmfvDVN5v
	6nyxFwui37BpjtAOVTSVNA16TxeSZjmcah8yj+1NGP8pwoBabXruBgXgrwsheX80pav2pwBb1rjmU
	ZGGBIHHJcXCGivTYwWepF4Hg73ypbSuRDbD+iKjZ3Kh/h+J+pyCzFa7aRB6zFfJZDw8tjM9NUXNTN
	Ul3x3yEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUCu-0000000Czbl-2BrI;
	Tue, 17 Dec 2024 09:49:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTiE-0000000CsLJ-1zeS
	for kexec@bombadil.infradead.org;
	Tue, 17 Dec 2024 09:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dnOfrSXu0JD2nOetxwQoi6738KkFF17+szDt2emi6Bs=; b=B0PU3uDOutnr9aTA+vMh+yV+od
	Yt+eIzPugNj3vQGTAhbFuGZA2V/MPqlphrne1wVoZO6macsebeshtHbUoqObnKmB3RTsM8AY1kctC
	D9MMqg6fgsNkEACVPwRlfeZTE7jahAeBstnJNng0zeH7h8w21JE6FVLZZHCKfuXHxGfp3ZA3Gg0U8
	72ShrQxK2Ucob0ZySWqRHTATuqpMI1xJYgUaqaq+9oSrfaec6DMSbrr1+95MahVlDVX8regl7mZ8M
	UpDrxx4lFoLgG2aQz+Xa1ENBhJa6ECmW+EJ0VI9C7p4XOdXFoeu8+8HZkXgt6FRcXkH1jEH8oPWDW
	a0smCcSQ==;
Received: from [89.27.170.32] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTi7-0000000538i-2qU4;
	Tue, 17 Dec 2024 09:17:48 +0000
Date: Tue, 17 Dec 2024 10:17:47 +0100
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
In-Reply-To: <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org> <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
Message-ID: <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org>
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

On 17 December 2024 09:47:36 CET, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead=2Eorg> wro=
te:
>>
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>
>> A few places in the kexec control code page make the assumption that th=
e
>> first instruction of relocate_kernel is at the very start of the page=
=2E
>>
>> To allow for Clang CFI information to be added to relocate_kernel(), as
>> well as the general principle of removing unwarranted assumptions, fix
>> them to use the external __relocate_kernel_start symbol that the linker
>> adds=2E This means using a separate addq and subq for calculating offse=
ts,
>> as the assembler can no longer calculate the delta directly for itself
>> and relocations aren't that versatile=2E
>>
>
>You can still avoid the absolute relocations though, =2E=2E=2E
=2E=2E=2E
>> +       addq    $identity_mapped, %rsi
>> +       subq    $__relocate_kernel_start, %rsi
>
>=2E=2E=2E if you turn this into
>
>0:     addq    $identity_mapped - 0b, %rsi
>       subq    $__relocate_kernel_start - 0b, %rsi

Is there any benefit to doing so? Are absolute relocations problematic?


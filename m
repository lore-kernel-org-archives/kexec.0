Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50799C021B2
	for <kexec@archiver.kernel.org>; Sun, 23 Feb 2025 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WgMF9vswv8p5CFXANTrRWBxbIQfBtJPu0XjamfklNUs=; b=fud8IpbPbu1agXARmRALlk67yv
	2wlhdBwCzBd3TPkFuKyg85bPSDflTrnL7t/wetxTzFFJuxxrPpJavsG9mjpX0RpDldo4TOwhXzDiZ
	45b1XcNL+F2OUxCru3ZTPijHfYxtB8n054FYtBu6VdPyIdtRSXwtrSxN3IwlmnS0Bvy30ccs8ngc1
	yVBIpC+FB/23ME7DaXyDDthl+f0QgnXfd78eeYWpSQlvcJGJLsADD1rKVaM85407/my36ou1WNvVr
	LbsgUeaedNfG5HsvPaN9KGiH/+B7pr/avanly0/Mw0bfJgKOxC11id7GOVwsgRSTXtuwIv4grEYpU
	3V1WxnSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tm9bu-0000000Au1o-0f7e;
	Sun, 23 Feb 2025 10:53:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tm9bt-0000000Au1b-12y2
	for kexec@bombadil.infradead.org;
	Sun, 23 Feb 2025 10:53:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WgMF9vswv8p5CFXANTrRWBxbIQfBtJPu0XjamfklNUs=; b=DV9mKRv5Se2cXBOZNCGq+ewZ98
	evVs7kGrm30iMBt3dRDimYsnU0/QHuTXjgtmXbwX1hTwT6A6YpAeGDceCrPL1UNH+5MGH580eJTIR
	dvGDcjoaZ6rxsZnTAJSYAr8QL07LfpWu3IosdKct2caF0moW6JeRt50y5YLAmthKNffqOhhPxKOq5
	OhU8ZbIOw7njmmQ4/yBiEmTZXhSDOFtJ98v6BafRnLFIh5m0ZQiSCVT4hYoRYsi2hZeSzas6NDgZs
	OjpD4NHitKSSMMWD/gG6Q2zIyf9kWL/KasL1Fp7UHfP5+VhWz5ELB2Us5CID/Ni6RP9daSBW1/lnF
	X6cWFGvg==;
Received: from [2a00:23ee:10f8:4733:9bf1:8420:b19d:105e] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tm9bo-000000030Fj-0oJm;
	Sun, 23 Feb 2025 10:53:17 +0000
Date: Sun, 23 Feb 2025 10:53:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
CC: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: Re: [PATCH v6 2/7] x86/kexec: Debugging support: load a GDT
User-Agent: K-9 Mail for Android
In-Reply-To: <Z7rwA-qVauX7lY8G@gmail.com>
References: <20250115191423.587774-1-dwmw2@infradead.org> <20250115191423.587774-3-dwmw2@infradead.org> <Z7rwA-qVauX7lY8G@gmail.com>
Message-ID: <738CB14B-6494-4049-86C9-9A7EBBD08A74@infradead.org>
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

On 23 February 2025 09:53:07 GMT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* David Woodhouse <dwmw2@infradead=2Eorg> wrote:
>
>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> There are some failure modes which lead to triple-faults in the
>> relocate_kernel function, which is fairly much undebuggable for normal
>> mortals=2E
>>=20
>> Adding a GDT in the relocate_kernel environment is step 1 towards being
>> able to catch faults and do something more useful=2E
>>=20
>> Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> ---
>>  arch/x86/kernel/relocate_kernel_64=2ES | 27 ++++++++++++++++++++++++++=
+
>>  1 file changed, 27 insertions(+)
>>=20
>> diff --git a/arch/x86/kernel/relocate_kernel_64=2ES b/arch/x86/kernel/r=
elocate_kernel_64=2ES
>> index af2cd06ff318=2E=2Ec62f03808f18 100644
>> --- a/arch/x86/kernel/relocate_kernel_64=2ES
>> +++ b/arch/x86/kernel/relocate_kernel_64=2ES
>> @@ -39,6 +39,18 @@ SYM_DATA(kexec_pa_table_page, =2Equad 0)
>>  SYM_DATA(kexec_pa_swap_page, =2Equad 0)
>>  SYM_DATA_LOCAL(pa_backup_pages_map, =2Equad 0)
>> =20
>> +#ifdef CONFIG_KEXEC_DEBUG
>> +	=2Ebalign 16
>> +SYM_DATA_START_LOCAL(kexec_debug_gdt)
>> +	=2Eword   kexec_debug_gdt_end - kexec_debug_gdt - 1
>> +	=2Elong   0
>> +	=2Eword   0
>> +	=2Equad   0x00cf9a000000ffff      /* __KERNEL32_CS */
>> +	=2Equad   0x00af9a000000ffff      /* __KERNEL_CS */
>> +	=2Equad   0x00cf92000000ffff      /* __KERNEL_DS */
>> +SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
>> +#endif /* CONFIG_KEXEC_DEBUG */
>
>Yeah, so is there any reason (other than paranoia) why the early-early=20
>GDT and IDT shouldn't be unconditional? There's many ways for such an=20
>approach to bitrot, it's much better to not hide it behind a=20
>default-disabled debug option=2E=2E=2E
>
>Some of the other bits, like the hard-coded serial debugging=20
>assumptions, probably need to be behind the debug option - but much of=20
>the new debug mechanism looks safe and generic and can be always-on,=20
>IMHO=2E
>
>This would also throw regressions back into the face of whoever manages=
=20
>to introduce them, ideally=2E ;-)
>
>Thanks,
>
>	Ingo

Makes sense to me=2E I was just trying to be as unobtrusive as possible=2E=
 In a test branch where I was trying to fix up the objtool vs=2E CFI pain, =
I did move the IDT/GDT setup entirely into the ASM code and remove the C co=
de which clears them (before the call into relocate_kernel() which might no=
w trap if we remove the __nocfi hack)=2E I never did get objtool to tolerat=
e both clang and GCC builds though=2E

I think even the serial output (tied as it is to earlyprintk setup) could =
reasonably be enabled by default too=2E


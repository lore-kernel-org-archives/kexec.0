Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0D4CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Message-Id:From:
	Content-Type:In-Reply-To:Mime-Version:Cc:Content-Transfer-Encoding:References
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S79WpFHXVfHNWtRhH5pmDfAnNvJ6NVAb5F8a0GQO6Qk=; b=f3OP04CFMEDcmTynwTCTymAsoT
	dUNm3VYCzwEWwsIVhhw8ED59TisiAm4m7xgF4mmmGd9PYaUn1X+3qmnGzANE8zS5rRSECw+rKX+vA
	Y0MPSqyLmVDvIvvpI+4o2uQB9XwvA2r7cNmZN9gTyhikOPuQHnqL0XCoSv6etoq51NPFcN91/qv0U
	J/24OH4aHunciPfPLm/66o+P+hrNdrVK/s9plds9z4iDqBFYLKQkE3Ab0KeX+O4DR1ZI7N9Qhk82S
	x07vtb1WwuE/8mZHY/NtxUP+wsQMBrLadvlVUoPM1GfvPWlGWlHADDubweR9q05rLBrGl48AkKD5k
	VNim8G6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNmMG-00000007Xfh-00wp;
	Fri, 15 May 2026 06:49:16 +0000
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNmMD-00000007Xe8-1NuI
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 06:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1778827744; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=S79WpFHXVfHNWtRhH5pmDfAnNvJ6NVAb5F8a0GQO6Qk=;
 b=BSF6Javdur5pVt+H1Nf/nQjdT+9JIf68UqbPGEtWxHNQnmkBsLRMJMuhpHMD+IEVoMSk6A
 n17oFZn+7AJx9qRLxHfN9ZVNhA0EI3NAqUjNQYTXqAe1APKlYKR4YMlDotEn02AwnsUVj9
 6lVNCxj76l5Jzqk9t+nLtCeBWLyMLe5CKg9PFEmcGzuKi+AHeEYSWHLEKat70TZsjJ1h6O
 LaWJBx/QQEgnoGBwX3whb0PjRiCuQfyo+vi1WjJlPh1TfA/34zTPEiv2C4vbk/3Vtp1RkS
 XQ29+1GpscmHcAqu3i0UQOHkQlITnpGWhyAVQjh56IEnnU/j/WZM6wQ0kV7/tw==
Date: Fri, 15 May 2026 14:48:51 +0800
References: <20260506115758.2497610-1-qirui.001@bytedance.com> <20260506115758.2497610-3-qirui.001@bytedance.com> <58d40519-caa4-4ea8-8162-bb213545d6dc@nec.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Cc: "Shuan He" <heshuan@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <58d40519-caa4-4ea8-8162-bb213545d6dc@nec.com>
Content-Type: text/plain; charset=UTF-8
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <81a77194-14cc-4b7d-9d58-58b52fc411da@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
To: =?utf-8?b?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH][makedumpfile] 2/2 riscv64: Fix huge page translation in vtop_riscv64()
X-Lms-Return-Path: <lba+26a06c1de+51e224+lists.infradead.org+qirui.001@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_234913_437547_F7B3A2DE 
X-CRM114-Status: GOOD (  13.96  )
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

On 5/14/26 10:26 AM, HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE =E4=B8=80=E4=BB=81) =
wrote:
> On 2026/05/06 20:57, Rui Qi wrote:
>> When a page table entry has _PAGE_LEAF set at PGD/P4D/PUD/PMD level,
>> the current code incorrectly falls through to the next level instead
>> of computing the correct physical address. Fix this by calculating
>> the paddr with the proper level shift and returning directly.
>>
>> Co-developed-by: Rui Qi <qirui.001@bytedance.com>
>> Signed-off-by: Shuan He <heshuan@bytedance.com>
>> ---
>>   arch/riscv64.c | 26 ++++++++++++++++++--------
>>   1 file changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv64.c b/arch/riscv64.c
>> index 28365fa0cc5b..67755331de24 100644
>> --- a/arch/riscv64.c
>> +++ b/arch/riscv64.c
>> @@ -107,8 +107,12 @@ vtop_riscv64(pgd_t * pgd, unsigned long vaddr, long=
 va_bits)
>>  =20
>>   	pt_phys =3D (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
>>  =20
>> -	if (pt_val & _PAGE_LEAF)
>> -		goto out;
>=20
> the following warning is observed:
>=20
> cc  -g -O2 -Wall -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -D_LARGEFIL=
E64_SOURCE -D__riscv64__ -U__x86_64__ -c -o ./arch/riscv64.o arch/riscv64.c
> arch/riscv64.c: In function 'vtop_riscv64':
> arch/riscv64.c:203:1: warning: label 'out' defined but not used [-Wunused=
-label]
>   out:
>   ^~~

Good catch. The out: label is now unused since we replaced all goto out
with goto invalid. We will remove it in v2.

>=20
>> +	if (pt_val & _PAGE_LEAF) {
>> +		unsigned long shift =3D (va_bits =3D=3D VA_BITS_SV57) ? PGD_SHIFT_L5 =
:
>> +				      (va_bits =3D=3D VA_BITS_SV48) ? PGD_SHIFT_L4 : PGD_SHIFT_L3;
>> +		paddr =3D (pt_phys & ~((1ULL << shift) - 1)) + (vaddr & ((1ULL << shi=
ft) - 1));
>> +		goto invalid;
>=20
> just a style point, if this path is not invalid, please do no use the 'in=
valid'
> label and better to return here instead.
>=20

Agreed, using goto invalid for a valid huge page translation path is
indeed misleading. We will replace it with a direct return paddr in v2.

Will send v2 shortly with both issues addressed.
Thanks,
Rui Qi

> Thanks,
> Kazu
>=20
>> +	}
>>  =20
>>   	if (va_bits =3D=3D VA_BITS_SV57)
>>   		goto p4d;
>> @@ -133,8 +137,10 @@ p4d:
>>  =20
>>   	pt_phys =3D (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
>>  =20
>> -	if (pt_val & _PAGE_LEAF)
>> -		goto out;
>> +	if (pt_val & _PAGE_LEAF) {
>> +		paddr =3D (pt_phys & ~((1ULL << P4D_SHIFT) - 1)) + (vaddr & ((1ULL <<=
 P4D_SHIFT) - 1));
>> +		goto invalid;
>> +	}
>>   pud:
>>   	/* PUD */
>>   	puda =3D (pud_t *)(pt_phys) + pud_index(vaddr);
>> @@ -152,8 +158,10 @@ pud:
>>  =20
>>   	pt_phys =3D (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
>>  =20
>> -	if(pt_val & _PAGE_LEAF)
>> -		goto out;
>> +	if (pt_val & _PAGE_LEAF) {
>> +		paddr =3D (pt_phys & ~((1ULL << PUD_SHIFT) - 1)) + (vaddr & ((1ULL <<=
 PUD_SHIFT) - 1));
>> +		goto invalid;
>> +	}
>>   pmd:
>>   	/* PMD */
>>   	pmda =3D (pmd_t *)(pt_phys) + pmd_index(vaddr);
>> @@ -171,8 +179,10 @@ pmd:
>>  =20
>>   	pt_phys =3D (pt_val >> _PAGE_PFN_SHIFT) << PAGESHIFT();
>>  =20
>> -	if (pt_val & _PAGE_LEAF)
>> -		goto out;
>> +	if (pt_val & _PAGE_LEAF) {
>> +		paddr =3D (pt_phys & ~((1ULL << PMD_SHIFT) - 1)) + (vaddr & ((1ULL <<=
 PMD_SHIFT) - 1));
>> +		goto invalid;
>> +	}
>>  =20
>>   	/* PTE */
>>   	ptea =3D (pte_t *)(pt_phys) + pte_index(vaddr);


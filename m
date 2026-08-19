Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87A4C5DF85
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J7SSYr9IcCYlpEA9on/0aKPIvhje3Akfn6JxapVuH8c=; b=KLi8a49Se/JzOn09ElnycruY1d
	+W9KbzuEx9S0bwtbsWojtGf9Hx9+Ad7v68PwS+a/rO6pqh+hOA6hdpc3IpRsaV/Xp2zd+B302rgJU
	+4npq8NTxxrlhyncHw9BYlSHmEFlWkXMRO3HofCy64LHbY/9fmt4lj/lByl2GN9Pfd7L0q5CmXFYY
	UMWeqc1wdK6WarQ23kuG6nua2wYlF5UOVOQEpKjp8AMYyIHqwYuWmWDRrqARYpyL7c+TkLsyHiPfQ
	MYOj87zZTLv5PaCC4g4kaxNYferiYFdRgNrIZB2VlfOWgB7FkyPTAzLaRl76kBew0lVPj4/U910gU
	h7g7t0Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcK5-00000009O0U-3cPx;
	Wed, 19 Aug 2026 09:11:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcK1-00000009O0D-0K9F;
	Wed, 19 Aug 2026 09:10:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B23A434CA;
	Wed, 19 Aug 2026 09:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515771F000E9;
	Wed, 19 Aug 2026 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130655;
	bh=J7SSYr9IcCYlpEA9on/0aKPIvhje3Akfn6JxapVuH8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jm+Wv4aOzeOFTNGkTPTh1XF0zLQEggF3fxwAzmzCyumgDLdn0f12E8o3GI6dpHpkx
	 ETq719cOrx8P/ruQ1OJxqoaV19IPggFEEVmEBqif88yyb5XrXMNEfPHKjO7dmA0zCS
	 XaFElWeGHWsTS30cQNtt/qevs6nQq/+keyts6TX3TXgRXhfvB1K4d3ql/t8lPKcszG
	 IdyqmlqIkRCGbPEzYxe8te0Su4J+GenFyDoXocfpKndU9TV/tVXa/Ltjh18TONIhIP
	 7RHGNtpbny9da2Ar64FJ4mMWrHdQLxuAtcmC0/40KEVCTsjb1sNCzLYzFb8a/cj9DV
	 YxESBVfYEonbA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mukesh Pilaniya <mpilaniy@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Catalin Marinas
 <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Huacai Chen <chenhuacai@kernel.org>,  WANG Xuerui
 <kernel@xen0n.name>,  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti
 <alex@ghiti.fr>,  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He
 <baoquan.he@linux.dev>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Tao Liu <ltao@redhat.com>,  Philipp Rudo
 <prudo@redhat.com>,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  loongarch@lists.linux.dev,
  linux-riscv@lists.infradead.org,  kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: return -ENOEXEC from image probe functions on
 mismatch
In-Reply-To: <0d7acb43-2eb4-44ec-9bfb-b89440afc605@redhat.com> (Mukesh
	Pilaniya's message of "Wed, 19 Aug 2026 11:28:10 +0530")
References: <20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com>
	<2vxzv79c23j6.fsf@kernel.org>
	<9cbe111c-ff63-4f24-b518-094ddd7cea30@redhat.com>
	<2vxzbjaz2269.fsf@kernel.org>
	<0d7acb43-2eb4-44ec-9bfb-b89440afc605@redhat.com>
Date: Wed, 19 Aug 2026 11:10:50 +0200
Message-ID: <2vxzqzjuzd9h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 19 2026, Mukesh Pilaniya wrote:

> Hi Pratyush,
>
> On 18/08/26 3:14 pm, Pratyush Yadav wrote:
>> On Fri, Aug 14 2026, Mukesh Pilaniya wrote:
[...]
>>=20
>> So how about the below diff instead? (** only compile tested **)
>>=20
>> --- 8< ---
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 2bfbb2d144e6..cfb2b8cd5679 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -67,17 +67,16 @@ int kexec_image_probe_default(struct kimage *image, =
void *buf,
>>  			      unsigned long buf_len)
>>  {
>>  	const struct kexec_file_ops * const *fops;
>> -	int ret =3D -ENOEXEC;
>>=20=20
>>  	for (fops =3D &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops)=
 {
>> -		ret =3D (*fops)->probe(buf, buf_len);
>> -		if (!ret) {
>> +		if (!(*fops)->probe(buf, buf_len)) {
>>  			image->fops =3D *fops;
>> -			return ret;
>> +			return 0;
>>  		}
>>  	}
>>=20=20
>> -	return ret;
>> +	/* No loader found. */
>> +	return -ENOEXEC;
>>  }
> Nice catch, Pratyush but this discards all non-zero return values from
> probe functions, which means real errors get swallowed. For example,
> kexec_elf_probe() can return -ENOMEM when kzalloc() fails in
> elf_read_phdrs(). With this diff, that -ENOMEM becomes -ENOEXEC, which
> tells userspace "no loader found" when the actual problem was a memory
> allocation failure.

Right, good point.

>
>>=20=20
>>  static void *kexec_image_load_default(struct kimage *image)
>>=20
> How about the following instead? It keeps the probe return value and
> distinguishes -ENOEXEC (format not recognized, try next loader) from any
> other error (real failure, propagate immediately):
> =EF=BB=BF
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 59fb9d71e9d8..ceb5c97cedac 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -68,17 +68,19 @@ int kexec_image_probe_default(struct kimage *image,
> void *buf,
>  			      unsigned long buf_len)
>  {
>  	const struct kexec_file_ops * const *fops;
> -	int ret =3D -ENOEXEC;
> +	int ret;
>
>  	for (fops =3D &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
>  		ret =3D (*fops)->probe(buf, buf_len);
> -		if (!ret) {
> +		if (ret =3D=3D 0) {
>  			image->fops =3D *fops;
> -			return ret;
> +			return 0;
>  		}
> +		if (ret !=3D -ENOEXEC)
> +			return ret;
>  	}
>
> -	return ret;
> +	return -ENOEXEC;
>  }
>
>  static void *kexec_image_load_default(struct kimage *image)
>
>
> This requires probe functions to return -ENOEXEC from fixes in patch 1.
> I will add this as a separate patch on top in v2.
>
> Does this looks good to you ?

LGTM. The only thing I'd change is to perhaps move the declaration of
ret inside the loop so it can never be used outside it, since ret is
only useful in the loop in this function.

--=20
Regards,
Pratyush Yadav


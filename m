Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54946CD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hVYQkZvCa/249OnnENN8S7mMprCEbWpK68lxOnRWYsg=; b=tx03lr6DJ56LtXBUKJBue6frvT
	OWGNFO5Uky8ljWtBJHQsEdSON3dj2XxxXiEzb2ctkr+El1iNX21fklF26zi/gr6iwxLadGx+Wx7Xk
	+RCO/wgv3pYnWEBb8FqILpjvtrQFjsp/OjSgL0MJamhMaCvOVHeR4vjtqohojdVIFzigeLXUyZ9Hc
	rK5pP8iWVfBQPhLTcUkDUR1plbpmtEmV/V6Ht+DstHDLJXuZNbIXaKQstE0jdgklgNfnFnXf8cE9r
	TFbH60+n4ms8Hz80ymbMW2W1ZF2J3lhoyc4AuBIrEbJfSqLSI6QC4GWMaiteCmPL+/fJvF/LVJijx
	AgPV52dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSJG-0000000DUVg-0Pug;
	Tue, 02 Jun 2026 16:49:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSJE-0000000DUVM-0961
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 16:49:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B8C243955;
	Tue,  2 Jun 2026 16:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4501F00893;
	Tue,  2 Jun 2026 16:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418983;
	bh=hVYQkZvCa/249OnnENN8S7mMprCEbWpK68lxOnRWYsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZTbddg9x4JZAsZUk9Om6SA060s6sGPRurLMSCBGjoeFEjhsc5hmpAte6cRQl0JrYo
	 9HXVxIPbiSSzIcj9lPRgVj8FS+pAMpPkiEjUYbDDfyi3NLqeKMZF1VOnn6ZmbcNAqn
	 GMYfKJZlWTIcJPAjN7wCGpAYuWeEzR47LvWdoRtpnKfwF2ZKVIvw3g/OHlju91ITY9
	 eiHiqalH3LtHXdHM2K/Mb7DD+Z/sJCV7JvazggorqLjn0c0PUI432LI5CecfoZjz+W
	 mQrhVWZrBPeHHSbgjouLyTDKvcKZiwEgTiVosY3C1JN9fQN+riMKATpTkY3WfApSyr
	 tXofEG/V4nzkA==
From: Pratyush Yadav <pratyush@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,
  kexec@lists.infradead.org
Subject: Re: [PATCH v2] kexec_file: skip checksum verification when safe
In-Reply-To: <CAAi7L5chTDdmGfdZGU+KONgYRi7JE-2R53-zhFi-L-17rg2G2A@mail.gmail.com>
	(=?utf-8?Q?=22Micha=C5=82_C=C5=82api=C5=84ski=22's?= message of "Tue, 2 Jun
 2026 17:43:54 +0200")
References: <20260602123311.1841746-1-mclapinski@google.com>
	<2vxzik81dlbu.fsf@kernel.org>
	<CAAi7L5chTDdmGfdZGU+KONgYRi7JE-2R53-zhFi-L-17rg2G2A@mail.gmail.com>
Date: Tue, 02 Jun 2026 18:49:40 +0200
Message-ID: <2vxz8q8wevkr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_094944_117818_1C685FFE 
X-CRM114-Status: GOOD (  43.36  )
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

On Tue, Jun 02 2026, Micha=C5=82 C=C5=82api=C5=84ski wrote:

> On Tue, Jun 2, 2026 at 5:16=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> On Tue, Jun 02 2026, Michal Clapinski wrote:
>>
>> > Checksum verification is needed
>> > 1. for crash kernels. In a crash, we can't be sure the kernel is
>> >    intact.
>> > 2. if we're worried about relocating the kernel into a region used by
>> >    some DMA that wasn't properly cancelled.
>> >
>> > If KHO is enabled then relocations will happen to KHO scratch, which
>> > is free from DMA regions.
>> > If we used CMA to allocate segments then relocations are not going to
>> > happen at all.
>> > Therefore, we can safely disable checksum verification in both of those
>> > cases.
>> >
>> > Instead of adding a new variable to purgatory, just skip adding regions
>> > and save the default value of SHA256 hash.
>> >
>> > Saves ~250ms on my 4.0 GHz CPU. This is an important saving for the
>> > live-update project.
>> >
>> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
>> > ---
>> > v2:
>> > - also skip checksum verification if KHO is enabled
>> > - small fixes from reviews
>> >
>> > My original idea was to do 2 changes:
>> > 1. Skip checksum if all segments are CMA.
>> > 2. If KHO is enabled, allocate the kernel inside kho_scratch using CMA.
>> >
>> > This way we could skip both relocations and checksum verification when
>> > KHO is enabled.
>> > But I realized that step 2 might not be possible on warm boots.
>>
>> AFAIU we only relocate into scratch since relocating anywhere else might
>> over-write preserved memory. If there is no relocation, there is no need
>> for the kernel image to be in scratch, since the image won't be
>> preserved memory anyway.
>>
>> So perhaps we can just use CMA directly, and only fall back to
>> kho_locate_mem_hole() if that fails? This should be a simple enough
>> change.
>
> I agree that it will work. However, the user would need to have CMA
> memory and it would need to have enough contiguous memory available.
> Do you think running out of CMA memory is a real problem?

No idea. I think that depends heavily on how much memory drivers are
using, and I have no numbers for that.

Anyway, if the user doesn't have memory available in CMA, we will still
fall back to the normal path so kexec load will still at least keep
working.

>
>> Do you know how much time we can save by skipping relocations? I would
>> guess it is in the hundreds of milliseconds.
>
> It's smaller than the variance between runs. Maybe 10ms. Everything
> between exiting the old kernel and TSC initialization in the new
> kernel takes ~70ms.
>
> Theoretically if we didn't have to do relocations, we could try
> unpacking the kernel before kexec, which would save a little bit more
> time. But again, definitely less than 0.1s.

Hmm, I thought it would take longer. I don't think we are at a point yet
where we should try to save 10s of milliseconds.

Thanks for trying it out though.

>
>> Can you try this (COMPLETELY UNTESTED) patch out and see if it works and
>> if it further improves kexec time?
>>
>> --- 8< ---
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 2bfbb2d144e6..0ccc7b6d67c1 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -720,14 +720,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>>         if (kbuf->mem !=3D KEXEC_BUF_MEM_UNKNOWN)
>>                 return 0;
>>
>> -       /*
>> -        * If KHO is active, only use KHO scratch memory. All other memo=
ry
>> -        * could potentially be handed over.
>> -        */
>> -       ret =3D kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
>> -       if (ret <=3D 0)
>> -               return ret;
>> -
>>         /*
>>          * Try to find a free physically contiguous block of memory firs=
t. With that, we
>>          * can avoid any copying at kexec time.
>> @@ -735,6 +727,14 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>>         if (!kexec_alloc_contig(kbuf))
>>                 return 0;
>>
>> +       /*
>> +        * If KHO is active and relocations are to be done,, only use KHO
>> +        * scratch memory. All other memory could potentially be handed =
over.
>> +        */
>> +       ret =3D kho_locate_mem_hole(kbuf, locate_mem_hole_callback);
>> +       if (ret <=3D 0)
>> +               return ret;
>> +
>>         if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>>                 ret =3D kexec_walk_resources(kbuf, locate_mem_hole_callb=
ack);
>>         else
>> --- >8 ---
>>
>> Of course this is not directly related to this patch so it shouldn't
>> block it, but I reckon we might be able to squeeze a bit more
>> performance out this way as a follow up.
>>
[...]

--=20
Regards,
Pratyush Yadav


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB48ECAAD1
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 10:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YCacdf7rnqse4WRAHv/0y5rt5pDNKwVOjnqR5z5OouA=; b=FhbwBr/tVogbYJ
	WfEWJGWeELEF4JMAMx0OfrTJO3oHBLTOfl45sO4wlYVVD5qPgD5WeMl2wtJ9A1h7z5oY1crlN4nTR
	NX7qvdu9ewmVMiMlA4JvxXKLlUmorMPd0GecroNq8ACpMuIx5AtoQga3w6leGbB1TGBpfXc7C/suy
	q7Gx30R6BIfavV+6k+WVcGcad3ZB0kxBwsyQREt0v/H57QQpVxcmI5LUO/sJ86eHygGNpbzdTDxoy
	SGyDqRiV3QHi/qOMo4SnnuhOWuPRqzZQ/7MQOlRRLgH9lGpxxqerCuDXM8Zp8LNpFPDdBZHagfwfJ
	mNZV+GQR+9zrq1cUqLRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTKyd-005gAJ-Uu; Wed, 31 Aug 2022 10:29:43 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTKyQ-005fye-Pz; Wed, 31 Aug 2022 10:29:32 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3376851fe13so302949227b3.6;
        Wed, 31 Aug 2022 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JtUe231ScKnZZsv1scR1HDTAYqZvJhxRELB+mbC/erg=;
        b=mWhAoBVM0lwZyI1sH4kD3oX7WXZLDc+gi00olyO/QOzC0P684xrcgzgK6q/pjqoLHc
         Eks24hDrkJB/Bm0cKceUEOcyM/wq8BUZluENZJJvHTc7ugj5TrAMQkigt9vN/130vWyZ
         Sj/FmjGyCq38iBXtNDLB76Oba5SLylD5ocj7+x0BEpOwguzPjC0WQ2BXC3GDtJbEu8F9
         5471l4UlL6vZPWrCfBxHIIhl0EAhF+ZQgEHYA73mXUg1SrkMkJkqBUFf59ice3rI/qt+
         745AoSfcVN4ZJ0GHTQIgBdq5xgZlnm+m99Ek+whN7+UKSMAktpq6RVwNeArIlMrTFZFG
         0fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JtUe231ScKnZZsv1scR1HDTAYqZvJhxRELB+mbC/erg=;
        b=MIXmZBxtzSfsaHT307ppXiPgBKal5JbdbNywetOREa9dviEWlS0impxaxoSsUGKZ0d
         dwyhM8p1aONnFnsasmFBi2gqAiX0Sv6snCZwMCtta0Exg1KwuyWoCeadghvWOw+uJQD+
         xVOpFNlxSjaoxbBgKqu6Lgv0+/NwuGIITf1Wa8r96YVjdEcUWLhq0PHq6ZFM6NMv7Osi
         zZYrZOYDyfcFuTdT5iMEcVlNHWzoJ5CWrpsQtWsTr1S8GdHKRlA4eZB4yAKAGy9b4ulT
         g/DLZYmZ/WECeBdGGaVJViioD6c+YXjqCdGagGZbmb/sw6UF1xLojDPrxDylbYs0+F38
         NzDQ==
X-Gm-Message-State: ACgBeo1VYIJw+kSWgw/8hmG4x+wiIrpRlmprx7Kmq1V2VQhR4vG37J60
	QEn349lpDV+bZ5P0ia1mfV90q8txWiO/El8gocg=
X-Google-Smtp-Source: AA6agR50wbmpClPpyJmIAU5A6Exa3YSSFc/iq/A6NBiwt8jVUSyIzpRlI6EGXrxDHzSOD3Qw6JIyvIYeFRbKK0XKAtU=
X-Received: by 2002:a0d:cc47:0:b0:340:cf17:9362 with SMTP id
 o68-20020a0dcc47000000b00340cf179362mr14990924ywd.127.1661941766239; Wed, 31
 Aug 2022 03:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
 <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv> <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
 <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com> <Yw83WQOgQf2yICaM@arm.com>
In-Reply-To: <Yw83WQOgQf2yICaM@arm.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 31 Aug 2022 19:29:15 +0900
Message-ID: <CAM7-yPQEF3PUH5ER7n1beSncEj=hJcE0Dk0JPZrxkh9-oHxt+Q@mail.gmail.com>
Subject: Re: [PATCH v2-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Baoquan He <bhe@redhat.com>, will@kernel.org, nramas@linux.microsoft.com, 
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_032930_858925_A7E19E88 
X-CRM114-Status: GOOD (  18.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

>
> To be even more precise, it should be:
>
> Cc: <stable@vger.kernel.org> # 5.19.x

Thanks! I'll fix it!


> Something happened to the whitespace here, so the patch can't be
> applied.

Sorry, I'll check and send again :). Thanks!

On Wed, Aug 31, 2022 at 7:26 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Aug 31, 2022 at 10:49:30AM +0900, Yun Levi wrote:
> > Like crashk_res, Calling crash_exclude_mem_range function with
> > crashk_low_res area would need extra crash_mem range too.
> >
> > Add one more extra cmem slot in case of crashk_low_res is used.
> >
> > Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
> > Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
> > Cc: stable@vger.kernel.org
>
> To be even more precise, it should be:
>
> Cc: <stable@vger.kernel.org> # 5.19.x
>
> > Acked-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >  arch/arm64/kernel/machine_kexec_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/machine_kexec_file.c
> > b/arch/arm64/kernel/machine_kexec_file.c
> > index 889951291cc0..a11a6e14ba89 100644
> > --- a/arch/arm64/kernel/machine_kexec_file.c
> > +++ b/arch/arm64/kernel/machine_kexec_file.c
> > @@ -47,7 +47,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
> >   u64 i;
> >   phys_addr_t start, end;
> >
> > - nr_ranges = 1; /* for exclusion of crashkernel region */
> > + nr_ranges = 2; /* for exclusion of crashkernel region */
> >   for_each_mem_range(i, &start, &end)
> >   nr_ranges++;
>
> Something happened to the whitespace here, so the patch can't be
> applied.
>
> --
> Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6ADE9A04C
	for <kexec@archiver.kernel.org>; Thu, 19 Feb 2026 06:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f5Y/ObMYOjMNaMYn2BS529u3eaizGhMbHv9x7KJjXe8=; b=nUJtyPEGlfKe5uj+OEB0I+9HBI
	wJlv81km6Sfyh+YJ6Ytwdw1LXucO4bTBMr34MQ9dX1WckjTbD8ox++LPnqrZKK8m9ys2y8juTxg10
	4vK7uKQwVRr90m/I4GRkACmBSDDJzX9piZB3fYjrymDZcbWddgJwPN4YL0TITVaiC5wEGerdOHH2+
	jB/j6xxWVZfxNzrpo3f8zCzlLv2RifRy6NBGNyxLsObQqkvtgi6Yhi+d744imnubAbnebQjVMMSD3
	9zZ4hNsHbuwMXfK2SDiI1Xg+MIkq8u8ETLzmmb9oKAZr19n60/bsHY/LIuw8sP6VIYNZHgTsOIuqt
	8xOlCbjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsxy0-0000000AzsT-0ZAd;
	Thu, 19 Feb 2026 06:56:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsxxx-0000000Azs5-04VJ
	for kexec@lists.infradead.org;
	Thu, 19 Feb 2026 06:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771484206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f5Y/ObMYOjMNaMYn2BS529u3eaizGhMbHv9x7KJjXe8=;
	b=FzZdm5mYJTSCdh9SBAR+kORCAb9tbSPNR7EtP8p6CbREQYU4UZllTyzSIwIB3NMtiQagLa
	C6ckbh+IvbbUAnJYGVEzPkoaeNJpsuPGY0S1lRJZQH4YqMb9/TVBd1LUMrZZh8XXkhMqT9
	OV86FrtG5asJOJTA5rxGzhRdgi5fYDw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Zrk3IxxtNgqqRcGjHPL2PQ-1; Thu, 19 Feb 2026 01:56:44 -0500
X-MC-Unique: Zrk3IxxtNgqqRcGjHPL2PQ-1
X-Mimecast-MFC-AGG-ID: Zrk3IxxtNgqqRcGjHPL2PQ_1771484203
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3870b9ec9a0so3328171fa.1
        for <kexec@lists.infradead.org>; Wed, 18 Feb 2026 22:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771484203; x=1772089003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5Y/ObMYOjMNaMYn2BS529u3eaizGhMbHv9x7KJjXe8=;
        b=KeTx70OcICMP4phAxLhUxSPkErGj2jKCUBaXeRShkYz1BcqL2SVCGEvxn0YvBPkK9Y
         TyULZsYdt6y0Xjp0zbdfU+pIC3+iEglJkuMK/Z5fmVbOmUxlbeVYYpyl9c1bHeyzfvo+
         BcaOQTjCThBIkMStFL4nx1eGh9ZrpBVKC3v+k3cCHspOlpAl/ALuYI615qZh376Ww/YQ
         J4VzL09IpLQwUEUbe8gakI3Pc7wxD6rbcYGmzesjSZAeQOqhRiitDDGcZZTITy38WrrT
         G6+0r8/T8W/APrcRni8advNkOvhDtkMmnbp2s7/3y0fqlFb2Zep/HNyck+xmHlYkKVXh
         aUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+uqTORT3ZpzHQEg7D3xKpt/s7uZM5oYWcbEt7I9Q4PfrUcfHghFgC4NoCpNIiGtHaQE0yrQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaaG1wsw+1Ml97KWBVQ5dCSGZ7NOiJYtUEziqMRj6A4yQAG1D0
	EEmUe8laTIb5nQ8MHo+RtY7+pfsUI3x/EliSaqFmFvSqkdJvQmWZXvtE3UasaizNwpUJ52QQd2l
	eI6oAG1IDZ7T6yUFuDWCedUMeBi9dBGYBQ+5pKP763vr9Vepg1Jw+P2fW3yUU+IU4sWwjutZkkj
	0w91uk6+z24pUGz0CagusUgAAGhvct9vnb/+e5
X-Gm-Gg: AZuq6aJISRQhY2QWiNThHHVjAQGa2chyVQ08xsMUX5xhV4uJ+e8IkBo95EHCGg/QrvM
	xkm9P+i8CLDZ7+DEbvBgVL1pzlmMiEmQdu+wTziNiPIclJtfopoO6Nla3qXyZJNiW8E7MqJqje6
	4koObCHOG8yN4K+2fushpEZrCKWddNX4ida5iEn3ZVYsw2iFVCzAI2ISaP/GPnFhPX8eC83vqIH
	3lsq1mN7wiAHscWZ5U8/8B2C8lPuOHP+wCFVsd0er73DHUBdIYZxQdNJg8uoPk2rx/W
X-Received: by 2002:a05:651c:2225:b0:385:c13b:5584 with SMTP id 38308e7fff4ca-3881b97e9a0mr51039961fa.36.1771484202703;
        Wed, 18 Feb 2026 22:56:42 -0800 (PST)
X-Received: by 2002:a05:651c:2225:b0:385:c13b:5584 with SMTP id
 38308e7fff4ca-3881b97e9a0mr51039911fa.36.1771484202292; Wed, 18 Feb 2026
 22:56:42 -0800 (PST)
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com> <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com> <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
 <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com> <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
 <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
In-Reply-To: <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 19 Feb 2026 14:57:15 +0800
X-Gm-Features: AaiRm52MPDjJIrnr6aiuB7naGrInBNXWrag7kRXeZTmUUl0RZ8Q467qwTU_SJBY
Message-ID: <CALu+AoRdx_=FFkFUcfwc8Z_7qmMbyC6Yf5AJA6PpTyDcjBS2Hw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j77b8RtDEj-tyG2fdqfM-R6ZeaxW_CioGQHFDEezLcU_1771484203
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_225649_132106_34BC7054 
X-CRM114-Status: GOOD (  14.03  )
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

Hi Ard,

> Actually, looking at that code more closely, I kind of wonder why the kexec code tests for EFI_RUNTIME_SERVICES to begin with. Perhaps it might be sufficient to do this:
>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index c3244ac680d1..bec91ee7e668 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -192,7 +192,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>         struct efi_info *current_ei = &boot_params.efi_info;
>         struct efi_info *ei = &params->efi_info;
>
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +       if (!efi_enabled(EFI_MEMMAP))
>                 return 0;
>
>         if (!current_ei->efi_memmap_size)
>
> That way, if the first kernel was booted via EFI but without runtime services enabled, the kexec'ed kernel will simply inherit the ACPI and EFI tables.

Actually it does not work,  EFI_MEMMAP is unset in function
efi_memmap_unmap() when runtime is disabled,  so nodifference for
checking EFI_MEMMAP or EFI_RUNTIME_SERVICES bits.

The x86 kexec efi code is simply written to assume EFI runtime is
enabled as it copies the cooked runtime service mem ranges in memmap.
 If we want to improve it I suspect the efi initialization code could
need changes, and then even if first kernel disabled runtime, the
kexec 2nd kernel still have chance to enter virtual mode to enable
runtime.    But this does requires more work to be done.

Thanks
Dave



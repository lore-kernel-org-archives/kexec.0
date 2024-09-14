Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C6EFC619E
	for <kexec@archiver.kernel.org>; Sat, 14 Sep 2024 06:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5WMRlv3Xj4ttx2UVZsAYsYfMD9DtUqVBewY7UL+xulw=; b=k9//Z8IY/X0Dt7
	vzATLpOFvPR6trBX1vUIRLDt28sT2fxvBV7kWGrVlFPobywejNwbXeVrSkgfQREdoHQupiOqU8fU+
	d17HWjhms63gjqPG1ysu4+4sPsTLpyc/6NCpcazCdyREHCmGROKgVvsRgD9ExxelpOVq2WSFU+p7G
	FRLIRd7Oop21lZG1NB9UYxyWckvuVmSaTRmTy0EiGSqkPEPmH7yD8vYMCChF76V3+Yi8DfJmO2dag
	7xZ1gYVjeoZtq5qQdhTsGmAIEbdz/STXHop0XVh+ujhmADN89gjrc1JinG8a+gAKT5oQhXdeyZaLS
	uYm0i3o5dRhRgh8sOgNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spMXo-00000000EDx-0IoA;
	Sat, 14 Sep 2024 06:46:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spMXh-00000000EDU-1m3V
	for kexec@lists.infradead.org;
	Sat, 14 Sep 2024 06:46:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726296360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eE+sUtCjdi/s3uFDNMp4FAK3ec8qOZ3QSC8oSZ6JDTs=;
	b=gA/ca8XYiBr2KFPQLV8C6Vh76njsxMtp9DBmiNHfnd9KRtsFLjDDYRw0MpCM0KGxQNjeIc
	ztrLbJuoFW9Lgtdgu3s/GN/64nzpe08AflKEXALddTJ0BV4UH1V1QT7DhQ0oFTtDcJRBul
	mzbuWs7ttlOra7qOFCevSpSlE4nIRTg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-BH_sdl-hPJyvE-8VgtSlDw-1; Sat, 14 Sep 2024 02:45:58 -0400
X-MC-Unique: BH_sdl-hPJyvE-8VgtSlDw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso51436445ab.0
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 23:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726296358; x=1726901158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE+sUtCjdi/s3uFDNMp4FAK3ec8qOZ3QSC8oSZ6JDTs=;
        b=aKRW9NEx+xzpDjvUksJEqptcnjReYLeiHga2Nch6wJKpUNmNjGXTDD6KW7sQjSyzA3
         sa7M1SOgb8qpYlLjf/5Cbf9XkCVqkYL5xL65wVAQ9HdLumD7QpteuWKuUS/esrYdvxU0
         XVehXg9GWZBJ6gm0OFj5XYjhxjYjcU04yFM37GIdXXHflU9nByETgivtu090Qx5PNP5I
         eZs8gsbpf3lS1LyS8ocEGKmDqmmRvBmZyv0jz369gUJWv1UvW3V56rcmRtXgbYXShwcc
         GfiGBByp4oSx+gaXxPRge5XjHyFyX9bGxjy8s33qwZgsstIRKvQoR0g9j4KnCgugmZqc
         iqDw==
X-Forwarded-Encrypted: i=1; AJvYcCUR0h0yijUIB7WAiNA/AvavgyN3pdib1QlvuXV9jfHFcKBk/NgNGuvvOeupeSQJOu+agmY+7g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHyeZRv7SCYF5a9+piLllWD5v2mceOAts1Wni2eaqoPyiDFo0i
	lfaY71n1SRv2xHSDt9DoIYbqW2are8ECK3rsEOy58Fsrz5VzjteW3EX7Z3gOrro1GQgJkOjs0Pq
	8CLTnLVY8tES0qsihirKcig/OqMnnrdFdMArIPMbCflsXKM0eKZMkFJPHaWDbBhxeslzIg5M09I
	qroTTTBijTa/PTm/kpn6yjX+lq8n0IqX45
X-Received: by 2002:a05:6e02:20c3:b0:3a0:65a0:460a with SMTP id e9e14a558f8ab-3a08b7853d2mr56807595ab.19.1726296358181;
        Fri, 13 Sep 2024 23:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKtOV06MvITuNSFqCNIuipejGNDZMGs5HGBfR92MW39oPD8LiixfpPzOKJFy295hNSsVybcQ9a493Mk9E08Vc=
X-Received: by 2002:a05:6e02:20c3:b0:3a0:65a0:460a with SMTP id
 e9e14a558f8ab-3a08b7853d2mr56807495ab.19.1726296357859; Fri, 13 Sep 2024
 23:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com> <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
In-Reply-To: <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 14:46:07 +0800
Message-ID: <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Breno Leitao <leitao@debian.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_234601_564032_44C75A45 
X-CRM114-Status: GOOD (  21.79  )
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

On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
>
> On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > (cc Dave)
>
> Thanks for ccing me.
>
> >
> > Full thread here:
> > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> >
> > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > >
> > > >
> > > >
> > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > Does the below help at all?
> > > > >
> > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > >         }
> > > > >
> > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > >
> > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > >                 pr_info("TPM Final Events table not present\n");
> > > >
> > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > which is e820_table_firmware.
> > > >
> > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > its end, just with e820_table_firmware instead of e820_table.
> > > > i.e. efi_mem_reserve does:
> > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > >         e820__update_table(e820_table);
> > > >
> > > > while arch_update_firmware_area does:
> > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > >         e820__update_table(e820_table_firmware);
> > > >
> > >
> > > Shame.
> > >
> > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > table, and 3 (!) versions of the E820 table in the correct way
> > > (e820_table, e820_table_kexec and e820_table_firmware)
> > >
> > > Perhaps we can put this additional logic in x86's implementation of
> > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > with configuration tables produced by the firmware that may not be
> > > reserved correctly if kexec looks at e820_table_firmware[] only.
> >
>
> I have not read all the conversations,  let me have a look and response later.
>

I'm still confused after reading the code about why this issue can
still happen with a efi_mem_reserve.
Usama, Breno, could any of you share the exact steps on how to
reproduce this issue with a kvm guest?

Thanks
Daev


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

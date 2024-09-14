Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75ED6C02189
	for <kexec@archiver.kernel.org>; Sat, 14 Sep 2024 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BuuIM2Hw9LDGDJSzjl2ijV3ojhKvE5wzd83B7V5Mb8I=; b=vZFeKiO4y6mG66
	sxTp6xcTImeq3cJeC5A0qWn3Pz/pOpUTZqU/bBAxJB/HOx+FDCsPpUOrRZ/dfTMQg5zT2MT4CJ63h
	Qpq7MhDOG5+kzE/7TCYcMe21eH5BWGZ0tmSZbDbqrr3FJGMcJS1JH2NuEuRYXQ9oi70bGS3nap/0b
	YYLcEFve7U+4N5q//O28NyCUjNAJv94QZQFBVmGyWQ7T1t/F2VjNyorX+8sBYg+Bwi0oYmwjfKd/l
	NoqZB/cPWX2EPNZpnLH63YbgyF8XWGtA1bVAiRBziXsvFjpsv2j62bSwCxoiuKeClKmcanr3vT01H
	UQBqbUwDXvqd0UzsIzew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spP0c-00000000RF3-1lLD;
	Sat, 14 Sep 2024 09:24:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spP0X-00000000RED-1lZY
	for kexec@lists.infradead.org;
	Sat, 14 Sep 2024 09:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726305835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+awoBYbz+fiOegQ6mOk8qScgUrhW8r4PWwqAdqhz0MQ=;
	b=HJj/+qrcFvMOVYGnO+XhN6cFbOw3/D5SHJWWNfC6RnP1l5eWJYryBQRUee6ubvH5mgsluu
	Au+gLitmLEeePhU6OSHZtVmqAcNmpvCkmw9MbACiUNWfQH/Q50jIDmi/3p8s1f28X2m6zM
	tcLHj+FfYd4VUAWIXWIorJnxNrC3Q7w=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-LI7n9SeGPP6Zf64akqkyug-1; Sat, 14 Sep 2024 05:23:54 -0400
X-MC-Unique: LI7n9SeGPP6Zf64akqkyug-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so46739485ab.2
        for <kexec@lists.infradead.org>; Sat, 14 Sep 2024 02:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726305833; x=1726910633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+awoBYbz+fiOegQ6mOk8qScgUrhW8r4PWwqAdqhz0MQ=;
        b=mp+SytZ/q2JjSHbn4Mj2+NP/VUB6YG0V1DvSCXutqItbmnIsl2jz8Ngr4ouKGmTgJ0
         dtRg3lO4aKLbXPU36nOlCX34vI6+HBS5sVz2RRNOIbqZhMIsgQUo6eKh0LaBewFXDfZF
         EXe+wchNV04AsnxGmt6pKqGoea+bsEPvDxg02bYE+CrV0VbBRXfYJOT8C4y+KAMoC+NL
         QC5tRTwUKv1kFHMYUZhyn6leuvkKNAZ+C2NgfAYWcNT4M/D6CLkSdYiM1Sk85qYG4uUT
         wgW1t1vj+Vn4NUZpz1lXxWxbfPEUVk5Pv/JF4AL+stKUxiultEPvRgPFvenKX5t+To8M
         ydJw==
X-Forwarded-Encrypted: i=1; AJvYcCWhvdqnbvt1d8L1X3edisy0PDryLuP9QSu2LWa3WV2x/ftWAU8liz7SVwz4McF1IoIRV7RWUA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwYaN2m7lIAsipAaZxFg1RRfQ+2LKwmcTQvfVPWK4wMHhdzmp6p
	xPyWrPhpwOVTxeU0BBBJ79wyJu59EKe17IygI5PdYXpRi18xUTyXJg0ofNItt90OI9OZLwHF/7T
	3t1wEs8KprR2VW+xb42vqielD07TUey7TnHxSanujiqpGTfYZWXCJtzhEERPkRE6jGH0jdakOq7
	VTupOPB6X+Yb/ct43BsSieCsOzqFaEvlc5
X-Received: by 2002:a92:c54f:0:b0:39b:2ceb:1a23 with SMTP id e9e14a558f8ab-3a08b6eaf31mr60811975ab.3.1726305833244;
        Sat, 14 Sep 2024 02:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1udwAp2hvQpffUsSCAinuqeX3gwXdqv9mYS2VXLF1QMtgx2Uyroz30Qdf3rG7X/Vc0kyHoQWKJ7b7ZwTjkmU=
X-Received: by 2002:a92:c54f:0:b0:39b:2ceb:1a23 with SMTP id
 e9e14a558f8ab-3a08b6eaf31mr60811745ab.3.1726305832959; Sat, 14 Sep 2024
 02:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
 <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com> <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
In-Reply-To: <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 17:24:01 +0800
Message-ID: <CALu+AoSp1ZryfH_j6RYqeCCjG5mFf6JkgaF4V9UwgPp+pE+mjA@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240914_022357_555580_03C2C31C 
X-CRM114-Status: GOOD (  32.10  )
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

On Sat, 14 Sept 2024 at 16:31, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sat, 14 Sept 2024 at 08:46, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > (cc Dave)
> > >
> > > Thanks for ccing me.
> > >
> > > >
> > > > Full thread here:
> > > > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> > > >
> > > > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > > > Does the below help at all?
> > > > > > >
> > > > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > > > >         }
> > > > > > >
> > > > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > > > >
> > > > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > > > >                 pr_info("TPM Final Events table not present\n");
> > > > > >
> > > > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > > > which is e820_table_firmware.

Updating e820_table should be good enough, it depends on where the
corruption is happening.

kexec will find a suitable memory for the kernel via searching through
the system ram resources.   So efi_mem_reserve will update e820_table,
then reserve in the resources list as E820_TYPE_RESERVED, thus it
should not be a problem.
During the 2nd kernel boot phase, it is carried as EFI_LOADER_DATA
with EFI_MEMORY_RUNTIME attribute, I think it is also fine,  and later
efi_mem_reserve will be called as what have been done in previous
kernel.

So I think no need to update the e820_table_kexec and e820_table_firmware

> > > > > >
> > > > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > > > its end, just with e820_table_firmware instead of e820_table.
> > > > > > i.e. efi_mem_reserve does:
> > > > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > > >         e820__update_table(e820_table);
> > > > > >
> > > > > > while arch_update_firmware_area does:
> > > > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > > >         e820__update_table(e820_table_firmware);
> > > > > >
> > > > >
> > > > > Shame.
> > > > >
> > > > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > > > table, and 3 (!) versions of the E820 table in the correct way
> > > > > (e820_table, e820_table_kexec and e820_table_firmware)
> > > > >
> > > > > Perhaps we can put this additional logic in x86's implementation of
> > > > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > > > with configuration tables produced by the firmware that may not be
> > > > > reserved correctly if kexec looks at e820_table_firmware[] only.
> > > >
> > >
> > > I have not read all the conversations,  let me have a look and response later.
> > >
> >
> > I'm still confused after reading the code about why this issue can
> > still happen with a efi_mem_reserve.
> > Usama, Breno, could any of you share the exact steps on how to
> > reproduce this issue with a kvm guest?
> >
>
> The code does not use efi_mem_reserve() only memblock_reserve().

Yes, I see this, I just thought that Usama tested with changes to
efi_mem_reserve and it still did not work, this is what I'm confused
about.

But maybe Usama did not test and only checked the code and assumed
that we have to update the e820_table_kexec and e820_table_firmware.
See my reply inline above.

Thanks
Dave
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

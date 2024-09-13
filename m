Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649B6FA3748
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 11:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1tUeouXxv6Vqvmsjgokxr2P9xtEoWyAIkKKMHPO7evg=; b=pxBnMeh3HQZMLs
	N1m98aUnkkdOmfYim9o3X4Pw1IHhZd04wWOHEq6CDSaSfwxpsiipQCrjTOPrSshzGl8CDCz1MlKqz
	z6b6EmmOhWbXfmGDT43BVm1QuSMZnS6WvNId1tc9YWtpCsFJkHR51om9Q53XTjntLdTxvtd2Qjh9L
	xIBjm9H90nb3uUZuGVMYLqlt6hmGgprZRwZF+0AVeZSK0imbDt0oauLz2lWIEPDTkBMnERhff6AYs
	3nveJ41NmnacIANoMdic6lCmLe1PfE4iXMueYyx0S5vcDCnzUXo9ZnVaKtLjZGHZz2t8fwRXh19vA
	DoHF1WGsgdYh+Q8MEU9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4nS-0000000Fn0b-2P7N;
	Fri, 13 Sep 2024 11:49:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4nO-0000000Fn0B-3Yun
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 11:49:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726228141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qLsgKJWlbStQF29sk2kzl+359xJBMr9YOTKXz/rvjuY=;
	b=FnvdftAaixVHmXDcBhtnHGpx7+KBdOT9abkZfVSySjuAG35nPwb/0IqbXFKsw9g8K8n+9y
	dsedot0vRl1GaEYBRxOy++yLScchdQT8t2pM5UvZPR3BWFEa8FwRqti2l84U2Ne7RithPr
	thfjCrBs9ovMP3ljrLQDVV+3x6dA3q0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-eEKTcVnLOYq2BWVyScamIQ-1; Fri, 13 Sep 2024 07:49:00 -0400
X-MC-Unique: eEKTcVnLOYq2BWVyScamIQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a043f8e2abso27498325ab.1
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 04:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228140; x=1726832940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLsgKJWlbStQF29sk2kzl+359xJBMr9YOTKXz/rvjuY=;
        b=urWeHC0quuQBMoDxq/KtUFz3IAZYccU86j+PD5rHY2TNu7GhwLsDn+/a4RRy6vVx91
         F0THSSjapMaXb38F6QUxe5KwUGJ3xE+00fBCLSXMz9sWNskXReDGY/z20Z+TCjcnGH3O
         dTbri3shx7YL3a15zdm5NxNp6JQTguKYo5UKvRGKksMtMUPeK/uyF4IVmFo6U02ZY/or
         mpDzXm+z6bRws/Djl/o5fSQYCw+mga6ggApERGExStW1K6Huzt6XwiFtWt9fvqK4l+lu
         QKF4+XysbVGqhJ3ZZ2kU41UHY6lf1pXPDN34W5+nbUK5Xq1W9t6kIB9By0ZWcAaMSQug
         KQlw==
X-Forwarded-Encrypted: i=1; AJvYcCUgNiYYZ10dCp9BorJ/TkOm0SMTDKH1DyaORYcgnRWBxH/oXW9OVA10ZmJzegQ+vwr8d2+8wA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxP5m0LO8lpi1/FMx6mi5g+zFgEKqVnjJgI9II4KhF5sAsiSszH
	GuWUHlWAZURQl/l8PR0N3vTczMcasXymTHGlwaSvVNly17E0A5pyZH8X42elo763j6e8piVrm7/
	UIHY31rbOsN69cF/0Dzf1VbJjZXZNsegHPSeojVBsBsXbS2DRXSDwsikkTQXkYr+aBF+bIcAA+Z
	S27Libew4RLivTMEQZIVx1ty6UJGKJsONo
X-Received: by 2002:a05:6e02:1d05:b0:39d:2a84:86a3 with SMTP id e9e14a558f8ab-3a0848aff21mr65013335ab.4.1726228139826;
        Fri, 13 Sep 2024 04:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBxhnTVx9pazmQpewUpzYgkKmDROO9FUau+OjYRUe1cM2IP3h9TK3N1cMqOfg6YcN/9Aw7a7Ms1iOdUE4IdMo=
X-Received: by 2002:a05:6e02:1d05:b0:39d:2a84:86a3 with SMTP id
 e9e14a558f8ab-3a0848aff21mr65013185ab.4.1726228139409; Fri, 13 Sep 2024
 04:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
 <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com> <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
In-Reply-To: <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 19:49:08 +0800
Message-ID: <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_044902_991432_163625EA 
X-CRM114-Status: GOOD (  34.54  )
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

On Fri, 13 Sept 2024 at 19:13, Dave Young <dyoung@redhat.com> wrote:
>
> On Fri, 13 Sept 2024 at 19:07, Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 13/09/2024 11:56, Dave Young wrote:
> > > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> (cc Dave)
> > >
> > > Thanks for ccing me.
> > >
> > >>
> > >> Full thread here:
> > >> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> > >>
> > >> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>>
> > >>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > >>>>> Does the below help at all?
> > >>>>>
> > >>>>> --- a/drivers/firmware/efi/tpm.c
> > >>>>> +++ b/drivers/firmware/efi/tpm.c
> > >>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > >>>>>         }
> > >>>>>
> > >>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > >>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
> > >>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > >>>>>
> > >>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > >>>>>                 pr_info("TPM Final Events table not present\n");
> > >>>>
> > >>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > >>>> which is e820_table_firmware.
> > >>>>
> > >>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > >>>> its end, just with e820_table_firmware instead of e820_table.
> > >>>> i.e. efi_mem_reserve does:
> > >>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >>>>         e820__update_table(e820_table);
> > >>>>
> > >>>> while arch_update_firmware_area does:
> > >>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >>>>         e820__update_table(e820_table_firmware);
> > >>>>
> > >>>
> > >>> Shame.
> > >>>
> > >>> Using efi_mem_reserve() is appropriate here in any case, but I guess
> > >>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > >>> table, and 3 (!) versions of the E820 table in the correct way
> > >>> (e820_table, e820_table_kexec and e820_table_firmware)
> > >>>
> > >>> Perhaps we can put this additional logic in x86's implementation of
> > >>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > >>> with configuration tables produced by the firmware that may not be
> > >>> reserved correctly if kexec looks at e820_table_firmware[] only.
> > >>
> > >
> > > I have not read all the conversations,  let me have a look and response later.
> > >
> > > The first glance about the patch is that I think the kexec_file_load
> > > syscall (default of latest kexec-tools) will not use
> > > e820_table_firmware AFAIK.  it will only use e820_table_kexec.
> >
> > I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap
> >
> > https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29
> >
> > which is e820_table_firmware.
>
> That piece of code is only used by kexec_load
>
> >
> > The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
> > is the right approach to it I believe, and I dont see the issue anymore after applying that patch.
> >
> > >
> > > Usama, can you confirm how you tested this?
> > > kexec -c -l  will use kexec_load syscall
> >
> > I am currently testing in my VM setup with kexec_load. But production is running
> > kexec_file_load and has the same issue.
>
> Ok, I mean efi_mem_reserve should be able to work if you retest with
> kexec_file_load.

Hold on,  I'm not sure about above :(

checking the efi_arch_mem_reserve(), currently it updates the e820
table, if you update the e820_table_kexec and e820_table_firmware then
I think both kexec_load and kexec_file_load will work.

Anyway I was not aware very much about the firmware e820 tables and
kexec tables when they were created.   I suspect that a cleanup and
revisit is needed.  I will have a look at that.

For Ard's fix to allocate it as ACPI memory, I think it should be good
and simpler.

>
> >
> > Thanks,
> > Usama
> >
> > > kexec [-s] -l will use kexec_file_load syscall
> > >
> > > Thanks
> > > Dave
> > >
> >


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

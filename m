Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB419FA3745
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8VWgxRSwEAVPWF01hiXcA4HM2EKU0kCEYvbpZr0F9TY=; b=l+UWhkpkquNQhp
	+y4ESjzmtx1QInytoUFQdNX47epuKjv4oA8lTKIOjP+4rr7elbZhlmBQtfLqgnuAufcB7YcNk5eZP
	w1HejX1MAa9PqpJNsMFBF7ky7npFWJOxcZKWhs9NoauCXhsaPzi56mZwSOJlSXLAIj5Ud/uVCxD6B
	WmRA1GjHHVYHXLR5O9P2s3A2FPjPNkomOHSS0GEmOg8Ajp+QAxS469/bVu3wRi+FHvR2mzuQ4TUei
	bEpEkFf6VYFUyydb5WbIw3ph2Kacr1Z85QpkTFJRWHzb77SOUnBPCb9o2xI8mBlYI0Phd2ybExmbZ
	HRNDBfqj27NeLevG7SVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4FO-0000000FiCK-04Rv;
	Fri, 13 Sep 2024 11:13:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp4FL-0000000FiBw-1Q5M
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 11:13:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726226030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MASR/9GQZ3+JJGeE8AwFTJhS8+TAiNPcAVjIePuGwyw=;
	b=UTmx4zmm4Jx0MaQnczsa4bLv6ZW2jbxn3veFpIUgP2lIBQrozBAZiuDfFm2HpJ+QoiqwpR
	GNn/5M2Q7M8r1hM1lQ4HQEdmwnBwFz/K0ZyJJd/Nky9p/TmTpCI/ENpgnFOEyrH6Gzep/J
	gA4vX+4I+WFda+zzNK+bnxfIamPitRc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-mhhb3jULNJW_773ZI2Pg5Q-1; Fri, 13 Sep 2024 07:13:49 -0400
X-MC-Unique: mhhb3jULNJW_773ZI2Pg5Q-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a080ae776eso23131965ab.3
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 04:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726226028; x=1726830828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MASR/9GQZ3+JJGeE8AwFTJhS8+TAiNPcAVjIePuGwyw=;
        b=rNOlOTSBJAdw5mKDXXu7q0RT2M3TeSSwUFX9+1IBtxCBDSlqzO3zd/84IIQdVDIqBq
         Ca7qE+Pu7K7sZhAKt9qVrICUDBecrLJEPNdUYK137+3QDdxnH86AauhXXoqYh2ruq9JK
         s/8bch/7hsZRR0tPluQMtAfZT4KBrYv0QI08t3MpQ3h0Xkgl0Dygt0cZfsDLrBpGmTnG
         ZDz3uCGcV6Pmm0sVSC9lhtiTaZVvAQSibOrcjeaNGhQsDVjuCgfRbWUDfuHJqRRR+70g
         sgIipiO+DCFniewhmRM3z5ZOObbG2tHWu2G+tjXuk+aimNVPoEOqExjF6h7ZSaLWJGVP
         PYfg==
X-Forwarded-Encrypted: i=1; AJvYcCXHS6JhJ4rn/4UTQu2xxcAb77JttYcw0++RbIW/0t8rN7/4PWJ5QimVQWVPlqlGksOzPjnzXg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEM/6Q7L7UVoIaf4R9BmrI5bGSV1NlDxJOUFWCe0q2YvaDb4GE
	L/UyfrCG1dJzC2cbGkjMcfkiRKTT8I5ZRWlGH8iDA8vBCr2C0WtI/dleTR9ZD17zX7VJKvwBpVP
	BTWCrW039hZbw7BGYh6BMSisOQnVeUe/Ja5+ACrOaTZBdsZgmsSF5gur/vty0CQl2KscMGf1ew+
	qRtciNxtkLM8NnQLJi/xJI3vSe971IJWUu
X-Received: by 2002:a92:b706:0:b0:3a0:8c8f:99ec with SMTP id e9e14a558f8ab-3a08c8f9aa5mr8882495ab.13.1726226028403;
        Fri, 13 Sep 2024 04:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsWFNdjlLRYC7/y0fJaPtKleRTR1PQe/Z3y/C8TCNPCol5vlzUbHhhMuwMbrDKD5nzJW0Xw4zuyyUIzT7g0uI=
X-Received: by 2002:a92:b706:0:b0:3a0:8c8f:99ec with SMTP id
 e9e14a558f8ab-3a08c8f9aa5mr8882345ab.13.1726226028010; Fri, 13 Sep 2024
 04:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com> <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
In-Reply-To: <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 19:13:57 +0800
Message-ID: <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240913_041351_473543_6FEA5713 
X-CRM114-Status: GOOD (  29.15  )
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

On Fri, 13 Sept 2024 at 19:07, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 13/09/2024 11:56, Dave Young wrote:
> > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> (cc Dave)
> >
> > Thanks for ccing me.
> >
> >>
> >> Full thread here:
> >> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> >>
> >> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>
> >>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
> >>>>> Does the below help at all?
> >>>>>
> >>>>> --- a/drivers/firmware/efi/tpm.c
> >>>>> +++ b/drivers/firmware/efi/tpm.c
> >>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> >>>>>         }
> >>>>>
> >>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> >>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
> >>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
> >>>>>
> >>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >>>>>                 pr_info("TPM Final Events table not present\n");
> >>>>
> >>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> >>>> which is e820_table_firmware.
> >>>>
> >>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> >>>> its end, just with e820_table_firmware instead of e820_table.
> >>>> i.e. efi_mem_reserve does:
> >>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >>>>         e820__update_table(e820_table);
> >>>>
> >>>> while arch_update_firmware_area does:
> >>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >>>>         e820__update_table(e820_table_firmware);
> >>>>
> >>>
> >>> Shame.
> >>>
> >>> Using efi_mem_reserve() is appropriate here in any case, but I guess
> >>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> >>> table, and 3 (!) versions of the E820 table in the correct way
> >>> (e820_table, e820_table_kexec and e820_table_firmware)
> >>>
> >>> Perhaps we can put this additional logic in x86's implementation of
> >>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> >>> with configuration tables produced by the firmware that may not be
> >>> reserved correctly if kexec looks at e820_table_firmware[] only.
> >>
> >
> > I have not read all the conversations,  let me have a look and response later.
> >
> > The first glance about the patch is that I think the kexec_file_load
> > syscall (default of latest kexec-tools) will not use
> > e820_table_firmware AFAIK.  it will only use e820_table_kexec.
>
> I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap
>
> https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29
>
> which is e820_table_firmware.

That piece of code is only used by kexec_load

>
> The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
> is the right approach to it I believe, and I dont see the issue anymore after applying that patch.
>
> >
> > Usama, can you confirm how you tested this?
> > kexec -c -l  will use kexec_load syscall
>
> I am currently testing in my VM setup with kexec_load. But production is running
> kexec_file_load and has the same issue.

Ok, I mean efi_mem_reserve should be able to work if you retest with
kexec_file_load.

>
> Thanks,
> Usama
>
> > kexec [-s] -l will use kexec_file_load syscall
> >
> > Thanks
> > Dave
> >
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

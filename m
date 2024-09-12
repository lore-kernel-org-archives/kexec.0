Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4D5EED60A
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tbm786VsIGo7Q5yNnEaGYdZyqEONz34GNr2eTqaj6Ss=; b=owGZwWqQ//Un8y
	BAPBUMYvK6ZnspZiMu9oPb8b10xyaLUOKX9m8IizzHnsYM9NiJZKcdZtGRXN/AAs0LoP+RLe/EhzW
	N5+p6cOj1fwpt35m/5xv0M82Q44rRmqFucw5cdM2Qe7FQWNNocDtTy1+RKsdsu6nyeCR4p6xYUMzl
	jETIwdeDTYG7Adl9c3t0V6sGZp2GLDhb8IbiWNwUafbVJB9OnpWad631pPA3VXXx0a51pBP9XGxi5
	L9JUUH3rwep/IVjhVg6TiOaIPXLx1UA9kORevw1EYsy8L46yoCsLKhze7JRwG3eVT0MBAPiK6dzFu
	TXuAbSBaJqFj24qfJzOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokb8-0000000DJka-1AL8;
	Thu, 12 Sep 2024 14:15:02 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokb5-0000000DJj7-1OAj
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 14:15:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 60E40A455D0
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 14:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21834C4CED2
	for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726150497;
	bh=VGZRJzmCN+Wam8xXW+P57As3xaf2eURuf7X7kqSVP/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UCu4fUizGzE/dzDYc6CuCz/qavF3YbiQyMrJzGo/5YZsGrD+qM5sopYjrApGcg/VV
	 es6Dwq7BMu6suX1JkIfpGnAXCt0FU7SW2zkAFHYhhQIDbj5hoGd+TrZ9IsBrHhjKr7
	 +OQ9CieoiZUesGyHUZZwAJucay1togj7ylsiSJMtU4dxEIALi9gPfWxfZWoKGCvHDk
	 ULLDsGQBNtHuNgqct0Gbe8QZTXN6gKWUKrFjP38ezSDlMAQ5I0MGRKdL2+Slt5GI5R
	 UERtzmrTLRPsZK6yvgm3F72GGvERC9s66IR+5AA0p6IYViJuOTa/PRin5wZCk6tCdW
	 Uj2nOqtepDcQw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f75c6ed428so11361241fa.0
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 07:14:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWe7kAvdkFahJX8kL/hhbZC4yLn1LgtDvai3iZL+71Za1n6nRGykbrwGHrSP5oHzo6CkUaKtg==@lists.infradead.org
X-Gm-Message-State: AOJu0YytumY7JaA7IMPTX5Ji3GiAft+PXbuOy4CzLtdATUyl3SdXO2WS
	Wr0ukkkIOd7K1yqbGuDypZ7i/D1zmKlvBO1F9eFLYl/mTHWbBPG94Q9IH5mBujmi11mjbmP3AtB
	j/XrtmLRLRlOX1duVDpDZzGsAZ+o=
X-Google-Smtp-Source: AGHT+IGyYLLbdVpehbHj2Oyt04OkcFENJP/n0YHbA9nWypu5M9+GnU0Kn53CEAQm2eO+JUyPpMVSPBaYRfKVMrIyfhM=
X-Received: by 2002:a2e:a7c1:0:b0:2f7:543a:3b1a with SMTP id
 38308e7fff4ca-2f787d9e337mr19645771fa.7.1726150495442; Thu, 12 Sep 2024
 07:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
In-Reply-To: <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 12 Sep 2024 16:14:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
Message-ID: <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>, Dave Young <dyoung@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_071459_505764_17FDEDBE 
X-CRM114-Status: GOOD (  17.58  )
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

(cc Dave)

Full thread here:
https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u

On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > Does the below help at all?
> > >
> > > --- a/drivers/firmware/efi/tpm.c
> > > +++ b/drivers/firmware/efi/tpm.c
> > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > >         }
> > >
> > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > >
> > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > >                 pr_info("TPM Final Events table not present\n");
> >
> > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > which is e820_table_firmware.
> >
> > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > its end, just with e820_table_firmware instead of e820_table.
> > i.e. efi_mem_reserve does:
> >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >         e820__update_table(e820_table);
> >
> > while arch_update_firmware_area does:
> >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >         e820__update_table(e820_table_firmware);
> >
>
> Shame.
>
> Using efi_mem_reserve() is appropriate here in any case, but I guess
> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> table, and 3 (!) versions of the E820 table in the correct way
> (e820_table, e820_table_kexec and e820_table_firmware)
>
> Perhaps we can put this additional logic in x86's implementation of
> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> with configuration tables produced by the firmware that may not be
> reserved correctly if kexec looks at e820_table_firmware[] only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

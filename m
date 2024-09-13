Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFA7FA3741
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SViE5qXgL5YtL8puGCyv8/n8MM0azwp+1sKZFejxzPs=; b=bObqFa2faUMQkz
	RhHKTj3jkPSulwrJxjm9qrBhAl2YT99Wp+QQJldRMvnCZ4G6ndF0Ho6XVShFQxDMkwpxMHSkaJTmq
	ba+UQIXhcfF4cecTcVGnZ+PbcoOMG0+/KQ0QcmhMpmEDRhMo0lZ9VLc6dpV/LQzu3IJdOr5litOUk
	NuxbEUWkL/jENhm6cI26Jtl98OwSUBjcrqA+3NjHVu5PEf+ywVfCoA1bN36j3XSYeOVsTylhdDlbY
	F64Dx4A2Giq5fX4GtDkQVGSFgpjQeK+mJOXSbeJ9bMh1BePPt1BQt/nSZVwgKDjiCWihByxWJcif+
	dokN5TS19Omc1qmFCIrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp3yf-0000000FgaC-0miq;
	Fri, 13 Sep 2024 10:56:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp3ya-0000000FgZk-104X
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 10:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726224990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yWxKjHuLSpOeE8+M838/N9qMnRp66pdf3mc/hdoDmNs=;
	b=IAIBAm7+Tut3vVSqeO4mq6wYoaAZ1HdwZWgR1BcqKBeGYW3b1OMg04QweKcjDUxyiQmkxe
	RD3mU6mgcfJ2FmWouqLIj2b5Kls1NWvVFklhMU3M/Q/CwOCztxW5Qr+A/mcwNi5J8IcE+l
	PmddLXRb73i2mpMPKSdYyZTVQhboOWI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Esuwy_KsMVib6x4bKNQXvQ-1; Fri, 13 Sep 2024 06:56:28 -0400
X-MC-Unique: Esuwy_KsMVib6x4bKNQXvQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aac437083so83848639f.2
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 03:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726224988; x=1726829788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWxKjHuLSpOeE8+M838/N9qMnRp66pdf3mc/hdoDmNs=;
        b=GyYYN2wneVA/q2mOI6lrA9eWbBNQJMseOgIl0IDRFSeQrQlVJCE1rfIlTQ96xTk3vi
         EGDr8fCZkck8VJfqcYboiSg403dNojbqSZnaIhpTa9M1JzsqBYVSSn27lPZ907H3pCXp
         xBzZwFkCdB1OxqQ1b9WesSCiKVLgF/nW0nmm10fHNVnVSQmOjmsvHI/M9cBtFwkG+pX+
         /9WT4Rm+ROa16KXUqrbTtynsFYNoIz4Os7zoPbcaw+8To6LjWhRLm0RxdeB8L4DrNikj
         p/bPpwTkFDPEhlfjp0P0M2vuazhItytGHUh3XumXLRT5+20L8P/sa13N1e6Nqs6iMEeU
         r8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlnkfuUmUOMKtPnI7o11/LmgBUgUZtO+oCGvFHfuou5X0HVnBCNJQ4H43mIMW3+8fH9K/tYg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzl8bbQSHpFSWkpojg4+U4GZ1uWW7ZG6rzMyQFJI2KwHxo0/kzm
	maGWH0KbraOq3oxOC+rhaza3E3lcBU2al4USfXQquQrmw3LL9rjCMDifLiPU+TZDx/TYvr0H1Xd
	f8Fa/qJ8n3tbD6Ni04V+qKJ2AVlUgpTafEYK9JXuRAhth+5698Fj0a6A71hK7UXvfdfVh7K+qdx
	NIqI11YjQyhEYk/WOabzPP9PgUOhUqGBt7
X-Received: by 2002:a05:6e02:1687:b0:39f:5d96:1fd5 with SMTP id e9e14a558f8ab-3a08b6f702dmr19005425ab.1.1726224987687;
        Fri, 13 Sep 2024 03:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEnk8QLAWeYTIvNhfvQaphtx6UllDLsrJFoYYDRbGC52xjsxLpE/GX1npjxguHhFEzJSjCfjCfRsCQoXQWWVA=
X-Received: by 2002:a05:6e02:1687:b0:39f:5d96:1fd5 with SMTP id
 e9e14a558f8ab-3a08b6f702dmr19005225ab.1.1726224987310; Fri, 13 Sep 2024
 03:56:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
In-Reply-To: <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 18:56:36 +0800
Message-ID: <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240913_035633_740757_D2E81CA0 
X-CRM114-Status: GOOD (  21.22  )
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

On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Dave)

Thanks for ccing me.

>
> Full thread here:
> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
>
> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > >
> > >
> > >
> > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > Does the below help at all?
> > > >
> > > > --- a/drivers/firmware/efi/tpm.c
> > > > +++ b/drivers/firmware/efi/tpm.c
> > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > >         }
> > > >
> > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > >
> > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > >                 pr_info("TPM Final Events table not present\n");
> > >
> > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > which is e820_table_firmware.
> > >
> > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > its end, just with e820_table_firmware instead of e820_table.
> > > i.e. efi_mem_reserve does:
> > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >         e820__update_table(e820_table);
> > >
> > > while arch_update_firmware_area does:
> > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > >         e820__update_table(e820_table_firmware);
> > >
> >
> > Shame.
> >
> > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > table, and 3 (!) versions of the E820 table in the correct way
> > (e820_table, e820_table_kexec and e820_table_firmware)
> >
> > Perhaps we can put this additional logic in x86's implementation of
> > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > with configuration tables produced by the firmware that may not be
> > reserved correctly if kexec looks at e820_table_firmware[] only.
>

I have not read all the conversations,  let me have a look and response later.

The first glance about the patch is that I think the kexec_file_load
syscall (default of latest kexec-tools) will not use
e820_table_firmware AFAIK.  it will only use e820_table_kexec.

Usama, can you confirm how you tested this?
kexec -c -l  will use kexec_load syscall
kexec [-s] -l will use kexec_file_load syscall

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

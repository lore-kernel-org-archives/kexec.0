Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7268E77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 03:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2sjW6rQL9UkpmtFhrA3tkj9VTv1IYCh8YeOqz/0g53s=; b=eHmFfjDoo+EJRXXXguNG/4m0h3
	V0YLp9T7+rJgqB7janhPNej0H8WgMn74TkS2enJ8z2eksofw9SsG8clLhCufMl7wrcrRuKih64ftD
	DAgKaKB9n047WeJ4vNJK/avZjCXoqFleBCQ2TwpeMq5qcEGhJXenufmNPXIwJGP3qpjlx1Y5FJ+Zd
	Ou1rKJYNQcwEqY0VgeMTnxbMOO6HUcrcdb+zg6hBmZj0ptSZX66un3P37OKoeh3i86YiccMfhoSI/
	/MizKkRSW/MMhhb+4s355usfzdzVHkdxVP35zrexvsUxgc/vJJ7X8sDefQzh1FJz4kDDVsrTPbnxN
	PJlWgYyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXY3C-00000007Orx-1OcI;
	Tue, 14 Jan 2025 03:57:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXY38-00000007OqI-1ox6
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 03:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736827024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2sjW6rQL9UkpmtFhrA3tkj9VTv1IYCh8YeOqz/0g53s=;
	b=V8bWrDa+ebmA7fwWOFVmAH7Wp0A6+rhmThcRtk1NV0/rVNjfinslzHzWkPuKowb/GwWeqr
	KyYKj8gPwk2TMM27wiTE/LatsfFpFu/B32nMNTVUoVqSBLz1Hia8a6PEl5QiBMsx3ir4r/
	QFTHphLsONcnPo/xiHRglqiA0qGf6ac=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-LI38CDE2O-22cdTLt1vVxw-1; Mon, 13 Jan 2025 22:57:02 -0500
X-MC-Unique: LI38CDE2O-22cdTLt1vVxw-1
X-Mimecast-MFC-AGG-ID: LI38CDE2O-22cdTLt1vVxw
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81754abb7so94223825ab.2
        for <kexec@lists.infradead.org>; Mon, 13 Jan 2025 19:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736827022; x=1737431822;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sjW6rQL9UkpmtFhrA3tkj9VTv1IYCh8YeOqz/0g53s=;
        b=N2tJnUDP4eYZRbzDnAFHL35aw9UiBtGOK2swl/IzGkYcWQtcEv6GpG+005sejZom7q
         7wd2zx0cMU59atq0KLczzicg+xtGkCvsfqcB3yfIWx3JUpDMBk0hkLNtj52JXgFMjWJZ
         tmkpVO7SalyzZbKI13IakGGFvmBxAbpwEHBITJbc4YOUt+fumCUSntEksBCq+AQyaWYT
         qLuypQR50QTsTSqxdbBRSc6EcWTtGXWewRiCYecTeMMBf7uyn/3/n11GEsPkuspFOOcE
         z3biLCl6ca73/1tgcDKRC0oPJee5G1r3Kt6E8VfTFddUT4sI/G466v46vMQysqXrFkiz
         35FA==
X-Forwarded-Encrypted: i=1; AJvYcCWLk/iKZtei0t7v0iihqMvys3d238IbupFbc/DBXksXYOPJxUknzvh7BM4WxTYnkHlxz4FhQw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/RTj88bbnZWK7xk6nG8oyw2C2CuD+YFKwUr0JKli6THisMVJT
	5pezVJwRwHCC1rb9VUq5beMtBtH9XszOhkwd8gwv5ECOATkjDYmz6OT816obEe9rtOJqMg5L/d7
	YzYyJ2TZNqKwu0EYSN2MzrE3ZfCAKZy/Te7ytsDDydLIy3rnRY2IigQCROLiXVZthFG8dBpgmg1
	4bgNm5LsSU/TEIsuwgkvc81Kz5hCnYRaA3
X-Gm-Gg: ASbGnctk/qkhmqv5Y8Qny1RfzVU/ipbcm/ttnfnfax3uxdylUrktp0ghUGiAAPEE+Tr
	VoqYnIyQmePPhJNmeWEqr3KpudI/qH6MrLx2T2fs=
X-Received: by 2002:a05:6e02:1a6d:b0:3a7:1bfc:97c6 with SMTP id e9e14a558f8ab-3ce3aa725b6mr171663255ab.16.1736827021998;
        Mon, 13 Jan 2025 19:57:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyQgnE+Kpy42bGJSdrK5htQB0OemVkk/Fl4HfxOqQXEP+3uI6Lsb4f2eMVwfiVTGsHOqHqz5OEE5p//BzCvaQ=
X-Received: by 2002:a05:6e02:1a6d:b0:3a7:1bfc:97c6 with SMTP id
 e9e14a558f8ab-3ce3aa725b6mr171663205ab.16.1736827021748; Mon, 13 Jan 2025
 19:57:01 -0800 (PST)
MIME-Version: 1.0
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
 <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com>
 <CALu+AoSKCtU4iGRM8LH6qYbgKvZ79=zfC8kXXb_GJqp=mpEdFg@mail.gmail.com> <DM4PR11MB6020E10A34536D3A3216248CA0182@DM4PR11MB6020.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB6020E10A34536D3A3216248CA0182@DM4PR11MB6020.namprd11.prod.outlook.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 14 Jan 2025 11:57:07 +0800
X-Gm-Features: AbW1kvZNnUK88UOnkQTGou5i4SVtgVWkvz4FaxPms-GfeCRbWRjc28A1ymohPcs
Message-ID: <CALu+AoRtSRfam6D1UP79SBXomNo7TSSZ+raDeuJnMfiZNeBhTQ@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
To: "Chen, Yu C" <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hL7TSTftJWFRlARiGBCnT9-Ztn0p4qf2GjIkjVCClcY_1736827022
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_195706_551966_E3E4CD8B 
X-CRM114-Status: GOOD (  47.06  )
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

Hi,

On Tue, 14 Jan 2025 at 11:26, Chen, Yu C <yu.c.chen@intel.com> wrote:
>
> Hi Dave,
> Thanks for bringing this up,
>
> > -----Original Message-----
> > From: Dave Young <dyoung@redhat.com>
> > Sent: Friday, January 10, 2025 2:30 PM
> > To: Chen, Yu C <yu.c.chen@intel.com>
> > Cc: x86@kernel.org; linux-kernel@vger.kernel.org; kexec@lists.infradead.org;
> > Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>
> > Subject: Re: [PATCH] x86/e820: update code comment about
> > e820_table_kexec
> >
> > > BTW,  the conversation below drived me to read the e820 code:
> > > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-
> > dmLndqqo2AYnH
> > > MRxDz-80w@mail.gmail.com/T/#u
> > >
> > > It could be better to clean up the e820 tables, anyway the comment fix
> > > in this patch itself is good for now.
> > >
> > > Basically e820_table_firmware is used by kexec-tools kexec_load
> > > implementation,  e820_table_kexec is used by kexec_file_load code to
> > > pass to the 2nd kernel in boot params.
> > >
> > > The e820_table_firmware is said to not be modified by the kernel in
> > > the code comment, but this is not true, at least the sev code updates
> > > the table.    The hibernate code generates crc32 checksum and verifies
> > > it, but since AFAIK e820 table update only happens in boot phase, it
> > > will be stable on runtime.  So we can just use e820_table_firmware for
> > > kexec use and drop the e820_table_kexec. With the change the
> > > kexec_file_load and kexec_load see the same memory ranges.
> > >
> > > Otherwise I thought we can use just one e820 table, dropping
> > > e820_table_firmware and e820_table_kexec, but then there will be
> > > fragments and memory waste  due to the setup_data ranges are reserved
> > > and updated in e820_table, so the e820_table_firmware being still be
> > > used for kexec makes sense.
> > >
> > > Anyway I need to think more about it,  please let me know if you have
> > > any concerns.
> >
> > Reread the old commit 12df216c61c89e31e27e74146115a9728880ca6f
> >     x86/boot/e820: Introduce the bootloader provided e820_table_firmware[]
> > table
> >
> > It seems the e820_table_firmware was changed to be exported in sysfs
> > instead of e820_table_kexec,   but I suspect this is wrong.
> > kexec-tools (kexec_load) use the exported sysfs memmap info,  but
> > e820_table_firmware was created by above commit to be used by hibernation
> > and the table should not be changed,  the fact is there are changes happen
> > from time to time.
> >
>
> This is not expected from the original introducing of e820_table_firmware, it
> should not be changed by OS. I suppose the changes to e820_table_firmware
> are because of the kexec requirements for /sys/firmware/memmap?

Yes, I think so at least for the AMD part.  Just maybe nobody noticed
this table is meant to keep not changed.

> Another question is that, why does kexec_load() get the memory layout
> from /sys/firmware/memmap, but  kexec_file_load() relies on the in-kernel
> e820_table_kexec?

I forgot the details, searching the git log, the history is like this:

Originally the table name is e820_table_saved,  both kexec-tools and
kernel kexec_file_load use the data from e820_saved.  Kexec-tools used
it via the sysfs memmap.

Later commit 544a0f47e7803443980496d6c9ae78b6c2b3dbcb changed the
table name to e820_table_firmware, so both kernel and kexec-tools used
e820_table_firmware.

And then the commit a09bae0f8aa08d4d76d0ebece26062a49ec51ac9 changed
the name to e820_table_kexec (kernel kexec_file_load use it) and later
the other commit created a new table e820_table_firmware.

The key here is the kexec-tools usage of sysfs was missed.

>
> > Question is does hibernation use the sysfs entries from its userspace tools?
>
> Hibernation does not use this sysfs entries in  userspace(or uswsusp )as far
> as I know.

Good to know, thanks!

>
> > If yes, then we should have both kexec table and firmware table exported
> > because they are for different purposes and one may change, another not.
> >
> > If hibernation only uses the table within the kernel then it makes no sense to
> > export it to sysfs, we should only export the kexec table for kexec-tools use.
> > In this way  both kexec_load (userspace) and kexec_file_load (kernel load) can
> > use same e820 table, it will reduce the bugs and be easier to maintain.
>
> I'm OK with not exposing e820_table_firmware  to /sys/firmware/memmap, if
> kexec is the only user of /sys/firmware/memmap.

Since ingo was involved in the table changes. Ingo,  any suggestions?

>
> Thanks,
> Chenyu



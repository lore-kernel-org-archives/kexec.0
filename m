Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970C3C0218A
	for <kexec@archiver.kernel.org>; Tue, 28 Jan 2025 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqRegm71YZYEpcZA/qUo3+kvEo3iENPrxp2MEBJLKwM=; b=xiWn9+cKAazB6Um6FTJtBzAVLL
	Xcpb2a/urVaXkXYmErNSq7oK/rhJUc/xnAabLJKKDKz4R/tnBzwPo9tezOETog4wcNQDQvKkjIibz
	A9LMOSxxygwgi2G9J8xBUrSVgaJpHzcww+yMtlrVJnlrnfCvHUGLWLcZfv2m1w2sWDqECu+pD/ejq
	6bfO/9tEbsiI9RwD4kZRTHyh2rnYBXpO8flJGKdf4C2VACatvpTLKWmSwQ0ZvO18Ucw1Tbmr7IqNd
	hCqU1K4ycqMpuKooBOjUr+TDQMIYMxlOmyefS4eDBIHYHeDb0H7QZN5M0E2toAswxJaRVmcRFF6K6
	ugXmbLTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tclwk-00000004zqT-31R7;
	Tue, 28 Jan 2025 13:48:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tclwi-00000004zq6-0GeV
	for kexec@lists.infradead.org;
	Tue, 28 Jan 2025 13:48:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738072081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqRegm71YZYEpcZA/qUo3+kvEo3iENPrxp2MEBJLKwM=;
	b=FI9bWYpoP+CqXTVVLXIFkuRy+3EYC0tbUYOJM9vLh0iHbm8oZaRtPDkPabVltl7ry8+prX
	iYCLOitdSMklYpHgaHkmIfjotLyWx7fhOdjkYdnwwuPQCi5wxemg30CfY/4O82OBz+e+Z5
	Q3pDVVcyQcUBMWt0XuNEmf3YVSLOqaI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-i8O3yzJsPf28vFkM5iU_rA-1; Tue, 28 Jan 2025 08:48:00 -0500
X-MC-Unique: i8O3yzJsPf28vFkM5iU_rA-1
X-Mimecast-MFC-AGG-ID: i8O3yzJsPf28vFkM5iU_rA
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3cffa136ccdso4401545ab.0
        for <kexec@lists.infradead.org>; Tue, 28 Jan 2025 05:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738072079; x=1738676879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqRegm71YZYEpcZA/qUo3+kvEo3iENPrxp2MEBJLKwM=;
        b=hEtBNMHkylmWQkrddkN9wabwGzPk9Nf6z5BQoeUNZdQ2pEnYmNookREgrLi4qWV1dB
         W8WWli9HItHujtj9wmuEOdtK2UDiL76/wug+SbMAi3bT4omr5pitiphTNO8FlWokTzTL
         qDhoMj6Xy1BKarRciWIrnGhxWpb8HcNk7/UOSozUaDVoYmksGG1mrhbnRrhXzb//KsNU
         Hrk68GlGRNJTdY1DQYmMyp3Vjx6rfijQQpK/Poh44dLbJTe3TJbAaMNmyXONPgVJ7vY4
         Y72Z20S+BPIILkV7uUjoBKuwODQVVZf+h+mFsox8n9Ef0c6859M9Z9aMjQ+Op4Ny2+0I
         dE4g==
X-Forwarded-Encrypted: i=1; AJvYcCXkpOZxEountmkXyl2m7N0HbffiFJxB9q/7ZWffxxIwP8xr3oDa50+D1KnhNdBSx5Q0gvd0Pg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxq+e7/FCGHAr73uAdS99MF7gkm/4PHMLoU5F+QrITHpoxZscqU
	xhaFANG9DxyyAZijCV7WYBGBu4vNVuJxPWbCrjs3WUtxygBJ6tmGnq1fj7iIRTc3xHRJDBoznoi
	ZUXx3FswzfvCSlX/iKOaZEGu5ZyetjBp9EJ+5gfkToxuBbYnGF/36tXbPtWsoW+aO0Cnthma4jR
	hx4RUMd070ymdnm2QuGZwAG3F/BsWpRr/b
X-Gm-Gg: ASbGncswOq/Z4TwyWxWAAAjH0KKFIIERdhmvR6BDACZVTDLtjGEkdJCeISpoMu+wqPA
	lZiSjwRGvza7mU+ztf85Eaoe1aQF5DGXBf3sx7pPjdQYbRxBcyacSXPH4nTPod18=
X-Received: by 2002:a92:c248:0:b0:3ce:7cca:7c0d with SMTP id e9e14a558f8ab-3cf74424035mr430327845ab.12.1738072079706;
        Tue, 28 Jan 2025 05:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfziWHfQ28+su+piSBTPIRJePpofC+imm92PAR46wlnk4RKFYzFsYSfa/DPZCiw7oxF6KPNMIMSoFkSjvPqQ0=
X-Received: by 2002:a92:c248:0:b0:3ce:7cca:7c0d with SMTP id
 e9e14a558f8ab-3cf74424035mr430327595ab.12.1738072079442; Tue, 28 Jan 2025
 05:47:59 -0800 (PST)
MIME-Version: 1.0
References: <ZuVxlJ77V2_U0HPM@darkstar.users.ipa.redhat.com>
 <CALu+AoQyGN2m1ss7GSPCn5UqiEWb+M5BK9MStzMn64k83egtQg@mail.gmail.com>
 <CALu+AoSKCtU4iGRM8LH6qYbgKvZ79=zfC8kXXb_GJqp=mpEdFg@mail.gmail.com>
 <DM4PR11MB6020E10A34536D3A3216248CA0182@DM4PR11MB6020.namprd11.prod.outlook.com>
 <CALu+AoRtSRfam6D1UP79SBXomNo7TSSZ+raDeuJnMfiZNeBhTQ@mail.gmail.com>
In-Reply-To: <CALu+AoRtSRfam6D1UP79SBXomNo7TSSZ+raDeuJnMfiZNeBhTQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 28 Jan 2025 21:48:08 +0800
X-Gm-Features: AWEUYZnxh2NiryP1Lm3WOwFsmFcV0acBQXkCW093cyLm0eduEjfetNH5VA8CXwQ
Message-ID: <CALu+AoTdiE7PDGoHtMbYZ4GTwkxR77FJL+BGRO+JE1CQLhs5pA@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: update code comment about e820_table_kexec
To: "Chen, Yu C" <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pfiZJ4HUBLiBRLj7W-IACyMdMIDxG1R5OkLwY18CP4Q_1738072080
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_054804_177593_FE3A3A4C 
X-CRM114-Status: GOOD (  53.26  )
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

On Tue, 14 Jan 2025 at 11:57, Dave Young <dyoung@redhat.com> wrote:
>
> Hi,
>
> On Tue, 14 Jan 2025 at 11:26, Chen, Yu C <yu.c.chen@intel.com> wrote:
> >
> > Hi Dave,
> > Thanks for bringing this up,
> >
> > > -----Original Message-----
> > > From: Dave Young <dyoung@redhat.com>
> > > Sent: Friday, January 10, 2025 2:30 PM
> > > To: Chen, Yu C <yu.c.chen@intel.com>
> > > Cc: x86@kernel.org; linux-kernel@vger.kernel.org; kexec@lists.infradead.org;
> > > Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>
> > > Subject: Re: [PATCH] x86/e820: update code comment about
> > > e820_table_kexec
> > >
> > > > BTW,  the conversation below drived me to read the e820 code:
> > > > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-
> > > dmLndqqo2AYnH
> > > > MRxDz-80w@mail.gmail.com/T/#u
> > > >
> > > > It could be better to clean up the e820 tables, anyway the comment fix
> > > > in this patch itself is good for now.
> > > >
> > > > Basically e820_table_firmware is used by kexec-tools kexec_load
> > > > implementation,  e820_table_kexec is used by kexec_file_load code to
> > > > pass to the 2nd kernel in boot params.
> > > >
> > > > The e820_table_firmware is said to not be modified by the kernel in
> > > > the code comment, but this is not true, at least the sev code updates
> > > > the table.    The hibernate code generates crc32 checksum and verifies
> > > > it, but since AFAIK e820 table update only happens in boot phase, it
> > > > will be stable on runtime.  So we can just use e820_table_firmware for
> > > > kexec use and drop the e820_table_kexec. With the change the
> > > > kexec_file_load and kexec_load see the same memory ranges.
> > > >
> > > > Otherwise I thought we can use just one e820 table, dropping
> > > > e820_table_firmware and e820_table_kexec, but then there will be
> > > > fragments and memory waste  due to the setup_data ranges are reserved
> > > > and updated in e820_table, so the e820_table_firmware being still be
> > > > used for kexec makes sense.
> > > >
> > > > Anyway I need to think more about it,  please let me know if you have
> > > > any concerns.
> > >
> > > Reread the old commit 12df216c61c89e31e27e74146115a9728880ca6f
> > >     x86/boot/e820: Introduce the bootloader provided e820_table_firmware[]
> > > table
> > >
> > > It seems the e820_table_firmware was changed to be exported in sysfs
> > > instead of e820_table_kexec,   but I suspect this is wrong.
> > > kexec-tools (kexec_load) use the exported sysfs memmap info,  but
> > > e820_table_firmware was created by above commit to be used by hibernation
> > > and the table should not be changed,  the fact is there are changes happen
> > > from time to time.
> > >
> >
> > This is not expected from the original introducing of e820_table_firmware, it
> > should not be changed by OS. I suppose the changes to e820_table_firmware
> > are because of the kexec requirements for /sys/firmware/memmap?
>
> Yes, I think so at least for the AMD part.  Just maybe nobody noticed
> this table is meant to keep not changed.
>
> > Another question is that, why does kexec_load() get the memory layout
> > from /sys/firmware/memmap, but  kexec_file_load() relies on the in-kernel
> > e820_table_kexec?
>
> I forgot the details, searching the git log, the history is like this:
>
> Originally the table name is e820_table_saved,  both kexec-tools and
> kernel kexec_file_load use the data from e820_saved.  Kexec-tools used
> it via the sysfs memmap.
>
> Later commit 544a0f47e7803443980496d6c9ae78b6c2b3dbcb changed the
> table name to e820_table_firmware, so both kernel and kexec-tools used
> e820_table_firmware.
>
> And then the commit a09bae0f8aa08d4d76d0ebece26062a49ec51ac9 changed
> the name to e820_table_kexec (kernel kexec_file_load use it) and later
> the other commit created a new table e820_table_firmware.
>
> The key here is the kexec-tools usage of sysfs was missed.
>
> >
> > > Question is does hibernation use the sysfs entries from its userspace tools?
> >
> > Hibernation does not use this sysfs entries in  userspace(or uswsusp )as far
> > as I know.
>
> Good to know, thanks!
>
> >
> > > If yes, then we should have both kexec table and firmware table exported
> > > because they are for different purposes and one may change, another not.
> > >
> > > If hibernation only uses the table within the kernel then it makes no sense to
> > > export it to sysfs, we should only export the kexec table for kexec-tools use.
> > > In this way  both kexec_load (userspace) and kexec_file_load (kernel load) can
> > > use same e820 table, it will reduce the bugs and be easier to maintain.
> >
> > I'm OK with not exposing e820_table_firmware  to /sys/firmware/memmap, if
> > kexec is the only user of /sys/firmware/memmap.
>
> Since ingo was involved in the table changes. Ingo,  any suggestions?
>

Hi all, I just posted another patch to export kexec tables instead and
included the comments update, please have a look.

Thanks
Dave



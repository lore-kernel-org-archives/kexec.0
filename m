Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CB7C47DD9
	for <kexec@archiver.kernel.org>; Fri, 22 Mar 2024 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rDb+po9Y8SIUngbnGM268dJgpkuMyXZfJEtTXeLUee8=; b=Ecps8jOOy6EPQk
	mDta0+auTuZFjq8wUSJPVAtkjHNnbRmEpRBBAY9yKWDf1sMH9dFE6BGJtEM2Nub5wcyBDFMcf/nsn
	773Bhv785DlY46ICR4qoecvUR/jsnySy7ULTInAG+LEBR5rrD6nta2WcA9YXHvMWuLSAuUD/Q9NBg
	FCzwn1oiHEx5BAqgWjOpB5ETM5XeU4wiIC94y8YxhKqwmnvWH/L+Ga06TjSBCUFYaC+wGmOPY6EC5
	amF0UYZ0yQNK07rTBFzUrdhLtgpCHTNCdS0kByLucWH8sdAtYq61BAXVS5FSwJ7LvZdDw2fPaVcPf
	8PT0Q7BuZLKsHBShzzKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnUT6-00000005VXX-3bay;
	Fri, 22 Mar 2024 02:17:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnUT4-00000005VWK-2BDf
	for kexec@lists.infradead.org;
	Fri, 22 Mar 2024 02:17:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711073831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MNgO21cK7btQLoesiqjurVas6kvko8W7lGGjCXh1DPY=;
	b=bjHlDnUL1LC2SH0WTx4RkIFDcRikBflKK7RBGJzwJNgU1CW13JmZWGzr3Rle41N8oHUaV1
	ymSwFwv6vf4qjm9zvr2a4ygYgm1XRsY6USJnKW8mqQHBq/SqkZRdmqkJH5P0jzp5kqjwkU
	Dj8yRdasyr6KXVYqcBez3ofvRFZpDMg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-2UNIgmpeOG-63toqBNErUQ-1; Thu, 21 Mar 2024 22:17:09 -0400
X-MC-Unique: 2UNIgmpeOG-63toqBNErUQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36873309ab1so1915ab.1
        for <kexec@lists.infradead.org>; Thu, 21 Mar 2024 19:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711073829; x=1711678629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MNgO21cK7btQLoesiqjurVas6kvko8W7lGGjCXh1DPY=;
        b=XMEAx08HHnPJZf1HKS/p1huvv1G2KCvPee+ZG0nXhASwq97Rr9CfYG1UPh/6i4dtMs
         prlxckNweJEhNZ0yKxrVYW+n8PW2F/CyLeKntye/m/aZK7+ckTwZ+t+ypGTfP1um1yck
         D5JIM7A1OJLGDgvUPQwWn+12SNo3sH3ocLqnJRXmnCVz6iiYbUPbysrO7c8vQVjbfcj7
         hNJczKq/JGHM4bHP5Lre8yHqDG27pwlFUuPN4se1vOzifwg9s8PYWL//RsZIkTVo9AyC
         Vsa9AO9yxZvue7qbaz4o8DhHa1W7pke+f4sdcXyx0HbpBqEpKeCiqLPDeEp6Z4kUQADs
         LmCw==
X-Forwarded-Encrypted: i=1; AJvYcCXNAZad9tHF+JU2uiKYPlr0tz3WP0pHGjoG5/VUBXNy1RT5u7fEBWbXIbLXZat6UvysZNhI2iaJYMHOSmWZmYrCA4TlqQH3RHRh
X-Gm-Message-State: AOJu0YwqrZ0HhYtyq5ixguglQLlFRhCGPVo4Kd9CVAkPhuGmm0l0f+It
	5xAC96Ysk2yUSg64xqn014y5kJlSsnp19zgbij9xzTVIGoDs1t0LY0hnUobjCc0Pa4rHXVom5x2
	tWpU5NEpTOwLksMTbZAKUDJPy3fZvtJcLPiWfLvabePTdybeNQjQ6h11t/+AF0nzX616FIEWqeh
	FY7XkDBFredwKYAhb9F9WXrkyqpVDE184I
X-Received: by 2002:a05:6e02:60a:b0:366:b533:cef1 with SMTP id t10-20020a056e02060a00b00366b533cef1mr1241302ils.1.1711073828744;
        Thu, 21 Mar 2024 19:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfAUv9CbsYT6rba0olU8YsLcYCsd+s9n6n8+9mllRpKdxyde3A9FklpPaV/NC29Hkk7aTJUhio/6Yy0QrvU3E=
X-Received: by 2002:a05:6e02:60a:b0:366:b533:cef1 with SMTP id
 t10-20020a056e02060a00b00366b533cef1mr1241287ils.1.1711073828471; Thu, 21 Mar
 2024 19:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com> <ZfwMribQCTKWSO9l@dwarf.suse.cz>
In-Reply-To: <ZfwMribQCTKWSO9l@dwarf.suse.cz>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Mar 2024 10:17:19 +0800
Message-ID: <CALu+AoT2jYfVTFpVvUJv5T+OdSAQzYw0kn74EighK5-4A3O16w@mail.gmail.com>
Subject: Re: [PATCH V2] x86/kexec: do not update E820 kexec table for setup_data
To: Jiri Bohac <jbohac@suse.cz>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Baoquan He <bhe@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	"Huang, Kai" <kai.huang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_191714_665665_40018D65 
X-CRM114-Status: GOOD (  38.09  )
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

Hi Jiri,

On Thu, 21 Mar 2024 at 18:32, Jiri Bohac <jbohac@suse.cz> wrote:
>
> Hi,
>
> On Thu, Mar 21, 2024 at 05:23:20PM +0800, Dave Young wrote:
> > crashkernel reservation failed on a Thinkpad t440s laptop recently.
> > Actually the memblock reservation succeeded, but later insert_resource()
> > failed.
> >
> > Test steps:
> > kexec load -> /* make sure add crashkernel param eg. crashkernel=160M */
> >     kexec reboot ->
> >         dmesg|grep "crashkernel reserved";
> >             crashkernel memory range like below reserved successfully:
> >             0x00000000d0000000 - 0x00000000da000000
> >         But no such "Crash kernel" region in /proc/iomem
> >
> > The background story is like below:
> >
> > Currently E820 code reserves setup_data regions for both the current
> > kernel and the kexec kernel, and it inserts them into the resources list.
> > Before the kexec kernel reboots nobody passes the old setup_data, and
> > kexec only passes fresh SETUP_EFI and SETUP_IMA if needed.  Thus the old
> > setup data memory is not used at all.
> >
> > Due to old kernel updates the kexec e820 table as well so kexec kernel
> > sees them as E820_TYPE_RESERVED_KERN regions, and later the old setup_data
> > regions are inserted into resources list in the kexec kernel by
> > e820__reserve_resources().
> >
> > Note, due to no setup_data is passed in for those old regions they are not
> > early reserved (by function early_reserve_memory), and the crashkernel
> > memblock reservation will just treat them as usable memory and it could
> > reserve the crashkernel region which overlaps with the old setup_data
> > regions. And just like the bug I noticed here, kdump insert_resource
> > failed because e820__reserve_resources has added the overlapped chunks
> > in /proc/iomem already.
>
> wouldn't this be caused by
> 4a693ce65b186fddc1a73621bd6f941e6e3eca21 ("kdump: defer the
> insertion of crashkernel resources")?
>
> Before that the crashkernel resources were inserted from
> arch_reserve_crashkernel() which is called before
> e820__reserve_resources().

I think reverting the commit you mentioned can paper out this issue
but it is not
the root cause.  Yes, arch_reserve_crashkernel can succeed, then e820
still tries
to reserve the setup_data overlapping with crashkernel for another purpose.

>
> The semantics of E820_TYPE_RESERVED_KERN wrt kexec quite
> inconsistent. It's treated as E820_TYPE_RAM by
> e820__memblock_setup() and e820_type_to_iomem_type().
>
> The problem we're seeing here is the result of the former.
> e820__memblock_setup() will add the E820_TYPE_RESERVED_KERN
> region to the memblock, merging with the neighbouring memblocks,
> allowing crashkernel region to span across the originally
> reserved area.
>
> e820_type_to_iomem_type() treating E820_TYPE_RESERVED_KERN as
> E820_TYPE_RAM will make the E820_TYPE_RESERVED_KERN appear as
> system ram in /proc/iomem. If the old kexec_load (not
> kexec_file_load) syscall is used, the userspace kexec utility
> will construct the e820 table based on the contents of
> /proc/iomem and the kexec kernel will see the
> E820_TYPE_RESERVED_KERN range as E820_TYPE_RAM.  When
> kexec_file_load is used the E820_TYPE_RESERVED_KERN type is
> propagated to the kexec kernel by bzImage64_load() /
> setup_e820_entries().

This is true, but it does not matter for the kexec kernel as they are
only reserved for
the 1st kernel, and it is not meaningful to the kexec kernel.  Use
them as system ram
is fine in the 2nd kexec kernel.

>
>
> > Index: linux/arch/x86/kernel/e820.c
> > ===================================================================
> > --- linux.orig/arch/x86/kernel/e820.c
> > +++ linux/arch/x86/kernel/e820.c
> > @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
> >               pa_next = data->next;
> >
> >               e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -
> > -             /*
> > -              * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> > -              * to be reserved.
> > -              */
> > -             if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> > -                     e820__range_update_kexec(pa_data,
> > -                                              sizeof(*data) + data->len,
> > -                                              E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> > -
>
> Your tree is missing this recent commit:
> 7fd817c906503b6813ea3b41f5fdf4192449a707 ("x86/e820: Don't
> reserve SETUP_RNG_SEED in e820").
>
> Wouldn't this fix [/paper over] your problem as well? I.e., isn't
> SETUP_RNG_SEED the setup_data item that's causing your problem?

Thanks for catching this, I will rebase and repost.

But it does not "fix" the problem as my problem is related to the
other setup_data
range, I think it is SETUP_PCI (not 100% sure, but it is certainly not RNG_SEED)

>
> Regards,
>
> --
> Jiri Bohac <jbohac@suse.cz>
> SUSE Labs, Prague, Czechia
>
>
Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

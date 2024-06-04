Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBA8C25B78
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xpmlVc+hylG3c+cW6DggcatGCg0vddDfdN8VCNfpZiU=; b=eZW0Yi2hgMKTPC
	cu1bmQCXWb6v0NXI1KEn79Ups7GhyhgkyMmAv5faVLBvDUY8YaV/5iVbAgJwN0sV+g9LuJzBEArji
	ynLThAA09LFIhQh6N4GEH5rrTwHdqGPBskMTAH5IjNnpVeyA1bzPZYJ8l77vWrUen8fn6qkr9g7tl
	F6f0qs2eocc7ur2gzUubHnPBvnEHvi4bR2U4LFGj30yeQlJN8F+q4WGBw2kpz8JF72wCdsIqR+xlF
	fFYTed5VXwelgZ6KfLArAIXJVSFVyMevbHTEWcoFxuIpvl3lygnrqvkwn3/Lv44HKQ8cwTlSw6fyY
	N3pkPnTEV+5kMuWxviZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sES2z-000000025nB-2Vfo;
	Tue, 04 Jun 2024 11:09:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sES2x-000000025mP-2m5C
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 11:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717499382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g1CYcVwVGdFbPFSwugJtb1aKEbbUUrRo/R593DHF02Q=;
	b=GnN7QcixDSI6aZ7wbjCtOL4S9AnM/K0N4lwt5mwkWhBGDpcTtFr6x3ZJEDFX4giyhGBp96
	6/NYCoqsCW2gXNFya+5km/Q1Bui/6k43bb6p+kQ8LTbM0wHW08mjhaJkFby2zK+Ro0hU3w
	SkfJOioNVjuk+g1JUpTQS39v5nslWhM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-OwJMhXK1NzulBSa1cXwd1w-1; Tue, 04 Jun 2024 07:09:41 -0400
X-MC-Unique: OwJMhXK1NzulBSa1cXwd1w-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-374a8187062so1815975ab.2
        for <kexec@lists.infradead.org>; Tue, 04 Jun 2024 04:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499380; x=1718104180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1CYcVwVGdFbPFSwugJtb1aKEbbUUrRo/R593DHF02Q=;
        b=fkKkgB2eitfxN+AooNNDk2yFWq1PE9q5Lm3eD1w08advq/H6hJ9C/30GE4WEMuiDE+
         F1IrZnJgfe5ClidV2o4PtnYEvhUKI4nRhXdd3/aL1m2uLDlZIM6XEFPVVBJTrOBkxN8D
         QF75UJgxwFtXDC7avfyoE7il4HTKmmFgdwqGOmy+arB4IvRgnklZMelZMyvxYwHYnIFQ
         frNq0CXprRAdUW7WhlZYSEnd32cfuuJyjspplUHldzeLsVIfkY3R4WBaIWnfAq9fHDGu
         95DGPeSgFL4e0HN4hOjyl9REUbqOZspB7cukT0V73T0XHmS8RA7nHYjOYuLS5yVKs2li
         gEuA==
X-Forwarded-Encrypted: i=1; AJvYcCX5cwuiBd82B4fPr302SUMe9sTmIIH4hZcx3lnNe+9MWBuLZqODwdnsyQGvmlr1JTWkjhGT8tP785pFEbntg0ByFgdyktFyW7BM
X-Gm-Message-State: AOJu0YyTdqPy4eaHwSo1n/QD8ylyTXqdpCVjGhvfETa4LQJQ6QvYRP4X
	RuJ3BJD0+w/QKEr6Z2X//WLlY+a/kI5CZLNDt0kSOGDCNAKfovDPtwl694nr1Sw3uo7CegWWarj
	ASivO4srxfzL/od9vJmb4XP42PscqShGtfzaPGKIXXoL2XDVCW5vy9fX8Tre2NBoB+Lw+lPx47k
	7nbjwpxr3rR4MuMxrMwYQcEEumh9jln86d
X-Received: by 2002:a05:6e02:1e08:b0:374:85bb:7592 with SMTP id e9e14a558f8ab-3748b8f5126mr139248275ab.0.1717499380484;
        Tue, 04 Jun 2024 04:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFst0U81Ttgn3X/ZFD/HP/TlZoB/pgBQKLugq4Ox4uYNFUHLID+6ovlnSkl6nuMD6Uc/ffi7a31slBzFXhlhUw=
X-Received: by 2002:a05:6e02:1e08:b0:374:85bb:7592 with SMTP id
 e9e14a558f8ab-3748b8f5126mr139247745ab.0.1717499379997; Tue, 04 Jun 2024
 04:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com> <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com> <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
In-Reply-To: <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 4 Jun 2024 19:09:56 +0800
Message-ID: <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_040943_798307_ADA87C11 
X-CRM114-Status: GOOD (  15.92  )
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

On Tue, 4 Jun 2024 at 17:44, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 04, 2024 at 09:23:58AM +0800, Dave Young wrote:
> > kexec_in_progress is only for checking if this is in a reboot (kexec) code path.
> > But eif_mem_reserve is only called during the boot time so checking
> > kexec_in_progress is meaningless here.
> > current_kernel_is_booted_via_kexec != is_rebooting_with_kexec
>
> That's exactly what I wanna check: whether this is a kexec-ed kernel. Or
> is there a better helper for that?

No general way to check if it is a kexec-ed kernel or not,  for x86
one can check the efi_setup as Ashish's original patch did, as the
kexec booted kernel (efi boot) will have efi setup_data passed in.

Otherwise there is a type_of_loader field for x86 boot protocol,
kexec-tools is 0x0D, the kexec_file_load also uses this.  But adding
the type_of_loader was only added in kexec-tools code when Yinghai
worked on the kexec-tools bzImage64 load, so older kexec-tools will
not set this field.  Anyway the in-kernel kexec_file_load code for x86
added 0x0D as loader type from the beginning.

Anyway there is not such a helper for all cases.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB0C25B78
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 01:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S0zZuWTuLdnjY6pijfcVdoR+7ZwrECqC6H1J3iIC09c=; b=GFM4VHdbvep/Nb
	eohFV8ai5qv5OaR26uGK0dZ4LqxU36Ta23OsTpUC9ikzjh/RCg7tR9SfJPdLveBLajKD1GU3hofdu
	5P+giA+IeH5+MPltAS99/t/zu6WDhjzsKlzZKCUNcKH6vUWsBzXxGi+Fa2xeJToXElrZh2vOeO7uY
	uDSedMeiZHMq3/nOgz8OLYmBqN85Vl4W3u6jfR2IelYgw8MqjTH4b015BCclTxgKGhYoMrsYuDDYG
	Mdu5KLjCKVeERXSbtgOtT/esk0Z/TKgFheuiXDzqyP1RrzJnSFQROahUfg1tDUvfarEfxdOhSBG4c
	m78na0A8A1eBNE2GOgiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEfoj-00000004PLh-3oHv;
	Wed, 05 Jun 2024 01:51:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEfog-00000004PKl-2LeM
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 01:51:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717552312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upN2cK+0+gJo/KqGs9LW3KxpT5YmqhfYJXwjAOS8ygY=;
	b=a+Lcyx/I2P8p74c2D9o7b82KEv5XBRDqn2zMo8IkgjS1aYACQA+xPokIsRnN8Ccvo7/4Eq
	B7/u8+02ZKGacUCkCGucznqtZAmrCD5Dn+GREQg559oz3WmXVgMPwxCeEDMkwLNSEBOUuB
	AbVJNVgEggj3UsoffVGTzHhXwMLXXqo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ixtL-AvfNi-_5_sh9718MA-1; Tue, 04 Jun 2024 21:51:51 -0400
X-MC-Unique: ixtL-AvfNi-_5_sh9718MA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374ae11e9deso2558655ab.1
        for <kexec@lists.infradead.org>; Tue, 04 Jun 2024 18:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717552310; x=1718157110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upN2cK+0+gJo/KqGs9LW3KxpT5YmqhfYJXwjAOS8ygY=;
        b=JS/Ier/lgj/mHQQGT8wiF36PF2LV5w6rcfz5lpD8tcxAMzNiIkP+uXjQInU8yRzwNq
         sxnQipKdmB1jbBRIuxcowm72GLW3KkBx5zyE3JOop+7lyQR0c1ZNl/KCUQ8wg5TMW1VG
         55Zyr39gbvCuSS+AqptSRxAWluHWyGork/vsv+ogeaMn2KBaVRnU146C0LNlbuGSS3pZ
         qPDIdV/394UOE+YyCpkZIrQsXvqlzUy5WCRFgYDvVxTrHO88U3QqGcPob7of9nsmZ8D3
         VueGT0KQ8ukvXEEkurDphIn1sSTWuwoPaXCj4s6RWdOsA5xDe6RkNhbxmxGRq/U5Clwv
         WR+g==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0d15HVEX6wM8hmiRTvpuGbmgMFFiMgi1k+I5VQ7J707PTaXZIgAIk5pOA0F0jA31zdl4IZXud/beZyqfdMN84g7T5KKiiT6t
X-Gm-Message-State: AOJu0YxcrrSw1wtPMIGkKl6rO7RYfww80jEBECCqMtmt91783IKzzb48
	bLcqLDX9/bK0xOZUUBJwSh2BDR6nrhF8ydDlin2usgqKZN92k7+euCsMJm/BaboXHpA0S0t8v+W
	JNmi9uvpCX2RCro+xuXG+HeHSEBzpk829zJLqK529Zmw7YEUC0ZpaU+tUJla+6N101jUgskyEzz
	uM8ASYqwVGgtrPOxb2Z0qDelXdsp/BZO/b
X-Received: by 2002:a92:cda2:0:b0:374:aedb:1607 with SMTP id e9e14a558f8ab-374b1e108e4mr11917235ab.0.1717552310603;
        Tue, 04 Jun 2024 18:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoAvumzWTEo5FkJ6C3OMbCpE5l3j5iU8XrNVp3YfRyiPEFNZA2Dhz1INdK+vIULCPwAJeNIpjtYyclX4eHIb4=
X-Received: by 2002:a92:cda2:0:b0:374:aedb:1607 with SMTP id
 e9e14a558f8ab-374b1e108e4mr11916935ab.0.1717552310203; Tue, 04 Jun 2024
 18:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com> <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com> <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com> <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
In-Reply-To: <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 09:52:09 +0800
Message-ID: <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dan.j.williams@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_185154_696427_BD7C446D 
X-CRM114-Status: GOOD (  10.00  )
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

> >         ...
> >         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
> >                 __efi_memmap_free(efi.memmap.phys_map,
> >                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
> >         }
>
> From your debugging the memmap should not be freed.  This piece of
> code was added in below commit,  added Dan Williams in cc list:
> commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Mon Jan 13 18:22:44 2020 +0100
>
>     efi: Fix efi_memmap_alloc() leaks
>
>     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
>     updated and replaced multiple times. When that happens a previous
>     dynamically allocated efi memory map can be garbage collected. Use the
>     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
>     allocated memory map is being replaced.
>

Dan, probably those regions should be freed only for "fake" memmap?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

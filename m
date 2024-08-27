Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BF2C52D6F
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 05:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0mBrsLcWzu+Zw2GZ60V7lLNBwH1lQpBu98Zr0hXLuHY=; b=rRtVHBSJvWVIPv
	c2MtXBoI5flGJnCyeWUsxRmen6tQ9xG9VV483gGMzWN4ytYWFES5NaCT633qo/GeCTccc476MxWqS
	XP9PYnS8PwnEr7U8/718MGgNzBJ0RFnhaCjHWFPa+8RCAC7aTrO+WxcPkmXp8u7aIC9+r+b0vxMR6
	epnwvJDaoWgHew8hc5yWdIO1A16HTGUvce6FhXZYYFe+ygFqM6DlVStjfglz8VxbCJZCKIGu2Mecn
	P4+DdQ/NgqkKGK2HtI2WngYB9CK0R2TBUp8ANB2S5U2tkaKAaxzZ0CT6sihQn8hdtuYia/3VMQHA/
	92sFbaGtOFVIWzODm+tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioxH-00000009tzu-16za;
	Tue, 27 Aug 2024 05:41:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioxE-00000009tzR-1YHe
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 05:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724737278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn4U33JvNoYJqKolndcGDNCaDrh5eC3o9PZWlH7K3zU=;
	b=bh/CxqCTkNrEa2r1nK9CiNq0vHEtmn9eJp6njTbe0g4LXxH1eFxDER1ROyLEZ3LSGye7BF
	65yPc1wlwY5nkC7OtIJ4KFMraS8w1i7PXy3r68aQekHBrNwGPpzqwrYVDUmJ2Vae2VEvAG
	VXvBPfs88RrWJlDJqQBwBN5aBymTaDk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-QJ8uspWiMrWhnbgG3ERaZw-1; Tue, 27 Aug 2024 01:41:16 -0400
X-MC-Unique: QJ8uspWiMrWhnbgG3ERaZw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d2dee9722so63508385ab.0
        for <kexec@lists.infradead.org>; Mon, 26 Aug 2024 22:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724737276; x=1725342076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qn4U33JvNoYJqKolndcGDNCaDrh5eC3o9PZWlH7K3zU=;
        b=c3rf+tCFBFFIgImMJ13CC2at6dao4ubBQxuJ9YqbQNO9fr/7njRFgBOPmrxx6VtHQA
         ZlLmR9ukcuojONgef0dCkXOSAeuuqo0Mcc9JIIA3AzqR1mHIU+LoObIzXL0jLB89d/AU
         lFFI3XYgomfwBmcmDRbmmxEPLse/MHfawXPzuU35ifdU3Ug6tTIRtOPQM5igvcS8Npcm
         eUEpnLIpLUx3DIkU8xi2NFersJXxk1Y27Ac+cJVNjDHcqNAxooiq+j6ht+CCAtYWYtzN
         N0QgoQejokXSgEc+hX118BWGACZY2yGJ1SW6fu9n88hXfpL1WbCLaJyD7rtJuxmskmM8
         PVhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0LP04Eg/0bjWR3MNlTl+ilpe22mLCzuqX//9ivVUHFxrkBhtPjtupDwNTq7HN7MHFOHlhqg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCykhg5zLKeaYyReVftKgBkJ4Lm0t/Xbu622apiuF7QHWvvcoi
	w49eNxzF/603bs4QMtqrAs84KUZ+3fIDxi9504HT+kI5quTOOxJEStSEwSVu2dALMyfvumDqG5S
	xU09R5LTPePklyBzyShfXD7tqtU4lnzpaFNz37/gDQ2uHhvg45Svc3Kb0Chp6BeIXwjw4bmcbwa
	gJKOgD7Mg9AZAgNg4Sjn6Yaz8Dbtjtzb6/
X-Received: by 2002:a05:6e02:170b:b0:39d:254c:ecd2 with SMTP id e9e14a558f8ab-39e3c9c2ab9mr137161985ab.19.1724737275705;
        Mon, 26 Aug 2024 22:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDp/ADhuerjiX7GDmxB19H6YBYr/C7zDHsCGeNpRcEjxIHbYd2iFKRU+5veBOpvt4gknCxEKkyaZTD6rzaCM8=
X-Received: by 2002:a05:6e02:170b:b0:39d:254c:ecd2 with SMTP id
 e9e14a558f8ab-39e3c9c2ab9mr137161895ab.19.1724737275293; Mon, 26 Aug 2024
 22:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240826024457.22423-1-bhe@redhat.com> <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
In-Reply-To: <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 27 Aug 2024 13:41:25 +0800
Message-ID: <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
To: Baoquan He <bhe@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org, noodles@fb.com, 
	x86@kernel.org, lijiang@redhat.com, kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_224120_510610_2F2EEB68 
X-CRM114-Status: GOOD (  39.81  )
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

On Tue, 27 Aug 2024 at 13:28, Baoquan He <bhe@redhat.com> wrote:
>
> On 08/26/24 at 09:24am, Tom Lendacky wrote:
> > On 8/25/24 21:44, Baoquan He wrote:
> > > Recently, it's reported that kdump kernel is broken during bootup on
> > > SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> > > can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> > > IMA measurement log on kexec"). Just nobody ever tested it on SME
> > > system when enabling CONFIG_IMA_KEXEC.
> > >
> > > --------------------------------------------------
> > >  ima: No TPM chip found, activating TPM-bypass!
> > >  Loading compiled-in module X.509 certificates
> > >  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
> > >  ima: Allocated hash algorithm: sha256
> > >  Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
> > >  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
> > >  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
> > >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> > >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> > >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> > >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> > >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> > >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> > >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> > >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> > >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> > >  Call Trace:
> > >   <TASK>
> > >   ? show_trace_log_lvl+0x1b0/0x2f0
> > >   ? show_trace_log_lvl+0x1b0/0x2f0
> > >   ? ima_load_kexec_buffer+0x6e/0xf0
> > >   ? __die_body.cold+0x8/0x12
> > >   ? die_addr+0x3c/0x60
> > >   ? exc_general_protection+0x178/0x410
> > >   ? asm_exc_general_protection+0x26/0x30
> > >   ? ima_restore_measurement_list+0xdc/0x420
> > >   ? vprintk_emit+0x1f0/0x270
> > >   ? ima_load_kexec_buffer+0x6e/0xf0
> > >   ima_load_kexec_buffer+0x6e/0xf0
> > >   ima_init+0x52/0xb0
> > >   ? __pfx_init_ima+0x10/0x10
> > >   init_ima+0x26/0xc0
> > >   ? __pfx_init_ima+0x10/0x10
> > >   do_one_initcall+0x5b/0x300
> > >   do_initcalls+0xdf/0x100
> > >   ? __pfx_kernel_init+0x10/0x10
> > >   kernel_init_freeable+0x147/0x1a0
> > >   kernel_init+0x1a/0x140
> > >   ret_from_fork+0x34/0x50
> > >   ? __pfx_kernel_init+0x10/0x10
> > >   ret_from_fork_asm+0x1a/0x30
> > >   </TASK>
> > >  Modules linked in:
> > >  ---[ end trace 0000000000000000 ]---
> > >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> > >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> > >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> > >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> > >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> > >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> > >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> > >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> > >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> > >  Kernel panic - not syncing: Fatal exception
> > >  Kernel Offset: disabled
> > >  Rebooting in 10 seconds..
> > >
> > > From debugging printing, the stored addr and size of ima_kexec buffer
> > > are not decrypted correctly like:
> > >  ------
> > >  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
> > >  ------
> > >
> > > There are three pieces of setup_data info passed to kexec/kdump kernel:
> > > SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED. However, among them, only
> > > ima_kexec buffer suffered from the incorrect decryption. After
> > > debugging, it's because of the code bug in early_memremap_is_setup_data()
> > > where checking the embedded content inside setup_data takes wrong range
> > > calculation.
> > >
> > > The length of efi data, rng_seed and ima_kexec are 0x70, 0x20, 0x10,
> > > and the length of setup_data is 0x10. When checking if data is inside
> > > the embedded conent of setup_data, the starting address of efi data and
> > > rng_seed happened to land in the wrong calculated range. While the
> > > ima_kexec's starting address unluckily doesn't pass the checking, then
> > > error occurred.
> > >
> > > Here fix the code bug to make kexec/kdump kernel boot up successfully.
> > >
> > > Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
> >
> > The check that was modified was added by:
> >       b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> >
> > The SETUP_INDIRECT patches seem to be the issue here.
> >
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >  arch/x86/mm/ioremap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > > index aa7d279321ea..7953c4a1d28d 100644
> > > --- a/arch/x86/mm/ioremap.c
> > > +++ b/arch/x86/mm/ioremap.c
> > > @@ -717,7 +717,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> > >             paddr_next = data->next;
> > >             len = data->len;
> > >
> > > -           if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> > > +           if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {
> >
> > I don't think this is correct. You are adding the requested size to the
> > length of the setup data element. The length is the true length of the
> > setup data and should not be increased.
>
> I talked to Dave, he reminded me that people could mix the passed in
> parameter 'size' and the local variable 'size' defined inside the while
> loop, not sure which 'size' you are referring to.
>
Baoquan, you are right, but I think I mistakenly read the code in
memremap_is_setup_data instead of early_memremap_is_setup_data.  You
can check the memremap_is_setup_data, no "size = sizeof (*data)",  so
these two functions could both need fixes.

Otherwise it would be better to change the function internal variable
name, it could cause confusion even if the actual result is correct.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

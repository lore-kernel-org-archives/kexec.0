Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6C7C52D6F
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 05:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7f9o5inTSE9ubu3bmNfF6L28LoOBhw4dIqSwdLn1uP8=; b=1Z26OmIcgNiZld
	8PNRRKQp0qeEsNrVnNCAalPrw2R0mxsa9UQ/TMjZ8hCCNVpSc2QSpxN0SCn/laxVDEAz8x3HNqA8g
	lDtxSg9PMYNVRYyuide/2kwQq/DxocW/cJxvW9ce9bpkAWkRDirKaxGCRuOWXfEb+1hEcegYTiTzL
	GWIVbxyn4bKMpu9VxxFu1gh+5uXVicQToL6SUKH/DBhRXCN5pW+g8lmzLQMB5d6rykOjpRO7Jw8S1
	63jnmRz3ibEjO7eJbrpEr2ub+DVyaQDu1/P85jEDAQYvaNIMIlVRrYmzg3P1lkOeW6cQ6vMf/SSBm
	runDGpfuCNzmjWXbCv4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siokY-00000009s36-1iD6;
	Tue, 27 Aug 2024 05:28:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siokV-00000009s20-0i4Z
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 05:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724736489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jS5i6mmipU7s9b5hzUepGHutOQBMw/QSW8og5ybiqVY=;
	b=MxnnOAHRY2FyIwn7dyxggICo4OcMBWj4TWlB/PQ6mvignt/XXZvM3mtEP1ITO7aMh88wc1
	Ffe1I7V565JtFjEPofdbunUlY3qVjys9pyr/b5xp4BnzEEr4y5qA6o1bNON+LZ9viIqySd
	6QX5oRTD7nBsl7TyfCf6nlgGCQvBc5Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-NIsIHW4APgq6ZouE2ZqIIw-1; Tue,
 27 Aug 2024 01:28:07 -0400
X-MC-Unique: NIsIHW4APgq6ZouE2ZqIIw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBAC41955F65;
	Tue, 27 Aug 2024 05:28:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17F493001FE5;
	Tue, 27 Aug 2024 05:28:03 +0000 (UTC)
Date: Tue, 27 Aug 2024 13:27:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, noodles@fb.com, x86@kernel.org,
	lijiang@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Message-ID: <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_222811_307333_9A7600EF 
X-CRM114-Status: GOOD (  34.32  )
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

On 08/26/24 at 09:24am, Tom Lendacky wrote:
> On 8/25/24 21:44, Baoquan He wrote:
> > Recently, it's reported that kdump kernel is broken during bootup on
> > SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> > can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> > IMA measurement log on kexec"). Just nobody ever tested it on SME
> > system when enabling CONFIG_IMA_KEXEC.
> > 
> > --------------------------------------------------
> >  ima: No TPM chip found, activating TPM-bypass!
> >  Loading compiled-in module X.509 certificates
> >  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b64700122bb1d6a904b070fef2656'
> >  ima: Allocated hash algorithm: sha256
> >  Oops: general protection fault, probably for non-canonical address 0xcfacfdfe6660003e: 0000 [#1] PREEMPT SMP NOPTI
> >  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
> >  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
> >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> >  Call Trace:
> >   <TASK>
> >   ? show_trace_log_lvl+0x1b0/0x2f0
> >   ? show_trace_log_lvl+0x1b0/0x2f0
> >   ? ima_load_kexec_buffer+0x6e/0xf0
> >   ? __die_body.cold+0x8/0x12
> >   ? die_addr+0x3c/0x60
> >   ? exc_general_protection+0x178/0x410
> >   ? asm_exc_general_protection+0x26/0x30
> >   ? ima_restore_measurement_list+0xdc/0x420
> >   ? vprintk_emit+0x1f0/0x270
> >   ? ima_load_kexec_buffer+0x6e/0xf0
> >   ima_load_kexec_buffer+0x6e/0xf0
> >   ima_init+0x52/0xb0
> >   ? __pfx_init_ima+0x10/0x10
> >   init_ima+0x26/0xc0
> >   ? __pfx_init_ima+0x10/0x10
> >   do_one_initcall+0x5b/0x300
> >   do_initcalls+0xdf/0x100
> >   ? __pfx_kernel_init+0x10/0x10
> >   kernel_init_freeable+0x147/0x1a0
> >   kernel_init+0x1a/0x140
> >   ret_from_fork+0x34/0x50
> >   ? __pfx_kernel_init+0x10/0x10
> >   ret_from_fork_asm+0x1a/0x30
> >   </TASK>
> >  Modules linked in:
> >  ---[ end trace 0000000000000000 ]---
> >  RIP: 0010:ima_restore_measurement_list+0xdc/0x420
> >  Code: ff 48 c7 85 10 ff ff ff 00 00 00 00 48 c7 85 18 ff ff ff 00 00 00 00 48 85 f6 0f 84 09 03 00 00 48 83 fa 17 0f 86 ff 02 00 00 <66> 83 3e 01 49 89 f4 0f 85 90 94 7d 00 48 83 7e 10 ff 0f 84 74 94
> >  RSP: 0018:ffffc90000053c80 EFLAGS: 00010286
> >  RAX: 0000000000000000 RBX: ffffc90000053d03 RCX: 0000000000000000
> >  RDX: e48066052d5df359 RSI: cfacfdfe6660003e RDI: cfacfdfe66600056
> >  RBP: ffffc90000053d80 R08: 0000000000000000 R09: ffffffff82de1a88
> >  R10: ffffc90000053da0 R11: 0000000000000003 R12: 00000000000001a4
> >  R13: ffffc90000053df0 R14: 0000000000000000 R15: 0000000000000000
> >  FS:  0000000000000000(0000) GS:ffff888040200000(0000) knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 00007f2c744050e8 CR3: 000080004110e000 CR4: 00000000003506b0
> >  Kernel panic - not syncing: Fatal exception
> >  Kernel Offset: disabled
> >  Rebooting in 10 seconds..
> > 
> > From debugging printing, the stored addr and size of ima_kexec buffer
> > are not decrypted correctly like:
> >  ------
> >  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df359
> >  ------
> > 
> > There are three pieces of setup_data info passed to kexec/kdump kernel:
> > SETUP_EFI, SETUP_IMA and SETUP_RNG_SEED. However, among them, only
> > ima_kexec buffer suffered from the incorrect decryption. After
> > debugging, it's because of the code bug in early_memremap_is_setup_data()
> > where checking the embedded content inside setup_data takes wrong range
> > calculation.
> > 
> > The length of efi data, rng_seed and ima_kexec are 0x70, 0x20, 0x10,
> > and the length of setup_data is 0x10. When checking if data is inside
> > the embedded conent of setup_data, the starting address of efi data and
> > rng_seed happened to land in the wrong calculated range. While the
> > ima_kexec's starting address unluckily doesn't pass the checking, then
> > error occurred.
> > 
> > Here fix the code bug to make kexec/kdump kernel boot up successfully.
> > 
> > Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
> 
> The check that was modified was added by:
> 	b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> 
> The SETUP_INDIRECT patches seem to be the issue here.
> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/mm/ioremap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> > index aa7d279321ea..7953c4a1d28d 100644
> > --- a/arch/x86/mm/ioremap.c
> > +++ b/arch/x86/mm/ioremap.c
> > @@ -717,7 +717,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
> >  		paddr_next = data->next;
> >  		len = data->len;
> >  
> > -		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> > +		if ((phys_addr > paddr) && (phys_addr < (paddr + size + len))) {
> 
> I don't think this is correct. You are adding the requested size to the
> length of the setup data element. The length is the true length of the
> setup data and should not be increased.

I talked to Dave, he reminded me that people could mix the passed in
parameter 'size' and the local variable 'size' defined inside the while
loop, not sure which 'size' you are referring to.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

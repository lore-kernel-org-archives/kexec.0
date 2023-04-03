Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A2C76188
	for <kexec@archiver.kernel.org>; Mon,  3 Apr 2023 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JdmUO9tTKT11IfU+/p0byibFCItyL0fo12LeMZJS2aU=; b=Gmq8OPSu/UWRXo
	tYAPZ6xV6Dx2Ajh2WuTsM8zV2n6Wlh4p4syO3azIKXwWToS0MIUdYMA64PtIV5ypmvLr/DGxrLmym
	QuPBP5wlJ6dubURaNfZ5tmpMWp3eHKKw4hM2gv5PxulJO7opu1n0/L6IWY5eRD2KZROQkJXbbMJqh
	3oLsvVx51NKr4ked65Y5Ci3qYxnNlfl20jUnJLC9qPnpFoTF4Cp3B2er2jOogNA508T8nY3KYPUjX
	OSozw5ToHyhvjx95wbwP2CR4NqEjvEfVJ27hlKf7p8FBmgnfG6ca7yLvjS7IlzNh9HTios0s5p8fj
	kLPLI4yAlCqHyKKJrvig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjLHr-00Feuj-1J;
	Mon, 03 Apr 2023 14:35:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjLHl-00Fetr-2o
	for kexec@lists.infradead.org;
	Mon, 03 Apr 2023 14:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680532550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cP+bGhDlk17abfeJRcbu/Vx3+Nezj9s5bVdauklB/8Q=;
	b=dlC3nXl+oDiWWGHVi0unYEDEqu9x3u0SpRjakTarDQ1JlVhd0+pkQNXtnb/t0ZTkuHmRQQ
	MGlLpWmtr82aG6EZ/pru1be3IuSa+HCTs7TVxuOnmm5NxF8ueezfa3tNJ4hhDWJbuNJ+6+
	DWwucQQQDkPd4IqAMhMEQMcIPZt5EEc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-kXwApEh3NracL8aTR_vbkw-1; Mon, 03 Apr 2023 10:35:47 -0400
X-MC-Unique: kXwApEh3NracL8aTR_vbkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 744272A5954F;
	Mon,  3 Apr 2023 14:35:46 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.158])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 612E21121315;
	Mon,  3 Apr 2023 14:35:45 +0000 (UTC)
Date: Mon, 3 Apr 2023 16:35:40 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
Message-ID: <20230403163540.4f597d50@rotkaeppchen>
In-Reply-To: <CANiDSCtu8oOn9vV9eak=S2RDVVO9yan2BO8K5ia9jALABqiwjQ@mail.gmail.com>
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
	<20230324165855.23084947@rotkaeppchen>
	<CANiDSCtu8oOn9vV9eak=S2RDVVO9yan2BO8K5ia9jALABqiwjQ@mail.gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_073554_004332_AB17F833 
X-CRM114-Status: GOOD (  21.64  )
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

Hi Ricardo,

sorry for the late reply...

On Mon, 27 Mar 2023 13:52:08 +0200
Ricardo Ribalda <ribalda@chromium.org> wrote:

[...]

> 
> I tried removing the -r from arch/x86/purgatory/Makefile and that resulted into:
> 
> [  115.631578] BUG: unable to handle page fault for address: ffff93224d5c8e20
> [  115.631583] #PF: supervisor write access in kernel mode
> [  115.631585] #PF: error_code(0x0002) - not-present page
> [  115.631586] PGD 100000067 P4D 100000067 PUD 1001ed067 PMD 132b58067 PTE 0
> [  115.631589] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [  115.631592] CPU: 0 PID: 5291 Comm: kexec-lite Tainted: G     U
>       5.15.103-17399-g852a928df601-dirty #19
> cd159e0d6a91f03e06035a0a8eb7fc984a8f3e82
> [  115.631594] Hardware name: Google Crota/Crota, BIOS
> Google_Crota.14505.288.0 11/08/2022
> [  115.631595] RIP: 0010:memcpy_erms+0x6/0x10
> [  115.631599] Code: 5d 00 eb bd eb 1e 0f 1f 00 48 89 f8 48 89 d1 48
> c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 cc cc cc cc 66 90 48 89 f8
> 48 89 d1 <f3> a4 c3 cc cc cc cc 0f 1f 00 48 89 f8 48 83 fa 20 72 7e 40
> 38 fe
> [  115.631601] RSP: 0018:ffff93224f65fe50 EFLAGS: 00010246
> [  115.631602] RAX: ffff93224d5c8e20 RBX: 00000000ffffffea RCX: 0000000000000100
> [  115.631603] RDX: 0000000000000100 RSI: ffff9322407bd000 RDI: ffff93224d5c8e20
> [  115.631604] RBP: ffff93224f65fe88 R08: 0000000000000000 R09: ffff92133cd3ef08
> [  115.631605] R10: ffff9322407be000 R11: ffffffffa1b4f2e0 R12: 0000000000000000
> [  115.631606] R13: ffff92133cee4c00 R14: 0000000000000100 R15: ffffffffa2b6f14f
> [  115.631607] FS:  000078e8b9dbf7c0(0000) GS:ffff921437800000(0000)
> knlGS:0000000000000000
> [  115.631609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  115.631610] CR2: ffff93224d5c8e20 CR3: 000000015be26001 CR4: 0000000000770ef0
> [  115.631611] PKRU: 55555554
> [  115.631612] Call Trace:
> [  115.631614]  <TASK>
> [  115.631615]  kexec_purgatory_get_set_symbol+0x82/0xd3
> [  115.631619]  __se_sys_kexec_file_load+0x523/0x644
> [  115.631621]  do_syscall_64+0x58/0xa5
> [  115.631623]  entry_SYSCALL_64_after_hwframe+0x61/0xcb

Yeah, simply dropping -r doesn't work. You at least need to add -fPIE
to the CFLAGS. But probably you need more. When you go down this route
you really need to pay attention to some nasty details...

> And I did not continue in that direction.

That's totally fine.

Thanks
Philipp

> I also tried finding a flag for llvm that would avoid splitting .text,
> but was not lucky either.
> 
> I will look into making a linker script for x86, we could combine it
> with something like:
> 
>                 if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>                     pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>                     pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -                                        + sechdrs[i].sh_size) &&
> -                   kbuf->image->start == pi->ehdr->e_entry) {
> -                       kbuf->image->start -= sechdrs[i].sh_addr;
> -                       kbuf->image->start += kbuf->mem + offset;
> +                                        + sechdrs[i].sh_size)) {
> +                       if (!WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
> +                               kbuf->image->start -= sechdrs[i].sh_addr;
> +                               kbuf->image->start += kbuf->mem + offset;
> +                       }
>                 }
> 
> So developers have some hints of what to look at.
> 
> Thanks!
> 
> 
> >
> > Thanks
> > Philipp
> >  
> > >                       kbuf->image->start -= sechdrs[i].sh_addr;
> > >                       kbuf->image->start += kbuf->mem + offset;
> > >               }
> > >
> > > ---
> > > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > > change-id: 20230321-kexec_clang16-4510c23d129c
> > >
> > > Best regards,  
> >  
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

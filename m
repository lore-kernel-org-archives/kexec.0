Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E892CC25B76
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 08:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e7UfBIxnqJxCR5Z31iS5jPQ6HKaNoRDKICddSdOVnUU=; b=kR5+oC5Dcw2aqK
	4l/SfZeT1BACLxVfW+/uIBq9XhV9GImK448S1qbRZRKFddx/wipJ3SUguFNzy2ac+/by1Tt61Sran
	43j8u2CdvmjD1LsCG6UjCLwhNlE4/R7p49iy2t63Au5zcOx9l84YYNse4VtIXCiF/bSgOBMm0Aops
	NDL9UrXqt/Cv8y1wvfzfE2tCTsg/Ouwcr8Ph98XSeW6ZTTinJXEBZXXMHrBW9rBS933oT8hF+1Rni
	wL2KfVG/XTxzIjPGbFwXS/ghowlCTTgfxDEZMVcvS9wgf7rJ6RNw1bszlZUf+HwR8rEN/GmXdwQ8F
	U1P+vSmIho9zeIe+SpuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElq0-0000000594Q-3x5c;
	Wed, 05 Jun 2024 08:17:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElpx-0000000592H-1n0z
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 08:17:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9C019CE124A
	for <kexec@lists.infradead.org>; Wed,  5 Jun 2024 08:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F8FC3277B
	for <kexec@lists.infradead.org>; Wed,  5 Jun 2024 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717575454;
	bh=SyrCABOxfzWFSovPG3pWSF6TsrdkmMeE5mrN2ab0BuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rWdluTXPbEFbLoMzAVsyPEa4VUNMNilDbm4uy+TGZYH8V1jS7yoNN4d93+g1Rob9g
	 N/Y2HwvJkT7VEfg+hc63kTu+Yz2nheDnkkfu6a7chArO5ngy3g7IdqyMKmWJfMxH4t
	 edldOrl1DwDGHRlhL3B7ehu6bJi2qay76ONDPTZ/KKGIxY909Abn8u4JbssRo+Zt7t
	 Ww3+bgiCuOBWgSVuJ+K9Th1az6IAWSec+p5wH0d+c4+AzXxlrNnSxgYmc7WP7Ddt/f
	 Fq9hFPSwqUM83rpb2k6rLbzv5Fx1wNqirmSLW9ZkyK4vjAL5XaSUjau1IrFSZKn7q8
	 zpVKw0J5Dd9hA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e96f29884dso21288361fa.0
        for <kexec@lists.infradead.org>; Wed, 05 Jun 2024 01:17:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUwNI1bxIg0bvyzf37FIag4z3khmGRrnS0b80HjFYIbi0leNZDt9R5EA0Ph7MUtUBwg16m+RHBWwdF1pYFQMnQtpN8AoM2ZhEv
X-Gm-Message-State: AOJu0YzaOcet4kvXJ8HNbNRky2VhAuGlZwQCJ1XF/Wsj2BQi7+nYlIf6
	aCM/cgNj+Z+YP8gkWzhkqGLQJw6qpdCmQ2fHfp3rk4mkYBLZd8G304Uw/NHA4FQ3elgadt/aEOn
	+rCO7bQKNyKnecxIgneBwpwslLrQ=
X-Google-Smtp-Source: AGHT+IGlZ8B/8qUP04+W16z855ba/YXAp1EIwaPL434uTzFqdW4tr39B39lzlfhSYchjCrvswDx/zghAaOFUls5LZKc=
X-Received: by 2002:a2e:a173:0:b0:2e1:e33d:67f6 with SMTP id
 38308e7fff4ca-2eac79e9d52mr8409391fa.28.1717575453266; Wed, 05 Jun 2024
 01:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com> <Zl3HfiQ6oHdTdOdA@kernel.org>
 <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com> <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local>
 <Zl3hwYL2GDiyUfGo@kernel.org> <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local> <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local> <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
 <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
In-Reply-To: <20240605074257.GAZmAXAbkc5TGVds5u@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 5 Jun 2024 10:17:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>
Message-ID: <CAMj1kXFweoskB_qnUFA1b+QXWhjovwMfpM00cGb9KMcm4Zr7EA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Young <dyoung@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_011737_828279_182431CF 
X-CRM114-Status: GOOD (  19.86  )
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

On Wed, 5 Jun 2024 at 09:43, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Jun 05, 2024 at 10:53:44AM +0800, Dave Young wrote:
> > It's something good to have but not must for the time being,  also no
> > idea how to save the status across boot, for EFI boot case probably a
> > EFI var can be used;
>
> Yes.
>
> > but how can it be cleared in case of physical boot.  Otherwise
> > probably injecting some kernel parameters, anyway this needs more
> > thinking.
>
> Yeah, this'll need proper analysis whether we can even do that reliably.
>
> We need to increment it only on the kexec reboot paths and clear it on
> the normal reboot paths.
>

I'd argue for the opposite: ideally, the difference between the first
boot and not-the-first-boot should be abstracted away by the
'bootloader' side of kexec as much as possible, so that the tricky
early startup code doesn't have to be riddled with different code
paths depending on !kexec vs kexec.

TDX is a good case in point here: rather than add more conditionals,
I'd urge to remove them so the TDX startup code doesn't have to care
about the difference at all. If there is anything special that needs
to be done, it belongs in the kexec implementation of the previous
kernel.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

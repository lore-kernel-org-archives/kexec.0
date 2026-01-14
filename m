Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA24D39013
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XbdwHN5Unw1sHLXGB6XuyerjfI2+/RO0oOZU7dEUE9U=; b=FGRu5xv8c5k290okcxiejC6aE4
	01eKJ54sl/cAA4ThzaQxZPJjNfKEYmIq4srltbW5MFr9e9QApSidlotmBZ182iUsyc7oOpUmJXvd7
	ZiDgAPBM/or9iC2+QgMkyIVB15zl8wrZiWIagDHvMb7JI+0U1pXvyRk60UYzMAhZnE8tq2jjlYlAt
	SDkyUHuUwa+GGZvzB1XCAr1SSnb+aNvQipfz7Wsw07FKaLK9cgR3xp25VmXaTb76ICuKvlUTFp59O
	a1BuB92wTCf6h2kTxiq46BfdmjC8e/vI08xqVjR3I38UiiYjZLssGHUZrxn/f94vodhtdLEQsX4JE
	uPqFv9uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg86x-0000000AjYZ-21nL;
	Wed, 14 Jan 2026 21:09:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg86w-0000000AjYJ-0nHY;
	Wed, 14 Jan 2026 21:09:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 09B616001D;
	Wed, 14 Jan 2026 21:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8A1C4CEF7;
	Wed, 14 Jan 2026 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768424940;
	bh=WY2v7TTkVAMIoJ6VgjyCIHMaXfZc57Ip7xvQxHTv4p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQlP4ogzmIg+JA/pCvyHUUO5wvv/C5zQHlnBqXHSLlASijL8pmOpQxN6Mp9g8yjZF
	 JSbWr/fkUFCssMc/dFWx53WUUKe4zHJ6ZYkSjNd6r1yX3mp12SLuUxgl9ozv63ZnlZ
	 jl3raBW0MaXvD6R6YWE58deFr8RmXTmk8TGzXsH0Sdi35Ya/1ZFr2ubX1tizPnxouv
	 dvucGK7xwkmHYbzM9vwJrQRTq/Y/S9jRrITCBXqvHPHWZJixTXbAVxA08Spk1KIgSe
	 lOZgKwHm4frxFppMK3Q/ZKKdz7ijGrqpXG3ah1bIYM6EXceqoiApHVgyMomBL50l0S
	 HZqj6PBTuoFBQ==
Date: Wed, 14 Jan 2026 15:08:59 -0600
From: Rob Herring <robh@kernel.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <20260114210859.GA3197242-robh@kernel.org>
References: <20251226141116.1379601-1-coxu@redhat.com>
 <CAL_JsqLEsUV34tMZWSMc6w-xDV=M0JpOmS95TxrtbbBMRoD3Jw@mail.gmail.com>
 <aV49pPV3OViTDe8c@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV49pPV3OViTDe8c@Rk>
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

On Wed, Jan 07, 2026 at 07:39:24PM +0800, Coiby Xu wrote:
> On Tue, Jan 06, 2026 at 09:44:37AM -0600, Rob Herring wrote:
> > On Fri, Dec 26, 2025 at 8:11 AM Coiby Xu <coxu@redhat.com> wrote:
> > > 
> > > Based on the CONFIG_CRASH_DM_CRYPT feature, this patch adds
> > > LUKS-encrypted device dump target support to ARM64 by addressing two
> > > challenges [1],
> > >  - Kdump kernel may not be able to decrypt the LUKS partition. For some
> > >    machines, a system administrator may not have a chance to enter the
> > >    password to decrypt the device in kdump initramfs after the 1st kernel
> > >    crashes
> > > 
> > >  - LUKS2 by default use the memory-hard Argon2 key derivation function
> > >    which is quite memory-consuming compared to the limited memory reserved
> > >    for kdump.
> > > 
> > > 1st kernel will add device tree property dmcryptkeys as similar to
> > > elfcorehdr to pass the memory address of the stored info of dm-crypt
> > > keys to the kdump kernel.
> > 
> > Is there not any security issue with putting the key into the DT? The
> > DT is provided to userspace. There's provisions already to not expose
> > "security-*" properties to userspace (see __of_add_property_sysfs).
> > Though I think that has a hole in that the FDT is also provided as-is.
> > However, I don't even know who or what uses these properties.
> > 
> > Rob
> 
> Hi Rob,
> 
> Thanks for raising the concern! If I understand DT correctly, this
> property is only accessible to the kexec'ed kdump kernel. A new DT is
> allocated and set up by of_kexec_alloc_and_setup_fdt. Btw, to be
> precise, it's putting the memory address where the key is stored but
> not the key itself into DT. The key is stored in the memory exclusively
> reserved for kdump. For more info on by who and how this property will
> used, I've created a dt-schema pull request as suggested by Krzysztof,
> https://github.com/devicetree-org/dt-schema/pull/181

Okay, that's a bit less sensitive. That still could expose a memory 
address to user space which has generally been locked down in recent 
years. Though I'm not sure we'd consider addresses of blobs passed by 
kexec sensitive or secure.

> 
> And yes, there is no need for even userspace of the kdump kernel to
> access it. So this idea of "security-*" properties/__of_add_property_sysfs
> seems desirable. Thanks for bringing it up! I'll give it a try.

Since it is just the memory address, kdump just moving the key would be 
sufficient. Or the property can be removed early on. I think we do that 
with kaslr seed IIRC.

Rob


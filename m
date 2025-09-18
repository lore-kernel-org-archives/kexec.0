Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE4CCAC5A0
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0x6r56VSTtFzI1KR80IkhiQu7zSpN7Rqke7zLSWIcUg=; b=uPfKAwf9R7kdDD9GtJehMH1QlA
	wwPk2hBzvM074rgxVoL1vyN1ZrSSaP/6YbsqR+OMNzIH5UGlOwzSl7jY6zslAvjP1S+N4teGek5Bp
	jcgsjR/U6H3NNkZs+ot1vrByF50jipDiMYRFl1u7VVTzMNvTnT+LQ5l/1tArTY8rQKjMMjsycrtRJ
	vUpB24c9Nf5/cPs3qSFZrJDf88fjgGM4xXUkRITRTtWCc2bkCI/VpcvTAKQvzOVDbhScoC2y20BDY
	pr0k8yjRulRFq6cwPHxVVPe86I71iwLZey++7WO1JUS/MuUwL+AcLcjkVKgjwDHncdVNcgQ/0ZOZ9
	O7mc9AZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzEvL-0000000HaFb-3lGp;
	Thu, 18 Sep 2025 13:43:47 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzEvI-0000000HaFP-2cDa
	for kexec@bombadil.infradead.org;
	Thu, 18 Sep 2025 13:43:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0x6r56VSTtFzI1KR80IkhiQu7zSpN7Rqke7zLSWIcUg=; b=fiiCOB09snr0roNvpJicn2odyO
	D+7Rg/sr/NuCUuzlcMmA4tlgLR3hmIORxb58oOcEhEHHw0XV0EdpYJM2ayHfJ5EPN9QSwZdnY/7tm
	aG5bdPDaqzDtY6dYSYTiq3eG6C+X5c129LbW25o+/adEaG+X0an5JEmKDSNjD1ULplqZx2MsUMB8e
	KEc8q9xH0yUAa3nqxTOHogTvEWHdOgv3dCJ869CRZUlUnH3IPqnG/BqD1CokTy+/OBCL8kZTafeuY
	AQTwlJsq/8OsNtY/cwqApyX5oZ+yqKJR1xop8vTLwKSix3HLR/TizI3esFvvE5LCLOC+Zt+BHpr8F
	09TfGCrQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzEvE-00000007c90-2DpJ
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 13:43:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758203010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x6r56VSTtFzI1KR80IkhiQu7zSpN7Rqke7zLSWIcUg=;
	b=I8u0mQOf3N9EA/41gqJt0qoxkuvzBFEISDtkEqXwhdsJx+ursyE7Aa89fGxsAPBZO4+Jlr
	4hgr6y9WvwtemPOUfkG6tP4fA1XmBgOF5Xnx62EEUNAua1XIk9QssZHviQKob7Sb27ecBc
	1mWywgEEj3MbSQdeoNd5ir+ubNi66J8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758203017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x6r56VSTtFzI1KR80IkhiQu7zSpN7Rqke7zLSWIcUg=;
	b=Xxvz+mIGai/bRNJcfQqzlX8+D7EYcIq0wIi9WzXXzGkLwCw0n308ZmZTk+xjZchbvAOuz+
	aSrFNOFFvZycF5VjoWJhWiB+kbDxB6U0G8RcUzIsXIPJ7vOQhzNbmW//XYu1KSiVj33MQ7
	zKOaBw7gICPcT+4NtRBiCpp1C16D+VI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-_V9_ryH_NsuKAb-PO06euA-1; Thu,
 18 Sep 2025 09:43:26 -0400
X-MC-Unique: _V9_ryH_NsuKAb-PO06euA-1
X-Mimecast-MFC-AGG-ID: _V9_ryH_NsuKAb-PO06euA_1758203004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D47C1956089;
	Thu, 18 Sep 2025 13:43:23 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.225.227])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1148C1955F21;
	Thu, 18 Sep 2025 13:43:14 +0000 (UTC)
Date: Thu, 18 Sep 2025 15:43:11 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd
 Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, kexec@lists.infradead.org,
 bpf@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 00/12] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20250918154311.3be690d4@rotkaeppchen>
In-Reply-To: <aMjEyfrNSuA3IBR7@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
	<20250901162929.11af536d@rotkaeppchen>
	<aMjEyfrNSuA3IBR7@fedora>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_144340_983919_F9805919 
X-CRM114-Status: GOOD (  60.71  )
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

Hi Pingfan,

On Tue, 16 Sep 2025 10:00:41 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> On Mon, Sep 01, 2025 at 04:29:29PM +0200, Philipp Rudo wrote:
> Hi Philipp,
> 
> Thank you for deep insight, please see the comments
> 
> > Hi Pingfan,
> > 
> > thanks for sharing the updated version of the series. There are a few
> > small nits you can find in my comments to the individual patches.
> > 
> > I also took an other look at the bigger picture. The way I see it the
> > series contains two major changes.
> > 
> > 1. A generic mechanism to parse and run bpf programs during kexec.  
> 
> Thanks for your suggestion. This makes the whole design look more
> natural. Without it, using the PE format parser as a frontend to the
> image parser looks a bit awkward.
> 
> > 2. A new loader for UEFI Applications building up on 1.
> > 
> > Both those changes are currently smashed together as "PE image loader",
> > which IMHO is quite confusing. It's correct that UEFI Apps are PE
> > files. But the PE format is also used in many other ways and in the end
> > we are only interested in this specific use case. Plus the generic
> > mechanism to parse and run bpf programs during kexec can also be used
> > with any other file format, not just PE.
> > 
> > In addition I noticed that hooking into kexec_file while loading the
> > image is too late. The problem is that in
> > kernel/kexec_file.c:kimage_file_prepare_segments the cmdline is
> > measured for IMA before the image is loaded. But we allow the
> > bpf_prog to change the cmdline. When that is done the IMA measurement
> > no longer is correct. So we need a new hook to run the bpf programs
> > after the initrd and cmdline were read but before the IMA measurement is
> > done.
> >   
> 
> This should be a issue when turning on IMA measurement on cmdline. And it
> can be perfectly addressed with your suggestion.
> 
> > So my suggestions are:
> > 
> > 1. Extend the kexec_file_ops by a new 'get_bpf_prog' hook.  
> 
> I'm not sure I agree with you on this.  We both agree that the generic
> mechanism to parse and run BPF programs should be independent of the
> image parser and belong in kexec_file.c. However, kexec_file_ops is
> still a concept that belongs to the image parser layer. So I think that
> moving the logic to kexec_file.c is good enough.

I'm not sure I get your point here. My rational is, that the bpf_prog
can be included in different file formats. So we still need a mechanism
to parse it from the different formats. Plus we need a file_ops that is
"responsible" for a file type. All in all it makes most sense to me to
have a file_ops that only has a .probe and .get_bpf_prog.

But yes, maybe I'm missing something. I'm curious on seeing your v6.

Thanks
Philipp

> 
> > 2. Move the mechanism to run bpf progs from kexec_pe_image.c to
> >    kexec_file.c (with the new hook in the file_ops there shouldn't be
> >    any problems).  
> 
> Yes, the logic of loading and runing bpf progs should be placed in
> kexec_file.c.
> 
> > 3. Rename CONFIG_KEXEC_PE_IMAGE to CONFIG_KEXEC_BPF  
> 
> OK.
> 
> > 4. Rename kexec_pe_image.c (and the functions within) to
> >    kexec_uefi_app.c 
> >   
> 
> OK.
> 
> Thanks for your careful review and good suggestion.
> 
> 
> Best Regards,
> 
> Pingfan
> 
> > Thanks
> > Philipp
> > 
> > On Tue, 19 Aug 2025 09:24:16 +0800
> > Pingfan Liu <piliu@redhat.com> wrote:
> >   
> > > Cc systemd-devel@lists.freedesktop.org so any UKI expert can comment
> > > 
> > > *** Review the history ***
> > > 
> > > Nowadays UEFI PE bootable image is more and more popular on the distribution.
> > > But it is still an open issue to load that kind of image by kexec with IMA enabled
> > > 
> > > There are several approaches to reslove this issue, but none of them are
> > > accepted in upstream till now.
> > > 
> > > The summary of those approaches:
> > >   -1. UEFI service emulator for UEFI stub
> > >   -2. PE format parser in kernel
> > > 
> > > For the first one, I have tried a purgatory-style emulator [1]. But it
> > > confronts the hardware scaling trouble.  For the second one, there are two
> > > choices, one is to implement it inside the kernel, the other is inside the user
> > > space.  Both zboot-format [2] and UKI-format [3] parsers are rejected due to
> > > the concern that the variant format parsers will inflate the kernel code.  And
> > > finally, we have these kinds of parsers in the user space 'kexec-tools'.
> > > 
> > > 
> > > *** The approach in this series ***
> > > 
> > > This approach allows the various PE boot image to be parsed in the bpf-prog,
> > > as a result, the kexec kernel code to remain relatively stable.
> > > 
> > > Benefits
> > > And it abstracts architecture independent part and 
> > > the API is limitted 
> > > 
> > > To protect against malicious attacks on the BPF loader in user space, it
> > > employs BPF lskel to load and execute BPF programs from within the
> > > kernel.
> > > 
> > > Each type of PE image contains a dedicated section '.bpf', which stores
> > > the bpf-prog designed to parse the format.  This ensures that the PE's
> > > signature also protects the integrity of the '.bpf' section.
> > > 
> > > 
> > > The parsing process operates as a pipeline. The current BPF program
> > > parser attaches to bpf_handle_pefile() and detaches at the end of the
> > > current stage via disarm_bpf_prog(). The results parsed by the current
> > > BPF program are buffered in the kernel through prepare_nested_pe() and
> > > then delivered to the next stage. For each stage of the pipeline, the
> > > BPF bytecode is stored in the '.bpf' section of the PE file. That means
> > > a vmlinuz.efi embeded in UKI format can be handled.
> > > 
> > > 
> > > Special thanks to Philipp Rudo, who spent significant time evaluating
> > > the practicality of my solution, and to Viktor Malik, who guided me
> > > toward using BPF light skeleton to prevent malicious attacks from user
> > > space.
> > > 
> > > *** Test result ***
> > > Configured with RHEL kernel debug file, which turns on most of locking,
> > > memory debug option, I have not seen any warning or bug for 1000 times.
> > > 
> > > Test approach:
> > > -1. compile kernel
> > > -2. get the zboot image with bpf-prog by 'make -C tools/kexec zboot'
> > > -3. compile kexec-tools from https://github.com/pfliu/kexec-tools/pull/new/pe_bpf
> > > 
> > > The rest process is the common convention to use kexec.
> > > 
> > > 
> > > [1]: https://lore.kernel.org/lkml/20240819145417.23367-1-piliu@redhat.com/T/
> > > [2]: https://lore.kernel.org/kexec/20230306030305.15595-1-kernelfans@gmail.com/
> > > [3]: https://lore.kernel.org/lkml/20230911052535.335770-1-kernel@jfarr.cc/
> > > [4]: https://lore.kernel.org/linux-arm-kernel/20230921133703.39042-2-kernelfans@gmail.com/T/
> > > 
> > > v4 -> v5
> > >   - rebased onto Linux 6.17-rc2
> > >   - [1/12], use a separate CONFIG_KEEP_COMPRESSOR to decide the section
> > >     of decompressor method
> > >   - [10/12], add Catalin's acked-by (Thanks Catalin!)
> > > 
> > > v3 -> v4
> > >   - Use dynamic allocator in decompression ([4/12])
> > >   - Fix issue caused by Identical Code Folding ([5/12])
> > >   - Integrate the image generator tool in the kernel tree ([11,12/12])
> > >   - Address the issue according to Philipp's comments in v3 reviewing.
> > >     Thanks Philipp!
> > > 
> > > RFCv2 -> v3
> > >   - move the introduced bpf kfuncs to kernel/bpf/* and mark them sleepable
> > >   - use listener and publisher model to implement bpf_copy_to_kernel()
> > >   - keep each introduced kfunc under the control of memcg
> > > 
> > > RFCv1 -> RFCv2
> > >   - Use bpf kfunc instead of helper
> > >   - Use C source code to generate the light skeleton file
> > > 
> > > 
> > > *** BLURB HERE ***
> > > 
> > > Pingfan Liu (12):
> > >   kexec_file: Make kexec_image_load_default global visible
> > >   lib/decompress: Keep decompressor when CONFIG_KEEP_COMPRESSOR
> > >   bpf: Introduce bpf_copy_to_kernel() to buffer the content from bpf-prog
> > >   bpf: Introduce decompressor kfunc
> > >   kexec: Introduce kexec_pe_image to parse and load PE file
> > >   kexec: Integrate with the introduced bpf kfuncs
> > >   kexec: Introduce a bpf-prog lskel to parse PE file
> > >   kexec: Factor out routine to find a symbol in ELF
> > >   kexec: Integrate bpf light skeleton to load zboot image
> > >   arm64/kexec: Add PE image format support
> > >   tools/kexec: Introduce a bpf-prog to parse zboot image format
> > >   tools/kexec: Add a zboot image building tool
> > > 
> > >  arch/arm64/Kconfig                           |   1 +
> > >  arch/arm64/include/asm/kexec.h               |   1 +
> > >  arch/arm64/kernel/machine_kexec_file.c       |   3 +
> > >  include/linux/bpf.h                          |  42 ++
> > >  include/linux/decompress/mm.h                |   7 +
> > >  include/linux/kexec.h                        |  10 +
> > >  kernel/Kconfig.kexec                         |   9 +
> > >  kernel/Makefile                              |   2 +
> > >  kernel/bpf/Makefile                          |   3 +
> > >  kernel/bpf/helpers.c                         | 230 +++++++++
> > >  kernel/bpf/helpers_carrier.c                 | 215 +++++++++
> > >  kernel/kexec_bpf/Makefile                    |  71 +++
> > >  kernel/kexec_bpf/kexec_pe_parser_bpf.c       |  67 +++
> > >  kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 147 ++++++
> > >  kernel/kexec_file.c                          |  88 ++--
> > >  kernel/kexec_pe_image.c                      | 463 +++++++++++++++++++
> > >  lib/Kconfig                                  |   3 +
> > >  lib/decompress.c                             |   6 +-
> > >  tools/kexec/Makefile                         |  90 ++++
> > >  tools/kexec/pe.h                             | 177 +++++++
> > >  tools/kexec/zboot_image_builder.c            | 280 +++++++++++
> > >  tools/kexec/zboot_parser_bpf.c               | 158 +++++++
> > >  22 files changed, 2029 insertions(+), 44 deletions(-)
> > >  create mode 100644 kernel/bpf/helpers_carrier.c
> > >  create mode 100644 kernel/kexec_bpf/Makefile
> > >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.c
> > >  create mode 100644 kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h
> > >  create mode 100644 kernel/kexec_pe_image.c
> > >  create mode 100644 tools/kexec/Makefile
> > >  create mode 100644 tools/kexec/pe.h
> > >  create mode 100644 tools/kexec/zboot_image_builder.c
> > >  create mode 100644 tools/kexec/zboot_parser_bpf.c
> > > 
> > > 
> > > base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9  
> >   
> 



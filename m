Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67325606A319
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i515dZgI;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zh6Pd3Hi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WgFMIOh93QhT86nsv4SkYxtkJuNYyAnLVgqCXTRDBJQ=; b=i515dZgID5D8o2ObLzgFliNAgL
	HHt2hPDbdRjlMMrKjMmXc+ztyrUZaLtmaoCeklPyT4Tx5CW45A4LqCJfvbD+8394oe5vMy9LBNVEf
	CDrGjUtuzTrsGaHSSDkLZL44u5MlxdV31UsR0tFC2RvkWZDMS+oT3wvvr2jsv7UY7LAc7R+Mi8tYZ
	ntFLbSFAujWcadpiukyWshHKgQjCqKtt+16Z536Zd4FNN2p+q5C2JHTxd7J14CK6H/ojqypHhO3tO
	tF8aEp9QRh22eaJipTURYPajDjRi7Y2MBEF6CTYyEvLskOt3Uu6RbiK152dDZFNW+EBaOkeBVFdWm
	/gd4x2hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDxi-0000000AO0W-2ToR;
	Tue, 20 Oct 2026 17:49:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJDxf-0000000ANzn-1now
	for kexec@lists.infradead.org;
	Tue, 20 Oct 2026 17:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792518557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgFMIOh93QhT86nsv4SkYxtkJuNYyAnLVgqCXTRDBJQ=;
	b=Zh6Pd3Hi0qpYpLNZoGzxp5kbYRn1xBZQtyig7vkzDZpzXpPlvpxOOquxKWWP4xIJCuHh3m
	2FrzSV8qkF2Rq0nWt7jMyvWHBPGW2CcbRjBZ9ZjtMyXVzSzQaHn0AoBoex92se3VhGGYY4
	SJOc+No4GNqBFUKixnFuUitFm5L0VR4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-ottbI5POOUSdDjVlOIXqxw-1; Tue,
 20 Oct 2026 17:47:36 +0000
X-MC-Unique: ottbI5POOUSdDjVlOIXqxw-1
X-Mimecast-MFC-AGG-ID: ottbI5POOUSdDjVlOIXqxw_1792518453
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89C1F18005B3;
	Tue, 20 Oct 2026 17:47:31 +0000 (UTC)
Received: from rotkaeppchen (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F5FF30001A2;
	Tue, 20 Oct 2026 17:47:22 +0000 (UTC)
Date: Tue, 20 Oct 2026 19:47:19 +0200
From: Philipp Rudo <prudo@redhat.com>
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, Pingfan Liu <atlarge80@qq.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jeremy Linton" <jeremy.linton@arm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon"
 <will@kernel.org>, "Simon Horman" <horms@kernel.org>, "Gerd Hoffmann"
 <kraxel@redhat.com>, "Vitaly Kuznetsov" <vkuznets@redhat.com>, "Viktor
 Malik" <vmalik@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>, Baoquan
 He <baoquan.he@linux.dev>, "Andrew Morton" <akpm@linux-foundation.org>,
 kexec@lists.infradead.org, bpf@vger.kernel.org,
 systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dave
 Young <ruirui.yang@linux.dev>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-ID: <20261020194719.4fbd4e4a@rotkaeppchen>
In-Reply-To: <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
Organization: Red Hat inc.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: WRvKFDqJLEmuslvjAAXMIA9t98IQFlUJQ9vgtKfplo8_1792518453
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_104919_548194_D704BDA0 
X-CRM114-Status: GOOD (  40.58  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jason,
Hi Ard,

let me add my 2 ct as well.

On Tue, 13 Oct 2026 21:19:28 +0200
"Ard Biesheuvel" <ardb@kernel.org> wrote:

> Hi Jason,
> 
> Thanks for chiming in.
> 
> On Sun, 11 Oct 2026, at 22:13, Jason Gunthorpe wrote:
> > On Sun, Mar 22, 2026 at 09:43:49AM +0800, Pingfan Liu wrote:  
> >> *** The history ***
> >> 
> >> Nowadays, UEFI PE bootable images are becoming increasingly popular
> >> among distributions. Currently, we have several kinds of image format
> >> parsers in user space (kexec-tools). However, this approach breaks the
> >> integrity protection of the images. To address this integrity protection
> >> concern, several approaches have been proposed to resolve this issue,
> >> but none of them have been accepted upstream yet.
> >> 
> >> The summary of those approaches:
> >>   -1. UEFI service emulator for UEFI stub
> >>   -2. PE format parser in kernel
> >>   -3. Signing the arm64/boot/Image  
> >
> > I recently had an interesting discussion with Ard around DRTM for
> > kexec and we sort of independently concluded that #1 would be the best
> > (only?) option there.
> >
> > All the implementations of DRTM today live in the EFI stub and
> > intercept the boot process as it goes along. After ExitBootServices
> > the DRTM implementation will launch the kernel in a different way.
> > Even worse today's x86 version strongly requires EFI boot services to
> > connect the Linux stub with a trampoline helper provided earlier in
> > the boot chain.
> >
> > A kexec flow that only works on decompressed vmlinux, with no option
> > to run any EFI code, is going to be difficult to support. There is
> > enough information and choices involved in DRTM that it is undesirable
> > for the predecessor kernel to try and DRTM launch it on behalf of the
> > successor, let alone trying to get the insane x86 trampolines into a
> > kexec successor kernel.
> >
> > Given those constraints entering the successor kernel through the
> > normal EFI entry point is highly desirable. This would allow x86 to
> > continue to provide the DRTM trampolines through an EFI mechanism and
> > means the Linux EFI stub always handles the launch with identical code
> > in all scenarios.
> >  
> 
> With some help from my friend Claude, I've prepared a prototype that
> reuses my efiloader Rust crate to boot EFI stub images (bare Image,
> zboot, UKI) in the kernel: the EFI boot phase is invoked at kexec
> load time, and runs under the preceding kernel up until the point
> where ExitBootServices() is called. Then, the actual kexec call
> will return from ExitBootServices() after shutting down the first
> kernel.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efiloader-kexec

I only took a brief look and cannot claim to fully understand your
solution, yet. Nevertheless I'm pretty impressed. I also agree that
this approach is by far the best, if we can get it to work.

The reason why I and Pingfan abandoned this approach and went for eBPF
instead was due to security concerns. Our premise is/was that the EFI
stub must not be able to harm the running kernel. Be it intentional or
not. That's a guarantee eBPF with its verifier can give but a simple
file signature can't.

I believe the way Ard ties execution of the EFI stub to module
signature verification solves the "intentionally malicious" case. In
the end it doesn't make sense to try to prevent a malicious EFI stub to
be executed when an attacker could also load a malicious kernel module.

But that still leaves the "unintentional malicious" case. Meaning,
that someone tries to be "smart" and does weird stuff in the EFI stub
he knows it won't do any harm during cold boot, but that will cause
problems to the kernel running the efiloader. IIUC Ard's implementation
cannot catch such problems. But I expect it will be a total pain to
debug them. Especially when it is caused by some out-of-tree stub.

To be honest, I'm not sure how this could be solved. I'm not even sure
if it's worth trying. Nevertheless I believe it's worth having some sort
of tainted flag. At least that would give developers a hint that some
untrusted code was run without them spending ours of debugging.

Two more comments with my distro head on.

First, kdump is extremely important to us. So the final solution needs
to be able to load a crash kernel as well.

Second, implementing the efiloader in Rust is not ideal. This prevents
us to support the feature in older streams that don't support
Rust4Linux.

Anyway, thanks for bringing up the topic again. I'm looking forward to
see the next version.

Thanks
Philipp

> 
> There are some limitations (4k pages only, CONTIG_ALLOC support
> required) but it seems to work as expected.
> 
> I haven't looked at measured boot or DRTM specifics.
> 
> 



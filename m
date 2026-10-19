Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C607CCA490
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 01:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vqm5NiksGY4HrQbWx/n2zQ+tsPVca38MSEIqYskeCW4=; b=Y5wx5mkcYJjT8I15gSbHPvad5h
	ZyS0NxqDINWNQM7tqAQDT7hCl+/pU7gJbIF17yDuA3ZnhK9vFbY/kosS+0uiqP+Q4IIWEa27v89FV
	rz7eLuKOgamRUdkm3qL7UYJvRNUFA2mT/+5WMUcgyw0FB5rkmMMGNQnhaaAQIPXXWAUIbTzxg2ECy
	NlGnnHAT6dF86wJSLwHCE1pvq9jkH9Z1LY5ep48T1IVdSwVHfFRPkSSNt9ONlqdMQ7logCzKKDYtH
	cOtnTuN2yuPxJb8SnhXwwAxo4HW+zESVyNbGC2Y2ui4DrFYtu6x+F4NhjWgZG5XseI5V2qdUsC5/6
	WjYbBCWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcNb-00000006PL2-2frH;
	Mon, 19 Oct 2026 01:41:35 +0000
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcNX-00000006PJt-2l2n
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 01:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792374081; bh=Vqm5NiksGY4HrQbWx/n2zQ+tsPVca38MSEIqYskeCW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EfBA1wB1kcALsHrJtIN6wpbGdUM7bnqMj7VYkgbHd0DomKlFcjJ2JoHciWyoQV8pq
	 b5kU3cF0qSA7NosrvjLlwaHB22WkJ6tWGPR1sqJqvEVY9EbAA2NrhlAR1Vd+6q8mZP
	 Ffzw7OzDaaLFPoEQOwmVp72hlvWWS8UHm6CKHnwU=
Received: from fedora ([2408:8207:c43:1bd0:c595:d7b2:f1d6:8a28])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id A4DBBE69; Mon, 19 Oct 2026 09:41:13 +0800
X-QQ-mid: xmsmtpt1792374073tqzj49z64
Message-ID: <tencent_FE9F89DF33773710DF821792DB952E8AE306@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnL/G/d/G+g99ale/grdxAGBmoOJg4kfvQJXfm2lB5iyAcuTWzMmn
	 2ngtY0wowG2i0OGO5cRzn6C/kwFMZlyRoPSE+1x9MIAZyHIqq30SyR6IdlCLCmhN7e6j97w2XhP8
	 MaBS60tDddPunpbgiTJojYURVqIKV2LswpYeZDmdiVaN3FjWWAoMPO+LhJOG71NfOqI8gfwM4aQs
	 1ghNngMpYyk8ohGwdZUNdxcFihClBBuf5UzOXMaD206H9aY0HeutC9tTb3IWToOUf3fBc67fVZke
	 Q8HUWVMsnN4TRRONRmUNnCAMAFP+UCh5qW1RyULrjYR/huqfsZat+OM7lDA/7hmZhKyzOAQT6Rca
	 PpBY26sNx4krLkTD9J4YGdU21RlMMeRhLChTWPeW+je/yu6wJr62UBxWzg0/ihj4VOX5rYkhAaWS
	 XmqsLqoiQeR27CiQ74AxYHRMoDYx9jZiVtLxyFUI927a5gSrBPzE4E7AZvYysxpnWKtBftQ+LI4X
	 XYsVwBDBVnfs5beDRHy1zt+Ktta/Ya1RMHf5D+tHJ1Bi4Jkp3R3psdPU+EgfkYWcwnoCn64ob1C6
	 i2rsyCpwzIocLX7o6x+Mv1C9YYYfiVPwTT6TZTjCzuN8HvDPWwaVPg3ATyleR86wGSfJlN1noJ3L
	 iw7Il9T5fRgWJWjNXEHytOvEWOdtnVNleJgjOn09zAnlgsRZ0kpZSqCJkeuSQmyOtf0p7NLFJmXz
	 8gz0ymE46cMc7h1+Wen9czFFu+YTnBG4SGETWifvY6YFzLsw9uF7ytnJuD4tDOvAbOGqa6yWBmGh
	 mf89GtW2xNhQsSEnC/brwiF0q29FiEfBeqXcstZN79AH/HqnMb9iS0DlKlO/eoDClSagBnYNEL3h
	 1+3hNO5oBB9RrnegLIdKh96621WpIu9vRrMYs4WfS3LgpPclP7/7heGHPJHz7DNOgq2MgyKCFXhH
	 5fxE2UNLri3yq2A42DNlJ0En6/c7H23OSYDqYnHo/WGO7SNObXnZvObyPvkJ9eWvLoXC/SjGg4bR
	 5xxs/8xbHP1132K2Tumj3tF8tOOphVeXxuQY/mfw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Date: Sun, 18 Oct 2026 17:38:48 -0700
From: Pingfan Liu <atlarge80@qq.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Pingfan Liu <piliu@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
X-OQ-MSGID: <atVmmBqDNXz6AjfU@fedora>
References: <20260322014402.8815-1-piliu@redhat.com>
 <20261011201325.GA918242@nvidia.com>
 <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <722bd9d8-5620-498a-a6c2-d9a1f498e0b7@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_184132_256629_D28DD721 
X-CRM114-Status: GOOD (  33.13  )
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

On Tue, Oct 13, 2026 at 09:19:28PM +0200, Ard Biesheuvel wrote:
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
> 

Sorry, I haven't had time to go through it yet. But I'm curious how you
would address the portability issues, especially those related to the
console, that you pointed out in my emulator implementation.


Thanks,

Pingfan
> There are some limitations (4k pages only, CONTIG_ALLOC support
> required) but it seems to work as expected.
> 
> I haven't looked at measured boot or DRTM specifics.
> 
> 



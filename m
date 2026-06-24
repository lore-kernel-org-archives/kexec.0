Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA861CDB471
	for <kexec@archiver.kernel.org>; Wed, 24 Jun 2026 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bPkGECt5a+DPxd1vxVeft1Ofd1Mb2QRWXAtXqKgxgFY=; b=4aXzrhVaRfwqNcGVIrliJpbHI5
	Rk1x2RhBXZ8umkAsOMbf6X0TIKQIPJdqK2W9Nrnhi2bA+rz1W4aCTNZ+wdOnVljej5ZvLk9C/G67/
	0JKZ005Q6xEflu0ALDhgKS1IrLWTUQHGcKmLoDw67Y7EHnEoD2iNrl+ED9hAHkvAvsgBl8/WgtKql
	Htkuvu8KNlhDn0WsVGJx6LLC2yTJ0lXN8NbyXavfwy1/fS7C1YZKOWPaOzPibl59NisfOpRKH+xXP
	PURPfk7nlcGIyNot7ChxTOrws1dKHuf093suC7tB615lMPP5Os7Pb4KvJbzy7jktET7Szru2B90Wz
	XMMyBcyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcMLG-00000007jGu-2frY;
	Wed, 24 Jun 2026 12:04:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcMLF-00000007jGU-0wca
	for kexec@lists.infradead.org;
	Wed, 24 Jun 2026 12:04:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4DC66601FF;
	Wed, 24 Jun 2026 12:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABD41F00A3D;
	Wed, 24 Jun 2026 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782302668;
	bh=bPkGECt5a+DPxd1vxVeft1Ofd1Mb2QRWXAtXqKgxgFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gHXfCHHeLJJQ6PuTMJDedcKWduFNd1gEpDrfxC0cXvLr5RvXcWyZxrXoRoFE6lDe/
	 V8PbBKhX2UwYqRfOdXUoEvJIE7gEKC9DZbULo8NEV5jonhC6sOJEYt1FpkLAIziamJ
	 0MzEgrttDApoOUHyIkn8MwPlAg3nlzwsrudmeVI31yS1rBpRp7+X+5u/5T+z46XBQF
	 DzCVrbdtlk/JfAzoBJin4OB4j3Oft7evDuvB1Mfazk2ginEgsC1s6Zm6l3buOCILVE
	 WSyB8LMIZezRNmbwRyUKQw64dUUSRIQIDBK4r4hS2dFCi5FJoFOITjX1Lw2rsV34R+
	 V9dTANI9rvzEg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id B3F5BF4006F;
	Wed, 24 Jun 2026 08:04:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 24 Jun 2026 08:04:26 -0400
X-ME-Sender: <xms:ysc7arJrmQBKPZMF7NHZ9TlaUeRfC4PjdpOQS23Md4llYtcCmRRSIA>
    <xme:ysc7avSmNCpscXkif3EuUFt60cx2HdrgoSg3x5RyeEQlgt_jllZ7Iu5JP0ivRffkH
    ZaTLlwhchhcqT45vK4Eq-LNVZkKKrmAmi6c7Uw2gnS2M8Sdn8Db1YU>
X-ME-Received: <xmr:ysc7ahisMMJgne3yhaqSpWOQ4ZNbxm8yl62DQeRPIf6o2pgVdcBWdavmetlbEQ>
X-ME-Proxy-Cause: dmFkZTE5F6I5b5uZvzSVxfQlILFYzxEnUbVGpGC0tlOAO1di1xZRoPj+aBYF3ihPNsV6UP
    AsQyKVi1xXuij4iiy8RU9hvvjU4ZhbyKXvWJNiNOEjkncWPlQrMyOpEMIbuMYzK1VCsIeX
    9eZQ3E2AsHkRloI8yXz+F1Qm18yX0pJokr8wZNZRv/PI6WIL3IrOdufGjVwdL92BvG070D
    HFdx6dkj+3BraPT3KjlB8VC957e/+oNNke/zhblgViiIKnDdvY0dmkJzjxY7OOZvLx871c
    qFoUJQNXHRvl7JVKuYZUpy3de409D0t6W5U1PXw+Wpf8CkWAQazEzW9mKFajAZXDTDgXgF
    ziYAfEMxaDqzsMOLfO8B0wK4U8VZ2Tgrf8Is76n9WT74HtuNp3l3YCfacvJhIAXn4exZCx
    mjw74zDmL9XDUxGh8z/7i3ZuV3c0EClGRQ56kwetkYSrOQzQFDQD7fekLoEhJiCGmEPGzH
    V6/hTquiL6rcojPoHWVT/bnoE+7It2Abm9QcozblpFEK0WKYbjBtcK3IjSlTy0u3dGzJ0N
    KWq2j6kUxy0mYBSOYltFVhqVIgmq8sN88iUzdsF51Xo+kX6f5Fh9a66uqIDvqn3xOMjghg
    WLAo8q6zCaLxyK9/P9dswjldKLuAoD0bxnW72YGG5Pt76IIPLaNfHQNmiIlA
X-ME-Proxy: <xmx:ysc7aooVbHNUJ-MsiwdYS3f7dWmYn035OELV-x5GozNcOjpOgpUACA>
    <xmx:ysc7agnWsCF1Ski3VuQJTTDgYhIbwTRfDOcBsNK6a0HHx06utPD8Jw>
    <xmx:ysc7ankraQY02ZSpJR7-e22Rz8ZgnOvEM7gyNZOfEbGyVvGUerNpAw>
    <xmx:ysc7atNe1BxOJlEwtiRCHC98iLie4dhu3n24xubz2GqtxvUnISMeZg>
    <xmx:ysc7am7ztHGF47Y0CQURacKtkYtjBjuw4irPf_R8CrP39zqnqgHGIIhY>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 08:04:24 -0400 (EDT)
Date: Wed, 24 Jun 2026 13:04:19 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, david@kernel.org, 
	lance.yang@linux.dev, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
	pratyush@kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, rneu@meta.com, 
	riel@surriel.com, caggio@meta.com
Subject: Re: mm/hwpoison: persist poisoned PFN list across kexec via KHO [RFC]
Message-ID: <aju5_WjBtagTOSJw@thinkstation>
References: <ajut_LDQGYCShApx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajut_LDQGYCShApx@gmail.com>
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

On Wed, Jun 24, 2026 at 03:39:38AM -0700, Breno Leitao wrote:
>   * Consumer: early in the next boot (fs_initcall_sync, before the
>     buddy allocator has handed anything out) it restores that array
>     and re-runs memory_failure() on each PFN, re-offlining the frame
>     and rebuilding the full hwpoison state (PG_hwpoison, counters,
>     HardwareCorrupted).

fs_initcall_sync is not before buddy hands anything out - buddy has been
live since memblock_free_all() in start_kernel(), and every initcall before
this one has allocated freely. So this is recovery, not prevention: you may
be running memory_failure() against a frame already in use, possibly by a
kernel allocation.

Two windows are missed entirely:

  - memblock allocations between setup_arch() and memblock_free_all()
    (page tables, mem_map[], percpu) can land on the bad frame.

  - The kernel image itself: KASLR picks its location in the
    decompressor/stub, long before any initcall. The next kernel can end
    up running *on* the bad frame.

So I don't think this should be a memory_failure() replay. The frames need
to leave the next kernel's view at the memory-map level, before memblock
and KASLR.

> Possible solutions
> ==================
...
> 
> 2. e820 / EFI memory map (E820_TYPE_UNUSABLE). Tempting because the
>    frame would simply never become RAM (no allocator race at all).
>    But: it is x86-only (no arm64 equivalent in the same mechanism;
>    this series is tested on arm64);

(+Ard. I might get some details around EFI wrong.)

This isn't accurate, and I think it's the right direction for EFI
platforms. EFI_UNUSABLE_MEMORY is honored on both arches today, no new
consumer code:

  - arm64: reserve_regions() marks non-usable memory nomap.
  - x86: do_add_efi_memmap() maps it to E820_TYPE_UNUSABLE.

And it closes the KASLR window for free, because the image is only placed in
EFI_CONVENTIONAL_MEMORY on both (x86 process_efi_entries(), arm64
randomalloc.c). So the bad frame is invisible to both the allocator and
KASLR, which is exactly what fs_initcall_sync can't give you.

There's also LINUX_EFI_MEMRESERVE (efi_mem_reserve_persistent()) -
cross-arch, reserved pre-buddy in efi_init() - and looks otherwise fine, but
it's parsed too late to keep KASLR off the frame.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


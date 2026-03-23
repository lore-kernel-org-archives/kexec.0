Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89F9F483E3
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYSdrG4lhGBkvbyIJ1O8SEkOWuJzyjQhEXG24a0bXYc=; b=DlOsrAF56GlaP/6iUFp732PDlr
	3YqYP/mcAMMPv0PVZ47c9+B/82PlyyZ+s+nlnCuF4hSo9PX1jebvpfrngjhiI62WDt+seauU/66UN
	ae5Klp5/1rgXJ78wbLMjWZLrpvjidjJGSN6qFBsDnVJHJBi3Axoxv1NqF8cAMkAByzZVao+/LbfxR
	VfHnSUTr0sB6KrQbUKneS4acMGlkwbnOCrWi5Tcgq8rI91jQzesqvtXCtIY/GtcIt5V5s8aGob2uy
	1eCT4HQGN7UA6WdwCT+9B6qiFPQ16FTVS+1VXXyjN704Yd4Fvku4YXFAHshjKUtKAhfzxyrh0hWTR
	gGPMrwxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4kXP-0000000HOzz-1Bus;
	Mon, 23 Mar 2026 19:02:07 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4kXN-0000000HOyT-2Vjz
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 19:02:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6B339600AC;
	Mon, 23 Mar 2026 19:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9B2C4CEF7;
	Mon, 23 Mar 2026 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774292524;
	bh=IwrSWtGi2v1DkqFTlr7GsesaD5m96uCr8RsRD7i9kXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDjXNoSPFa9vqQcYPFHo5QBuN9qbSdcVciNaX5z7tIjoerpVOhqIG3qOBnXy0wElU
	 bFM7RJYtwa3xrc7YS0cM1NsIpADp5QVBTEfLRJGD+WzfKyesme5R6ohwdjWZ4NtUi9
	 rCYk1cyu5LxVFxKfCWipoxIqXZqsNS59mNmeDwiU=
Date: Mon, 23 Mar 2026 12:02:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy
 Linton <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon
 Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor
 Malik <vmalik@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He
 <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, bpf@vger.kernel.org,
 systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-Id: <20260323120202.e662110de3ca696086f9e1f9@linux-foundation.org>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 22 Mar 2026 09:43:49 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> Nowadays, UEFI PE bootable images are becoming increasingly popular
> among distributions. Currently, we have several kinds of image format
> parsers in user space (kexec-tools). However, this approach breaks the
> integrity protection of the images. To address this integrity protection
> concern, several approaches have been proposed to resolve this issue,
> but none of them have been accepted upstream yet.
> 
> The summary of those approaches:
>   -1. UEFI service emulator for UEFI stub
>   -2. PE format parser in kernel
>   -3. Signing the arm64/boot/Image
> 
> 
> For the first approach, I tried a purgatory-style emulator [1], but it
> encounters hardware scaling issues. For the second approach, both
> zboot-format [2] and UKI-format [3] parsers were rejected due to
> concerns that variant format parsers would bloat the kernel code.
> Additionally, for example in arm64, both UKI and zboot format parsers
> would need to be introduced and chained together to handle image
> loading. For the third approach, I attempted [4], but since zboot or UKI
> images already have signatures, upstream maintainers dislike the
> additional signature on the Image. Moreover, for secure boot UKI, this
> method cannot use signatures to protect the initramfs.
> 
> 
> *** The approach in this series ***
> 
> This series introduces an approach that allows image formats to be
> parsed by BPF programs.

AI review has a ton of questions:
	https://sashiko.dev/#/patchset/20260322014402.8815-1-piliu@redhat.com

Coverage is partial because some patches didn't apply.  Probably some
of these questions are legitimate, others will be false positives -
we're still figuring this out.


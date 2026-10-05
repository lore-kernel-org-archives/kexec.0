Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D478CA5FCE
	for <kexec@archiver.kernel.org>; Mon,  5 Oct 2026 09:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Td2jgZ9iuFQaqHEEPoHQlHGfvsxyaNRBcTYEBxaNio=; b=M78FMrsbBGXdRoLrbkAEWSteWJ
	9a7WPTJblii2s5jzda52ULTzJK9aumEL3FofmMoODaD8Fn2bfyKUqsmD0KdvXBnXOwixAsg5uOmL8
	soaK3Zvr9aYTJ1PIo2ZwYs2XQ5OIu4Eie4jcLS4tyz/59QMjFOzSjgtGdevufeq/VtDyGifB9O7Jl
	hFv7aMzDPfX89ocrbmKUFI0kf6bcJcy4GOY05RUOsFbTVXOvY5xr3Mz4TVMSSRo/2jHpT+q1tKmbl
	fnfUsGxJhOpwH+xZ+JP+5dEGHSB/mDbODWtHIOKvgOGPFUrV/r+vZ0ywYLcRB+l/8CI3b8atmt6ef
	EVQPGUOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDefU-0000000Fw7o-0Z1W;
	Mon, 05 Oct 2026 09:07:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDefT-0000000Fw78-2qB2
	for kexec@lists.infradead.org;
	Mon, 05 Oct 2026 09:07:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 239CD60235;
	Mon,  5 Oct 2026 09:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEE01F00893;
	Mon,  5 Oct 2026 09:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791191250;
	bh=5Td2jgZ9iuFQaqHEEPoHQlHGfvsxyaNRBcTYEBxaNio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nS+xEIrUl7iXDaSwruA4IloVQLXLgkpGvQcXV6OM5uue41MZYyNq5xA9SHNCrsgCF
	 UIne/e4SFne4pVD0CdUduIInKMHbMUuyspHYoKsGQo1+gs+aoIhgfhIe2pAVt9G0LP
	 svfqOo+OABZ3XLx7agZ9LMPuFVGKADYK/b/6YGY8tfy+NiNX2y4zubsZCk1zeHH4SJ
	 tBIXiessJXo6JXpls53KTvghu6gy404bdFmQNloR3c6EpMWaeWM75SgsT5TdUgzREN
	 oksIIXk07MfFdnWDMSusN/9p654yp/DHyxo65F48Q1P0YlyhwobOLypGYQIFbidKe3
	 5MPlw7HM3Oq6w==
Date: Mon, 5 Oct 2026 10:07:27 +0100
From: Simon Horman <horms@kernel.org>
To: Serapheim Dimitropoulos <serapheimd@gmail.com>
Cc: kexec@lists.infradead.org, Bhupesh Sharma <bhsharma@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Philipp Rudo <prudo@redhat.com>,
	Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
Subject: Re: [PATCH kexec-tools] util_lib/elf_info: bound VMCOREINFO string
 comparisons
Message-ID: <20261005090727.GD184916@horms.kernel.org>
References: <20260911-codex-vmcoreinfo-bounds-mailtest-v1-1-32c9fe102018@coreweave.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-codex-vmcoreinfo-bounds-mailtest-v1-1-32c9fe102018@coreweave.com>
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

On Fri, Sep 11, 2026 at 10:23:51AM -0400, Serapheim Dimitropoulos wrote:
> From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
> 
> scan_vmcoreinfo() terminates each VMCOREINFO line before matching
> known field prefixes. Most fields nevertheless use memcmp() with the
> full prefix length, so a short line near the end of the note can make
> the comparison read beyond the allocated note buffer. AddressSanitizer
> reports a 24-byte read immediately past the allocation in this case.
> 
> Use strncmp() for the terminated VMCOREINFO lines and in the arm64
> VMCOREINFO hook. Check the ELF note name length before comparing it,
> and ignore an empty VMCOREINFO descriptor.
> 
> Fixes: f4ce0706d957 ("util_lib: Add functionality to read elf notes")
> Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
> ---
> AddressSanitizer found this while running vmcore-dmesg against a minimal
> arm64 ELF core. A two-byte VMCOREINFO descriptor containing "X\n" makes
> scan_vmcoreinfo() request a 24-byte comparison from the final four bytes
> of the 28-byte PT_NOTE allocation. ASan reports the read at
> scan_vmcoreinfo(), with the allocation originating in scan_notes().
> 
> Before this patch the reproducer aborts with:
> 
>   ERROR: AddressSanitizer: heap-buffer-overflow
>   READ of size 24
>   0 bytes after 28-byte region
> 
> After the patch, the reproducer completes without a sanitizer report.
> Empty VMCOREINFO descriptors and undersized note names were also tested.
> A valid synthetic legacy vmcore exits successfully and produces the
> expected output byte-for-byte.
> 
> The patch was tested on arm64 Ubuntu 24.04 with AddressSanitizer and with
> make distcheck.

Thanks, applied.
Sorry for the delay.

- util_lib/elf_info: bound VMCOREINFO string comparisons
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=0fd0d8e9ea97


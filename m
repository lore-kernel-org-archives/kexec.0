Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D9CCFA1E
	for <kexec@archiver.kernel.org>; Tue, 11 Nov 2025 13:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZGYg+6Xlczx6sBTmLN3MrkcOy5ayC2d+RAIRujtxDXg=; b=LaSS2GLX8WyzzPLV+KLjf1XBH5
	SVwFY9Az3ZQ4dPNQCqcJul0GVO51WrkE5sCnP+JVRVPrRXO35QmS62lqMkwVlOEmqq2kR5AYfSc26
	aiRm7jlpn4pNolHQXDz01qA5ZhhKP1t9d0voeg1wAp1gpUOC2lTJ3zT9ubA69Z3xMAJLcM9M5BVoN
	LRtdAXej+gqqkqP+RYUiFh44jtSdqocLVdMt1/LN+H8LEe6qmJiFX7yEXhRBmcdpBbCmbbILqvCTA
	r9ZNe8TazDOKoNgHyLHX0yu+68T7LLa3/Y7WnltN+p+oe2TcAOrFyyMzJgcy1mo8pNASjWW1lkAUv
	Nd1JLl5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoT7-00000007FG8-2Iwe;
	Tue, 11 Nov 2025 13:31:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoT6-00000007FG2-46j6
	for kexec@lists.infradead.org;
	Tue, 11 Nov 2025 13:31:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1B06860211;
	Tue, 11 Nov 2025 13:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED5FC4CEF5;
	Tue, 11 Nov 2025 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762867891;
	bh=x7lHQzV8xa5R7sMhlmuHYacgOVc5J10M+5fgMIXIR2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2bZIN1iPJRorwQZJtfVm87yCnpZ1fnlH6wdErOs9M+Yu3IyuoB/wpYx4sHW/i4Fz
	 O2gICtqDZRT99FSdt/2cJCfBwm6tzZTKxzcZMpzJ81PLaFdM78oBmjB/btx63DRk+X
	 1tky96fYnJSPvL/5S8KBMJNIeFjLJB7Rbrh+Wo555PR7+Uw+oKOQ8wwr3iyJCAb2Vd
	 J8MXT1C8eto8sBhS8nQaRne0ezJ8f4M3zxWxfG32CXRemvhQ45me8KRqkeDEv1BQ93
	 mif/l/shjouQwxd3eNNOG8jnWasIdlghz0X3g2ZRcPafRSqK4BcympIxHNXafYKhtI
	 ZumOJcixDsGzw==
Date: Tue, 11 Nov 2025 13:31:28 +0000
From: Simon Horman <horms@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: kexec@lists.infradead.org, Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH 1/2] kexec-tools: powerpc: Fix function signature of
 comparefunc()
Message-ID: <aRM6sOfZdcyB-2j3@horms.kernel.org>
References: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
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

On Wed, Oct 22, 2025 at 01:44:12PM +0200, John Paul Adrian Glaubitz wrote:
> Fixes the following build error on 32-bit PowerPC:
> 
> kexec/arch/ppc/fs2dt.c: In function 'putnode':
> kexec/arch/ppc/fs2dt.c:338:51: error: passing argument 4 of 'scandir' from incompatible pointer type [-Wincompatible-pointer-types]
>   338 |         numlist = scandir(pathname, &namelist, 0, comparefunc);
>       |                                                   ^~~~~~~~~~~
>       |                                                   |
>       |                                                   int (*)(const void *, const void *)
> 
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,

I was able to reproduce this using gcc-powerpc-linux-gnu 4:14.2.0-1
on Debian Trixie. Likewise for patch 2/2.

There is a CI workflow that exercises 32-bit PowerPC builds [1].
However, it does not exhibit the problems reported.

I guess that is because it is using an older GCC,
gcc-powerpc-linux-gnu 4:13.2.0-7ubuntu1 on Ubuntu 24.04.

[1] https://github.com/horms/kexec-tools/actions/runs/18554906205/job/52889935741

It would be nice to update the job,
but perhaps that is something that comes with Ubuntu 26.04.

In any case I have applied this series:

- kexec-tools: powerpc: Fix pointer declarations in read_memory_region_limits()
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=6c878e9b8a50
- kexec-tools: powerpc: Fix function signature of comparefunc()
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=2786f8eb3e5e



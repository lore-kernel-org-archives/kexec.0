Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4522CC5DF9C
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7KwqEJ2YTii5ttexwXqSYWI3ClTVc5nU9NJMGvUEhAc=; b=n2qDcbPzbmwgvpBqRygZes4GGO
	pI2MdNyRiwnLNpkDARI6IEX/fsEDB+J6Giek/uiEAiiN9GDggUFmWdHmf4tO3HHpApQIo9DMoZifd
	zAjeWCDUUcNXi9UKbl8J/y+J9d4rB/EQWy+7b82A9+Ph4ndIZo7Ed9dhU+trh+lunySB/gODbEyfr
	HexY+skM3zQpeRkjz23cWoBg0N0tkVjVU3cwb9c0tnyAncvv9lY3OSG+722620AJtvGCb+xanSRRI
	r3Ck2Po+oXcqUNKtmKhT8CwuEMrXJg5ZxE9Fn9gn7u0VZLJWgHRVCBEtxiPRjXFtPb9sh7LpBG2FY
	PMjnxjwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWq9-0000000Gx88-2Pnx;
	Mon, 24 Aug 2026 15:44:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyWq8-0000000Gx7H-0LVv
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 15:44:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 851146011F;
	Mon, 24 Aug 2026 15:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C81F000E9;
	Mon, 24 Aug 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586239;
	bh=7KwqEJ2YTii5ttexwXqSYWI3ClTVc5nU9NJMGvUEhAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mh7SAQlOny+D+mX67ttkRC8cslOdV/CM7k08a53hKwdcfn2wZbIIZmrcMO5EZWNag
	 FP2rqg1wh2s/IVShbnKzah69m95WOWKYbKc31cOg7ev2HyRFpyHICN6R44JrL3p12y
	 dFjdAHxT4+dPLAob5ZFNA8up9/6CSCNIli+2C2prG7MXZf7LxAR8cTjV69zSt6yh8L
	 iyifRPz1Mm6RrHmKqT7vtmTK3cNgqatbGzXIrOrw1Exq8jvjELLMpNJQnN2yAI+mFe
	 0s5sdMtsxy/NT2z2XVhSq3kVyiU1oZ0GroNmbO0AYnwdbsoCQZLUwDc2DmoOCgHbHq
	 A8Cjh2CUziysg==
Date: Mon, 24 Aug 2026 16:43:56 +0100
From: Simon Horman <horms@kernel.org>
To: Joseph Cathcart <josephc@linux.ibm.com>
Cc: kexec@lists.infradead.org, eoin.mcnamara@ibm.com, iii@de.ibm.com
Subject: Re: [PATCH v1] kexec-tools/s390: add --reuseinitrd support
Message-ID: <20260824154356.GC102316@horms.kernel.org>
References: <20260818153925.6203-1-josephc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818153925.6203-1-josephc@linux.ibm.com>
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

On Tue, Aug 18, 2026 at 05:39:25PM +0200, Joseph Cathcart wrote:
> Currently, the --reuseinitrd param is not supported on s390. This
> prevents testing kexec in environments such as virtme-ng, which by
> default does not store the initrd on disk.
> 
> When --reuseinitrd is specified, add retained initrd memory range to
> memory_range[] and fill new kernel parmarea directly with retained
> initrd base and size, rather than memory range of a new ramdisk.
> 
> Add die() cases for trying to use --reuseinitrd flag in addition to
> --ramdisk or --initrd, and for using --kexec-file-syscall instead of
> --kexec-syscall while trying to use --reuseinitrd.
> 
> Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
> ---
> 
> Depends on: https://lore.kernel.org/linux-s390/20260818153559.5700-1-josephc@linux.ibm.com/T/#u

Thanks, applied:

- kexec-tools/s390: add --reuseinitrd support
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=43c5cba85ad2

Let me know if the kernel portion doesn't land and planned.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8445D5E145
	for <kexec@archiver.kernel.org>; Fri,  8 Nov 2024 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EI141ps+PP0Hni/Hi6x9zz2FUVJk1cVCYbTW5Mma5VU=; b=EP2gCWB6b1xl5m
	l+ssyh9ghcjsGGIF0B9mxuY9TsqsQwXxnI28qymvwx13igqoA6i+rnxo4om7bTmW84F1wjqc+fmem
	3haeT/DVxI0BAV8FCehim29bntbvIay0GqHSKhZxvbqnBZUif7jL8WQ1/cMnQMcvMEXR4LP8ZbGe5
	zDFCgajmvjWRJd5UKWgwNzfN+z+VQbmnYvK5AKlnSwO7Eay1MWtiQXhWOOQ424jrJ25Cb+MhXZgFH
	gPnVBo77/ffTAD6gK1vB4hQHogCsS3gRhfMDaLnbOmeMTu7yhIgAaL4sgW8jE+Fru87ObwXdnEvro
	wqCMNHvOG8FCCaVbojyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Jxl-00000009hvm-1Gjz;
	Fri, 08 Nov 2024 08:03:25 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9JxF-00000009hqt-1IRy
	for kexec@lists.infradead.org;
	Fri, 08 Nov 2024 08:02:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 026B5A42F36;
	Fri,  8 Nov 2024 08:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58FEC4CECE;
	Fri,  8 Nov 2024 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731052971;
	bh=u6tHcMMbaivlkcB31/xixjvAgErgLqtNGhBnM2MRiMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjGTCS9I43VQZU47RZFFlO/cck/em2v3HYFKm1czwPjpL4iSGQolCwXhz4a5555iO
	 ODzS9GCVUWwwzL4gNiSuByeAwb8QwqnDIvyRLk9NnDYnvzqNoQHUxTd1uoj77UebkE
	 TQtiDShbM153UDV22d9eudEvRDHzJTyonl0Bgu9ytus6MzXLeutbrgoy4aDTkdYrLy
	 rm5EGjPknC1W8JPzPmHZAMe5ItVe1TVCZ2XPXjJDusUKwlcWov+YGuyCZrzm6Jt9vN
	 r4M2OJ9DTELHlepb24tT7wStbtSxUE9aV6mWypLanIscwRD432KNgJP5/BXcflXBo4
	 yrdqr35VNjGnw==
Date: Fri, 8 Nov 2024 08:02:48 +0000
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v1 1/1] kexec: x86: Use init_size in 32-bit case as well
Message-ID: <20241108080248.GX4507@kernel.org>
References: <20241106175807.1042574-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241106175807.1042574-1-andriy.shevchenko@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_000253_432114_7B64053F 
X-CRM114-Status: GOOD (  11.45  )
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

On Wed, Nov 06, 2024 at 07:58:07PM +0200, Andy Shevchenko wrote:
> If the region of the memory is not enough for the decompressed
> kernel, e.g., it follows by reserved memory, Bad Things may happen
> as it's proven to be in practice on Intel Merrifield platform.
> 
> Include decompressed kernel size into the calculations for finding
> the appropriate hole in memory to load kernel to.
> 
> Note, this has been already done for 64-bit case, this just
> synchronises the approach for 32-bit case.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

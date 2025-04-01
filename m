Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6436C3601A
	for <kexec@archiver.kernel.org>; Tue,  1 Apr 2025 08:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y2g+4tPC+rBsGkzo/a6BZQR5HMf/URUGDu5eBQLBWqE=; b=J09sFCef/39nnSmP0teZ+PtLA/
	4mxeE+H02USGbkeZOE5lFjhAKtAX+VYK9pOeGADLlo45Ita5KyJ4V+zgG1hkrCZ4l5U2Vn2t0odvA
	V2HsafT1BhwbUQBIeijj36bWfPPrFLmjq8YX5hfsK/kf8Iy4sm9vXCIjTgy/ngjQS9BYpq80c7O49
	pUaCy+BZQjdYH105e1y89iraGhLwgAs8ZG6NkqypXUWYc8m0LRKgFSdCVLmfdDCrTsOOoUCl5XKEX
	ei9iaHcJE5Nv7ZGKNRplw8Hxeg4iLG3u4WO8DaawQZthoe0wbttE35pov+9qsGZ3sT1zrARVv07d3
	nfFQOJPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXCE-00000002M3f-39sp;
	Tue, 01 Apr 2025 08:42:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXB0-00000002Lyp-0e2k
	for kexec@lists.infradead.org;
	Tue, 01 Apr 2025 08:40:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BC86661138;
	Tue,  1 Apr 2025 08:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D287DC4CEE4;
	Tue,  1 Apr 2025 08:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743496853;
	bh=zlfY4fiJI2PnShZN27Kymvau2f+p8IEzNj8RIODp93I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdbjjq29miKHSdQ3AEreVXYMuOrFvV8HcvqUmtpL/o1ivAGvl57row7L9P8hb1Aou
	 wgfLyqwykoLs8ZDkeTrnKYC+EiI8NQeBVyt9q7tBEXtKjI/haJvERxmBxmE8JX9HPS
	 RaTf38B0BWHmjMUoBNiStLKPSwHpi+iYvclayBptvCJLoqx+ApBgIsPvwvsuMHNKyo
	 H7ssBITVvJ6kFEbBcW3b51dOnFp/Q/0PkCkYbY1bB+KGIpuPQWAy+WmJZyraxukl2C
	 ka4HhlXWZv6ZSzrPRu8zBFPErOucIflkl+ldoiZoRnCqM3aATsB1yyfU3SXjMk5I1x
	 66tFnD12yU0cw==
Date: Tue, 1 Apr 2025 09:40:49 +0100
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, simon.horman@redhat.com, dyoung@redhat.com,
	ebiederm@xmission.com, kexec@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Add Andrew and myself as kexec maintainer
Message-ID: <20250401084049.GA225535@horms.kernel.org>
References: <20250328104402.16826-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328104402.16826-1-bhe@redhat.com>
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

On Fri, Mar 28, 2025 at 06:44:02PM +0800, Baoquan He wrote:
> Add Andrew as kexec/kdump maintainer because he has been helping review
> and merge ready kexec/kdump patches.
> 
> And I would like to nominate myself as kexec maintainer because I always
> try to review generic kexec codes.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

I support these changes, assuming that Andrew is happy to take this on.

Acked-by: Simon Horman <horms@kernel.org>


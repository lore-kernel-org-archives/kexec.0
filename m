Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC93EF06E3
	for <kexec@archiver.kernel.org>; Sun,  8 Feb 2026 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDzR9lpKjFEUV6LzjMz/jFbiERE11kuQT8Dk9zXCm+c=; b=vpnjqPdQkd0oqh4pkUHe0bfq9O
	gZI8/PolTtreDQ0GLGt1IVHQNG7ukRXtzrej/fZ64rgzj61A/vbG40XWsA8Vy23KeN5EUASbyx07e
	NITAqcst9TGLF/xX3QhonTnvg7vxXGc3b5/zb74ikjiecvvKkVOn4ZoZ9V5Iw1CxkgGKlQ4EQGC1D
	psuA/BkwVeZRRcckijdlyZQ8+504q2RBBVK0sepKnULDBaHrnuqMfTfyN7YMH1VSaWz2w8cVzINYt
	des3aOm4fDq6w7w3unGgSm0Ca7uLjqwkfYBTMFdPiTr4xKaVF+i0T7MnbWcBGdi+KR1V9e/Zt5lXM
	TQcdkR5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vp9CQ-0000000DXSM-0KkX;
	Sun, 08 Feb 2026 18:07:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vp9CP-0000000DXSG-2AHK
	for kexec@lists.infradead.org;
	Sun, 08 Feb 2026 18:07:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A8E0600BB;
	Sun,  8 Feb 2026 18:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5FBC4CEF7;
	Sun,  8 Feb 2026 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770574076;
	bh=kQt8t7OYMDtNIa31uvKvR7rjvGtIHYQ481BGVMxx3o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCkh6TOJJvFbwBRVm1u4XSnuqOddU90qqDYh7bHdCfTliBoksC2mZUXnJ6aM/9csd
	 q5EN9teFq6YQCsfb28mfFOUt9tXnGZHFrKDbLeOsuGPhXeE8lkfUQzaTh7FDP0bAnO
	 RrROpFFspU3v6NrUtV6rz/FVijUm8MwCTBTHLTtdjGrZCtkOOfxEdo7HSGsWOLbZRM
	 1oNVh+YGmDLy13BHv5N9HTfyhrt6BVSGLK2yauQV8TQuaKKcIL2JuUSr+BDBtc6BGQ
	 18hko4wU0uu6JDzKvMrlFSsqmgadgl/VnYXl37i4IsnSjopbD+MWorp2oRQNaISbDu
	 lt5o7xLDLouTg==
Date: Sun, 8 Feb 2026 20:07:48 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 2/2] kho: Remove finalize state and clients
Message-ID: <aYjQ9FYujrFJVDel@kernel.org>
References: <20260206021428.3386442-1-jasonmiu@google.com>
 <20260206021428.3386442-3-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206021428.3386442-3-jasonmiu@google.com>
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

On Thu, Feb 05, 2026 at 06:14:28PM -0800, Jason Miu wrote:
> Eliminate the `kho_finalize()` function and its associated state from
> the KHO subsystem. The transition to a radix tree for memory tracking
> makes the explicit "finalize" state and its serialization step
> obsolete.
> 
> Remove the `kho_finalize()` and `kho_finalized()` APIs and their stub
> implementations. Update KHO client code and the debugfs interface to
> no longer call or depend on the `kho_finalize()` mechanism.
> 
> Complete the move towards a stateless KHO, simplifying the overall
> design by removing unnecessary state management.
> 
> Signed-off-by: Jason Miu <jasonmiu@google.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


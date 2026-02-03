Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A68E87842
	for <kexec@archiver.kernel.org>; Tue,  3 Feb 2026 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6T3Az5ve4UBbIJhUKrG9rATlOgWfWRksnYXGgxKSvYE=; b=1241qvQXX+6P59muhx8JUUFnKH
	+kOnEzvGFo/Lbn1e49ScH4SlnPndWemobHP6J3sFNyp7rD/zVlVCGTOMMj5VJSiyqKgo+1ErTKxGs
	W6Xq5Mt6S878udTVbqxf5ngUpzUIe1DtMTUlRkv8IaNCIgxSjztqeHKXlpYndp/CfUTU7v68Mj8rk
	S3Tt+K962MoFKmH51rJDEbgm7wfh1/m75nUnp80VzPF/tRPqH7wb/PlwddWP5B4y6eBOirAq/T6q9
	gJaOWd01AjstVRyOlSb2u8jBrFdQHVVFzMg2A2ohhURB/6r+97spl1y84VA+BzEOwaIvRUoO913AC
	7e4KHSkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnJ6v-00000006uTn-2tHi;
	Tue, 03 Feb 2026 16:18:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnJ6t-00000006uTK-30fs
	for kexec@lists.infradead.org;
	Tue, 03 Feb 2026 16:18:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CBCCB601E4;
	Tue,  3 Feb 2026 16:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A752C4AF09;
	Tue,  3 Feb 2026 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135518;
	bh=t+xsjeWFVLSKurDj7D5PeSnLdx1mHlEer5mWWhx0m+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPw9Yz2ewWsZC74qCWy79KV4zsVshB9Iq/hOHPwXPkby4iTb1vviUNVI95rFWf+uW
	 d3hT1L6a1m6W6qTyXU2sKIn7mU8YNOXSr6UJBWZ7KLLSeda6byFvzEaWEmiQnFtR5I
	 FcwctMmaiENipUcr0hLmua/ZZmMFm1FoGCiTdB5aZDdGvML7fHQsnp6HZMZ2EliVjp
	 //DSe/t+woW8eO9F0uWmzJEixjW5kYCuzIAO6mLNPnFVKrsUNsMQEb3y5deWlcCSNU
	 Pw374nkEBvZmDZYfQgxTpcCkTT8upXMyHcnw75bd8l9gRG5Yo1itUkBqUWxeH7kMaF
	 oeQ9nePc6dLqw==
Date: Tue, 3 Feb 2026 18:18:30 +0200
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
Subject: Re: [PATCH v8 2/2] kho: Remove finalize state and clients
Message-ID: <aYIf1hOQzG6xuTAA@kernel.org>
References: <20260130005739.3163049-1-jasonmiu@google.com>
 <20260130005739.3163049-3-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130005739.3163049-3-jasonmiu@google.com>
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

On Thu, Jan 29, 2026 at 04:57:39PM -0800, Jason Miu wrote:
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

I think I already added RB tag :/

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


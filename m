Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68764CD37B6
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Vays8x+y+TnHpt//KEgyCfpbymoIR7MVrgJDMaqlXI=; b=iTb+RFEKLKzrD/zDJ1ihPu2+Ml
	IDYD24213yGaw/1FXk4zSjTQ5BKH+pAskM58GnpQ0ravJ32AzJQjSn0jeYY+56exAY9DbMjTe7H/5
	wAXCRvOeGnxqpCR9iRChJKmR6Muv6lkYC02l0QBwiNWGDufxX3Q+d9GECOLG89OHeVGYuUxNdZ2gP
	7ngwHsh1Xd8A0H4QeDKGcIOcxq94de9AYdDi+jeklR8tnG7kt/vvKDH0SxIpPLUvG6074lWmT12Ia
	pjGgZWtpUE8VWwqT+xNNnEtud1vi+qOIHcy9AzjKiPNkVnU5/dcaB2giDH2ON4VPPh6yUwiSuNFcb
	fxG5CmRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6tP-00000002C5m-2Q8A;
	Wed, 13 May 2026 10:32:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6tN-00000002C5L-3TZP
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 10:32:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EA3A60121;
	Wed, 13 May 2026 10:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23970C2BCB7;
	Wed, 13 May 2026 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778668360;
	bh=ZzMQKwrs8B6u4WEOzanO567l+RO2hrydIn7OzIi6yAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkdigcFqYg7kgngvmc1Zg+e8nSoebVC897YRbfvvcVJb338fBeXZLs8HdeIzRy354
	 SzKevcBnEP4R3NeTNSCKNCcQfv4lNzl0Nf4bWMNfIQLLzJ8IQOtb9tAwaJpqKbEuKm
	 d6tvQ1P8fm/l9DZ3Oq94JuNh2/qbdFT4nVQneTibUmCVhcgQepdkHNVZqwadU3ZRv3
	 wNtg//yn0q1p8KhJlxevexxGaBX0RI6Gk3we/zAvKpKuw36Q2rX0CebFL/U/0trcCI
	 GwD+B+a7LSlauF2OQVxcVbzB5Htoar2TJgBhYC88x2NIeSpViE3GfKmXsvtT+HDnwe
	 61/OXJ9VmdcBg==
Date: Wed, 13 May 2026 13:32:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] kho: generalize radix tree APIs
Message-ID: <agRTQLJv9pMEZe_7@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
 <20260429133928.850721-2-pratyush@kernel.org>
 <agG-OuOTAg5YD-CV@kernel.org>
 <2vxz8q9pdib3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz8q9pdib3.fsf@kernel.org>
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

On Mon, May 11, 2026 at 06:25:52PM +0200, Pratyush Yadav wrote:
> On Mon, May 11 2026, Mike Rapoport wrote:
> 
> > On Wed, Apr 29, 2026 at 03:39:03PM +0200, Pratyush Yadav wrote:
> >> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> >> 
> >> The KHO radix tree is a data structure that can track the presence or
> >> absence of an arbitrary key, with nothing inherently tied to KHO memory
> >> preservation tracking. This was one of the design goals of the radix
> >> tree. This was done to enable it to be re-used by other users of KHO.
> >> 
> >> Despite that, the radix tree APIs are very closely tied to KHO memory
> >> preservation tracking. Adding a key is done by kho_radix_add_page(),
> >> which encodes it as a page tracking operation and takes in PFN and
> >> order. kho_radix_del_page() does the same. These functions encode the
> >> key internally that goes into the radix tree. kho_radix_walk_tree() does
> >> the same by baking the PFN and order into the callback arguments.
> >> 
> >> Generalize the APIs by taking the key directly and doing the encoding at
> >> the callers. Rename the functions to kho_radix_add_key() and
> >> kho_radix_del_key(). In practice, this removes a line each from the
> >> functions and moves the encoding function call to the callers.
> >> Similarly, update kho_radix_tree_walk_callback_t to take the key
> >> directly.
> >> 
> >> To keep the naming convention clearer, rename
> >> kho_radix_{encode,decode}_key() to kho_{encode,decode}_radix_key().
> >> 
> >> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> >> ---
> >>  include/linux/kho_radix_tree.h     | 18 +++----
> >>  kernel/liveupdate/kexec_handover.c | 76 ++++++++++++++----------------
> >>  2 files changed, 42 insertions(+), 52 deletions(-)
> >> 
> >> diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
> >> index 84e918b96e53..f368f3b9f923 100644
> >> --- a/include/linux/kho_radix_tree.h
> >> +++ b/include/linux/kho_radix_tree.h
> >> @@ -85,7 +85,7 @@ static struct kho_out kho_out = {
> >>  };
> >>  
> >>  /**
> >> - * kho_radix_encode_key - Encodes a physical address and order into a radix key.
> >> + * kho_encode_radix_key - Encodes a physical address and order into a radix key.
> >
> > Let's keep kho_radix_ prefix for namespasing please.
> > This is the common practice these days.
> 
> I am keeping the namespacing, just moving it out of the "kho_radix"
> namespace to "kho" namespace. The mental model is that this function has
> nothing to do with the radix tree. It is just something KHO uses for one
> of its radix tree, so it should live in the "kho" namespace not
> "kho_radix".
> 
> Does that make sense? I can add this explanation to the commit message
> as well.

With this explanation it makes sense, with "to keep the naming convention
clearer" it felt the opposite :)

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


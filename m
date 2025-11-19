Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A53DCF3943
	for <kexec@archiver.kernel.org>; Wed, 19 Nov 2025 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Cmpu4dlPICQ7jEZW3q9WrL3LoFxSpfQ1qa9NR8USio=; b=vVyCt0hasGAuCkkOgt0i8P5VkT
	fWgIK3YYc+o77ob2zo+yOrsx0Ed5GGXgAClUa9WGvlGY4zOLHcwqC3n594DxifSq4qVo1VDfoL4Nt
	mUwCRbEtSRQge+lzwQLOkUfzIJHP6CUhzgTf16GjU3kNKhwe6shDZpbhuKAF2HpDZ7GYxerXeiibv
	La7WiR2mZDNUqxZg4VK05vd9qGF/lG99WwS9wn2sFml7bwrA+/SDHhgYzFPcBNQnVXRNmWSFRlhyS
	PCCYkbAu2qbBYYFHGx1aF8MN7MRc0oHTXVHKTBZe1fLd/8lPzqfeNLI8NU2B5Soz0ucNYUNMGrRvQ
	YWnxR1+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLkWW-00000003bg5-2Mqc;
	Wed, 19 Nov 2025 15:55:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLkWU-00000003bfb-05Sj
	for kexec@lists.infradead.org;
	Wed, 19 Nov 2025 15:55:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 46CD3442FE;
	Wed, 19 Nov 2025 15:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C35C113D0;
	Wed, 19 Nov 2025 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763567709;
	bh=gjDP2XYX+ovocOAAnCbnLjruEh9DhHdieIst67As1IU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZHNRg/4V/VlqnzWuKRvqScmKkGA5uOlh8+un22hhoP2BOPO7yDBoSWzRXLxlUCSjN
	 da8rWk89W3/awMVc4m+xhFUOF1XxpM/jCc4vcpHNdv4FVpYx35Ht4KQPQYJpv81vto
	 G0MJwcyuMBFQbX4yrbE4XXw0vBIPCTozn5HrwbIsn0+R3aYugExuJjlavubeRKWSma
	 isEAg9nLiTFySCB5VfdL0bnb77o2vU7Mxkl6M0PGY58R+LTlpsT9olP1QVvEJXGwul
	 Ng5nR0UVCzKTcEzFKSgj4CCPf7W2eGI+qjyyj/hT/cln4EqIXXerX5xYsZPX9N22X9
	 GpNFfEyCnmyPw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
In-Reply-To: <2025111944-tracing-unwieldy-1769@gregkh> (Greg KH's message of
	"Wed, 19 Nov 2025 02:36:09 -0500")
References: <20251118182416.70660-1-pratyush@kernel.org>
	<2025111944-tracing-unwieldy-1769@gregkh>
Date: Wed, 19 Nov 2025 16:55:06 +0100
Message-ID: <mafs0wm3m2f1h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_075510_106053_FA4136A9 
X-CRM114-Status: GOOD (  12.55  )
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

On Wed, Nov 19 2025, Greg KH wrote:

> On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
>> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
>> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
>> KHO maintainers can get patches for its test.
>> 
>> Cc: stable@vger.kernel.org
>
> Why is this a patch for stable trees?

If someone finds a problem with this test in a stable kernel, they will
know who to contact.

-- 
Regards,
Pratyush Yadav


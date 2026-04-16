Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D7FF8A146
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JrmV0E2FR5QIiwCjjUz4crYhfG5jwFca3BcKbwvfTbU=; b=De1eIASyXhwlgG4IH7o+fxBGeq
	pv39D97kxUF8qBUCQA/4jWgM3vGovaFJTmlAkDFtGbHAo0CINECtZQT00OYrSFQAgAt2BK/QzwlRJ
	bnsVOPTM9kQBkdqMhVPZTGecO48/kMsfCP33ZWSG9Za33EGVGAZgtlH0bcYpPApc0XM+QD5rnGSWW
	me+iSz0A5owk9iIs2bSyKY1ysJyKxQS/hz+kXLdilm5wkFn7dcrYFfZzcrP7l/zx42IM3QKoLi9Ov
	2sYjJpPpPfTVSg4Gej2ANtTIjdhgrdDEjZqPBajZFUAL9O0wIYrmf9D9shjnEeHCyH/AzM6P4SP/w
	kpK4PpzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDJGf-00000002GBD-0u2D;
	Thu, 16 Apr 2026 09:44:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDJGd-00000002GB1-3S08
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 09:44:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E10EB60123;
	Thu, 16 Apr 2026 09:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A991C2BCAF;
	Thu, 16 Apr 2026 09:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776332650;
	bh=CPSWvjITVlDgLqJaNBJ4mUklmtrmxg+VXMXbQXCouI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=naarDjEyGSJoW4LnTL4F2XkqZixsO54podpGe54idT5LI8xKd9lFol6POyM9EjwyS
	 HjZsccyA4hqkKhLkrYCnoqCfkUa0DlTmc/CeJnpiLKHlNmBtzxHFpZepRWmzlbGiSL
	 6Ne/oUuxTDNJgwK/UpkYdnUuJScKVNdxzdQSH8xVfbgM9t5Mu0SXmZQGKv+wfHLWUv
	 W8/alr94CH26BOTOvpFAhpeXQ77+8RXwF8KoNd5n8hPwv9JC7u88P/yzdtWlbJQ6zb
	 nV05JT4Q4zSuYVxFN9IExOz/LY9yI5Oi9bhQDEoX6kf1oZ3Owy6AgzcfwFij3w3tfJ
	 17PuGeGbNQdpg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
  Evangelos Petrongonas
 <epetron@amazon.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
In-Reply-To: <DFD0C0F5-F23B-44CA-B2C7-9D03F2397DCF@nvidia.com> (Zi Yan's
	message of "Tue, 07 Apr 2026 09:21:25 -0400")
References: <20260317141534.815634-3-mclapinski@google.com>
	<AD9E1B18-C813-480E-894C-FEEB51EE8A93@nvidia.com>
	<CAAi7L5dSOxXETv-bYs4hJ1SfixMBQXS4fmfKs3SzVvQ=yY7oSg@mail.gmail.com>
	<76559EF5-8740-4691-8776-0ADD1CCBF2A4@nvidia.com>
	<CAAi7L5ex+66qgFzRkLDbuOmC=cVrMyBctPZv6wd15n1rc2U9KQ@mail.gmail.com>
	<0D1F59C7-CA35-49C8-B341-32D8C7F4A345@nvidia.com>
	<CAAi7L5fvUPUqd3A4m6wubeYh90NH+S2KBRE1R8WKerBYhkU8kg@mail.gmail.com>
	<58A8B1B4-A73B-48D2-8492-A58A03634644@nvidia.com>
	<aburnbP64n9axmu_@kernel.org>
	<CAAi7L5evx8ta8BifNiGNfUoTiaBUsv4cgQRbm_15RoAfdKPcMw@mail.gmail.com>
	<acAAp4JaTGn_STBH@kernel.org> <2vxzwlyj9d0b.fsf@kernel.org>
	<DFD0C0F5-F23B-44CA-B2C7-9D03F2397DCF@nvidia.com>
Date: Thu, 16 Apr 2026 09:44:06 +0000
Message-ID: <2vxzjyu76xzt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Apr 07 2026, Zi Yan wrote:

> On 7 Apr 2026, at 8:21, Pratyush Yadav wrote:
[...]
>> Hmm, I don't like that how complex this is. It adds another layer of
>> complexity to the initialization of the migratetype, and you have to dig
>> through all the possible call sites to be sure that we catch all the
>> cases. Makes it harder to wrap your head around it. Plus, makes it more
>> likely for bugs to slip through if later refactors change some page init
>> flow.
>>
>> Is the cost to look through the scratch array really that bad? I would
>> suspect we'd have at most 4-6 per-node scratches, and one global one
>> lowmem. So I'd expect around 10 items to look through, and it will
>> probably be in the cache anyway.
>
> It is not only about the cost of going through the scratch array, but also
> about adding kho code to the generic init_pageblock_migratetype().
> This means all callers of init_pageblock_migratetype(), no matter if
> they are involved with kho or not, need to do the check. It is a good
> practice to do the check when necessary, otherwise, this catch-all check
> might hide some bugs in the future.

We can move the check to memmap init, so it will still be done for most
pageblocks I reckon. The only other callers I see are zone device and
CMA.

Anyway, I get your point and am fine with moving it out to memmap init
functions.

[...]

-- 
Regards,
Pratyush Yadav


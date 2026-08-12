Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D04C5AD5A
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 10:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7enFee0jAt08OEyw0dUeqUaEU2QqTLX8gKg/GfUdVQo=; b=Z67bR2YDH9PBSa8O+DB1XQXO2h
	ROB6dV/3Sc2X8GY4qGzjfpcqpijLGRvM0MhHESjCL3IR/HOv2rLaOzG7Kuto7nr/GsYCKbhvUVSKS
	s16rh6N5V/ZjswtZuOO5NKgXc7clHJ/oCjMFFwOo3wG7gGc0tDAMRgh2UXeRGWJBaeT6DgzDTeG0u
	bqz7BEQhscpxLjvrUQXYC0ODHiDiOEGmCgV8BcvTLg4mIya59fjgmknMZPXUIhqz3lvO+8F4rEcOI
	EmcZrOtF0YGAVXseEBwjTd400UwVqgzgvxsdKHHFSyI6H9cqP0OtQHnIB2p/qicukCTTAnR8jo2eC
	yTn1TwGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6G8-0000000Fu3E-0NPA;
	Wed, 12 Aug 2026 10:32:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6G5-0000000Fu2v-2Gdo
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 10:32:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 03CA560A88;
	Wed, 12 Aug 2026 10:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011DA1F000E9;
	Wed, 12 Aug 2026 10:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530748;
	bh=7enFee0jAt08OEyw0dUeqUaEU2QqTLX8gKg/GfUdVQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=HeDSLgDM6lV5H3FjBS7R0fKuLaRZlILJlBAykX+QILIl6u593Cn5+YEZ6cP7bAL/z
	 1hIIuDEvmhvWJe+sAi4nQNciJis5uxa++bY8vAFlUYXmTa16eLXdK8I90EKszZFt+y
	 6XOWjBn8PaGLWuYCWt7CgHfGYAeXpNUsCB/NYAY+I2Ein1nwAsySA119VYUb3E406d
	 FipOXlUdZIXF4n4qEfdue4yR74U85S59MD2Ej43NemqcvyFM4raZQTHea4HVJxJ49j
	 hP9S9rigy180grTLHjxasl+WKjERwi+MM51yB3PKYnrUuZqGyRbN5KFTJhRK5KMY+c
	 MQwBYbMgjsw0Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pranjal Shrivastava <praan@google.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Samiullah Khawaja
 <skhawaja@google.com>,  David Matlack <dmatlack@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] kho: support preserving high-order non-compound
 pages
In-Reply-To: <anr4-F-e5_vHEar8@kernel.org> (Mike Rapoport's message of "Tue,
	11 Aug 2026 13:27:04 +0300")
References: <20260803113944.3694290-1-praan@google.com>
	<anr4-F-e5_vHEar8@kernel.org>
Date: Wed, 12 Aug 2026 12:32:25 +0200
Message-ID: <2vxzv79f39za.fsf@kernel.org>
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

On Tue, Aug 11 2026, Mike Rapoport wrote:

> Hi Pranjal,
>
> On Mon, Aug 03, 2026 at 11:39:41AM +0000, Pranjal Shrivastava wrote:
>> Introduction
>> ============
>> This series is required for the ongoing effort to preserve DMA allocations
>> across KHO [1]. It addresses a fundamental mismatch between the current KHO
>> restoration logic and the physical reality of high-order buddy allocations.
>
> I skimmed through the patches, they look fine to me before the in-depth
> review :)
>
> But we are really close to the merge window, so we'll anyway need to
> reiterate after v7.3-rc1.
>  
>> The Problem
>> ===========
>> The current KHO restore implementation treats all multi-page blocks as
>> split pages during restoration. Specifically, kho_restore_pages()
>> initializes every 4KB sub-page with a refcount of 1.
>> 
>> However, many kernel subsystems, most notably the DMA allocator (via
>> dma_alloc_coherent), frequently return high-order non-compound pages.
>> In this state, only the head page carries a refcount of 1, while
>> all tail pages have a refcount of 0.
>
> This hints that these patches could be a part of the DMA preservation
> series, unless you expect other users of the new API.
>
> Generally, we don't merge new APIs without the users and if DMA
> preservation is the only user, it's better to fold these two patches there.

Makes sense I think. We can review the patches here, but then they can
go in with the DMA series.

-- 
Regards,
Pratyush Yadav


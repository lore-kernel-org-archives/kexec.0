Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9280BCD37BE
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCYrtbFhK/BqbyCC51Y7EFk0DyopccmjT6Qz3J8kaBM=; b=v39n7mwxPkv6ft101kzSxvuDLs
	FlGr0AZfk4q9WDcutXFVGffLFhWcbZaOeIQzKbKQ86bMb+LcJ16fDcH6XsFaeVkOkfDtgkKR0dDL1
	O+rAo0O1TFWqbiKnPKQeHT1UedpdZwP4RjaV8YNbPGSX0BHQsdvH1R9Oj0N3/3/7QD7cf/iplFcQB
	+WJFxDa5/dHvxV0iczGaZ7wz1wzsXJgu40HYnQPyScuti2jvyHn13GVp7cJPDRzAboO2GIc5pRd7B
	qv3fxrHS2mQKTm1Rx2+t/yamf5+BL49nEVr8668udsIlVS2qn1L5IoKdyyeXZhmkdclfp4LfBrHLy
	I1gs/BdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTdm-0000000EEbz-1fF0;
	Mon, 11 May 2026 16:37:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTdk-0000000EEbj-25tS
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:37:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EF8086001A;
	Mon, 11 May 2026 16:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF4DC2BCB0;
	Mon, 11 May 2026 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517475;
	bh=1RfJS1aJjFsfMSotJ2thwUAXHq+RuaNrgrSptVxqnkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UTUovfWQQwywyQ605mSF8CC2LQ1+uhAnHnrWselk1awvZQLicAlyeB8gmnUQTmKF8
	 EnNNyf8mONLtMnI7MWFFDaAhFQS5p5XOOYdbkGAkf1Adguq7B9f42ULlJsdF43QKSs
	 iCtBt7dEbFv7u25jJQGhWjWLBh2MSwNlqArbBLy33Yn63OZrvHXGgp2ednWyBeGrMf
	 OnatP3UAzYKEu/RIpEhWhY2eOVBvlxj430oMXVvJEx/3/4BP53D8fshzljeVuhljhe
	 /v2b3z4DO8Z70buo2qtetrAO1GGhS+P3EK2X8C5JcwdMoPp3/L4bykY6aVwvC4FItc
	 vlu9ntaiB4huA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] kho: allow early-boot usage of the KHO radix tree
In-Reply-To: <agHD-E4iDhvUEZDS@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 14:56:40 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-7-pratyush@kernel.org>
	<agHD-E4iDhvUEZDS@kernel.org>
Date: Mon, 11 May 2026 18:37:52 +0200
Message-ID: <2vxzmry5c36n.fsf@kernel.org>
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

On Mon, May 11 2026, Mike Rapoport wrote:

> On Wed, Apr 29, 2026 at 03:39:08PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> The KHO radix tree allocates memory for table pages from the buddy
>> allocator using get_zeroed_page(). This is not available in early boot
>> when memblock is still active.
>> 
>> Using the radix tree in early boot is useful for KHO to track metadata
>> about its memory. One such example is for tracking free blocks for
>> memory allocation when scratch runs out of space. This feature will be
>> added in the following commits.
>> 
>> Add kho_radix_{alloc,free}_node() which allocate and free the table
>> pages. They use slab_is_available() to decide which allocator to use.
>> While slab_is_available() indicates availability of the slab allocator,
>> it gets initialized right before buddy so it serves the same practical
>
>                            ^ after?

ACK, will fix.

>
>> purpose.
>> 
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)

-- 
Regards,
Pratyush Yadav


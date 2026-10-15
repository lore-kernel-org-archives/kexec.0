Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D086CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 11:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bIfes0VmGz93Q/D7qKVAipk4bYqd8Rm8ZLiZKuFMUfw=; b=KYKELCIKGcZiRVSFWF2TfFn+ql
	vtugim7y+6mQvvEQ7PIDHqdy2+PfwCnz/YQkUfCFU1JlNCnD0aCeqs0Spajqm75feWdc9V7T5YLhI
	bv6F3QB0bKA5JF9OiVpZwme254ZkxUrY7Cc9cidSF8hNOKM9UOZ0LxmMI1g4EM830riXXLKbJ2K6t
	FJJymfY6BlnLCPOT/+jIFop8oykhNvMV81K2fKVPkRuFrIZcjZydW+Ca5nhFbTrQV5yBqPfbwnBP7
	M/rzmDN/POP5EBKlYNoBsPz3wcN4tNzfUjH2WFNE3Q0iFehX8FEINw+GLYpU1h1SgJd1kjxXrFIG9
	SMiGLARg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHJKe-0000000HXBm-1I0U;
	Thu, 15 Oct 2026 11:09:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHJKZ-0000000HXAv-3qwq
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 11:09:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1C5FB60232;
	Thu, 15 Oct 2026 11:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6491F000C4;
	Thu, 15 Oct 2026 11:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062542;
	bh=bIfes0VmGz93Q/D7qKVAipk4bYqd8Rm8ZLiZKuFMUfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=i2jp9z9RcjWmzfTFdI2o0RKgNd5lHBSExqJbfVUWMOO3Hqtg8Ocr3XnH8AjA1rE+8
	 4JOg3mOL71xU17oyCOVQS5D3nzPIUBu7SzLxVt96CbTNjdvz6IUMxyGYg8frUbyE62
	 Ms9bTFfLVQPNoq4JbZ9vTDdpJB8/5/biHLFU9tXDLucmpQc5I05+e4jZru9aTEpCn4
	 DjPR2z/M8mfvz1R/8ekpZy+0etF37VzorR8WK8iwKd0M7AftHzPSuvsJHmIJ0WEj3F
	 5AqSWH/YNaidOXVDE7d+knZY7phLDP9/OtWpltqn9ir8Xnwjns3+7I71a2hISoySxd
	 SICGxvBZK0p1g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Bing Jiao <bingjiao@google.com>
Subject: Re: [PATCH] kho: do not reserve empty per-node bootmem areas
In-Reply-To: <atCQqghin0KOyx63@kernel.org> (Mike Rapoport's message of "Thu,
	15 Oct 2026 11:36:58 +0300")
References: <20261014131547.259138-1-pratyush@kernel.org>
	<atCQqghin0KOyx63@kernel.org>
Date: Thu, 15 Oct 2026 13:08:59 +0200
Message-ID: <2vxz8q3zi5kk.fsf@kernel.org>
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

On Thu, Oct 15 2026, Mike Rapoport wrote:

> On Wed, Oct 14, 2026 at 03:15:44PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> Some nodes do not allocate any early boot memory. An example is
>> hotpluggable nodes with movable_node enabled. So the scratch size for
>
>                           Let's use the new naming please ^ ;-)

Argh, muscle memory...

>
> I'll fix it up when applying.

Thanks!

>
>> them ends up being zero. Zero size allocations normally don't play well
>> with memblock. Memblock returns an address, but then doesn't actually
>> reserve anything. This address ends up being recorded in kho_bootmem
>> with a size of 0. In case of hotpluggable nodes with movable_nodes, the
>> allocation on the node actually fails because memblock refuses to
>> allocate there, and so KHO fails to initialize.
>> 
>> Skip bootmem reservation for such nodes entirely.
>> 
>> To keep the code more robust, avoid overloading kho_bootmem_cnt. use
>> max_nr_bootmem to store the size of kho_bootmem array. This ensures that
>> the location of kho_bootmem_cnt assignment does not affect the cleanup
>> paths.
[...]

-- 
Regards,
Pratyush Yadav


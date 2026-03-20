Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6F11091914
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 09:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rFEUQS40e8ZuUNK+kkGjgLyPCZhV9YM/3NDUpWGxwl4=; b=dCuC88VDsl+IlRV42QQuYUtpzh
	SUrfXv8PMMb3jhIOpxn7VV+jcOIixDB/LDre91FdjTBUT0SBjQtNN83X3BU64UEY2/FpPXzBOi+Jn
	9hraF/YhVVhv0aGB4ScaEq7oz0ShC//pf3+9f2gRkLVpgZathOSnVHBgqaCa/2Xm2pH5tBG+RoIXC
	UgNrgfv3ootNIawoq8rvmZHfUaYW4n3t/P5WXvsxnYLeomtBWcCoYlqrPkLjgXdL3hwpYPZ4UR5ns
	/DNEl8nifKnlrZb60ZenDekALoAUNzyl1hhCVNpa6x8u4X/DxHRuld9StmG4jwcmIEtj2oPH72Fa2
	7YeenLmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3WF9-0000000CUCl-1UNc;
	Fri, 20 Mar 2026 09:34:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3WF7-0000000CUCD-3KGC
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 09:34:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C7DF60127;
	Fri, 20 Mar 2026 09:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8171C4CEF7;
	Fri, 20 Mar 2026 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773999248;
	bh=1pObmRVkfeuQHYXDX4q0M1f+DzcmBEqslPtmpLMlMHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LRIN//CB6MP+nL28Urhsf35RBU+5j+q4s9WMUnkan6oPM5eUelTBgsLXNwnb6cj+7
	 /wlQgCFQ9QStiUsV3QXxDxCPt6K7Po24n9hJt+xABILmFuebTJmAZtPeDVD3leehRi
	 ZbNbYFJqQ55b38pAAVD9HJgWK1inJ2m0xriETxGH95kCunDnLqEEeDSpRrB1pYkoxs
	 XK8P1rnwPgyQ/LanSiCVzqhHTWiC+JY5kGush4hpuqJHL4xxIsuXb1o0hXcZelek9w
	 NyUXdLYDUopFe6DYKiCYqH3GsIPy6V9K6fsRotl612dRlmadMWmv3Jk3hCn7hSLY8b
	 q9Fb92lDd2bhw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>,  Alexander Graf <graf@amazon.com>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  kasan-dev@googlegroups.com
Subject: Re: [PATCH v2] kho: use checked arithmetic in deserialize_bitmap()
In-Reply-To: <20260319193735.2ea34594b36d37e7850a8c37@linux-foundation.org>
	(Andrew Morton's message of "Thu, 19 Mar 2026 19:37:35 -0700")
References: <20260319210528.1694513-2-elver@google.com>
	<20260319193735.2ea34594b36d37e7850a8c37@linux-foundation.org>
Date: Fri, 20 Mar 2026 09:34:05 +0000
Message-ID: <2vxzv7eqc0aa.fsf@kernel.org>
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

On Thu, Mar 19 2026, Andrew Morton wrote:

> On Thu, 19 Mar 2026 22:03:53 +0100 Marco Elver <elver@google.com> wrote:
>
>> The function deserialize_bitmap() calculates the reservation size using:
>> 
>>     int sz = 1 << (order + PAGE_SHIFT);
>> 
>> If a corrupted KHO image provides an order >= 20 (on systems with 4KB
>> pages), the shift amount becomes >= 32, which overflows the 32-bit
>> integer. This results in a zero-size memory reservation.
>> 
>> Furthermore, the physical address calculation:
>> 
>>     phys_addr_t phys = elm->phys_start + (bit << (order + PAGE_SHIFT));
>> 
>> can also overflow and wrap around if the order is large. This allows a
>> corrupt KHO image to cause out-of-bounds updates to page->private of
>> arbitrary physical pages during early boot.
>> 
>> Fix this by changing 'sz' to 'unsigned long' and using checked add and
>> shift to safely calculate the shift amount, size, and physical address,
>> skipping malformed chunks. This allows preserving memory with an order
>> larger than MAX_PAGE_ORDER.
>
> AI review asked questions:
> 	https://sashiko.dev/#/patchset/20260319210528.1694513-2-elver%40google.com

I have also been keeping an eye sashiko for kho/live update patches. I
think it is missing some context for KHO/live update, like the fact that
only 64-bit platforms are supported, FDT data doesn't need to care for
endianness, and so on. I think we need a set of subsystem prompts for
KHO and live update. I am experimenting around with a local deployment
of sashiko. I'll see if I can get a basic set of prompts working.

The the LLM review of this patch, I think the only relevant comment is
checking if elm->bitmap is NULL.

For the others:

1. The restore path does (should) support order larger than
   MAX_PAGE_ORDER. I sent this series [0] to make that work properly.
2. KHO is not supported on 32-bit.
3. We just have to trust the previous kernel. There is no sane way of
   preventing attacks if the previous kernel is malicious. For example,
   it might as well give us valid memory addresses, but change the
   contents there. So all of these checks only defend against buggy
   kernels, not against malicious ones.

[0] https://lore.kernel.org/linux-mm/20260309123410.382308-1-pratyush@kernel.org/T/#u

-- 
Regards,
Pratyush Yadav


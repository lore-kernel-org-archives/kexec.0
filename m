Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F64D3900B
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 19:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+EXMu8fVYrjqzrdjaSOI10qKA87dcHyKFOPIbUS4EPg=; b=KXnMZupIHwwiLueppax8ot0vve
	gmypr1SdfLbt76S4DZ6KcwicAUA9UQRPvFn16SEL4omVcNRakaT8pyc5AFb7QQdNZU5XzcY+/dF9S
	iyd5RJUowgLQc4B9L5igj+3++5NaBGiucjvnWwSagjwaKKPNy9ODMrIITHVASxmlbX9LCEnvIOQFs
	ZX2w4zroR95onPcvR8ocd4CAJjGY/6Mswlf7x2K0ay1pDIDVdDFx5UYR4FU0u5hmTxpAKBV5/oAZc
	3OXBHnOB6X1/CAsihGeu8EvOGi1qQfxjM9od8SV1eqFySNa4gnLhIQUfp4pHUARg7cpyXZ1BDeyiA
	HEJOaeaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6B9-0000000AQB1-37OU;
	Wed, 14 Jan 2026 19:05:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6B6-0000000AQA9-3vnz
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 19:05:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 512A24407C;
	Wed, 14 Jan 2026 19:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10075C4CEF7;
	Wed, 14 Jan 2026 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768417512;
	bh=2QKYOyEjrfuxHKVNPGX4pgerNIQSPvRZMBbE7X+COHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TBE16hKH5B1htBPywslXb3uE1G9s3+1zukbdGdlVTRKU9+GHpwxCGNVyD1rJDG1sM
	 ypztzWs0yTDPqUuo7+Okx21fYvpOZtelOEspY4N6lXkNszYpELSMVN38Q1hHI8MSlq
	 FWHgj/wokP9nwQNMeJQ63AH6rS9qTMdQjX6jVx0AybrqYwcB7BIuXADDiJ7tPTDnuW
	 LD2sI+eUuTnrqfONFyvw7KdIaO48b21ooICSQyR5GtdjgqDLPDB7z9CMO4L4pV9iVS
	 ob5xMRHaDy6gwcsXgZYz/BGOHmAhKuXjDI6lXx7WxrfA2J8nUuvjDRp69QFrjmNZ4g
	 Otpd4WLe8rG2A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] kexec: history: track kexec boot counter
In-Reply-To: <w542cckfixvgo6pvepdg6itaera6qlq75pemqvpah7us6c7yxa@6vm7ebxd6ala>
	(Breno Leitao's message of "Tue, 6 Jan 2026 03:04:28 -0800")
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
	<20260102-kho-v2-2-1747b1a3a1d6@debian.org> <86o6nb7oi1.fsf@kernel.org>
	<w542cckfixvgo6pvepdg6itaera6qlq75pemqvpah7us6c7yxa@6vm7ebxd6ala>
Date: Wed, 14 Jan 2026 19:05:08 +0000
Message-ID: <2vxza4yghv6j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260114_110513_035998_6D6FF663 
X-CRM114-Status: GOOD (  24.57  )
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

On Tue, Jan 06 2026, Breno Leitao wrote:

> On Fri, Jan 02, 2026 at 09:23:18PM +0100, Pratyush Yadav wrote:
>> On Fri, Jan 02 2026, Breno Leitao wrote:
>> 
>> > Track and display the number of kexec boots since the last cold reboot
>> 
>> Nit: this does not track kexec boots, it tracks KHO boots. None of this
>> can work on normal kexec boots. Can you please update the wording to
>> make that clear?
>> 
>> > when CONFIG_KEXEC_HISTORY is enabled.
>> >
>> > This extends the previous kernel release tracking feature by adding
>> > a counter that increments with each kexec boot. The counter provides
>> > visibility into the kexec chain depth, which is useful for understanding
>> > boot history in production environments.
>> >
>> > Add a new property, "kexec-count" in KHO FDT alongside the existing
>> > "previous-release" property. The counter is:
>> >
>> >  - Initialized to 0 when kho_in is instantiated.
>> >  - Incremented by 1 on each subsequent kexec.
>> >  - Printed alongside the previous kernel release version.
>> >
>> > The counter is stored as a 32-bit unsigned integer in FDT format and is
>> > only active when CONFIG_KEXEC_HISTORY is enabled.
>> 
>> We have such a counter for LUO as well from the properly
>> "liveupdate-number". If you're using LUO, why can't you use that counter
>> directly?
>> 
>> If you're not using LUO, I'm curious, what's your use case? Right now
>> KHO only supports reserve-mem outside of LUO. Is that what you plan to
>> use?
>> 
>> Also, do we want to keep both counters independently? Or do we have one
>> and drop the other? Pasha, what do you think?
>
> In fact, I do not have plan to use LUO right now. My goal is to pass the
> kexec release from kernel to another, and for that I am using KHO to
> pass this information.

Oh, cool. Nice to see other use cases for KHO.

>
> That said, I am planning to use KHO as the infrastructure to pass the
> kernel version from one kernel to another.
>
> Given that I don't think this "feature" should depend on LUO, maybe the
> counters should be independent (?!)

If you aren't using LUO then you certainly can't use its counter. But
LUo users are all KHO users. So perhaps we can get away with removing
the LUO one and moving it to KHO?

-- 
Regards,
Pratyush Yadav


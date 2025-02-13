Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99889C021A0
	for <kexec@archiver.kernel.org>; Thu, 13 Feb 2025 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6y87UDK6Pszxw1zMHktjLBz6/o7EYdRAfORzdSdMS3A=; b=IJWFF+V5Z+qx2dgvigiEHbhbv8
	TH4PuflRnHRUzgQYqAue7UPWs+UQoG2Zcnbk41TjqV9V1LtD7kgX5TElXWyISQT4d89ZpQMKxQ+ng
	wxQDzydsGcjkJ8BAOeObON88mL+8A5bYmkZm9rVZT8haTocbXKlxCrl5bk3iCC5oIoCkud3+0Xzib
	3J+/+wn4E5IgdKr6bd6e6Q5oCMQIQsNH4HCU9noKruv7iByg74Sxi1bWCfaialsbQZsVej/WLYUhT
	qqYqDDHKNDOF8n3y/rbgkOFWB2sXz1raFgw6skUWA0Tbwm4wAkbdjkXu+E+htXtI+SQl5i6jWp+my
	yuPKeHog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tibhc-0000000Bfvs-3UKH;
	Thu, 13 Feb 2025 16:04:36 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tibYa-0000000Bdek-2L6k
	for kexec@lists.infradead.org;
	Thu, 13 Feb 2025 15:55:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739462116; x=1770998116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b7ObII/vFR47LETuncg9l2bFg9S6/OwFkur2pLXDuzg=;
  b=XFkNmonzJ0yhRCRM/6s5nMSpc5ZkcSiq1DmtxzC6jIAW/UHeyc1d2nIn
   27jLW4BFbGNy6i/31PqNTichVYZNBqGNuMZSqpTHRts9oEPQJE9DPcnSQ
   fKVeO7XCjcd2i1OZitd6d2Mbqy5Utb9/BB2lsVoeZ0q5n7gQTk/m/DW32
   zYtC8kkfC1ilkcUQ+i8EzAhor8qTbMxMGlC7MStFQwpabddI1CzxUWv2V
   GTCscwBrO//pP9sHQ9xF3dwmeJM30q1dPRNp3eCUw71MPGVEwU1+8Ru9I
   X41EL8Xup71LRX2xWQNsOIc6JOC3I6f+a7n224rcahRff7DxYcBRQT7Hb
   A==;
X-CSE-ConnectionGUID: DxYlG8eNTPGeJ5Wf7XXyFg==
X-CSE-MsgGUID: 7cwhwtdwTyGAZixh/yt5mQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65523204"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="65523204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:55:16 -0800
X-CSE-ConnectionGUID: jweFNLneQO6WT10qF3AKmQ==
X-CSE-MsgGUID: E86di0h5Sj65g1P4Nef7mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113840907"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:55:15 -0800
Message-ID: <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
Date: Thu, 13 Feb 2025 07:55:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
To: "Eric W. Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org,
 kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 security@kernel.org
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_075516_615846_D3510E97 
X-CRM114-Status: GOOD (  26.69  )
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

On 1/13/25 06:59, Eric W. Biederman wrote:
...
> I have a new objection.  I believe ``unaccepted memory'' and especially
> lazily initialized ``unaccepted memory'' is an information leak that
> could defeat the purpose of encrypted memory.  For that reason I have
> Cc'd the security list.  I don't know who to CC to get expertise on this
> issue, and the security list folks should.
> 
> Unless I am misunderstanding things the big idea with encrypted
> memory is that the hypervisor won't be able to figure out what you
> are doing, because it can't read your memory.

At a super high level, you are right. Accepting memory tells the
hypervisor that the guest is _allocating_ memory. It even tells the host
what the guest physical address of the memory is. But that's far below
the standard we've usually exercised in the kernel for rejecting on
security concerns.

Did anyone on the security list raise any issues here? I've asked them
about a few things in the past and usually I've thought that no news is
good news.

> My concern is that by making the ``acceptance'' of memory lazy, that
> there is a fairly strong indication of the function of different parts
> of memory.  I expect that signal is strong enough to defeat whatever
> elements of memory address randomization that we implement in the
> kernel.

In the end, the information that the hypervisor gets is that the guest
allocated _some_ page within a 4MB physical region and the time. It gets
that signal once per boot for each region. It will mostly see a pattern
of acceptance going top-down from high to low physical addresses.

The hypervisor never learns anything about KASLR. The fact that the
physical allocation patterns are predictable (with or without memory
acceptance) is one of the reasons KASLR is in place.

I don't think memory acceptance has any real impact on "memory address
randomization". This is especially true because it's a once-per-boot
signal, not a continuous thing that can be leveraged. 4MB is also
awfully coarse.

> So not only does it appear to me that implementation of ``accepting''
> memory has a stupidly slow implementation, somewhat enshrined by a bad
> page at a time ACPI standard, but it appears to me that lazily
> ``accepting'' that memory probably defeats the purpose of having
> encrypted memory.

Memory acceptance is pitifully slow. But it's slow because it
fundamentally requires getting guest memory into a known state before
guest use. You either have slow memory acceptance as a thing or you have
slow guest boot.

Are there any other CoCo systems that don't have to zero memory like TDX
does? On the x86 side, we have SGX the various flavors of SEV. They all,
as far as I know, require some kind of slow "conversion" process when
pages change security domains.

> I think the actual solution is to remove all code except for the
> "accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
> code.  At that point there are no more changes that need to be made to
> kexec.

That was my first instinct too: lazy acceptance is too complicated to
live and must die.

It sounds like you're advocating for the "slow guest boot" option.
Kirill, can you remind us how fast a guest boots to the shell for
modestly-sized (say 256GB) memory with "accept_memory=eager" versus
"accept_memory=lazy"? IIRC, it was a pretty remarkable difference.

Eric, I wasn't planning on ripping the lazy acceptance code out of
arch/x86. I haven't heard any rumblings from the mm folks that it's
causing problems over there either. This seems like something we want to
fix and I _think_ the core kexec code is the right place to fix this issue.

There are definitely ways to work around this in arch code, but they
seem rather distasteful and I'd rather not go there.


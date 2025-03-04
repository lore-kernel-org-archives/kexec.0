Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB39C282DC
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 19:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5TCsW9XHfUCO29/pSg3et6o21s2sj6bi4Wbc2rT3bmI=; b=cvasfNkuN6ScKr+dB93neJPMCw
	a+Mzjkmy5x2OsN1aVnByNX0P9BDYHKLBGaD0ecM0CGYMkLlFmp9jwsq7Yx6FS/4fSKgWaehQD0g6u
	ffPwhDdWBDd4gzNM7JkcpXbBwhY2MtSVKnDukB8waAMBuL6MI6rdrzb1/CuLcS+Buydn6VqaoMEK1
	ZEFG52YSeLWqk+rxp/cVVYF+1//hJCz5PEKFRCWv9BzHP8f8CtdJCEaCMr67v97yycpEJqs9aaQIM
	+kzuczUFsxkooHPylsiYzvucyzBoi75NaN57dMUCCAh5gYp1/iRPZAhM+OGibgqjd2kdgpq+7jDr9
	TuCkyy5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpYGz-0000000669r-03Cb;
	Tue, 04 Mar 2025 19:49:49 +0000
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpXLM-00000005u5v-0o6G
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 18:50:17 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:41330)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tpXL4-003CrC-Sf; Tue, 04 Mar 2025 11:49:58 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:43810 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tpXL3-009qdL-OE; Tue, 04 Mar 2025 11:49:58 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org,  Dave Hansen <dave.hansen@intel.com>,
  Baoquan He <bhe@redhat.com>,  "Kirill A. Shutemov"
 <kirill@shutemov.name>,  kexec@lists.infradead.org,  Yan Zhao
 <yan.y.zhao@intel.com>,  linux-kernel@vger.kernel.org,
  linux-coco@lists.linux.dev,  x86@kernel.org,  rick.p.edgecombe@intel.com,
  security@kernel.org
References: <20241213094930.748-1-yan.y.zhao@intel.com>
	<xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
	<Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
	<87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
	<f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
	<fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
	<4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
	<wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
Date: Tue, 04 Mar 2025 12:49:15 -0600
In-Reply-To: <wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
	(Kirill A. Shutemov's message of "Tue, 4 Mar 2025 10:41:56 +0200")
Message-ID: <87o6ygskb8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tpXL3-009qdL-OE;;;mid=<87o6ygskb8.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+GBcBx8IrnL69HP7CI9T5d+uij0wQ3VeY=
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: security@kernel.org, rick.p.edgecombe@intel.com, x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, kexec@lists.infradead.org, kirill@shutemov.name, bhe@redhat.com, dave.hansen@intel.com, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_105016_223566_B33CD9EB 
X-CRM114-Status: GOOD (  22.50  )
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

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> On Fri, Feb 14, 2025 at 08:20:07AM -0800, Dave Hansen wrote:
>> On 2/14/25 05:46, Kirill A. Shutemov wrote:
>> >> It sounds like you're advocating for the "slow guest boot" option.
>> >> Kirill, can you remind us how fast a guest boots to the shell for
>> >> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
>> >> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.
>> > I only have 128GB machine readily available and posted some number on
>> > other thread[1]:
>> > 
>> >   On single vCPU it takes about a minute to accept 90GiB of memory.
>> > 
>> >   It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
>> >   it doesn't scale past that in my setup.
>> > 
>> > I've mentioned it before in other thread:
>> > 
>> > [1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm
>> 
>> Oh, wow, from that other thread, you've been trying to get this crash
>> fix accepted since November?
>> 
>> From the looks of it, Eric stopped responding to that thread. I _think_
>> you gave a reasonable explanation of why memory acceptance is slow. He
>> then popped back up last month raising security concerns. But I don't
>> see anyone that shares those concerns.
>> 
>> The unaccepted memory stuff is also _already_ touching the page
>> allocator. If it's a dumb idea, then we should be gleefully ripping it
>> out of the page allocator, not rejecting a 2-line kexec patch.
>> 
>> Baoquan has also said this looks good to him.
>> 
>> I'm happy to give Eric another week to respond in case he's on vacation
>> or something, but I'm honestly not seeing a good reason to hold this bug
>> fix up.
>> 
>> Andrew, is this the kind of thing you can stick into mm and hold on to
>> for a bit while we give Eric time to respond?
>
> Andrew, Eric, can we get this patch in?

How goes the work to fix this horrifically slow firmware interface?

Eric



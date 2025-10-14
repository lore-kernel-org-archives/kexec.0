Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6514BCCD184
	for <kexec@archiver.kernel.org>; Tue, 14 Oct 2025 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nsF6PObp6qoqkkCKTQsSNmyL4hK2S7wY4EQepojwbJw=; b=CiBlIMVHruyfMwbGoFlc87/LbU
	5NMZUHrHpwWagx9fSnBZjyzQYO/O4AgKD3fxWqhIVl5IfRO9IXZaSm9V6Dv1MkqQtIKOWuv/2P9XG
	oUECl+Y4JZ+uQil5gH5qTiYHfCyDwhBTFcsQr1KS+c0VbWsoKuAizznAhMpqSQWZq+w6gyZZn6vtN
	0L/KRtn638C2JeH9m/Pps5frFZEqvplzFGSeSzNGn7bOzzdTHZSsIARk4x9N9luKfjnC1+GdM42cD
	BSGKN5K8ylGWl05IWONdleWCJDYis4n5DFd3cYxoYB3XZ0maoMj7eK9ksiKp9mQabuciZcY0pG7sT
	mb6McNtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8ene-0000000GPjm-0cY3;
	Tue, 14 Oct 2025 13:10:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8enc-0000000GPiS-2vuB;
	Tue, 14 Oct 2025 13:10:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0EF9C622CF;
	Tue, 14 Oct 2025 13:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8533FC4CEE7;
	Tue, 14 Oct 2025 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760447443;
	bh=1z29qiTz6h5jyAO8g68bo34GcYPLqTUSe9I3ydJUTw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g9+NifUwXszKwI+i9b+BADg9CHX9pjgCw2mu/yxA+73glB/SfRpvhpeMLwX+7zeg9
	 cpZyrZdbl6zsMX+Wo90KkdV6hDFv+HpHH+GKnixUqPtsiiuipRTYlBSA+RFLrU6AdF
	 z8MA7ZC0dDyvXrecjZhU8nlLLfZCLEsyyqROyne29Obt+UqzwZBF2jT+f8QUD3imN0
	 gQ5aZfRz1OgEk0IJVCMTbI4VrsIEPNPKNZutUFVMj6TdGeXxePJsX5/R68ibLC+6iv
	 jZYvfqrXGK5MchNQMt25O838FaWOmrFURP+ZyNfLcRWE1zF4CmsEn6AFbRAtwXlHBn
	 SOQ76mXQJoW1Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Changyuan Lyu
 <changyuanl@google.com>,  rppt@kernel.org,  akpm@linux-foundation.org,
  linux-kernel@vger.kernel.org,  anthony.yznaga@oracle.com,  arnd@arndb.de,
  ashish.kalra@amd.com,  benh@kernel.crashing.org,  bp@alien8.de,
  catalin.marinas@arm.com,  corbet@lwn.net,  dave.hansen@linux.intel.com,
  devicetree@vger.kernel.org,  dwmw2@infradead.org,  ebiederm@xmission.com,
  graf@amazon.com,  hpa@zytor.com,  jgowans@amazon.com,
  kexec@lists.infradead.org,  krzk@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  luto@kernel.org,  mark.rutland@arm.com,
  mingo@redhat.com,  pasha.tatashin@soleen.com,  pbonzini@redhat.com,
  peterz@infradead.org,  robh@kernel.org,  rostedt@goodmis.org,
  saravanak@google.com,  skinsburskii@linux.microsoft.com,
  tglx@linutronix.de,  thomas.lendacky@amd.com,  will@kernel.org,
  x86@kernel.org
Subject: Re: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
In-Reply-To: <2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
	(Breno Leitao's message of "Tue, 14 Oct 2025 01:34:07 -0700")
References: <20250509074635.3187114-1-changyuanl@google.com>
	<20250509074635.3187114-2-changyuanl@google.com>
	<ef6wfr72set5wa5el3wbbu4yd5tnc4p2rhtjpb5kpmncv3xs5d@i3c5v3ciioi3>
	<mafs0wm4yluej.fsf@kernel.org> <mafs0h5w2lpqu.fsf@kernel.org>
	<2ege2jfbevtunhxsnutbzde7cqwgu5qbj4bbuw2umw7ke7ogcn@5wtskk4exzsi>
Date: Tue, 14 Oct 2025 15:10:37 +0200
Message-ID: <mafs0cy6pljci.fsf@kernel.org>
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

On Tue, Oct 14 2025, Breno Leitao wrote:

> Hello Pratyush,
>
> On Mon, Oct 13, 2025 at 06:40:09PM +0200, Pratyush Yadav wrote:
>> On Mon, Oct 13 2025, Pratyush Yadav wrote:
>> >
>> > I suppose this would be useful. I think enabling memblock debug prints
>> > would also be helpful (using the "memblock=debug" commandline parameter)
>> > if it doesn't impact your production environment too much.
>> 
>> Actually, I think "memblock=debug" is going to be the more useful thing
>> since it would also show what function allocated the overlapping range
>> and the flags it was allocated with.
>> 
>> On my qemu VM with KVM, this results in around 70 prints from memblock.
>> So it adds a bit of extra prints but nothing that should be too
>> disrupting I think. Plus, only at boot so the worst thing you get is
>> slightly slower boot times.
>
> Unfortunately this issue is happening on production systems, and I don't
> have an easy way to reproduce it _yet_.
>
> At the same time, "memblock=debug" has two problems:
>
>  1) It slows the boot time as you suggested. Boot time at large
>     environments is SUPER critical and time sensitive. It is a bit
>     weird, but it is common for machines in production to kexec
>     _thousands_ of times, and kexecing is considered downtime.

I don't know if it would make a real enough difference on boot times,
only that it should theoretically affect it, mainly if you are using
serial for dmesg logs. Anyway, that's your production environment so you
know best.

>
>     This would be useful if I find some hosts getting this issue, and
>     then I can easily enable the extra information to collect what
>     I need, but, this didn't pan out because the hosts I got
>     `memblock=debug` didn't collaborate.
>
>  2) "memblock=debug" is verbose for all cases, which also not necessary
>     the desired behaviour. I am more interested in only being verbose
>     when there is a known problem.
>
> That said, my suggestion is to only dump extra information when something goes
> wrong, not affecting the boot time neither boot verbosity.
>

With your proposed change, we only know what the overlapping area is,
but not who allocated it. I don't see how that can be done when the
error is detected. memblock debug lets us know that, which is why I
suggested it.

-- 
Regards,
Pratyush Yadav


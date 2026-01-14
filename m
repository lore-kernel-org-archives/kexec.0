Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC29FD39008
	for <kexec@archiver.kernel.org>; Wed, 14 Jan 2026 19:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONpShYkx4yde+rOSHm2uXRVSmGRuF3aUNB0l05in+RQ=; b=vkGT1mqHZjIKyvK5hCRhyRU/II
	P+Gq3QXbfrlSU/ZeNev0jl3xyqF0w8o54cK0Y9D1hDpqKsxix3tOjtIWxUz/f0lTVxDdzDcTaseJf
	or6M5L3C/G8EY5k8KVu1aLMEKRGs7CP3HJQ9qHPP0girHTJ0WDXtcKRZCsC0U9j9dR4Mt1Pwe3RWO
	iKvVncTaJmR9UeU95iwNYNv5vcdMQFshttrHioJ/mljYH4CK6Qbg6EXGYYPE54/AGu6/DKMekggRy
	brX2TxPwqTckXlKMf19iL79QgBaWCAELreLfCcbrhNIuy+5cDDsiO9y9R4iCmZxzyUC0ewo7Prs6H
	7UEHPe2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6EF-0000000AQly-3kz1;
	Wed, 14 Jan 2026 19:08:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg6EC-0000000AQkp-1SvP
	for kexec@lists.infradead.org;
	Wed, 14 Jan 2026 19:08:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 63ECC6001D;
	Wed, 14 Jan 2026 19:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7E0C4CEF7;
	Wed, 14 Jan 2026 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768417703;
	bh=rL1mKtzqQfzbgIbEAmKDaAOtTmTs/5Lg60KQErpr7tg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PbyEkIU5tPZh9NXRoJ4l5vH2mFRF3E4ehAdw7jhsFC7QOhdS7yYmGZlmbSy7/hKbV
	 1OcecXFZpT1MofeCqmKlG0NLG4qA8cQBkWvHkWijm1nr5FqFEOYOCNqu8IvaaI06Ia
	 4gungsE66v0kv/gk9jMYpMRdvwnkzlu3zl7OED5FJ3E9iBJR9d4Iq5dGXe6RYNUxRa
	 pgxATN4mio0oo6PiHqQATGkatX4gwDtzcdyNZovSV1tKTT7+7RUugEuDUOk9T9duRq
	 4ZloYoCfiAnlfVVL0ZE08dAGMsROZasHnuiaXSMNpX8G6XvdG12M4JUNswd5+JYQl8
	 VYenKl2uMNqnA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] kexec: history: track previous kernel version
In-Reply-To: <josgeh3zd55a5sjmclidj53v7hoekzvb63ah45aocvgwh6ajxk@rnzjabyqkojz>
	(Breno Leitao's message of "Mon, 5 Jan 2026 02:47:39 -0800")
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
	<20260102-kho-v2-1-1747b1a3a1d6@debian.org> <86secn7ors.fsf@kernel.org>
	<josgeh3zd55a5sjmclidj53v7hoekzvb63ah45aocvgwh6ajxk@rnzjabyqkojz>
Date: Wed, 14 Jan 2026 19:08:19 +0000
Message-ID: <2vxz5x94hv18.fsf@kernel.org>
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

On Mon, Jan 05 2026, Breno Leitao wrote:

> Hello Pratyush,
>
> On Fri, Jan 02, 2026 at 09:17:27PM +0100, Pratyush Yadav wrote:
>> > Subject: [PATCH v2 1/2] kexec: history: track previous kernel version
>> 
>> Nit: please use the prefix "kho: " for KHO patches.
>
> ack.
>
>> On Fri, Jan 02 2026, Breno Leitao wrote:
>> > Add CONFIG_KEXEC_HISTORY to store and display the kernel version from
>> > the previous kexec boot.
>> >
>> > When enabled, the current kernel's release string is saved to the
>> > "previous-release" property in the KHO device tree before kexec. On
>> > the next boot, if this property exists, the previous kernel version
>> > is retrieved and printed during early boot.
>> >
>> > This helps diagnose bugs that only manifest when kexecing from
>> > specific kernel versions, making it easier to correlate crashes with
>> > the kernel that initiated the kexec.
>> 
>> Why can't you use journalctl to figure out which kernel was running
>> previously?
>
> This is a good question, this is why this doesn't work for me:
>
> 1) in some cases you cannot rely on systemd infrastructure.
>    - This is very common when you have linux as the boot loader, which
>      basically boot linux (UEFI -> Bootloader/linux -> kexec -> target linux)
>    - In these cases, the bootloader doesn't have write access to the
>      filesyste/journal
>    - This is becoming more and more common. For instance, at Meta, Linux
>      is the default bootloader.
>
> 2) in some of the bugs I've listed earlier, the machine doesn't even get
>    to userspace before the crash. For instance, in the bug fixed by
>    commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event
>    log to avoid corruption"), the kernel was not reach userspace/init,
>    thus, it would not be possible to run journalctl.

Ideally, you should have external ways to track the kernel history of
each machine in your fleet.

But I can see that it might not always exist so I can understand the use
case.

I have some comments on the implementation though. I'll reply on the
latest posting.

-- 
Regards,
Pratyush Yadav


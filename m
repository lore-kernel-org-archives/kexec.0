Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAEECD4F26
	for <kexec@archiver.kernel.org>; Fri, 26 Jun 2026 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/4pqgcq9wOLsYE6QVsSxWSWz+ZXSQyYGZ30obGSCUs=; b=fNb4kbmjbi7OKOFiwwzWwF6NmS
	Ih9gbChPB6mEDb5DH1K9OWaSlJggRtrHi68bCd99zFiHwturk2NJKngWmlSZ4XtRUZeTZ6SeXRBId
	2tSz+SZM+THqWSEpiq9cvEHMNgCOGSpHOVzwF+XlQETgVnfL/V/9OMuQWan6Yenb03EjwZnlOfiRB
	ikNjjUrX37FRDgbQ8nYrIPyE1eW9u4di8qm6wpeBse6YFgt6iWzN6x3fDhjXnXQ+c+++erLIaZR9t
	cd3ilX09RNVNKbKqMlNkdJyws0+CwTg7AAiNwRNb4L+EwbtxG6ipMHH+d1i/8JnQV2OPF2BocjGS0
	fDJvZK0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1oU-0000000AnPh-1nkH;
	Fri, 26 Jun 2026 08:21:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1oT-0000000AnMe-10Sm;
	Fri, 26 Jun 2026 08:21:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 015CB416D6;
	Fri, 26 Jun 2026 08:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08041F01558;
	Fri, 26 Jun 2026 08:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462084;
	bh=E/4pqgcq9wOLsYE6QVsSxWSWz+ZXSQyYGZ30obGSCUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XcOuCqMetxebaok5K747BiRuwF263jUQf6yCWdNaDMF23/wT10XwviIPTA4JVVOgb
	 hRJ7fmvjaJO0hVXMKrZUCfZooWH/3Hc7nUL4tCBnkBaXogndD+PeCVBixrS/bW7XaO
	 dvKHJMmlqOkiKcgmDDgUBx8dz6IdWYyFHI8Ka/+4zqAOiGbYE8UC409sw8N1fVBxVN
	 jIN+faUZCAstmP7Q4rPNVuxR9HqnLb8yKeiFOlsxXRjgbnGFAhKmjWIT8m/R2vKSk7
	 B0YgUgN5Q+i/YL7zbEhLJy34F2qFUnwC/froHedJvhycoV0suw+233NPcpZHU4Osz8
	 +8q+nGUMMfE0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19ABB39389E8;
	Fri, 26 Jun 2026 08:21:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/11] kdump: reduce vmcore size and capture time
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <178246207180.3816447.2682390089667943548.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:11 +0000
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
In-Reply-To: <20260527032917.3385849-1-chenwandun1@gmail.com>
To: Wandun <chenwandun1@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 devicetree@vger.kernel.org, kexec@lists.infradead.org, iommu@lists.linux.dev,
 zhaomeijing@lixiang.com, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
 akpm@linux-foundation.org, bhe@redhat.com, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 m.szyprowski@samsung.com, robin.murphy@arm.com, quic_obabatun@quicinc.com
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

Hello:

This series was applied to riscv/linux.git (fixes)
by Rob Herring (Arm) <robh@kernel.org>:

On Wed, 27 May 2026 11:29:06 +0800 you wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
> 
> On SoCs that carve out large firmware-owned reserved memory (GPU
> firmware, DSP, modem, camera ISP, NPU, ...), kdump currently dumps
> those carveouts as part of system RAM even though their contents are
> firmware state that is not useful for kernel crash analysis.
> 
> [...]

Here is the summary with links:
  - [v3,01/11] of: reserved_mem: handle NULL name in of_reserved_mem_lookup()
    https://git.kernel.org/riscv/c/cfba13a18672
  - [v3,02/11] kexec/crash: provide crash_exclude_mem_range() stub when CONFIG_CRASH_DUMP=n
    (no matching commit)
  - [v3,03/11] of: reserved_mem: avoid post-init UAF when alloc_reserved_mem_array() fails
    (no matching commit)
  - [v3,04/11] of: reserved_mem: zero total_reserved_mem_cnt if no valid /reserved-memory entry
    https://git.kernel.org/riscv/c/50a488de5fcc
  - [v3,05/11] of: reserved_mem: split alloc_reserved_mem_array() from fdt_scan_reserved_mem_late()
    (no matching commit)
  - [v3,06/11] of: reserved_mem: add dumpable flag to opt-in vmcore
    (no matching commit)
  - [v3,07/11] of: reserved_mem: save /memreserve/ entries into the reserved_mem array
    (no matching commit)
  - [v3,08/11] of: reserved_mem: add kdump helpers to exclude non-dumpable regions
    (no matching commit)
  - [v3,09/11] arm64: kdump: exclude non-dumpable reserved memory regions from vmcore
    (no matching commit)
  - [v3,10/11] riscv: kdump: exclude non-dumpable reserved memory regions from vmcore
    (no matching commit)
  - [v3,11/11] loongarch: kdump: exclude non-dumpable reserved memory regions from vmcore
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




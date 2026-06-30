Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B50C43458
	for <kexec@archiver.kernel.org>; Tue, 30 Jun 2026 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KziUE99JyCXJvfI9gWixTL5K4MSlxqncGllEjWQ7FFU=; b=i1Hl98agB7TnGzIHTygLv0IA0Z
	yKvX/HZgXY7H+0p10pvKYCurCXmZgKYBaDaPDQ5si9ekhEXsVDTpsMkhvTEBT838+fHKa6RweZohX
	hZb/juD5ZIjYxhm/qrhcceAmgqYVfurde10EUlzA56/5NuPnXKMjNlsxHPV6ryWI8us/pxH8UT5WM
	NCLkrSgGpwKGJI2b5CE59uXuN32C8VJNoR4ryFlr+c6lt3j2IzVrBLSjoRP52/L2ABmCIYXv6Zi/G
	vW51Gk+EP/UsqUAL4s+IyFhugMnTCdlSavVAZjzO1boitiZu/Q34PIpYLYht4+kLw9dHFWLyaXTTF
	Q8PylrHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWIO-0000000GmvG-3RrH;
	Tue, 30 Jun 2026 11:06:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weWIO-0000000Gmuk-0K1W;
	Tue, 30 Jun 2026 11:06:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 265CF600C3;
	Tue, 30 Jun 2026 11:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970C51F000E9;
	Tue, 30 Jun 2026 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817586;
	bh=KziUE99JyCXJvfI9gWixTL5K4MSlxqncGllEjWQ7FFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gbSReGHGi6BBBm1jGbagqwMr3EDZYuq6/aVP0SmPh5q3XsQf2OyoXmHLpD7jKFuXN
	 rz/DuYqpdl8L3DXfBDTvQ7kL0hoqzMjWXWkW8p3niXHmRq2KJO1lhQLr2BGi+0/xW1
	 1QN7bIbJ1gjbY8koWTFN6rYpDeBENnDuuo3Di/Qb6ZxIaSfy0sRjdwCT0pQ7sNxCeM
	 zOq3PScln3ortRJ02gpXTvE3pm2Lk4DnNeyCU0ee7DMVL+uHvo0MsRKXj5dTHKpBrf
	 Xhnkz9uFlwHhr0XSswtrvXEZTcdZ9vbGyco4qHRo1JKwGuORedI6VrlOrYZTkpFs86
	 RPXDfpVVtd2LA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: chenhuacai@kernel.org,  kernel@xen0n.name,  pjw@kernel.org,
  palmer@dabbelt.com,  aou@eecs.berkeley.edu,  robh@kernel.org,
  saravanak@kernel.org,  bhe@redhat.com,  rppt@kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  loongarch@lists.linux.dev,  linux-riscv@lists.infradead.org,
  devicetree@vger.kernel.org,  kexec@lists.infradead.org,
  iommu@lists.linux.dev,  zhaomeijing@lixiang.com,
  catalin.marinas@arm.com,  will@kernel.org,  alex@ghiti.fr,
  akpm@linux-foundation.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  ruirui.yang@linux.dev,  m.szyprowski@samsung.com,
  robin.murphy@arm.com
Subject: Re: [PATCH v4 07/10] of: reserved_mem: add kdump helpers to exclude
 non-dumpable regions
In-Reply-To: <20260630074715.4126796-8-chenwandun1@gmail.com> (Wandun Chen's
	message of "Tue, 30 Jun 2026 15:47:11 +0800")
References: <20260630074715.4126796-1-chenwandun1@gmail.com>
	<20260630074715.4126796-8-chenwandun1@gmail.com>
Date: Tue, 30 Jun 2026 13:06:21 +0200
Message-ID: <2vxzmrwci8ya.fsf@kernel.org>
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

On Tue, Jun 30 2026, Wandun Chen wrote:

> From: Wandun Chen <chenwandun@lixiang.com>
>
> Add two helpers to exclude non-dumpable regions for arch-specific
> code.
>
>  - of_reserved_mem_kdump_nr_ranges() returns the count of regions
>    that are not dumpable. Each excluded region may split an existing
>    crash_mem range into two, so callers use this to calculate
>    crash_mem allocation size.
>
>  - of_reserved_mem_kdump_exclude() walks reserved_mem[] and calls
>    crash_exclude_mem_range() for every non-dumpable region.
>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
> Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


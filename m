Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB382CA0EEB
	for <kexec@archiver.kernel.org>; Fri, 22 Aug 2025 02:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LivtmMeCeZWwwQJpwzuEIu6S0LvxpimnjmIL4YU/XCo=; b=3GzxAQmK9yoc99kOvnes9r71lz
	QJ/HzFu8hDz1w9V5tHnDnvP1m8Kxcg14Ql8oBBGtE8MZxVJtzWYjrfyGRD6cCQiPd47NwNrqYgkR0
	PIrRcO8NrHNUSAz+cHVyock7vnU844YIqQEcgg0H/UX9t+3vWMoGZ15KJOOpwC7rmuacP3UVb8sHv
	0Gh3MOXsk3yJDRDZh/KgsiZjcmmv2rg3lnBDpsZmygi6gMgWEhuZI3U7RZ6M7bI4rnXsUnmLgUYba
	L3rJePOcyyQdC1coVdUgDkuWy5zPcIEQ8fh8Wx3/jOspNwlqtzO7L4dgnL/oKrOhT0vPtwN7V3cb9
	Ym1wTejA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upHSX-00000001Gw7-0cwC;
	Fri, 22 Aug 2025 02:24:53 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upCMN-00000000ajU-2cGf
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 20:58:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BC507A581E1;
	Thu, 21 Aug 2025 20:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC3C4CEEB;
	Thu, 21 Aug 2025 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755809890;
	bh=AFBLWJOwJ4b7vAnIXPiDRB7zDnfWhOvar1ez+tAVaCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umNePAT7FP/nR5oaHv1H9T/yjVUYXR+nZuOVPtkysLQ9NhRZuyTdMBoFbF/ziX8K2
	 eV5xKGtgX5CjNLxozP7au3YTYdCUCJ3PXw/HZnwGKHApRpXMIwg+OmbWf3g+D8B0Tb
	 B4ACvmCB5X6wuzLlzZyLIBvwg69IU3jtKrzwqnqE=
Date: Thu, 21 Aug 2025 13:58:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
 Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH v3 0/2] efi: Fix EFI boot with kexec handover (KHO)
Message-Id: <20250821135809.c12105ca2a246a9fcb905af1@linux-foundation.org>
In-Reply-To: <cover.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_135811_772323_01B497D5 
X-CRM114-Status: GOOD (  11.85  )
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

On Thu, 21 Aug 2025 17:58:58 +0000 Evangelos Petrongonas <epetron@amazon.de> wrote:

> This patch series fixes a kernel panic that occurs when booting with
> both EFI and KHO (Kexec HandOver) enabled.
> 
> The issue arises because EFI's `reserve_regions()` clears all memory
> regions with `memblock_remove(0, PHYS_ADDR_MAX)` before rebuilding them
> from EFI data. This destroys KHO scratch regions that were set up early
> during device tree scanning, causing a panic as the kernel has no valid
> memory regions for early allocations.

Do you think we should backport this into 6.16.x kernels?  If so, is
there a suitable Fixes: target we can include?


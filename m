Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358E6D78773
	for <kexec@archiver.kernel.org>; Fri, 19 Dec 2025 13:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DNnsrT+xqjSs+eoJ714r3VZyZ8ePN/6D90yOcvKqJTo=; b=Hxeqv1Wddmk3HhnS+T8Mu4uTHi
	S/AXY2028MlZyck3UGEP1fqnbd5TqnudVACpelfPk3Ia/gXelkZ1Mv2BwQ2fMg/fwmb0Hf96WBHlV
	u3PHDwHnnMUMyWaxCy/89Ld0JXGJsJJPpac4UHsGhk6Y5ZaXN7zTD355CG0hIAHj5Bi3M1qVNPawe
	qvQaJCu7kNyQiJa5whJ8iGixaqZF5vU4vAgMAsD2lw7sQeVdJnF0lS8jdF301vqzx6f/3KYxFwhk0
	rcDY/TfFbEbB3WF+EN+b2Q2Eb18Ic3qaIv0p2d/atcqYKDLfqsLHKcCEBKD38OYXu0p/rug3b+H5g
	wq2rR2oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWaPi-0000000ALQR-19dN;
	Fri, 19 Dec 2025 13:20:58 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWaPd-0000000ALPx-2Fos
	for kexec@lists.infradead.org;
	Fri, 19 Dec 2025 13:20:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766150453; x=1797686453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0sb46hShgEmBn++3KKU6DlH/HUmKOnchsckBopK7AI=;
  b=ZWEFgbAc78a2/CND5/deA/CzwtqmHSqtYw5bobtnV7zN1q9mP2+HiiV1
   OzMLckf2MDL3d+xqrAHNtUHdzIkmnDs8Z+P7w4xHjo0IeSB9fpjtZOg00
   ytM2gkndU1USlGbVGaQpmyN9n55KAmBdLBcw6KquoAxBJN2uXuNOFcnLY
   sJRa8qxx26CsvUjkjkpuDDUGnHi7IuVx4CqkEWB701daysT91XnVMKAMa
   jsOzCpv5a8axKTbc0Or4aYjAC/VX1187tq6WCZo09dnw8s5hBoiwlqy2/
   vqTuLYM67FVV6+Bez8oa2w2DFTvkJ8OD6fr5HNZbWz652ZnIHJwiuWT4w
   A==;
X-CSE-ConnectionGUID: CY2WYiMRQRKx39twXpFDrw==
X-CSE-MsgGUID: 8e2sGh7tTxe3AkKlR4BcfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="68005921"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68005921"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 05:20:51 -0800
X-CSE-ConnectionGUID: cgKRPYbxTeqSA8bqcKwKWw==
X-CSE-MsgGUID: jlI0wWT2TOeRGNdaDL8Png==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="229544196"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 05:20:51 -0800
Date: Fri, 19 Dec 2025 05:27:31 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, pratyush@kernel.org
Subject: Re: [PATCH v3] kho: validate preserved memory map during population
Message-ID: <20251219132731.GA18378@ranerica-svr.sc.intel.com>
References: <20251219071209.3696755-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219071209.3696755-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251219_052055_499788_1D2A6DFE 
X-CRM114-Status: GOOD (  11.67  )
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

On Fri, Dec 19, 2025 at 02:12:09AM -0500, Pasha Tatashin wrote:
> If the previous kernel enabled KHO but did not call kho_finalize()
> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> the 'preserved-memory-map' property in the FDT remains empty/zero.
> 
> Previously, kho_populate() would succeed regardless of the memory map's
> state, reserving the incoming scratch regions in memblock. However,
> kho_memory_init() would later fail to deserialize the empty map. By that
> time, the scratch regions were already registered, leading to partial
> initialization and subsequent list corruption (double-free) during
> kho_init().
> 
> Move the validation of the preserved memory map earlier into
> kho_populate(). If the memory map is empty/NULL:
> 1. Abort kho_populate() immediately with -ENOENT.
> 2. Do not register or reserve the incoming scratch memory, allowing the new
>    kernel to reclaim those pages as standard free memory.
> 3. Leave the global 'kho_in' state uninitialized.
> 
> Consequently, kho_memory_init() sees no active KHO context
> (kho_in.mem_chunks_phys is 0) and falls back to kho_reserve_scratch(),
> allocating fresh scratch memory as if it were a standard cold boot.
> 
> Fixes: de51999e687c ("kho: allow memory preservation state updates after finalization")
> Reported-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Closes: https://lore.kernel.org/all/20251218215613.GA17304@ranerica-svr.sc.intel.com
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks for the patch (and fixing my e-mail ;)). This fixes the reported
issue and now I can kexec reboot correctly with an empty, unfinalized KHO
FDT.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>


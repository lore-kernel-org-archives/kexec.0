Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA66CE8D60
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/ZAkhA8QTisGRypHsicpVYj5kCwYkYd2pPBJbAZpVM=; b=GWWmv60gHy88zxOzB45aR/31Bp
	dW6PGj8lFBqJmGbNVv05AlEMAoXyJdOnDMPwBtAXC2BSSox2mpN6u3iNq3Q+PceveAAF3KMKVUFJU
	VAPSw+47rKLHCD/3/ZPeSnBAL3nH/LqJF2oi0TU2FKqaD12sy6zi31oYYZhCDDYBvVq5h5h9BDR1M
	bLvQShkmrsy6d/f6SUJsU8Om3kg1Amgrk9zBEUPMa+l070LWnFaPRoi2Tkygv8jBafS1Al94jmKRk
	pkhmyq4StoMryl08z5ohior5+2yCIcAmndF1DJEMW1mqDSM40naV4RgtAnYdZhR5NeZdgZmrwGpCi
	E9oDtxDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxdD-0000000CqsZ-1kd8;
	Fri, 14 Nov 2025 17:30:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxdA-0000000Cqs2-088H
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:30:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3BFEC60188;
	Fri, 14 Nov 2025 17:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7BFC4CEF5;
	Fri, 14 Nov 2025 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763141437;
	bh=9zJM61pEY/RyS31C8d8lddjHkoR9XcjIF+H2kqS6aoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M+xmio9ZvLQQd4tOIMuM4bh1qihQHHKp/4ETopDOztabprihCxZChC5JczUq9nZ0B
	 23AFwn+qdcRhKQoXL3AWMaov3UlhBZxA1dX/ebuVXm1GPp6tyZye54Ipa/PPO57vqO
	 PCU4ziQPWSL3HRcXdMSoGku5ChEqCo5PQWfGEJCBbZdyZkd8tEKy1MK8CMayC3IS7b
	 neffwZhHhYqjnU8m16l2qfyuzmI7m1DY1px4/WxeYUd3MTKdYPussKaSgptgnzd733
	 1R9IjHosNiWp2eYcV/lJsKN/gzvxg5Y4KJOdPE+aXmX7aomi2u0Pbf9qeD9VRyNGzC
	 PT3BN+diQgj+w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 10/13] kho: Allow kexec load before KHO finalization
In-Reply-To: <20251114155358.2884014-11-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:55 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-11-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:30:34 +0100
Message-ID: <mafs04iqw7c91.fsf@kernel.org>
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, kho_fill_kimage() checks kho_out.finalized and returns
> early if KHO is not yet finalized. This enforces a strict ordering where
> userspace must finalize KHO *before* loading the kexec image.
>
> This is restrictive, as standard workflows often involve loading the
> target kernel early in the lifecycle and finalizing the state (FDT)
> only immediately before the reboot.
>
> Since the KHO FDT resides at a physical address allocated during boot
> (kho_init), its location is stable. We can attach this stable address
> to the kimage regardless of whether the content has been finalized yet.
>
> Relax the check to only require kho_enable, allowing kexec_file_load
> to proceed at any time.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


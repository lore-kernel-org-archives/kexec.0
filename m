Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3055CC43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N77zMmBboDh9Nu37LAGHb5ZOl7VeRMGQwkLWZG8ZIM8=; b=w3FKn2CNhbIltgv2QosXPUT+2Q
	wa+0RayUbct5DHzH41625JkKKnN7K3nY7VLrlxtRRXacfMpLVBrTIGi1i0TYaKUEe5rSmozFzF0X/
	JTmRZzyGLiz+I4FNtsDrDdzkNMYk/fRPPUSA+KNsr023ffBrgjrrJRoJrHqjKYiqPzL9Sl0uENhsV
	WT18UNTjBEkNlxyBUz+7c72UTk/OH19ovItn/VIH/s6UNaDL15zJVB6Sv7Vv+GJGmSB1APobKxeN6
	sDvoDFHtFcBoVXuRIO7WDkEPf/hWhfQKjT5HCt6xC5M3n/1Hnuq9wCgshrGStN0Iex32oNvgwfZ/e
	By/XGzhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1AY-0000000EThE-03tu;
	Tue, 07 Jul 2026 08:28:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh1AX-0000000ETgy-2Jld
	for kexec@lists.infradead.org;
	Tue, 07 Jul 2026 08:28:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 067FE618AC;
	Tue,  7 Jul 2026 08:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646BD1F000E9;
	Tue,  7 Jul 2026 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412920;
	bh=N77zMmBboDh9Nu37LAGHb5ZOl7VeRMGQwkLWZG8ZIM8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=avLOoc6CNA7Sdt2c27xf32aadrrjoziceuNEjkmLnw1wW5/k7FOpSTWmxNOzDLEgh
	 TCL/ccSG3jVCEW8vWe/mAL6k7vGnGJPSsoo6izUjxKd/rTQB/fwP3WgKOdm8/jIpSg
	 7nffJbQHiZL/n+7f8oIwMZZCemo6eCD6eFeZJ8t9xHMhwO9sCi8o0Ux3AnQZFcmeCK
	 BKpGb0W9m7zEJg9Yq5v/vcmns5MulQ5oFeRnsf5bu0+rVoP0jtjZRIUgrrsXaUg6oa
	 7t2sdzmFFQhUhRuaX3RUoEanjBpj5EAUT+YcK7W2RkRdWZyJY/nr3Uxl9GavcUBF3u
	 SnZKIkrTZoeLQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 2/4] kho: Detect preserved page types
From: Mike Rapoport <rppt@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260703020832.1731864-3-praan@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <20260703020832.1731864-3-praan@google.com>
Date: Tue, 07 Jul 2026 11:28:28 +0300
Message-Id: <178341290876.3292146.918384529988808795.b4-review@b4>
X-Mailer: b4 0.16-dev
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

> Detect page types in kho_preserve_pages() by peeking into the refcount
> of the second page in each block of order > 0. If the second page has
> a non-zero reference count, it indicates that the block has been split.
> Otherwise, treated it as a contiguous, unsplit block.
> 
> Since the page type is now part of the radix tree key, update the
> unpreserve path to use the same detection logic to ensure it can
> correctly locate and delete existing entries.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index f829ffdd00f45..d6e81f72fe5de 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -918,15 +918,29 @@ static unsigned int __kho_preserve_pages_order(unsigned long start_pfn,
>  	return order;
>  }
>  
> +static bool kho_is_page_split(unsigned long pfn, unsigned int order)

You can return enum kho_page_type here directly (and rename the function
accordingly).

-- 
Sincerely yours,
Mike.



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62ABCE8D5F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rfE1ixHW4HLZWlryQ8v4nSzY9wnCBJEHv4p0NufeQ0Q=; b=LpauyBlIY7cFKRCC1vrCsNhXQ/
	iwP5vn9xjNHe1lWLlpJKb2UsQlgNF3wKdMGmEV/DqbCdkCE+UiyUVugfgnrIwAEXZJUJIuO15uFpn
	REKhNc74Yq8REU8q7qxpwHksHcIfVjtqM/rGc+P2h+wV8M8o0lEy+oLrF9L5iwGZmNnv2qbYnhtQn
	7Z2Iyme2uEghRGi+rnlEqx0t0jOglS42d/zQQc8Pl/NTqa+QG3BU2GjKVVeNdfUfzbUFDJi/eRAfQ
	wxJNCHIu0RIrfhNnT5apqrOnvvO/6KRkAIWtjMTkSsJZixoS2yLwz6GMxNEtET1OjfKM1U/UXzOD4
	CQrhG0Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxge-0000000Cr5Q-1BMd;
	Fri, 14 Nov 2025 17:34:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxgc-0000000Cr4y-0vx4
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:34:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 757FC43373;
	Fri, 14 Nov 2025 17:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22048C116B1;
	Fri, 14 Nov 2025 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763141653;
	bh=sfUecj5LXq8ygB5hZwBv17W6tTJhiXt4mvVHfCkRIYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pFcxALcKxbGfPOXU6jl11AI5j70DY3GzkB3VavJQ8ZlP+ZbFdyUw2vNOqThHcLzu/
	 /GPFvJl0xWEhLxkz8YVAOvYkrqK/Rn6YyCse+wrvOL4DujdiBGxmMDpfo6SnAN4wwb
	 etVVvPYOAwkB4w0QvDSsFTPw7Re5IRsadi1m3UhYANYlNtuVSxOM80ku9tGoddJJOh
	 I398yJQxGOzIMpgjO2wvkROaHfZpvJMRGixyeTM4CqdXoLIay3J5s1Gd3qCfke/lcn
	 TRxhlF7eZ1xXJRLlMXYfy21PY0gFifnNLCfFt/1UN8D2auos2yinyUH7wZAUzu9N9H
	 wljpJKETg73Cg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 12/13] kho: Add Kconfig option to enable KHO by default
In-Reply-To: <20251114155358.2884014-13-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:57 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-13-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:34:09 +0100
Message-ID: <mafs0v7jc5xim.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_093414_278175_FD8003F1 
X-CRM114-Status: UNSURE (   6.87  )
X-CRM114-Notice: Please train this message.
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

> Currently, Kexec Handover must be explicitly enabled via the kernel
> command line parameter `kho=on`.
>
> For workloads that rely on KHO as a foundational requirement (such as
> the upcoming Live Update Orchestrator), requiring an explicit boot
> parameter adds redundant configuration steps.
>
> Introduce CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT. When selected, KHO
> defaults to enabled. This is equivalent to passing kho=on at boot.
> The behavior can still be disabled at runtime by passing kho=off.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


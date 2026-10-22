Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3B606A327
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0csXruEn;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqS2EOF3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=guiJ4aBhyGq0bfn00zMCo/CYuhvnJTZBmGSJvCGmgy4=; b=0csXruEnRtgyuO89r5jlsKX7CR
	MtW3M+dIV0GFXNgcxRedj4y9PFp6cixC07G2VqaFQH8YVm5lLaCR92aOW8Zp4edCjqmCYbl2nOP+I
	QKiDPQfU1Rl1mrpLWm35YMx7pG+0Lgq7GvA5p5xpuGhjrQj/Tt9RTM/ZFGq1IsXFGwbpqlRiDABBk
	7moOtmp+EDOYU4nFN8XTqomexAxKP3nNSPS3Aujp9McRBJ755YGaEgkWqXHeB6SITLHbO7GGpbjXY
	EmF03wnItWCF7CCj3CTwRaapn16gQJin0qdKrf9uyN6oZToGw8MQYz51fvr7EjeM+Gl6/nWyVjrTB
	4dv3b9LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsys-0000000EDcK-1P8Z;
	Thu, 22 Oct 2026 13:37:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsyq-0000000EDbh-3JBW
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 13:37:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A534402DA;
	Thu, 22 Oct 2026 13:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AEA1F000C1;
	Thu, 22 Oct 2026 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676236;
	bh=guiJ4aBhyGq0bfn00zMCo/CYuhvnJTZBmGSJvCGmgy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dqS2EOF3Z2QrUBNCDGMnS5+612xBithuHVMX6RMdNLt/jTiAZFsNXQxsIjmPT7wKs
	 teOTq/3nlswzTSfmSx06jQ1I3xxmtH65Ou+qIxRapAkoupGwRbH1YqRi4qEVHou4FO
	 jyrZsPWB4P/TagrkWN0MgXAuFuwiHrzvMZnZ6qpTwYH/Ot97qs+2b3GgX96tlMeIu7
	 W+Pz5xIa05G+td1gZPD3uDV7PC+BeDYDC4rzSjwNK+rfnwsmr5YdyGfgJuZ5k4tChs
	 EAEkheql0xAzkPK5mnd0VVcBwPCHEN0qA/W0cmiIJw3gGI/4MFxIzmu90vum4iJogF
	 FY+Y0HVKNb4HQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [RFC PATCH 0/2] memblock: keep reserve_mem regions out of KHO
 bootmem
In-Reply-To: <20261021211058.83483-1-azpijr@gmail.com> (Jose A. Perez de
	Azpillaga's message of "Wed, 21 Oct 2026 23:10:44 +0200")
References: <20261021211058.83483-1-azpijr@gmail.com>
Date: Thu, 22 Oct 2026 15:37:12 +0200
Message-ID: <2vxzqzhhg8l3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, Kees Cook <kees@kernel.org>, Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21 2026, Jose A. Perez de Azpillaga wrote:

> On a KHO boot, a reserve_mem= region that can't be revived (new name,
> size or alignment) can be allocated from KHO bootmem, which the next
> kernel boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG preserving it
> fails; without it, the next kernel's memmap ends up on top of it.

What's your use-case? Why are you adding new reserve_mem regions after
cold boot? I'd rather avoid making purely theoretical fixes.

[...]

-- 
Regards,
Pratyush Yadav


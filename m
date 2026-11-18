Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198E606A336
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 00:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WYKzpOVl;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcbYZgYK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0FtVx+bdZ2ArSXP0mcBKd/WQHCmPoQ5KtqvMi55F/xs=; b=WYKzpOVl9F5qpXOs4HK9aIhjSa
	vPgoGaXEL7BDOxF7mA9bT2MfmCJasmcbyQpot9H2GADUKikoP2EGSLaBY+rkBQja7aYv5TH99pzOj
	ayBEW95hx1nsJyec2Hecs+/Q++/tQkNO2D1zL2Sr3sZ4kEi/rr/xDrMIJpBX52VFn9MrpMnDU/FgA
	tC61vHoSndpdYF+f+sADgOfsAK7ZidNDuwCccaIEGSgMS2B0baBvcQLJAgV6Dgus74s2JE6QjachU
	TN4rfb+maD66n2G43i+Qc3qkLTir0nLAR4twFzKDHJRlmra5jaahsX+lGQvb1OZmPJw5dZjz6AiXp
	o9FQJIRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTUU-00000007LeQ-3p2v;
	Wed, 18 Nov 2026 00:25:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTUU-00000007LeG-0FgU;
	Wed, 18 Nov 2026 00:25:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F80C61D41;
	Wed, 18 Nov 2026 00:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112E31F000C4;
	Wed, 18 Nov 2026 00:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961532;
	bh=0FtVx+bdZ2ArSXP0mcBKd/WQHCmPoQ5KtqvMi55F/xs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=RcbYZgYKuT8rtNBavT9z0RMeM4rv0wQkI8zvWHGBOBvEBOgztWdMgNcwrojSs3pWx
	 HRRaFKWgBtsPJfe0t/DO4Bbcp04o4fMI9CXSTEo+D7alzjW73Kmofjb+seANrtRMXg
	 PbXFyPiP+fZj/bQNK3A3AMBPlvGQE2r2QDwBeOp0kkL2YEgx+WSPQZyx+ZCwm1Fctn
	 xkVDBtaBfAt5+4g9ucbO/tXTR3RX0McYZgbPwcNcNfrQ58eFBavf1XIYebevnXW4/K
	 A7jlS6YsGDl3fqMDvPR+spnQ2RThSzCEcsf2Oa0e/rpWh4VVy7jnhNwQN27f2d3G/9
	 4l3d+Yv1MXXkg==
Date: Tue, 17 Nov 2026 17:25:27 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
    Chen Pei <cp0613@linux.alibaba.com>, pjw@kernel.org, palmer@dabbelt.com, 
    alex@ghiti.fr, pratyush@kernel.org, graf@amazon.com, shuah@kernel.org, 
    guoren@kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v3 2/4] riscv: Add support for kexec handover (KHO)
In-Reply-To: <avLi0_mYXatBWmpL@kernel.org>
Message-ID: <6c377596-479e-439a-f68c-5d61fe40824c@kernel.org>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com> <20261106071459.2003-3-cp0613@linux.alibaba.com> <179415145358.358073.165272378597657083.b4-review@b4> <avLi0_mYXatBWmpL@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mike,

On Tue, 10 Nov 2026, Mike Rapoport wrote:

> On Sun, Nov 08, 2026 at 10:24:13AM -0500, Pasha Tatashin wrote:

> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 
> > 
> > But pre-reqs. should be applied prior taking this series:
> > 
> > 1. https://lore.kernel.org/all/20261023054518.3258350-1-gthelen@google.com
> 
> I'm planning to send it to Linus this week.
> 
> > 2. https://lore.kernel.org/all/20261104-kho-bootmem-sizing-v2-0-b0d1a834780f@kernel.org
> 
> This is easy if we take it via liveupdate tree :) 
> 
> @ricsv folks, how do you prefer to play it?

Sure, if you want to take it, that's fine.  I'll send acks for the two 
arch/riscv patches.


- Paul


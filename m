Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794A1FC6160
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t1YcIStoqkIcSHhANLnGzWO4A4OHzOlFBp5QJ1ROnc4=; b=uRxC9/oLGUbSacDbnpeCMiHPdP
	G100wIf+UMs1xLGPnyvB+Ptuh0UMxg/M6maeiu6jUI9KcoS1sJno5j0BSkOUfKY/Xt8llEwO7srDy
	xNr/+zjZ+lGHJZTnBql+ZuKMoNM0lH74pCjQ+DtoZCL35E046Of1UzJ5XPJHagm0jnMGpMbYFfgDq
	EcAg3ft7qPF5IvpeTaYwwT9nafZzUN2S9GJmuQA04onCoHU1ruD767/K+/KRsaEfTAK33GoXfmS7R
	QOFCbRC8aio7mjdcaUD5vfJXXu9zpHnvnfeQqlhkzotZN7qMk+pV7dt0qyJ02G/UxVGh6qrxcTpb2
	aR0dxs1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vblgF-00000008hOv-2ZWg;
	Fri, 02 Jan 2026 20:23:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vblgD-00000008hOY-2Fw4
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 20:23:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E8E0040328;
	Fri,  2 Jan 2026 20:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5E1C116B1;
	Fri,  2 Jan 2026 20:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767385404;
	bh=36h+gzQOCGURAdbtJyCuaVTakIb422pTXIoravRz/yA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=C850m0yzR3hfqz7dBIq6J71yU2NNbzw4mZaZTNyPS1TZV7qYNGtTDRPG8kpI1KJZU
	 ofuE0e2/hKuY+6qQQ+lwQ0cj+QRkeNR26LRPa8WC2Y0oXilcU6aovdOyDqulr10/0J
	 5w+ird2Y68JVQc1u6tcW/DP7po+/gYn1EcUYwlJp6jHPGn2Yy/S+qSk+7FuXSSkyt5
	 nCJuLXK565YOlUy2SvzN3oX2xAQGgxxkic4YaKhFFok0GamRAPMXKe6yrSoNzIPeAe
	 i1FlTFFmTkhtejMhNuCFQjPyckllVuKw4dtWQQ8M+NlfERKco0rQC6McmwA9iTE7T4
	 hcbWYVbQZ+9zw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] kexec: history: track kexec boot counter
In-Reply-To: <20260102-kho-v2-2-1747b1a3a1d6@debian.org> (Breno Leitao's
	message of "Fri, 02 Jan 2026 06:53:24 -0800")
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
	<20260102-kho-v2-2-1747b1a3a1d6@debian.org>
Date: Fri, 02 Jan 2026 21:23:18 +0100
Message-ID: <86o6nb7oi1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_122325_616879_972AF5E1 
X-CRM114-Status: GOOD (  14.90  )
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

On Fri, Jan 02 2026, Breno Leitao wrote:

> Track and display the number of kexec boots since the last cold reboot

Nit: this does not track kexec boots, it tracks KHO boots. None of this
can work on normal kexec boots. Can you please update the wording to
make that clear?

> when CONFIG_KEXEC_HISTORY is enabled.
>
> This extends the previous kernel release tracking feature by adding
> a counter that increments with each kexec boot. The counter provides
> visibility into the kexec chain depth, which is useful for understanding
> boot history in production environments.
>
> Add a new property, "kexec-count" in KHO FDT alongside the existing
> "previous-release" property. The counter is:
>
>  - Initialized to 0 when kho_in is instantiated.
>  - Incremented by 1 on each subsequent kexec.
>  - Printed alongside the previous kernel release version.
>
> The counter is stored as a 32-bit unsigned integer in FDT format and is
> only active when CONFIG_KEXEC_HISTORY is enabled.

We have such a counter for LUO as well from the properly
"liveupdate-number". If you're using LUO, why can't you use that counter
directly?

If you're not using LUO, I'm curious, what's your use case? Right now
KHO only supports reserve-mem outside of LUO. Is that what you plan to
use?

Also, do we want to keep both counters independently? Or do we have one
and drop the other? Pasha, what do you think?

[...]

-- 
Regards,
Pratyush Yadav


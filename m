Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77F606EE84
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mf42wsJc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dxKzc6mj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ReGNOaOBCMvIg7gK/G7qltHWui+c1mv7BQpRUdRVU2o=; b=Mf42wsJcuTlb4HE6W6VjOCJZxi
	N9b6fnbRF0eurIsiWnpf2O9gP9kPxVsUXMaGfw6sfS5meyLLMbEkr/+7B6p0K/rXIpC/gxSeccb3C
	mSFE2ugEYk/yAOOftMulaEOQTDqpV6mnPhJnz1pRmsSAIXy2Qbk0OPdzKHlTXM9WNGHpeHj0qXrKb
	w6RM/79QwxF69N8zNi3cFedhUQY9qfmPSot3Tmj45IYDj7HglzM5QCyqFkM6CTwIbjXCi1AGHELCc
	Z3Vj7+Uvv4Rl7q4SPTu1NOqXUoPQgUit/nQ+TZbe97RIDa/0I5UTadrL/4HcR+ViaRB42HjKNwpre
	AAmuNdug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOx1m-00000009273-2BV8;
	Thu, 05 Nov 2026 12:57:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOx1k-00000009261-4Bgs
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 12:57:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D882605F4;
	Thu,  5 Nov 2026 12:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010D61F00A1C;
	Thu,  5 Nov 2026 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883432;
	bh=ReGNOaOBCMvIg7gK/G7qltHWui+c1mv7BQpRUdRVU2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dxKzc6mjgpEI/gtpOZyuQeLjQvddHurnQsGDoMpXnjknrfY2hKAiYfqUmgA557koH
	 e7jmaCP+YJaAZRcy5orhOkgHcEFid9SLfIXq5prOVlqYQVEZZwtmz9vUtd5273iQxI
	 UKxAfeO0bjeO9WLaog9V0U61zMaIpiIZ7UeSyqBH9eym1B0XA4KlbnQtdJ0bW7qW6B
	 Z1EHYFW28+7LtXyj9olREmKA7WH/g4bDfXZqlXZTqiELFDFk2194EltzQCAk3l7bUi
	 BrmfDnlOnDQgNxM40UatpYAMCFdANbrAM6XbiFTbSkp5ZSQsr91noJlmtNvMpPf0XO
	 IQZ1KqUo2KWEA==
Date: Thu, 5 Nov 2026 14:57:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: pasha.tatashin@soleen.com, pratyush@kernel.org, chenhuacai@kernel.org,
	ardb@kernel.org, shuah@kernel.org, ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org, baoquan.he@linux.dev,
	ruirui.yang@linux.dev, guodongtai@kylinos.cn, kernel@xen0n.name,
	graf@amazon.com, liukexin@kylinos.cn, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v6 5/8] LoongArch: Allow memblock arrays to resize
Message-ID: <aux9Hm0QFJLUDPWv@kernel.org>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-6-dongtai.guo@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029172956.20791-6-dongtai.guo@linux.dev>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 02:29:52AM +0900, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> LoongArch never calls memblock_allow_resize(), so the reserved region
> array cannot grow beyond INIT_MEMBLOCK_RESERVED_REGIONS entries
> (INIT_MEMBLOCK_REGIONS + NR_CPUS).

This might be something to fix independent of KHO.

Huacai,

What's the reason LoongArch never enables memblock resizing and why it
defines INIT_MEMBLOCK_RESERVED_REGIONS to include NR_CPUS?

-- 
Sincerely yours,
Mike.


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A1606A32C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AxHWlhc1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/v5cxLh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4kbBk37SUYvMVJny9GfKjjQos42kqXBJeWxGUOyaU2E=; b=AxHWlhc10l+R0LwXOjqsot6r/q
	eEqKftotF9/UrnIl0PM/X+yC5WPb4mVyIBzLiYCP/oAvvHWhMhOsLfl2xn4UzaZAdOl49eZOi09xa
	eiELxphIx3J/ydYbwji2s94xVNk6AMEek3FXqxp1snw9mCedTokyxvfCySFJQt+CwMYFc39Enyh6m
	LFxKdhoeS+XZfsYd9jHXR1QtlniA7vpYTojF033dKfwG/m8Yob3es3ryVD3eS4b744UhPq2oQhpoK
	RqPdMqB+35xOJ+1LC8ZQh7SGSGHQrk1DnriRtHJNUXzrUSu27Mll/EJ8nY/ALt8WAPvsULJf7WUs9
	joYqZlRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTfq-00000007Nlo-0Qmo;
	Wed, 18 Nov 2026 00:37:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTTfd-00000007NcU-21fJ;
	Wed, 18 Nov 2026 00:37:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B25E561205;
	Wed, 18 Nov 2026 00:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9419F1F000C5;
	Wed, 18 Nov 2026 00:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794962224;
	bh=4kbBk37SUYvMVJny9GfKjjQos42kqXBJeWxGUOyaU2E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=G/v5cxLhB1/dgV5Xl4goxSccn7AlW8fiE46777Hs9OGguTbq4AVahrtcMrkZAxsRp
	 CkHKfhKDSUQozc4kaG/isS8F9+wNaQyf2aogoLhx21hHs75+24Or1WlZLzBhGNN34+
	 HW3ehV/A6A9BGnUJWeBJ68PF/ehdNtSQBuX2yPMcOdnXqvEqN3KOdRvRAakhekJEFU
	 sSFKFCig4yJdhauT0zTrQGVXsNS6DuTpmWJkK8ISxIAp3owW0612Sy8F824Qkt4q/2
	 Ysx5CZst9jrsCyQEtK1PP+/PQ8UkF0ZxMTGXX6i0/ohUyjvAQr3dhVxFO6LH5X5uM6
	 cM+oNRMSrzOSw==
Date: Tue, 17 Nov 2026 17:37:03 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr, rppt@kernel.org, 
    pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com, 
    shuah@kernel.org, guoren@kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    linux-kselftest@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v3 2/4] riscv: Add support for kexec handover (KHO)
In-Reply-To: <20261106071459.2003-3-cp0613@linux.alibaba.com>
Message-ID: <8259aea2-c8f7-b9c2-9e31-bb852bffb83b@kernel.org>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com> <20261106071459.2003-3-cp0613@linux.alibaba.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026, Chen Pei wrote:

> The generic handover paths are already in place on RISC-V: the outgoing
> kernel publishes the handover FDT and the bootmem list in /chosen of the
> DTB built by of_kexec_alloc_and_setup_fdt(), and the incoming kernel
> picks both up while scanning that node. Only the architecture symbol is
> missing.
> 
> Set it to 64BIT && MMU: ARCH_SUPPORTS_KEXEC_FILE is already 64BIT only,
> and KEXEC_HANDOVER selects CMA, which depends on MMU.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Acked-by: Paul Walmsley <pjw@kernel.org> # arch/riscv

... since MikeR is planning to take these.


- Paul


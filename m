Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A03606D81E
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oTunJKvx;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AG12x7tg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3EMc1b5KEH9cVXiMGA75dD7QU3+3/XGYyYWj4dXStIU=; b=oTunJKvxuwIoV89HfBUTyZTVNO
	cpCE4f0ZaZXzVU4VDeudIfqJFv7IJq/H9WuMcE2xTE4W5vEP7qG101zCaoNq9UoTJ+VzsoYJ8wHvf
	O0NTjS49+ilNVLJR+D4P1+MIE/ku9SOK3tgdfylIVCffVMoo9zjOCqvoi11D5vQ+dfpyHgak+yx64
	BkWRlX1b1fj2Nh2ueIg4pSi5GfrpQWlJ+8jUJSkhEL8h4CZvLFSAYXlMezPY02eZp8LQ/0AFiHJ1k
	yt3rAAdayRWMsRh6mPPp7jF+J4IctPK/iK2afR2s4icAVydPMmu0wmyJiBoObxU6Ta5FEnZFnxdPM
	Z33YCPPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOwxw-000000091D3-42V6;
	Thu, 05 Nov 2026 12:53:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOwxv-000000091Ce-1Ilf
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 12:53:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D55E407D2;
	Thu,  5 Nov 2026 12:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9AA1F00A1E;
	Thu,  5 Nov 2026 12:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793883194;
	bh=3EMc1b5KEH9cVXiMGA75dD7QU3+3/XGYyYWj4dXStIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AG12x7tgg25+b9BGhXiSz/ofPJ4/nOOi9uaGp8uGSrgkfC6bThURnEzl370xiLQpC
	 6muAHtivbUfevoV3luEzApxkC8XXfAHuDlJqLtaVtu1OONXVixuRtjn5c1UD9JIbh5
	 byWnONieIPW8PfllGp8EESZ/SwNwqh+z+bUeOFhSUE0oNulQ0zcu+Pv5pPKNy1VA/v
	 PXcbV0RACErEMoyZsiEx6uq7lKwa1pq0Kc38NlHNoFAHt2wIyJj2a0fiHRBcgHX0Jt
	 UBIZMH7O7j5NDtS3xfVZrECjEHi7M1FxaeHxqmkQ+XBWSr9qt2j43IsF7RzChgfKCz
	 qsCOafVsbDhNA==
Date: Thu, 5 Nov 2026 14:53:04 +0200
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
Subject: Re: [PATCH v6 4/8] kho: Add kho_disable()
Message-ID: <aux8MKSzObmqUBta@kernel.org>
References: <20261029172956.20791-1-dongtai.guo@linux.dev>
 <20261029172956.20791-5-dongtai.guo@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029172956.20791-5-dongtai.guo@linux.dev>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi George,

On Fri, Oct 30, 2026 at 02:29:51AM +0900, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> On LoongArch, KHO state is passed to the next kernel only through an EFI
> configuration table. Only the EFI stub installs this table, during a cold
> boot.
> 
> A kernel entered through kexec does not run the EFI stub, so it cannot
> create the table if the previous kernel did not provide one. Without
> the table, it cannot pass KHO state to the next kernel on a subsequent
> kexec.

The idea behind KHO and liveupdate is that the system uses kexec + KHO for
reboots after the cold boot unless a new cold reboot is a must.

Doing one yes, one no, breaks that assumption.
 
> Add kho_disable() so architecture code can turn KHO off when the EFI
> configuration table is missing.

I don't like a global kho_disable() API. It's ambiguous and fragile.

> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/linux/kexec_handover.h     | 3 +++
>  kernel/liveupdate/kexec_handover.c | 9 +++++++++
>  2 files changed, 12 insertions(+)

-- 
Sincerely yours,
Mike.


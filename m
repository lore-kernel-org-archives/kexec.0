Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978E606A330
	for <kexec@archiver.kernel.org>; Sun, 15 Nov 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AylDSwXo;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYkZvG7T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TIMpcp5q0yTDtJcCpdNxmcyuVAuHnxRcCai9kzJu3Mg=; b=AylDSwXoS+E690+iKbhByJLY8q
	BKEK53hXh+vIxKruwXrq12Rm6eB0p3FmFF2vvZYXfjtXfVPxgAo8fj8+QGiWgt4ogm61YsYDq3VR+
	UtdWQ3MMvrkH0H4BT36wEqhNRFynA0F+80mrVqE/xwmvPGzJYtbjRNKdTMQ+Q+p0odXz2S8zKQuBM
	ra5MOCbqvUpc4G4NFd/QeZ2j8ny3xwXaGes/gYWq4i46FKCysxs0qaWRrhKM0qQoLZ86BLhAjAfml
	uNlTUkCHjXXU730Ga62wMryFB5L1K02LRDd+nHFpFLJDjd/tMKiYfvyiViygYSSLgmNvdF0bNUrbA
	Y660zegQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSfni-00000000NJz-30GC;
	Sun, 15 Nov 2026 19:22:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSfnh-00000000NJr-0oA7
	for kexec@lists.infradead.org;
	Sun, 15 Nov 2026 19:22:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3ED67601CC;
	Sun, 15 Nov 2026 19:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877A31F000C4;
	Sun, 15 Nov 2026 19:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794770523;
	bh=TIMpcp5q0yTDtJcCpdNxmcyuVAuHnxRcCai9kzJu3Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YYkZvG7TDza6ISUNrA5UxvkwMkMaTYDOKtlTjJFwt5WNutN24VaxlsSYmqhTVY9li
	 mIZTkFQTGnBegqSkt7a9Ipe9CeKF14uY8FAe0wFb0LP22FzQ67JY+dckJsIF+yidHR
	 SlTuALfyn43kZRzSCEvulKt5vwiT2jphAkIg9eZwP7a32TCNO212ENSsJz4QQtyUZj
	 1uKDAouRdv8wY7F0SKuAiAd48ic38IeJ+YXUSFfSTn1IENOSTLTqYFK9EJ/6mtwox+
	 84H0dI6au4UnWReLyQSXq7WX9642Fp1ZeDtPe87f1hFUOQ5oASWAQ6wHAa68wYrhKu
	 nF6Tbtja0p8lQ==
Date: Sun, 15 Nov 2026 21:21:56 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Mukesh Pilaniya <mpilaniy@redhat.com>
Subject: Re: [PATCH v3 0/5] kho: fix bootmem sizing
Message-ID: <avoGVI3Ja6ZgRBL6@kernel.org>
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:38:52PM +0200, Mike Rapoport (Microsoft) wrote:
> There were several reports about issues with KHO bootmem sizing.
> 
> The bootmem areas are sized from overlapping views of the memory reserved
> in memblock, so on NUMA systems memory allocated on a node is accounted
> twice and with CONFIG_NUMA=n the lowmem and the global areas are accounted
> once again in the area of node 0. Besides, the lowmem and the global areas
> are reserved even when they are empty.
> 
> ---
> Mike Rapoport (Microsoft) (5):
>       kho: reject zero bootmem scale
>       kho: walk bootmem areas in address order
>       kho: skip zero-sized lowmem and global bootmem areas
>       kho: fix bootmem sizing
>       kho: docs: update description of bootmem regions
> 
>  Documentation/core-api/kho/index.rst |  31 +++--
>  kernel/liveupdate/kexec_handover.c   | 225 +++++++++++++++++++++--------------
>  2 files changed, 158 insertions(+), 98 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261103-kho-bootmem-sizing-5d6aed47a243

I took this version to the liveupdate tree.

-- 
Sincerely yours,
Mike.


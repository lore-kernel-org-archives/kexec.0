Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F158606A323
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 11:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cRKDxVkL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqAxEVHu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pTL3W/tdk+66hSBUiF9xLt8oJSgQZMOfyjWHi+MQBy8=; b=cRKDxVkL5ILQHAaQZ/QRBhBTZw
	f6B1sQJKxMbLHXTNfMxj1U7XGFpNgZEdtAJ2LFqevqTjoGvKNzNfYlLxH839+6QamGx9drv0o0mWz
	h9oNC2yDc1pAt9WDYcZ00ESjfVGlleIj1YaFUIR1AyDqRqg7zqN9cnv26ndq3k7qLCanvSjyRGvJ/
	PjRJSF06qqwK1uoZd8N6WTI4Juobar0S5XDhQmRsu0igJ8K6ruVpLAzFJBVXpPfF9Asv4ou3/6YZm
	5IdTWoCHk6/fKUfci0zRPST3bkdH3nmaCSM/SqqV1pnf9344CewMrm4yXzCA8TaxZsyc9sjBHbGvm
	mrMbxA9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ0su-0000000G2Ht-3dPC;
	Sun, 08 Nov 2026 11:16:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ0st-0000000G2HM-49Rq;
	Sun, 08 Nov 2026 11:16:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1518361263;
	Sun,  8 Nov 2026 11:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8193A1F008A3;
	Sun,  8 Nov 2026 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794136586;
	bh=pTL3W/tdk+66hSBUiF9xLt8oJSgQZMOfyjWHi+MQBy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VqAxEVHuEhhuWlEGb3a6IcRZyzsBZId1gDwYYjwHpernz6+NWTAP7jGbs/6QQjRHm
	 VfC+qplsRTxDZ/vccuWSCdOmu1rpryCd9j8oOPlmOAONo+jZ0pP7qlx51TcZJVCM3O
	 4iJMzChAwjEJhqUqmKqLx4CGsRVFnzhWHguhQIzj5oB6MCGhqckA4UW6rASoF+fTX5
	 JpdLvciQEhY8AEWfhVNGoET/Cln25UEVVxOHtpsexdZf6n15F83LJFciV71ax1+y+A
	 DKcjPsbQQfbr1Te5VsGEHvxAzx4IY2Y7yOmNtDkYNW+9j0GfjPNR2zXAXG/bxyrs6U
	 /OZh+sg//YuIQ==
Date: Sun, 8 Nov 2026 13:16:19 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
	pasha.tatashin@soleen.com, pratyush@kernel.org, graf@amazon.com,
	shuah@kernel.org, guoren@kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v3 3/4] selftests: kho: Add riscv support
Message-ID: <avBaAz0_ZvN-3m4D@kernel.org>
References: <20261106071459.2003-1-cp0613@linux.alibaba.com>
 <20261106071459.2003-4-cp0613@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106071459.2003-4-cp0613@linux.alibaba.com>
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

On Fri, Nov 06, 2026 at 03:14:58PM +0800, Chen Pei wrote:
> Describe the machine the KHO vmtest runner needs to boot riscv64, so the
> test stops being skipped on this architecture.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  tools/testing/selftests/kho/riscv.conf | 9 +++++++++
>  tools/testing/selftests/kho/vmtest.sh  | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kho/riscv.conf

-- 
Sincerely yours,
Mike.


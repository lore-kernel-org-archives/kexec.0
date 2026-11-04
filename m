Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B107606EE84
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H+ZV/jf3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKWIpJro
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h9wu6kihgi9yB1xWkuSesGFotgBTDc+RlqCdPr5bB/c=; b=H+ZV/jf3cuTKSgKjVW1TAI68gK
	h2JyRYY/gmIGwKd7Ku6/I81V2Fx4Le5rSAz+s//tWB0W2/3VJXJti0Bao7bUXHqB9E8BLT+gLU4Si
	5B1RZA2sfcWSR7zZ93oPjltIVQbwicrfTbGqgsTg2yzjXFXVn/zzHRj1T0E/ngqvcQGKzGXNY+Bcp
	B//LfyxiHkrF/LU4tN7+/m0KD0EZ02Hd9P/OXZb5h5U2dxYQPwEdSG7L8kgbSX73wxaWVgo5GW2KK
	0L0yT/mfsJhB/y4VnPgJk/tS/dXMISj7YRHG/ZLgbbrJ1lBhqLXby4wwLZzYm/bVPgISH1tsS3FF9
	q0SseAIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBh-000000066GU-0m0K;
	Wed, 04 Nov 2026 16:50:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeBf-000000066Ec-0MaZ
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 16:50:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C135343D01;
	Wed,  4 Nov 2026 16:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCD41F00A1F;
	Wed,  4 Nov 2026 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811010;
	bh=h9wu6kihgi9yB1xWkuSesGFotgBTDc+RlqCdPr5bB/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bKWIpJroWZmQuSMKmkcHkS+KBMrgb1w1jTz5HKzXIOr50CEf78uf0IDuq69Df3xiG
	 McCrtoOIvk0xb6p6wbnwjGvzKd6b6pyVQf4nKgBFJap0yATUxKBBuOYv3hAxPCo9+z
	 5piNj6JnHodsMU9py/wzB+LPq7CLnzXj5WQz0Bj42hex+bec+bW9zqWjC7hrHRS2IJ
	 tlvXHJC7RxLi3+LmQyX6yRcwvcx28ds5CuCBBa4/hScO7VelF15BopQikaxNJn608s
	 0vUMHKv70OmXy28yj7eKHQK9jOI7XNRssHsj8OdrzqaI+XX28zWZTY9aH9cN7yI7GJ
	 05o1Esz3NWV3w==
Date: Wed, 4 Nov 2026 18:50:04 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>,
	Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kho: skip zero-sized lowmem and global bootmem areas
Message-ID: <autiPITgQl7nhFER@kernel.org>
References: <20261103-kho-bootmem-sizing-v1-0-45aa74098f34@kernel.org>
 <20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org>
 <auo3PzmisfK3br1l@google.com>
 <ausVbqZd9qgZf4zc@kernel.org>
 <autM3_pSLuOGZQCh@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <autM3_pSLuOGZQCh@google.com>
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

On Wed, Nov 04, 2026 at 10:32:14AM -0500, Pasha Tatashin wrote:
> On 11-04 13:22, Mike Rapoport wrote:
> > On Tue, Nov 03, 2026 at 02:48:36PM -0500, Pasha Tatashin wrote:
> > > > @@ -852,56 +873,32 @@ static void __init kho_reserve_bootmem(void)
> > > >  	 * reserve bootmem area in low memory for lowmem allocations in the
> > > >  	 * next kernel
> > > >  	 */
> > > > -	size = bootmem_size_lowmem;
> > > > -	addr = memblock_phys_alloc_range(size, BOOTMEM_ALIGNMENT_BYTES, 0,
> > > > -					 ARCH_LOW_ADDRESS_LIMIT);
> > > > -	if (!addr) {
> > > > +	if (kho_reserve_bootmem_area(&i, bootmem_size_lowmem,
> > > > +				     ARCH_LOW_ADDRESS_LIMIT, NUMA_NO_NODE)) {
> > > >  		pr_err("Failed to reserve lowmem bootmem\n");
> > > 
> > > You are adding a helper that returns an error code and then ignoring it 
> > > at all call sites. Even though it can only return -ENOMEM right now, 
> > > dropping the return value is not good practice.
> > 
> > I don't think error code is important here.
> 
> Perhaps, but it is just not elegant to add a function that returns an 
> error, call that function from three places, and ignore that error every 
> time.

Because it's not important what the error was. 
 
> What is wrong with:
> 
> err = kho_reserve_bootmem_area(...);
> if (err) {
>         pr_err("Failed to reserve lowmem bootmem: %pe\n", ERR_PTR(err));
>         ...
> }

More churn for no value?

> -- 
> Pasha

-- 
Sincerely yours,
Mike.


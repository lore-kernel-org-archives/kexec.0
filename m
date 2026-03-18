Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A9B103E160
	for <kexec@archiver.kernel.org>; Wed, 18 Mar 2026 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHsENFWJu5RfeUAa+mJU7gbm+1K/VwnjpaZM6gtznCA=; b=lFOE/3t4K6nFM8L7hSjAgOtiIT
	yX8mw32Q3yVt/P3DTOZlYzzrsjKAL8c/bvbafBNUrk+0Jkirx2BApZ4wKy9wE/btLAlDzw2lwowPr
	jMyhLizsUuzYkt/ks0gEbj/yKdWMAzLsvm2o7Ic8PDoMlUVEcylezLHtp7M/7KL2UajfetJa+fKVO
	zJHpfUnuvyNG7WPvclBsshnel5XTKMmx3PQYg3HWFCHaGq8gFdflvhXQdPVtKyAKv5ea0V73JaGgW
	mGQxemHqkCz+N/O6UHiwZfLrYhYLbRuyNP0NJvHZiiEQzFUjBeTJQDXTQ7fiMVbfKhrZoB2yyKpOE
	TW1YB9Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2og3-00000008GRR-2HkZ;
	Wed, 18 Mar 2026 11:03:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2og1-00000008GR5-0pmN
	for kexec@lists.infradead.org;
	Wed, 18 Mar 2026 11:03:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CAF13439DC;
	Wed, 18 Mar 2026 11:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ABBC19421;
	Wed, 18 Mar 2026 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773831776;
	bh=zfsdZBqryydH27u6JZMfb3afJOf35YTfOia93PQ1C00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+3MoTCFbOoSCaDnsO98mty6x/IRu1jwhpGqiG9UdhI2m9A4L+uLhSAyE8ok1p0Ai
	 CO9lM8wb7ZgHkq4g3ptKIChmnYSYqVIhmg8gKwDFU0PrqHJgFki/7/SmmLwcdTFf98
	 wKffjIZN34gzR3Nep6U+Va9Ipn9NsKn3+Wuump9CHVsQZ5bgo6n9SdcmTAj44pTc/y
	 YDEGzmLqWRm92GzrlnLvCttlhG3bpFVJwFP72Ssvpo/99OatfSjmPSlDtusovF3NdX
	 nQ0WhL22ieafm7WwepuzVuyKxNjn9eOkayIYmeA1LJ8wiUDvRp6nHUYoSDLr63/XYp
	 F1GelnWWCD1Wg==
Date: Wed, 18 Mar 2026 13:02:49 +0200
From: Mike Rapoport <rppt@kernel.org>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 2/3] kho: fix deferred init of kho scratch
Message-ID: <abqGWfEINMEeh9B6@kernel.org>
References: <20260317141534.815634-1-mclapinski@google.com>
 <20260317141534.815634-3-mclapinski@google.com>
 <abpxUEijdHJzziEV@kernel.org>
 <CAAi7L5e9GxgvGTFvPfcn81Ve59N-K-o7FOh+Y8qKHwpuCYycCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5e9GxgvGTFvPfcn81Ve59N-K-o7FOh+Y8qKHwpuCYycCw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_040301_259726_BABDA27E 
X-CRM114-Status: GOOD (  13.07  )
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

On Wed, Mar 18, 2026 at 11:33:09AM +0100, Michał Cłapiński wrote:
> On Wed, Mar 18, 2026 at 10:33 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > @@ -1500,8 +1502,8 @@ static void __init kho_release_scratch(void)
> > >  void __init kho_memory_init(void)
> > >  {
> > >       if (kho_in.scratch_phys) {
> > > -             kho_scratch = phys_to_virt(kho_in.scratch_phys);
> > >               kho_release_scratch();
> > > +             kho_scratch = phys_to_virt(kho_in.scratch_phys);
> >
> > Why this change is needed?
> 
> It's not necessary but kho_release_scratch() will call
> kho_scratch_overlap(). If kho_scratch is NULL, kho_scratch_overlap()
> will return early, making it slightly faster. Alternatively, I skip
> invoking kho_scratch_overlap() if migratetype is already MIGRATE_CMA.
> (resending this since the last email was html)

Thanks for the explanation.
Let's keep the change and add a sentence about it to the changelog.

-- 
Sincerely yours,
Mike.


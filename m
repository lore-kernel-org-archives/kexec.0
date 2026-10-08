Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F53DCA6007
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpUiMVYggDHC60dcd+5OU1osGuMwZpbWqR6frOfrR9k=; b=HQdriwQjQji9y3wSz+nTL/O/i4
	LFVHYOdtSwfQQq3K2ZWcrpQOS27KFdp44WDYbMf1uY422N2RES7OYdSYcDEk9BQpTI4X/9KqtLjrR
	lUIP61BbNOY/vl8HWd2AaRMfZztdr7EWp+kn/3BsRwLzWDxsC1waSuQ4UbcOMLR5N+mMXk6T2lYzf
	uAD/hA8vaBrYUtZ89S5eKJyrx2TYsDgjzBhhU06BQeW5aOZE+DTKTWx1Dg5zEgewEx4xI2KulOFvs
	QJpiF9sioh8GfD4cErKiDZEZCCd4HjRCpt5f60wTbMV5+fni4p3COSPyImJysq3aCa/Fi3N6xBiPP
	pcRZ3lsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkyX-000000043Tx-3Iaw;
	Thu, 08 Oct 2026 10:03:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkyW-000000043Tm-2L6j
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 10:03:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E75A2414EF;
	Thu,  8 Oct 2026 10:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9888C1F00893;
	Thu,  8 Oct 2026 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453823;
	bh=hpUiMVYggDHC60dcd+5OU1osGuMwZpbWqR6frOfrR9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hpqj7e9paR3mLUgx+I9fl3recU/uXrRAyWLlziTybAbQAZv3w4wLaBb349DuynC9F
	 gpU0/ybWFt+MegvClIbMPIlw+5jwM835m4w4fgQLQo9mCFIWLglqVGCAKfkWNs4tT4
	 BgdItEHFcwTpVS6UDVKECTXb3fzziR2cBA2x3BAkCipd5RIfqfIHQZ0ev1deRk1NS5
	 aL4aIq4+KdrP5LitbApMC6W75iQC/uHL1CsV5g07gKFQVd6EBMnCgOGxPhJ3lMvBV1
	 uq4rLCfDywOjVRNNzN1t7ij7pcko4oyb08JxMc8sd3gLXcgeh0BiwQDl3UoB85Yf27
	 mEYh1YaM0IdWg==
Date: Thu, 8 Oct 2026 12:03:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: tarunsahu@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, dmatlack@google.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	dev.jain@arm.com, Pratyush Yadav <pratyush@kernel.org>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 2/2] memblock: use binary search to locate candidate
 regions
Message-ID: <asdqetdGMXGhtiBh@kernel.org>
References: <20260926092448.4090401-1-tarunsahu@google.com>
 <20260926092448.4090401-2-tarunsahu@google.com>
 <asC1FwHVHOhBHDGK@kernel.org>
 <9huzy0c9siyn.fsf@tarunix.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9huzy0c9siyn.fsf@tarunix.c.googlers.com>
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

On Wed, Oct 07, 2026 at 02:06:56PM +0000, tarunsahu@google.com wrote:
> Mike Rapoport <rppt@kernel.org> writes:
>
> >> +{
> >> +	int mid, low = 0;
> >> +	int high = type->cnt;
> >> +
> >> +	if (type->cnt && base >= type->regions[type->cnt - 1].base +
> >> +				 type->regions[type->cnt - 1].size)
> >> +		return type->cnt;
> >
> > Using local variables would make it more readable IMHO.
> 
> removing this as per next comment. Let me know what you think? Should we
> keep this optimization or not.

Yeah, that's fine :)
 
> ~Tarun

-- 
Sincerely yours,
Mike.


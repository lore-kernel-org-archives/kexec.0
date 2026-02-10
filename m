Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27863EA811B
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cx2qFC8zKSktmx2f3TdcwYh+PzGsWeNescQ9pa/hiL0=; b=3o6OmzbIxlPOXGHjCBP5ynOlAw
	4llr3ggt2m0r6GKo19GcKNNOYYdi40NTH8l47JjeaHeaogREPDI9xZ/llPnL0tTJP8nAnsuv5wHiO
	lPcWLeCoVZL8Z13wNLL+e5XVAUquQ3AAPSvlNyZ8CQQQHDZXHmgeaGadMAJ0FbEiXy4YFiC0Y9qdJ
	RAOq2gH8EGlZCr0SXtrJ5i6je5TKOkD+eoKNgIXrJpdhZsAmd04GXHXQEhvOhHJgOJFcj0dVDcHPh
	eY4basRoeX94brgrjJG+H2GlZv1o6dh9s3s3wVaewcBJ+oE6WwJiUQ2TkwYv4/m/yLkcmw3GRrE8P
	E8FmMkRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoBi-0000000H15G-0f7G;
	Tue, 10 Feb 2026 13:53:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpoBf-0000000H14v-3ZWJ
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:53:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 230A743C53;
	Tue, 10 Feb 2026 13:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FBAC2BC87;
	Tue, 10 Feb 2026 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731634;
	bh=VjfuewZzYWww0CFJ55+XO3WsL/dZMjCPGMxVFhP69TA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vDd/q0azdMtrp2hKtDQkpUaA9emXt02SSh7+uAg7CkpQJk1RE3gahzbaGsioInj1p
	 x7WJ1rPOuQyw1aQfAXLKw+brfi4W4qFZw6Y/xB5+DC66567PDhAYMiwJFiOGSMfV3n
	 d7QuxkkYNLvVmuk8EzCaEHAmNYk6YJiG1L1N4e/QG+NZkbBbWSpwtkZd5vImwdQJFx
	 QpOktu/gxks+TfF96NyQq/n2BihpMTOVQfaBpfUYSPHLJGegZHwCsdNWrypoaOSbnO
	 enWdJBd0Wn10LU/ZXuSRfbCPw0f8Ua2BygD1+kWCSc5WKthVKRxoqWdPd6/zS8EGU2
	 WO6dD/9RiQ3jA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Hugh Dickins <hughd@google.com>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Samiullah Khawaja <skhawaja@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: preserve file seals
In-Reply-To: <20260210131307.GD3076640@nvidia.com> (Jason Gunthorpe's message
	of "Tue, 10 Feb 2026 09:13:07 -0400")
References: <20260123095854.535058-1-pratyush@kernel.org>
	<20260123095854.535058-3-pratyush@kernel.org>
	<aXYGkb-QtYNaWYw4@kernel.org> <20260126183115.GU1134360@nvidia.com>
	<2vxzseb8u4kq.fsf@kernel.org> <20260210131307.GD3076640@nvidia.com>
Date: Tue, 10 Feb 2026 14:53:51 +0100
Message-ID: <2vxzikc4so0g.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_055355_909136_308B55CD 
X-CRM114-Status: GOOD (  21.50  )
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

On Tue, Feb 10 2026, Jason Gunthorpe wrote:

> On Tue, Feb 10, 2026 at 02:10:45PM +0100, Pratyush Yadav wrote:
>> Hi Jason,
>> 
>> On Mon, Jan 26 2026, Jason Gunthorpe wrote:
>> 
>> > On Sun, Jan 25, 2026 at 02:03:29PM +0200, Mike Rapoport wrote:
>> >> > @@ -67,11 +72,13 @@ struct memfd_luo_folio_ser {
>> >> >  struct memfd_luo_ser {
>> >> >  	u64 pos;
>> >> >  	u64 size;
>> >> > +	u64 seals:8;
>> >> 
>> >> Kernel uABI defines seals as unsigned int, I think we can spare u32 for
>> >> them and reserve a u32 flags for other memfd flags (MFD_CLOEXEC,
>> >> MFD_HUGETLB etc).
>> >
>> > It is a bit worse than that, the "v2" version is only going to support
>> > some set of seals (probably the set defined in v6.19) and if there are
>> > new seals down the road then this needs a version bump.
>> 
>> If we are running say kernel X, then X + 1 will always support a
>> superset of the seals, since the seals are UAPI. So it should be able to
>> handle all the seals that are given to it by X. This only becomes a
>> problem on rollbacks. Is this what you are worried about or am I missing
>> something?
>
> I think you need a check at some point only permitting seals that are
> defined right now.
>
> Eg some future v7.19 kernel has MEMFD_SEAL_XX it should not be allowed
> through luo until the API is bumped to v3

Makes sense. Will add.

-- 
Regards,
Pratyush Yadav


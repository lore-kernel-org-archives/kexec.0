Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4DEEA810F
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0h9spvQPsXRmFyX7NfVe0MGvBvIuwiJh1xd+Oy7s8A=; b=d72nGhmxu6hTbjNtUiuLY8kuEK
	eiKHqGDEAVKy6uk9d9k1cgJI/eFRK28CWNxWAw7DXeTilDs+0iYXZYdB09GGcLbLNvvvNM0u4b8zf
	QQPxTMNx7aQ3eFtnGcVGuKUCumWX8DULjSAw05kciaebc5viY4/LOkqyZ01uw8ah63744vPOBwIOK
	LoI6v6WBIzIjJMbN4NE2MUF9r5ctp1IdQkzRMLqgq2vpvPUQWtsR5yPEDGgqwxBSyO9Oe8gitNq3S
	GJib6Wobku7NLjJXohlDli2Yw2a3V1eq1gyX0mvkg0cX+qEq2CWMCEtgvrLICAruqGNVMVG+cgz8d
	gBAlJj1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnW1-0000000GyeX-3Pxr;
	Tue, 10 Feb 2026 13:10:53 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnVz-0000000GyeO-4C1b
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:10:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D5BD60127;
	Tue, 10 Feb 2026 13:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F91C19423;
	Tue, 10 Feb 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770729049;
	bh=y/HJEMaa/rbv0tW6eu8usmweDN19KKP/8uDNCBZhhIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YAK2dF3e6lqB6pnmA+92RZmQ0JxS3hdmtrlWH7Jz+RnEUeWsrg3LJAlPHl0GcrSPf
	 my0Bd3/hU8KVKgVRr8mk3XkU42cjfs7f/8ciBFxBoxeDYXWLAx+2bZTTkPsx1P55d9
	 YYVWLtMai04SQzbJBBrCHbgEJdcL0PR7Ck7B5H8f6ihl46obqnBWV9l5W14fWQObk1
	 0NSh4d6EpTsapeDSGqPVuBK+9SyLfyNrJaKSFL1sQYnkH/LsvWUeEayowKhUorndES
	 JEdDncgOcjnhgUgHsZ+cA+TMccqh1vJqyUBBoV78whC6k2Gu9R5OqwcJzOheqBow8c
	 CWN/XFgXUw8yQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Hugh Dickins <hughd@google.com>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Samiullah Khawaja <skhawaja@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: memfd_luo: preserve file seals
In-Reply-To: <20260126183115.GU1134360@nvidia.com> (Jason Gunthorpe's message
	of "Mon, 26 Jan 2026 14:31:15 -0400")
References: <20260123095854.535058-1-pratyush@kernel.org>
	<20260123095854.535058-3-pratyush@kernel.org>
	<aXYGkb-QtYNaWYw4@kernel.org> <20260126183115.GU1134360@nvidia.com>
Date: Tue, 10 Feb 2026 14:10:45 +0100
Message-ID: <2vxzseb8u4kq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jason,

On Mon, Jan 26 2026, Jason Gunthorpe wrote:

> On Sun, Jan 25, 2026 at 02:03:29PM +0200, Mike Rapoport wrote:
>> > @@ -67,11 +72,13 @@ struct memfd_luo_folio_ser {
>> >  struct memfd_luo_ser {
>> >  	u64 pos;
>> >  	u64 size;
>> > +	u64 seals:8;
>> 
>> Kernel uABI defines seals as unsigned int, I think we can spare u32 for
>> them and reserve a u32 flags for other memfd flags (MFD_CLOEXEC,
>> MFD_HUGETLB etc).
>
> It is a bit worse than that, the "v2" version is only going to support
> some set of seals (probably the set defined in v6.19) and if there are
> new seals down the road then this needs a version bump.

If we are running say kernel X, then X + 1 will always support a
superset of the seals, since the seals are UAPI. So it should be able to
handle all the seals that are given to it by X. This only becomes a
problem on rollbacks. Is this what you are worried about or am I missing
something?

>
> So I'd check that only supported seals are set here:
>
>> > +     seals = memfd_get_seals(args->file);
>> > +     if (seals < 0) {
>> > +             err = seals;
>> > +             goto err_free_ser;
>> > +     }
>> > +
>> >       ser->pos = args->file->f_pos;
>> >       ser->size = i_size_read(inode);
>> > +     ser->seals = seals;
>
> ..
>
>> > @@ -444,13 +453,23 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>> >  	if (!ser)
>> >  		return -EINVAL;
>> >  
>> > -	file = memfd_alloc_file("", 0);
>> > +	/*
>> > +	 * The seals are preserved. Allow sealing here so they can be added
>> > +	 * later.
>> > +	 */
>> > +	file = memfd_alloc_file("", MFD_ALLOW_SEALING);
>> >  	if (IS_ERR(file)) {
>> >  		pr_err("failed to setup file: %pe\n", file);
>> >  		err = PTR_ERR(file);
>> >  		goto free_ser;
>> >  	}
>> >  
>> > +	err = memfd_add_seals(file, ser->seals);
>
> Because we really don't want this to fail :\
>
> Jason

-- 
Regards,
Pratyush Yadav


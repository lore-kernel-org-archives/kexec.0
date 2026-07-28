Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3C1C54F54
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 16:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1d8NjVYJJn+wjjiK3UWZkRgmZ9sB7Xz8XibGwlAR4TU=; b=EUP4ZznMofxO+kVlQF8F0raSa3
	eNqjdt6Qvxo14T2HhoYZJ6tsZ4Pd3Z2MmITqDczV5KhZAxfdf5fAwWVlUuIoyYQAfQoo8in+8mW/F
	3giLuN89nvfAVbuDqzWqY8NeigbVUMGk2w4R34ZZ1lYKdW6LLTUfW5YDIfvpSqCYZzIE2470UqgjR
	XTQML0Wrf13ZK3KU8vtRWu/4Zlc29rMqGwjtNeXqnSHP5SkKak6PSb98Nsr5fhojLHC+QNUfM/11M
	/3ePo2Uwgz3blpmlfl1sbU0VxyICcAvBO8/cxJPB12XMtWkeK8aFfSGwyMda8F70ZWhRvNbFlY1jv
	+mPp6m7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wokLD-00000005mev-1XQL;
	Tue, 28 Jul 2026 16:07:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wokLC-00000005men-1amN
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 16:07:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 07B2143C7B;
	Tue, 28 Jul 2026 16:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA8D1F000E9;
	Tue, 28 Jul 2026 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785254857;
	bh=1d8NjVYJJn+wjjiK3UWZkRgmZ9sB7Xz8XibGwlAR4TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=do9Qf31f+8z39RaavaLnmBkTzfJzmuRlrk8+c6DfkV589EUCL9anWdb2KW+CMNtWO
	 nrtuVp3Rl2+Ob8SWcEcEgDQDmBmreziaWFdrI6Yya8u6sJo92w2Sj2eF6lkknMnbx5
	 GswKhL3Abrgsq6uXH23uuN3kfiyB2ZAqwbRqDM15Tnm2MV06pRD43C/kEUuTbiNpZ5
	 eFujT+vDCoUOvMALJ+z87C7KGHWB/GVtPB7tOshxTpI2jwQtcUuhT1mpVkEPKrdSYm
	 Ssw8TFKkcDDJ/UEBU1loEG+wuv0jrBPxS0Kxb0zv5waA+ONOdsvZbCu6gb2ZomxRa3
	 OW3+Vdr61M8/w==
Date: Tue, 28 Jul 2026 19:07:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/21] kho: make boot time huge page allocation work
 nicely with KHO
Message-ID: <amjTwoWWQBvFvz8N@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
 <amiwLSEi8cczamP1@kernel.org>
 <2vxzecgn89jt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzecgn89jt.fsf@kernel.org>
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

On Tue, Jul 28, 2026 at 04:37:26PM +0200, Pratyush Yadav wrote:
> On Tue, Jul 28 2026, Mike Rapoport wrote:
> >
> > Please take a look at Sashiko comments, we might need v5 if it has valid
> > (not pre-existing) points.
> 
> I took a quick look and the only valid points I can see are the ones on
> patch 19/21 "memblock: make HugeTLB bootmem allocation work with KHO".
> 
> All others are pre-existing problems.
> 
> Is it okay if I send a single follow up patch to fix 19/21? Or would you
> prefer a full respin?

I prefer a full respin please :)
 
> Also, general thing, but I should go and fix all the pre-existing
> problems too at some point. I sent a fix for a really simple one
> already, but Sashiko has found other problems too...

Yeah, that's true for any subsystem nowadays.
 
> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


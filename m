Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB93CD4851
	for <kexec@archiver.kernel.org>; Wed, 13 May 2026 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L3vDLT7eL5gRY9mYntqRxATDSmIZOlGhdKqY01mZEms=; b=EGd5d9EYP+b/rl3xFvNNTbZoKB
	TYLyTQeNTB0Ym1bvviQNKDYpDP5I+z2baCGt/hlVj1oKlVki5XxYvgAKgpQcGFqszJZwWCvDh++sy
	9XlNkfoSS65Zw9eGfoKcnwM26kyZnw5tEFOwWCpmjxi0kTyUKSPbq+mVTQXitZtfmRKCrwlE/2Tza
	qomUQltxgGUzB7bYzltv4bhCMIziy5sRhSQSUA0G0iMUSW+Iz99knupTOCix5npUzkDgc2dp7G4hv
	MkHJ6U/qPR5Vh95sHVHFrkUgD/OX9v7nKK+Q2oIh50Dnl/LzyEYiG+Bb9jxAA4tRqlALdMYhPogQ1
	XsZf+eGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4Ml-00000001eDL-2wJH;
	Wed, 13 May 2026 07:50:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4Mj-00000001eC8-06Jm
	for kexec@lists.infradead.org;
	Wed, 13 May 2026 07:50:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DBD644448;
	Wed, 13 May 2026 07:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A0EC2BCC6;
	Wed, 13 May 2026 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778658648;
	bh=MCQeJ5Iv131m6kkGCuiJh8lRJbCMXYg1egO+kK3uzhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8tu24O4/8Mdg4dQoG8Q12JtRpcMuK9ZwwlE5pj6eCnqgKc/jmkwugKBpoKzB3hGa
	 o+Rs7Q65GsAMFWDYtrgpUEIBoViTy2abAmFwlbZVlcRVeWDxIMKO6kKVJWy6lBX8gL
	 Ce+v2ddB1S/xm3KKhsCZii6w+nUWH1lQGa4KIZbHleuemxRBt/oNQHjphVdbsBZPuP
	 N6L4K76HmOhHk/uk9nlLwi7FV65i5CRLCs+zcFlMCEwrfoJYm1i7mcjXvqCdzIvEK/
	 5fr6mgjDcLiqLhamJaxAobs7Og6yey+bl7vX5pVJO+aaZIkg83JpIvBwKossxCoLjX
	 O5T//PvVAtihg==
Date: Wed, 13 May 2026 10:50:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: George Guo <dongtai.guo@linux.dev>, pasha.tatashin@soleen.com,
	graf@amazon.com, jasonmiu@google.com, ran.xiaokai@zte.com.cn,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	George Guo <guodongtai@kylinos.cn>, Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH 1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
Message-ID: <agQtUOImdpoYrfkV@kernel.org>
References: <20260509024415.33190-1-dongtai.guo@linux.dev>
 <2vxzcxz2dybi.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzcxz2dybi.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_005049_084075_30DA1C1E 
X-CRM114-Status: GOOD (  14.32  )
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

On Mon, May 11, 2026 at 12:40:01PM +0200, Pratyush Yadav wrote:
> On Sat, May 09 2026, George Guo wrote:
> 
> > From: George Guo <guodongtai@kylinos.cn>
> >
> > KHO_TREE_MAX_DEPTH is calculated as:
> >
> >   DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
> >                KHO_TABLE_SIZE_LOG2) + 1
> >
> > For systems with 16KB pages (e.g. LoongArch), this gives a depth of 4,
> 
> As of now, we only support KHO on x86 and arm64. Support for other
> architectures is not there. Are you working on supporting it for
> LoongArch? What is your use case?

arm64 can have 16k pages, but ...
 
> So based on this, looks to me that the 5th level table won't ever go
> above index 0 and the 4th level is enough to represent all possible
> keys.
 
... as it looks like your math is correct, I'm going to drop the patch for
now.

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.


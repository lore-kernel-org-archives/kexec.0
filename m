Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1BAC44503
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3n+7WeSImaE/4g038c1rdz4vAq6B0NjqEh02G408iWI=; b=gQKyGXFskzWKBHuB1S1hV15pdu
	pK3leQX09eotZ7Q/6bpXcURPG1JjQOFionv1eWPx6VrRMmQAckdejP/XwZQ51FX2BkDx68cYB5Zkr
	n+sX8/TLESab0EKwACgWUOyeYlq71b5aEG6V77HP7GxqWSBO8qnL/TpQbegwWfJIePdwu44UVaZKk
	Cbte384yWAj+iVY4O5adn5Cd60jB9Pkmy26sZs/8V4JaSP3E+rbZlHDZtXRH6D7DPAmRIhh5W9SXq
	NP+VbwB8XAcMZxKFPO8ns8tBKdynLhnRXI++xjcKgQdPxuXNoGHdzeOBM/CvqkeAQT0UfC96yifu7
	4mjxqCKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWNy-000000008Na-2lWB;
	Wed, 08 Jul 2026 17:48:38 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whWNw-000000008NC-2n5I
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 17:48:37 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ccdf36f63dso10475ad.0
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783532916; x=1784137716; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3n+7WeSImaE/4g038c1rdz4vAq6B0NjqEh02G408iWI=;
        b=vW6LTPk+BxDGgHVwkTPd7ZGyKAreI4Y86ooFfBn8+lci6V+NXlXBM47ISdjFicP2wq
         l/pKv296Z4vrZzQ1/P29qu9EI7I5ICMnAstbSKXjHn04W03E3EvlKVj1Q3yY9FBIEYKF
         i3I8mRSVLshTCHdzPLVK/BBuKyq65p8Idcxd04dZ2G2JM1psPOAFiF3TmR1LhAtq7EX+
         5oBYXeQOmnDMGV3l7GXzcHy7LFep7OKPRuJ4EH0hKLsBbp/q5i2USVGbIg6C/L3X4Fwk
         JLQfGW0wADDjoBckHBCmqoE83RsbVGu6GQniIk1WdZFCGaNORUqd1H7sviH2fO3gdfxZ
         zAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532916; x=1784137716;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3n+7WeSImaE/4g038c1rdz4vAq6B0NjqEh02G408iWI=;
        b=S9/f6LplMAzDNC2y3NBzw6fjAFF70IWVEHeFZgC3nafChNEQY+L5v57kQ1bCizidmf
         VU1xHpLlSgiza+FO79EOZJFXd31aQ22+BkfOjWVojcByxBuu2uenTf5dxNAJw3dgtm/i
         sDfVcAzq3ltShf0RenyWu3YZuqkJ4DUEzRNyDqAZn9+xvPzk1OVcdPqpzuCOp8o4m+Jh
         M/7DUpWSUnA6Qxfc56cdiPTGRkZfL7TYTJ7kcTThU8S54aTxkYYa8HfLCmdqB9hHyj2b
         bu7OWzvJym4eH0+CcDGnOB1T1gKgpFY6DE4qWLH04zeMcPvFm+jpucRvgxC/rVlRg1eS
         EgmA==
X-Forwarded-Encrypted: i=1; AHgh+RripDG8lX8mTEWVad/iZMSwTqD+9EYJsZi/puRlmtFxWMOpK7AOLvZ1dIqK/QJTa81HFZTTHg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyegHBfeA82hGaubcJofQd4XrKTIEg2F4Wk4tuS0+H7RE5E9dY6
	EZSjMoNvmkwS/xNGBBIEUPu80mcT7n5KLpfzrrnFH0MGSNIilMhM/XvH2VpGV44rHg==
X-Gm-Gg: AfdE7cnKrSNcoEFH74JpB5orDqHD12ub9dN0hnMq7vRTMpKl3d737Ho+pmT7Q4Ms4h6
	Ww3V2xEpGV15WnLfIFrLn4ASsc2A+wFTPrFBnHad+TVnJFzcPI2y/PceQ+Mwlzg4x3SdUBApgTG
	YfmmtZCCMEg0ToURMOgKVL0PkcGza9aVwOXGUtdb+T8F+E7M5+E5nnDPIfAMlqcxsWWv3RhTvCY
	2tWv7ytpQSoS3DZq4ExJzJDOb//gNYajKk5UB6QuiJzWp67YO+Df905WmmtTCxt07kPdkEEbB6p
	gp0IJbuoMoCypBu49OBJdrHI1lrqZf8Tcfwc4/j5CRoBAtz6f/ttYUopZkfh/1ii5DqvwEFD1uu
	qAmhRLEbsO7BAwieFI6J46JMuj8t/oCPPqv4+DlDdvrT1iyCYOZ5q3r204Yxe9scR5/my1r2MJn
	9JrsDZSvYlpdUE/BpWX4Rp9JIVwl9eHMkyEg77xkcjBGNvIUI=
X-Received: by 2002:a17:903:120f:b0:2ca:cbe5:c3af with SMTP id d9443c01a7336-2ccff8db91fmr332755ad.7.1783532915006;
        Wed, 08 Jul 2026 10:48:35 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bcc0sm31299635ad.67.2026.07.08.10.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:48:34 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:48:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] kho: Support preserving unsplit high-order pages
Message-ID: <ak6NbMKnGRoj4YkA@google.com>
References: <20260703020832.1731864-1-praan@google.com>
 <2vxz7bn5mv0n.fsf@kernel.org>
 <ak6CxVty3O5Ib7q4@google.com>
 <2vxztsq9l6x7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxztsq9l6x7.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_104836_709079_C98A9748 
X-CRM114-Status: GOOD (  31.14  )
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

On Wed, Jul 08, 2026 at 07:36:52PM +0200, Pratyush Yadav wrote:
> On Wed, Jul 08 2026, Pranjal Shrivastava wrote:
> 
> > On Wed, Jul 08, 2026 at 04:11:04PM +0200, Pratyush Yadav wrote:
> >> On Fri, Jul 03 2026, Pranjal Shrivastava wrote:
> >> 
> >> > This series is required for the ongoing effort to preserve DMA allocations
> >> > across KHO [1]. It addresses a fundamental mismatch between the current KHO
> >> > restoration logic and adds support for high-order buddy allocations.
> >> >
> >> > The Problem
> >> > ===========
> >> > The current KHO restore implementation treats all multi-page blocks as 
> >> > split pages during restoration, i.e. kho_restore_pages() initializes 
> >> > every 4KB page with a refcount of 1.
> >> >
> >> > However, many kernel subsystems, most notably the DMA allocator (via
> >> > dma_alloc_coherent), frequently return high-order non-compound pages. 
> >> > In this unsplit state, only the head page carries a refcount of 1, 
> >> > while all tail pages have a reference count of 0.
> >> >
> >> > Consequently, when these contiguous but unsplit blocks are restored by 
> >> > KHO in the new kernel, the forced refcount of 1 on tail pages causes some 
> >> > trouble with the buddy allocator. Downstream of the eventual free path
> >> > the __free_pages_prepare() [2] ends up calling page_expected_state() [3] 
> >> > when is_check_pages_enabled() returns true (only when CONFIG_DEBUG_VM or
> >> > debug_pagealloc=on).
> >> >
> >> > This detects the non-zero refcounts on tail pages [4] and incorrectly
> >> > taints the kernel while leaking the pages in question.
> [...]
> >> >
> >> > 4. A new helper, kho_split_preserved_pages(), is provided for subsystems
> >> >    that may need to split memory after it has already been preserved.
> >> 
> >> Umm, that sounds scary... Why do you need to do that? What's the use
> >> case? Why is the driver reconfiguring its memory after preservation? I
> >> assume these are DMA buffers, so why do they suddenly look different?
> >> 
> >> And in either case, why does KHO need to do the split? Why can't the
> >> driver unpreserve old preservation, then split the pages, and then
> >> preserve the new ones?
> >
> > Ack. I was trying to cover up an edge-case I guess but if we're simply
> > moving to an explicit restore API none on this would be needed.
> 
> Even with an explicit restore API, I'd say it would be a bad idea to
> preserve using one API and restore using another. The driver really
> should be unpreserving and represerving. And even that if it really has
> to.

Ack, I'll add a new pair of preserve/unpreserve APIs for this and
mention it in the kdoc that the driver is responsible for handling
splitting preserved pages by unpreserving & represerving.

> 
> -- 
> Regards,
> Pratyush Yadav

Thanks
Praan


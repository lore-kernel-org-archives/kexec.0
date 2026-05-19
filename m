Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9631ECD4F5B
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 14:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0sGtfsMt+NWWfWgP1GuryhPZenTz+43P15Viqh/cz5I=; b=hjxbeuF694Tl93rj1LrdE1Piqx
	Dk3ijbjkhcUMTVKRkFBIWzKuwJYLmaaCXGc22IgNjBH9sEkUvhH/Ggiee93ukSxg6rhkvcMJRYF9l
	HG4/Cr+f5lHoH99jKd6YxTRCRbO0lzTBw46A6ysyY6RfblMPE07n7RK7Ave2GrjxKxLeOC84lrigF
	VqZreBDH8HwG6YqYah4jmFZdKc+pMMUxnEbBxJqa+lARjWXNfxuP0y8jBLMH0vs910w/gNtQqXZp6
	OzggvQyLpL+Qvd3Z0vwN8S9fPgLUVeLlJkX2PKMCOF2vvginggnnXywLlvdpvxiF4ktsK/12tjZww
	uYxNbbGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPLC4-00000001mdc-213T;
	Tue, 19 May 2026 14:13:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPLC3-00000001mdK-49y1
	for kexec@bombadil.infradead.org;
	Tue, 19 May 2026 14:13:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0sGtfsMt+NWWfWgP1GuryhPZenTz+43P15Viqh/cz5I=; b=QpJ6WGhsTUXd6b0bSGGrlu77Lm
	KsxUZV2Aa8QcQo00HntfFKbT4KYBlro5rVt3TyH1ORODhzN6dKFNnHOIVA8SEtvPLG7+Ntni9LHln
	NOjbKuGWeuNyizfRzA7efuBfjZeDD3s51StqnN5WAGBKv+4x8bORMsRzzbSWBUP4ydww+tXDa0Ovo
	lf9+AZHCneesBOpW42port+P7Ifh0xifv1QjijuLYUJUUXUdqoSfmyR7bRee7ER3bavx5O9L4wbTM
	/beZ4x8m5EZfq64nJcvqAgYp9qgB3+2kAGUqL86psMZ2FWDx49jtLWXHTuHHG7ikIM81ZJGMNx2/Z
	onpp+XXg==;
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPLC0-0000000ETNq-45Uh
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 14:13:10 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso46217306d6.0
        for <kexec@lists.infradead.org>; Tue, 19 May 2026 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779199987; x=1779804787; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sGtfsMt+NWWfWgP1GuryhPZenTz+43P15Viqh/cz5I=;
        b=T/0+bgDy6j8gcNStbATUrw+rqsl74zxI4acd2DQlGzXP2Krvuql119c+gAYLA+K/hf
         zVi/hkOgPQXJCcyln74GhoqNJL592Hkp3GK0M2oQmrSHMg2SHcgaVRjaezhaBkY3wzMy
         3lq+r5ZsUr6nq9wYMzV2eVuYf8gZFnESiodJPmqouclsLYeIptMMwofdl/97v2U8OfBP
         Opz2tzSTn4pjDQJ3mfStMBKz3Jf4GtU55OL5krBfbEwlVPtc0QzL0QUZNon053Q9LwlT
         IXq2aIZp8E+cPvKpC5QnZbnM9hJ0WSa2e/9E72mTiOn/n/yWE794uNPJGFTpDjNjLOmT
         SseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199987; x=1779804787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sGtfsMt+NWWfWgP1GuryhPZenTz+43P15Viqh/cz5I=;
        b=kH8ZLu1OVOI/VWEq+Cdqj6OiWSzUQftPEoLgc+CYNvupckZFJ3lRjEhVp9jdj3Rv1O
         2sw/vFBm/igML3wDvEBOGFqnux7hOx1UP7MkeHqZKgehtTNDETcg1QK05kZU1st/n5Uw
         1JU6PQtsxlY5PA6hCLa6L0aLVksyuUwJit/xsLHt6cPC1RdArPXjt9XYTaHDtoQ0ICUb
         2PyM9+UhjSUxH7MOiXxWO5yTs4rPVQYuXes5Q7UBFvnH1cY4C5il4dz8xkEy9z00g0gt
         z/t7ZMXl5AcJgpBl3feIFfsUZTe24A1wYtEFKU7EcE/w+gEBKk68/pnYU9MWQPEC1Yee
         8dRw==
X-Forwarded-Encrypted: i=1; AFNElJ87JFIkMWU91ENSlDWNaHyTm1FPQG9NNUH3oMPBl2PPdRfzTQV7AIjK8v6/1OTGyH+N55S/xQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YykYQNRut7p8I3Pp41RN4R/cXPNekR4HpurmnvPrZKp8WTuUOlg
	wSA12ASaxkyO3Wg8ATRMGRqIbeWXO6DR3ikLzNSXjCtzaZ6YDXpkdkPc11QnZnKNSiA=
X-Gm-Gg: Acq92OElEWdliOj7M0MlQkEMGF/iuxMthxkGr1kPFbCO13Bf+Bd547ZVhupZjopohq8
	b3l9GMV976tro3MLSVqA97AkAFT3AXiew1D+MdnVL+wvnNyVUYU0xkeopXBRLLjaWgOHtFi8P03
	jxJsn5P5E5XvVPZM87j/SFTixkWlYvZA3thUizCsEv03HvO+QHFgC9FtfucgpbtHA5g9mdG1opL
	u7MMq+ETe5eB/OVTFYNXfwyaaoi7qC85g/TVohJCelZrrd78xHfN4QVt5k6pO5A4+xUepmZTLtG
	xj2zH23sUNS4mRu5WZcktnhHmHWa0enFe2uNbSn/Q6bthKb4GrpgrYTKtAi3JrQsMhJ+4tGz4Ty
	ETuMrMepcMZ0fjYRn7KGu54K5FWgRLbXd0Jhp7DazlIf/z94vaH5U7O8EBoR4pP9hkmp1NifIWn
	liTWwQdVRt2bWa5sh8dIHEl60QCXTNUOHhXqR6l9fUhUegnDTcIyY=
X-Received: by 2002:a05:6214:590a:b0:8ae:5fcc:8069 with SMTP id 6a1803df08f44-8ca0f62bc61mr376033696d6.22.1779199986811;
        Tue, 19 May 2026 07:13:06 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c424sm92013666d6.3.2026.05.19.07.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:13:06 -0700 (PDT)
Date: Tue, 19 May 2026 14:13:05 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] kho: fix order calculation for kho_unpreserve_pages()
Message-ID: <agxv3w--GPrc85De@plex>
References: <20260519133332.2498092-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519133332.2498092-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_151309_334241_3E592DF9 
X-CRM114-Status: GOOD (  15.82  )
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

On 05-19 15:33, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Commit 91e74fa8b1bc ("kho: make sure preservations do not span multiple
> NUMA nodes") made sure preservations from kho_preserve_pages() do not
> span multiple NUMA nodes. If they do, the order is reduced and tried
> again.
> 
> The same logic was not implemented for kho_unpreserve_pages(). This can
> result in unpreserve calculating a different order than preserve, and
> thus not actually unpreserving the pages.
> 
> Fix this by moving the order calculation logic to
> __kho_preserve_pages_order() and use it from both preserve and
> unpreserve paths.
> 
> Move __kho_unpreserve() down to avoid having a forward declaration. Its
> users are further down in the file anyway. Also, it results in grouping
> for all the page-level preservation and unpreservation functions. This
> unfortunately makes the diff hard to read, but the main change in
> __kho_unpreserve() is to call __kho_preserve_pages_order() instead of
> open-coding the order calculation.
> 
> Fixes: 91e74fa8b1bc ("kho: make sure preservations do not span multiple NUMA nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

Pasha


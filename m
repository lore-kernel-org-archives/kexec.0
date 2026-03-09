Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B14F41808
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdgCe2J3lvudY3Ri4RUwnY+/LSuwRgctaurAZvpEmI4=; b=0HPPFQRFa+0WXMBAOPHD+L3SDr
	ytfBNbKQ5/95YmmwHiu71WjF8evbHpd7QO6rd9JHVWiUjq3bQ1IaBpJUsyjE4cI6umVftfb0cyyHL
	CnTSulPy+XkRlMG9Cw/j5b9PF5vOrK9tdEBCmnx8y5iGmnHqHg3ZkS46WMMn2OXq86Tu8/BBVQHm6
	HkG9YFOriI+DuQmSOOb7ausdiCMAMaTqwI1OgfqOVWvaJSYCEelnA2UQIrfPgl+Cjzgcv5o3Xn8Fj
	G5QhOdd5PLygfvRbNAEvIZTTjKR4AHeOTOmJxZBOtbLQehm/NFIu/3a8FaAKQNaKhhSDE8GtCJ3MB
	3Uqc/tEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzd1X-00000007em3-2GfV;
	Mon, 09 Mar 2026 16:00:03 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzd1U-00000007ekd-0DVf
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 16:00:01 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ae49120e97so157135ad.0
        for <kexec@lists.infradead.org>; Mon, 09 Mar 2026 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773071998; x=1773676798; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdgCe2J3lvudY3Ri4RUwnY+/LSuwRgctaurAZvpEmI4=;
        b=1Sha9/oc4GGLKopYkMwwEKEBo4WBaXMfULcdb2BtjEbz6I79FS4l3s4//9y9epdQUD
         uwtnMBjVgj1rvSID1iK4Q5lO54Tl0+ptxE4lDC004qXv/1nCwrm0ZQ7TkbRnTY2orCZy
         b4VQ40mCQ8c77oZuLcw+I88ylQ1at+x8npcIdqG0PlUHBQwYKhtRwOgIYNRAyGOgutNx
         3x0eJsIAI5gUsGxE/tYTuB7UpE26p+pc4Pm7tdTqJ/mm9IkJYVo47N4v580LPXtOygBj
         pfCvvcDJraxb7ifgE1tmY1n5KmOGj7FCADYVhehKBw4Y1NiX6SxIV1Lx6vcDV59ua4Fy
         OVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773071998; x=1773676798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdgCe2J3lvudY3Ri4RUwnY+/LSuwRgctaurAZvpEmI4=;
        b=hCwg9fzQzNAojBcnormQq52L1fAGbQjJLe4FhYJf+X7psLzUSujE8ZFY5Mnim4VkkQ
         qawMXN3i68R9ZxMn7YFtEYUYZWCynBSyIXhHjfVvChKAs7/NQWzBA4UIGpKuxAdAEVff
         KDXzpiFNfthGfw+et6Uz99tx/q7ZpViQuXetyiB7/O/DgroDIPp9dqU0NkXZJhvpuF1E
         YBBSeiwuXfgZOyIRO8TBQnkRqr//wgreJX1FBXYsTjxUmMxVcS+1n59bfGG1eSTWoN7m
         LX5ndoSX+91q1+bkmohgDzk9BL4spTgbGNvoCTPkZFVDCTp60CQL7fGjI54pWHv4pXoO
         IrdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKzNC1pjUOrK02ke2w15FKB/rmhKA+KwQuiEe09DMWmHdpubKjHtaU00VCQ5qwq02dheDIQQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxFWDRSZQvrO+uxxlffmSfRtc/hL3P1NJb8w87E/OpFEe7Wknjw
	e7AWGdIIjRV6G9AQ0K9K9P7RKj/kdGnYxiFZcj4x0QGkjfdodZNzqy8VYtL4X3SAKA==
X-Gm-Gg: ATEYQzxYWs65oWpur0fiSmTABc9XA3BTpfALW9rMkUmHd6obtjbHNGtXGkkhwHfX9jF
	bgGFq4u2X8Qm+AylBaO4aq9mVKomp2/2Gnrd8aCYbKKgeRUzVte8f1jxR+R6mNqoXfOgig0AcQ8
	jexDjRcYPQHqgjrQUSxLn1ho0nqOYG9rgLyp7FsDbeVHq4/yO8HpDNSPKqjwXsOrtauMIanJv5u
	HNCJI9lEthDPbEiSrvJZPRT86wcpHnVvZ3WhMA5y/A3Qhk9qUh6Q9ET7OAjaTbWXCXpcVrZh0M4
	VKryoBf/Wu/+B1CpQm0pvNr38DqaKGhKlISadgY62JwUJbrGVF2ez/u4LArGTTCGd5HRD4RFZnp
	UJZ3oFESbi/7LaYrNwYdT4CIYAP/cdP0hB1wcjS/s7aBDi6rjU3SXh+6SZxvBd9cebu2ximOyOp
	+oVCJtdlPCZUIGL7QzJ6D/XaoySM32PsnJNPU9V5h2LVn0ceVehmH+seI2Bzjerg==
X-Received: by 2002:a17:903:98c:b0:2ae:6432:8f77 with SMTP id d9443c01a7336-2ae8ba59672mr3148705ad.17.1773071997647;
        Mon, 09 Mar 2026 08:59:57 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad894sm162231525ad.80.2026.03.09.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:59:56 -0700 (PDT)
Date: Mon, 9 Mar 2026 15:59:52 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: make sure preservations do not span multiple
 NUMA nodes
Message-ID: <aa7uXzkRCHuY2jA6@google.com>
References: <20260309123410.382308-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260309123410.382308-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_090000_118386_D528F57A 
X-CRM114-Status: GOOD (  13.33  )
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

On Mon, Mar 09, 2026 at 12:34:06PM +0000, Pratyush Yadav wrote:
>From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
>The KHO restoration machinery is not capable of dealing with
>preservations that span multiple NUMA nodes. kho_preserve_folio()
>guarantees the preservation will only span one NUMA node since folios
>can't span multiple nodes.
>
>This leaves kho_preserve_pages(). While semantically
>kho_preserve_pages() only deals with 0-order pages, so all preservations
>should be single page only, in practice it combines preservations to
>higher orders for efficiency. This can result in a preservation spanning
>multiple nodes. Break up the preservations into a smaller order if that
>happens.
>
>Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>---
>
>Notes:
>    Ref: https://lore.kernel.org/linux-mm/CA+CK2bDvaGmfkCPCMWM6gPcd4FfUyD6e5yWE+kNcma1vT3Jw3g@mail.gmail.com/
>
> kernel/liveupdate/kexec_handover.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>index cc68a3692905..bc9bd18294ee 100644
>--- a/kernel/liveupdate/kexec_handover.c
>+++ b/kernel/liveupdate/kexec_handover.c
>@@ -869,9 +869,17 @@ int kho_preserve_pages(struct page *page, unsigned long nr_pages)
> 	}
>
> 	while (pfn < end_pfn) {
>-		const unsigned int order =
>+		unsigned int order =
> 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>
>+		/*
>+		 * Make sure all the pages in a single preservation are in the
>+		 * same NUMA node. The restore machinery can not cope with a
>+		 * preservation spanning multiple NUMA nodes.
>+		 */
>+		while (pfn_to_nid(pfn) != pfn_to_nid(pfn + (1UL << order) - 1))
>+			order--;
>+
> 		err = __kho_preserve_order(track, pfn, order);
> 		if (err) {
> 			failed_pfn = pfn;
>-- 
>2.53.0.473.g4a7958ca14-goog
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>


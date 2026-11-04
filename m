Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBA5606EEAE
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=48BZiq0C;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J04GpwmK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kJ//CR0rNJB7v4/EWrk6Rgg5jN7w2KYrl2J7vZDJGZY=; b=48BZiq0C4y0LrRb/xc5c2BzDY0
	rSK6E/BfL+BhLCNA3EmWtaQFlyl8A5vAcUzme+c61TT2Tqoi/bTRDPIin5+mWEFU7PeCto90tbHqW
	ynOuRr8v6MgFT6Sqcw4s/4VjZ3Kd+mBjUyd+mEFqYSt2l6uoQbXHa504pxuh+nQPIrFlX3b/YajJb
	IHCW9nyOFdIrS9BEh3al45kg4cdrB+wpZM5kXzbUGhqFH48oicLP9AQksR35SbkWw6MDE60Ws3nNj
	oJ2A4hSxkNqUk/P44P/Bfd3+Gtb5X2YmVgxSwwq6AUVU3QEmpy1CiXCHVvG6ONJ+bS6VdlJvRlRRq
	u63oqh9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcnM-00000005lUk-0n1D;
	Wed, 04 Nov 2026 15:21:00 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcnK-00000005lUB-1o4z
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 15:20:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 33FCF407EC;
	Wed,  4 Nov 2026 15:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97921F00919;
	Wed,  4 Nov 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793805658;
	bh=kJ//CR0rNJB7v4/EWrk6Rgg5jN7w2KYrl2J7vZDJGZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J04GpwmKvwAvs5rvSq6YwT5Zq9je2GxUIiTrhVG2nBwZcdPfHjPQfInyEK880+tG1
	 wfkOfIVxeHWCezi8+24T/FuHWcz/MenvLN1yjdAWCXC2ZrjmfrTiZUJcVWGaYqItqX
	 HNEvdX6ssO5Bd5Y9pBuoM3uEqEv4B6EB6MR5ozg/OwrjyfE2G6NoaTFenz5GecG1fy
	 Z3HGwO3J755E9uCjFAWDfqCtB+33seQlaND6Miab8V8rbnvOD7Y3Wq6fC5/3i7/g3y
	 uy/6Ft2l/oJqLiMSM4D82qyRmP26bj6XroqOSTrEY73f/+vP5RL5C1pDGVj8cb/eaM
	 DXKMiygT229uQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 577C3198003A;
	Wed,  4 Nov 2026 10:20:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 04 Nov 2026 10:20:55 -0500
X-ME-Sender: <xms:Uk3rasYNqcr0e7oX_N81eL0LZXGbBpMgeTVyguwhoWE1deuGbU8VRA>
    <xme:Uk3raqkRwJA3NCHdCd2e-3d3UsbBBd3_hWmmG-yaagIX-Kj_QLSPl46GRUdZjMXmd
    9egYpQCqDMYyaNxmKYvMlKUQybVmyetKPdMIXU-MOb4diUc1NZa-UGKAQ>
X-ME-Received: <xmr:Uk3rajF3y4JOG8Lz_bJnitNrMmWcxB_a1dEiDKLOgwUebEP4zXW8dXTCBG0>
X-ME-Proxy-Cause: dmFkZTFtxpiu2LP14cIYcyJ7X5qabzm2BzpkyynMyiWriFQOhwO4iOlilGAYuG72swqRJi
    Bz8ZzcQ02LzCtXShfIs8nQwvr70QyU4BQ3QGSMTor0iqq1/umFVKzuPdZvGyZHpuAWbgUk
    YtJYpDNQU5eGtxkWAafn6R00XepYhmon5wsUybRAp1fyx25PodgGzm5XnTdaZ8/m/W318m
    ueFHNJOCuNFrSnRbN0ljsfFnJhIFQ1CTjoWhk+jPLi5y1GCZF4hKgzXGkldAtCAQq2wM97
    9+7I0RiDOJ1Wn8GcLWLH9LY1cuCc5mxnJslpqjVhHYjF7KE/HVWL6z7MRT7MuPxGnS/eYj
    T29jPgd4eodMdNH4DcjlWcD14WrHarLiWrEOrqYlYVpu7KKm0ZWeANy+dECylIIuTFu7zy
    LTGcyz27eAnQByqLr1NdcAwSH4C/6Q4Bw7Ogwvph1gYdZ2MyCiBaNIH6FMK2y3o0f84Q3L
    p2xKs8qurGukJ22IwBPNoSfbzPpC/KCrGS4y2MDhjbX0uO8R1lWRLw5Qh9VCcyR9s65+qZ
    4KID4H9Y7zzBUjd4hNNMTPEGBXRHn1y5jVskNGYt0nAzzYpN4X2CTMXrDWclf4ZfOq2tgp
    viuCv95jefJTx+bdkT9rAn8PUT0PqPIMnfKlV4uWjYXWOLnG2GEbuK84Ba6A
X-ME-Proxy: <xmx:Uk3rahHKq18GiQZ3nyDskj6S66qC9l5zFlQ6NBrq42V8pWmtDTHxnw>
    <xmx:Uk3rakxgzWtRN7zjBavMjABxjpDUcgRkOH59QIjhgCPm_pfj6wLIXg>
    <xmx:Uk3raqTPchiT8nft2yn3Rv82synIhoZ_VU2xumyCcOXC-vhPUYonZQ>
    <xmx:Uk3raqp12uS3JTOm8qXzawV8IlzevdpwPwxlmD4GdeuBWbxDd4IM1Q>
    <xmx:Uk3raqvxVr0tfkuHZM52LGQpZuZBFJbugGo5z2yo_9nC6sElCg_8FRO6>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 10:20:50 -0500 (EST)
Date: Wed, 4 Nov 2026 15:20:49 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	muchun.song@linux.dev, osalvador@suse.de, david@kernel.org, jbohac@suse.cz, 
	sourabhjain@linux.ibm.com, ruanjinjie@huawei.com, leitao@debian.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH] mm/hugetlb: allow crashkernel to reuse hugetlb CMA memory
Message-ID: <autMHwldMudQOO3j@thinkstation>
References: <20261104142727.2894800-1-usama.arif@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104142727.2894800-1-usama.arif@linux.dev>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 06:27:27AM -0800, Usama Arif wrote:
> Use a separate suffix to make the exclusion of existing HugeTLB
> allocations from the vmcore an explicit choice.

The crashkernel=size,cma documentation already says that pages allocated
from the range are not in the vmcore and that it should not be used if
dumping of userspace memory is intended. HugeTLB pages are userspace
memory. I don't see what a new suffix makes explicit that ",cma" does
not already.

Why not let crashkernel=size,cma take hugetlb CMA first and reserve a
dedicated area only for what hugetlb CMA does not cover? With
hugetlb_cma=6G crashkernel=2G,cma there would be no extra CMA at all.
With hugetlb_cma=2G crashkernel=4G,cma the crash kernel would reuse the
2G and a dedicated 2G area would be reserved for the rest. Either way,
nobody has to learn a new option.

The catch is ordering. reserve_crashkernel_cma() runs from setup_arch(),
but hugetlb_cma_reserve() runs later, from mm_core_init_early(). The arch
code could record the size and leave the reservation to generic code
right after hugetlb_cma_reserve(). That is still memblock time, so the
remainder can be declared there. An early_initcall is too late for that.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


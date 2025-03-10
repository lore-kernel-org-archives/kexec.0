Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E03C282DE
	for <kexec@archiver.kernel.org>; Mon, 10 Mar 2025 08:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=csWbwEiXnN3k3hOiqezshSsmwqgj7zqeo9XkzzIm5Ds=; b=rVSmhCvIMgNV99EMvE76/wwTwQ
	FuFn/X6aUWT6I8UslW9MJ/++3ZvioBQ5YkhT7ueZF1oJSCrFl7Xjwslg3jpDaEgFqZsa2aYzH9JUY
	+TeBh8LuL/cEiz8UodPjqr/8RPQRaTQyopZRU82VdYjRCx1ML38/UKhASI8FpxsvEyLbUnc7A4EM/
	6vbxMY1uL/yykRNQiP+goJBQJw8dBTyGDiC+V9pLoC+By0k66RLG8IS3zUqfaO/fg5R4MWq4Jw+90
	RZskxXl+BfnJr8p30tUO3em2c9fUGazm0B/DqlcmppNIl6N/7mea3IMk66K6ALOA4X32F7Jd5Jl05
	m8+47ZSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trYWY-00000001v5y-2puC;
	Mon, 10 Mar 2025 08:30:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trYUq-00000001ubf-2g7l;
	Mon, 10 Mar 2025 08:28:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8AAEF5C488E;
	Mon, 10 Mar 2025 08:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20474C4CEED;
	Mon, 10 Mar 2025 08:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741595303;
	bh=7uCFQcex+j6cpQPJF/6LfRBEaDs9jns/4ey91A2Sm5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dt+61OBuhSx0XzWa7kuR97NtRZolf+Ni76hFMdBs33YLt/1k+RMsxShKq8ywE5izv
	 Xq0lyi+y7SJzKRcmF6pLe0/pMIp2CN1NtohvIhp4Lfz70fUXaKP8fdlcvDgL6nFqFz
	 egPccLakn6UNDZwAc49vCsDGQvAccm2S6VOGcQu87kNkGYRfcWBfvdZMHBeMdQgSn4
	 J/L+XCc+GdJd0FpcGKyrg/IzPOfmKo79PxsSU2iqjEbBsVqKufsF8EZdPd3pBHuFq6
	 ipnF9XH2wTyTICRsMyZozegPxkb/EOVYqYIAdiNDHZduHzAW48E8qnjKEoT8Kf1pgw
	 OUmx0WBZnksfg==
Date: Mon, 10 Mar 2025 10:28:02 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 02/14] memblock: add MEMBLOCK_RSRV_KERN flag
Message-ID: <Z86ikkLVHQhLmBWj@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
 <20250226020915.ytxusrrl7rv4g64l@master>
 <20250310075627.5hettrn2j2ien5bj@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310075627.5hettrn2j2ien5bj@master>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_012824_796553_C1BE378C 
X-CRM114-Status: GOOD (  24.87  )
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

Hi Wei,

On Mon, Mar 10, 2025 at 07:56:27AM +0000, Wei Yang wrote:
> On Wed, Feb 26, 2025 at 02:09:15AM +0000, Wei Yang wrote:
> >>> 
> >>> From the above call flow and background, there are three cases when
> >>> memblock_alloc_range_nid() would be called:
> >>> 
> >>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
> >>>   * If it is called after (2), we don't touch memblock.reserved.
> >>>   * If it happens between (1) and (2), it looks would break the consistency of
> >>>     nid information in memblock.reserved. Because when we use
> >>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
> >>> 
> >>> So my question is if the third case happens, would it introduce a bug? If it
> >>> won't happen, seems we don't need to specify the nid here?
> >>
> >>We don't really care about proper assignment of nodes between (1) and (2)
> >>from one side and the third case does not happen on the other side. Nothing
> >>should call membloc_alloc() after memblock_free_all(). 
> >>
> >
> >My point is if no one would call memblock_alloc() after memblock_free_all(),
> >which set nid in memblock.reserved properly, it seems not necessary to do
> >__memblock_reserve() with exact nid during memblock_alloc()? 
> >
> >As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
> >patch.
> >
> 
> Hi, Mike
> 
> Do you think my understanding is reasonable?

Without KHO it is indeed not strictly necessary to set nid during memblock_alloc().
But since we anyway have nid parameter in memblock_alloc_range_nid() and it
anyway propagates to memblock_add_range(), I think it's easier and cleaner
to pass nid to __memblock_reserve() there.

And for KHO estimation of scratch size it is important to have nid assigned to
the reserved areas before memblock_free_all(), at least for the allocations
that request particular nid explicitly.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D592CE92FE1
	for <kexec@archiver.kernel.org>; Mon, 29 Dec 2025 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9kCsFatynB5A0849K42/FH7W+ckv4A5AgUXc8wzTD+w=; b=EIfUknHK8A5RQUrePssdQd0S0U
	PgaWoyglIoco8JlJNwjnFPAzo/YETOxhgfJbR+Qr6jeag5VdqhkL4S8YTSOarOqSLLx24jA1tqcbZ
	knRc6xLg2gC0FZVkdFWcvVFAE2iZ1VOAOBlJvW49hkYcMXhGhSNFjeS1pVWE/2iXC5vhl6WzynecC
	0OMXgSmZoWdvaRPTmvQ3nxTjRE6E8yFEuBCxjZ5xG6iJmhcJew1GzFXzwrzfnXHZ4I78WDsakCcUx
	fH3FFLtkajvX/zjZ7DuKStbwgLija190pXtg7geUeQssh9PE7ZuFPY6mNTTypQMN0zXCV9uZK/POd
	pG1ua3uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKjk-0000000453B-39Pk;
	Mon, 29 Dec 2025 21:25:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKji-0000000452m-3R2u
	for kexec@lists.infradead.org;
	Mon, 29 Dec 2025 21:25:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2073243928;
	Mon, 29 Dec 2025 21:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC83C4CEF7;
	Mon, 29 Dec 2025 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767043506;
	bh=q82e+byaIcXWChEnLqhJwOQExSMsHkk9DYJ3CC9why8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AExtGijBIRiwcf0k6km3zcRvW4TlCNI/Gv/8K1uyvwCt+MmqI7n2mAEfhSwDxr7lp
	 YPyu5Hy68fYfyYpEq0E5593W4b6WJzNJJrtUMVCWXfcV9QsDT+cZZRoqzR6lvYNJpp
	 27Hv7sUpHCTtisjT95LLkJS0hGmz3yPcKyR3rQo8HCf3WaMRtC4Bs5lLSfwAmdXNMY
	 G5X3rSUjaDJrXPVLCuXBtNTVRWKgmxjt5DwDbx+ui9912NlwvIbWH3alq3ElIju24+
	 6j7CxeS7EnFinddUveciY1tott5eJo2PRhF4wLHywKTY6gyHjrk3cke9FicS0eAc0J
	 A4guRzmC53AuA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam
 R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Jonathan Corbet <corbet@lwn.net>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Alexander Graf <graf@amazon.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Vipin Sharma <vipinsh@google.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  kexec@lists.infradead.org
Subject: Re: [RFC PATCH 01/10] kho: drop restriction on maximum page order
In-Reply-To: <CA+CK2bDvaGmfkCPCMWM6gPcd4FfUyD6e5yWE+kNcma1vT3Jw3g@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 23 Dec 2025 12:59:05 -0500")
References: <20251206230222.853493-1-pratyush@kernel.org>
	<20251206230222.853493-2-pratyush@kernel.org>
	<CA+CK2bDvaGmfkCPCMWM6gPcd4FfUyD6e5yWE+kNcma1vT3Jw3g@mail.gmail.com>
Date: Mon, 29 Dec 2025 22:24:56 +0100
Message-ID: <86ikdp7zh3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251229_132506_932287_095988BE 
X-CRM114-Status: GOOD (  17.53  )
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

On Tue, Dec 23 2025, Pasha Tatashin wrote:

> On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> KHO currently restricts the maximum order of a restored page to the
>> maximum order supported by the buddy allocator. While this works fine
>> for much of the data passed across kexec, it is possible to have pages
>> larger than MAX_PAGE_ORDER.
>>
>> For one, it is possible to get a larger order when using
>> kho_preserve_pages() if the number of pages is large enough, since it
>> tries to combine multiple aligned 0-order preservations into one higher
>> order preservation.
>>
>> For another, upcoming support for hugepages can have gigantic hugepages
>> being preserved over KHO.
>>
>> There is no real reason for this limit. The KHO preservation machinery
>> can handle any page order. Remove this artificial restriction on max
>> page order.
>
> Before removing this restriction, please also add a patch that makes
> sure that the calculated order does not intermix memory from different
> topologies.
>
> I suspect we need something like this in kho_preserve_pages():
>
> order =3D min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> /* Reduce order if the block spans across NUMA nodes. */
> while (order > 0) {
>    size_pfn =3D 1UL << order;
>    if (pfn_to_nid(pfn) =3D=3D pfn_to_nid(pfn + size_pfn - 1))
>      break;
>    order--;
> }

ACK. Will do. And I think I will split it out of the HugeTLB series
since I think this can be applied independently.

--=20
Regards,
Pratyush Yadav


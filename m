Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6400D1CDC6
	for <kexec@archiver.kernel.org>; Tue,  9 Dec 2025 08:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aL/hwR8PIWPLlV6uFQBsf2fAQbPmjSBfIHKkmx7HAzw=; b=cU+LZJ/B4u48EFAD8PYjtem/Oe
	RVhHYwWMMVRO+VXcg3DMR1GLCnYKWyTshHYmrYhLSxAFj5I0j8PAwgrOOsmJOXIV3vD65YoVBMzUN
	JdibM79Mhw4a3cKu1WvNfTNaykVr5nT3ZstBDCvOzqlYRyCW5u/Ryn3whIszbyBDC6cg/GOFuO01R
	SxN3W3PY1lXnkJGpqwwDDQl4MUIIj7DhWAUvWYgouuQNxwHpUZqey0laj5bo3Cur/xjXouEQHP08i
	pauMmGv+QvrS/AZE3jSqAp/G9hN8GgjsyQxXnpDSGMf+Uuzl2f/UFO0+R353dtlVQf7e+L0BRKnCj
	V+8PlYbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSsw1-0000000DzEN-1MXm;
	Tue, 09 Dec 2025 08:19:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSsvw-0000000DzDt-42wz
	for kexec@lists.infradead.org;
	Tue, 09 Dec 2025 08:18:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 414CB40408;
	Tue,  9 Dec 2025 08:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66519C4CEF5;
	Tue,  9 Dec 2025 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765268335;
	bh=aL/hwR8PIWPLlV6uFQBsf2fAQbPmjSBfIHKkmx7HAzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J+aaFS9DJjhtBzUXMwjiV1dTctAzbSTgd+qhpLMl5+L/KZvE8jsx3AyT07Pl72FmX
	 DBXpTNDIbkr0ESOZCipm+oEipaq4Us8aDhRUR89KNBqA+0HaL+Rx/ENO3lxV6x8fuW
	 zptCYOGL5rXnmjGw26F1L16Wwp931gY+IQ6hg2bslYXpzSAJ9LgoTsnFgsw9jq78ry
	 1BCC+EnCrO8RFAZGdvmCba4sJVIpSvxSVnHIHT/MVh7fJqJYfQHh7ASXPxCpKc5FTR
	 5B5vOjVS8NOEHgGq2/S31MnHy6yDdyNJoBZTN7PXj7Rf8Rl7DtrXCXmUHKkDB38QiT
	 z81VvUd0S+h+A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Mike Rapoport <rppt@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  David Hildenbrand <david@kernel.org>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,  Suren
 Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Jonathan Corbet <corbet@lwn.net>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Alexander Graf <graf@amazon.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Vipin Sharma <vipinsh@google.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  kexec@lists.infradead.org
Subject: Re: [RFC PATCH 00/10] liveupdate: hugetlb support
In-Reply-To: <48d0b46e-2b82-44b6-a717-94bc258a508d@linux.dev> (Zhu Yanjun's
	message of "Mon, 8 Dec 2025 20:43:22 -0800")
References: <20251206230222.853493-1-pratyush@kernel.org>
	<48d0b46e-2b82-44b6-a717-94bc258a508d@linux.dev>
Date: Tue, 09 Dec 2025 09:18:45 +0100
Message-ID: <86h5u0ax0a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_001857_085346_62FB423B 
X-CRM114-Status: GOOD (  14.50  )
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

Hi,

On Mon, Dec 08 2025, Zhu Yanjun wrote:

> =E5=9C=A8 2025/12/6 15:02, Pratyush Yadav =E5=86=99=E9=81=93:
>> This series adds support for live updating hugetlb-backed memfd,
>> including support for 1G huge pages. This allows live updating VMs which
>> use hugepages to back VM memory.
>>
>> Please take a look at this patch series [0] to know more about the Live
>> Update Orchestrator (LUO). It also includes patches for live updating a
>> shmem-backed memfd. This series is a follow up to that, adding huge page
>> support as well.
>>
>> You can also read this LWN article [1] to learn more about KHO and Live
>> Update Orchestrator, though do note that this article is a bit
>> out-of-date. LUO has since evolved. For example, subsystems have been
>> replaced with FLB, and the state machine has been simplified.
>>
>> This series is based on top of mm-non-unstable, which includes the LUO
>> FLB patches [2].
>>
>> This series uses LUO FLB to track how many pages are preserved for each
>> hstate, to ensure the live updated kernel does not over-allocate
>> hugepages.
>
>
> Is this patch serise based on the patches in the link
> https://lkml.org/lkml/2025/11/26/1665?

No. That is an independent series. This series is based on
mm-nonmm-unstable, which has the base LUO patches and the LUO FLB
patches, but not the VFIO or IOMMU patches.

[...]

--=20
Regards,
Pratyush Yadav


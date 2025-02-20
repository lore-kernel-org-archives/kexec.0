Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656FFC021B1
	for <kexec@archiver.kernel.org>; Thu, 20 Feb 2025 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ywthUrsaZUgbi1jImCfUyZ9XeZtfacq1MlreX2juEEk=; b=piEWL/eoOu/iHk4Qp73tVe3DCP
	CvzlceqYYnICJukbfEr/UJ1SvPpkbKOE5vrT3mj7RIQ1Cz787hh7ioeeuqTGFMxTFFn9/rGrdizVb
	65HmkSg0M8pOepJJYiVA9BMjDAxbttI4wQWEYZe1Kv2eKErpr59zUokLeYEuKk6toDht44TemcrWE
	AURfsYbAO05nfm8Cslw8vkdm6M18wqMmsbsJYNA42BAWMtEiooPmfCBhiVc3h+oG9zJnZ4hwWsfiE
	MISpmBj5tUn6JnwyWuEJRGdQdJQ9M7NTQdkN8OWIZDqTAztGoHocwYS20YMKfYh2YjDjuAesyjSkL
	KdiKmWlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl7wq-00000001QV4-08Nw;
	Thu, 20 Feb 2025 14:54:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl7wn-00000001QTw-3iGy;
	Thu, 20 Feb 2025 14:54:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 771B95C5DAF;
	Thu, 20 Feb 2025 14:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63166C4CED1;
	Thu, 20 Feb 2025 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063280;
	bh=BC0dhBX7Eg81uhggtuEZHVM8dUwnpQ+dA2ufHLGdn4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InovFzdwowCfkaS3mdofhqdbNRDT0QPSXwLh3w3Ks3gabjyfLh3ZoKBTtSmNarqnX
	 NWSycHqGlN7yNd+0eWaOU0+ODeMj6drkyWUBF0F3RDCZrjku80gpxCYmc+kAAFUIhF
	 cIdOH8Da91vYXQfiFliQAi78+0x05PEFtzKvkt3XktgkdC4Zn64/wMsF41e4w438lb
	 73um6//H3gzH4CFINfnDIYtLDsWM0e8qrbcvmRP2pP+F9H/e6WTApFpXNGqIxMY23P
	 l5ycIRreRRuogv2tc/sBZpVOPGfjbPnHoaxZx2Ce/d5jWstSBddCKPXyzlLKyYjqF8
	 fPv0Kjhu6R8bQ==
Date: Thu, 20 Feb 2025 16:54:19 +0200
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
Subject: Re: [PATCH v4 01/14] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <Z7dCG3ihTnDuJ8_c@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
 <20250218145904.x57chhz3whvckzu3@master>
 <Z7WEktyNoCPylytL@kernel.org>
 <20250220083601.4p6ehmfhyvs5q5io@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220083601.4p6ehmfhyvs5q5io@master>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_065442_036945_221AF70A 
X-CRM114-Status: GOOD (  30.00  )
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

On Thu, Feb 20, 2025 at 08:36:01AM +0000, Wei Yang wrote:
> On Wed, Feb 19, 2025 at 09:13:22AM +0200, Mike Rapoport wrote:
> >Hi,
> >
> >On Tue, Feb 18, 2025 at 02:59:04PM +0000, Wei Yang wrote:
> >> On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >> >
> >> >When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
> >> >function performs initialization of a struct page that would have been
> >> >deferred normally.
> >> >
> >> >Rename it to init_deferred_page() to better reflect what the function does.
> >> 
> >> Would it be confused with deferred_init_pages()?
> >
> >Why? It initializes a single page, deferred_init_pages() initializes many.
> >
> 
> See below.
> 
> >> And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
> >> after it. Current logic looks not clear.
> >
> >There's no __init_reserved_page_zone(). Currently init_reserved_page()
> >detects the zone of the page and calls __init_single_page(), so essentially
> >it initializes one struct page.
> >
> >And we __SetPageReserved() in reserve_bootmem_region() after call to
> >init_reseved_page() because pages there are indeed reserved.
> > 
> 
> Hmm... I am not sure we are looking at the same code. I take a look at current
> mm-unstable, this patch set is not included.

I was looking at Linus tree, it was not there yet :)

> So I am looking at previous version with this last commit:
> 
>   8bf30f9d23eb 2025-02-06 Documentation: KHO: add memblock bindings
> 
> Here is what I see for init_deferred_page()'s definition:
> 
> init_deferred_page()
>   __init_deferred_page()
>     __init_reserved_page_zone()   <--- I do see this function, it is removed?
>       __init_single_page()
> 
> What I want to say is __init_deferred_page() calls
> __init_reserved_page_zone(). This sounds imply a deferred page is always
> reserved page. But we know it is not.  deferred_init_pages() initialize the
> pages are not reserved one. Or we want to have this context in
> __init_deferred_page()?

If the commit that introduced __init_reserved_page_zone goes in before KHO,
I'll just rename both functions, there is nothing about reserved pages
there.
 
> >-- 
> >Sincerely yours,
> >Mike.
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.


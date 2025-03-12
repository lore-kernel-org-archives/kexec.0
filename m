Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6E9C2BA1B
	for <kexec@archiver.kernel.org>; Wed, 12 Mar 2025 05:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KzbXFMV786eVJq7FLnO8K0MeCoB9B3Kay5zlGk5e+v4=; b=SznDIF10k7O3FT8r/2YyzJm7X5
	/uOSWbhEDiH5E79pZH3X2wBjS5CmzLxqRvyCLpBgP8KlB6Eaa79UrpgvSHmo+R6CnRyBhv8HVXqhY
	dayElkjwM7awMJnD1038MK2i266xWBuExoYFiI2E6zPeoMPD2HzgYw71ySsGRBD6WPgLPLVi7Aeso
	Zq2If0XDnY+2ctR9z9qgIknt7NthBFdAqcNKsm5oKVl9jgxfKD8Qq6e6A5IH0XwekcnoGzebS6fie
	NMSgfkNNZDb8GIClXD86/mxvpQkqr6qGKHKkxQGaVDghV9PYdvLNpJRf9dXE/ASSyUiFuLWn9WK7A
	bS/WnHbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEYS-00000007W6B-1AZR;
	Wed, 12 Mar 2025 05:22:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsEYQ-00000007W5B-0vex;
	Wed, 12 Mar 2025 05:22:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7568B5C00DE;
	Wed, 12 Mar 2025 05:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02259C4CEE3;
	Wed, 12 Mar 2025 05:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741756973;
	bh=MX9hYn1R3GA95hwjkNf4w1qXBrTQlxYINeZ/wUzSEoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJLi4J2x24E0OjEkqPuO1haW7AHR6DGYru/D1S6ptUFAvXbp8in4nAmGLKr2pOUg7
	 Z1J0plTI95OI5ebPj6ikSorMqIzs0QJEWTxu/wtkocmIXt2J7MukuodYaHq6AaCIbe
	 jjFPMJdAZgZHtTYJTVSEXf37NEP0oaHu8LCtGp5IhwCZJzWVAmRXwqDqvijPZiTaRi
	 K6OyYLahKkCniytb67C66EIRERf+81EC2yi2+TksactycCQF2RWhWrZFsp/iCcTi9a
	 JhFxt5gH9x92KyCsM0hxvS6FcRsy7ygG829sFZf8gGkI7EAo1Jz2UNTLaIb/g4ITvo
	 6pD0U/hv4Ofow==
Date: Wed, 12 Mar 2025 07:22:30 +0200
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
Message-ID: <Z9EaFhviaZHOqs8j@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
 <20250310095124.pa7dwgqhxglqrfes@master>
 <Z8_Ju0p63GBCdSG9@kernel.org>
 <20250311134126.xfjdq6sq7jtcotck@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311134126.xfjdq6sq7jtcotck@master>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_222254_375362_351F9381 
X-CRM114-Status: GOOD (  25.88  )
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

On Tue, Mar 11, 2025 at 01:41:26PM +0000, Wei Yang wrote:
> On Tue, Mar 11, 2025 at 07:27:23AM +0200, Mike Rapoport wrote:
> >> >> 
> >> >
> >> >I took another look into this commit. There maybe a very corner case in which
> >> >will leave a reserved region with no nid set.
> >> >
> >> >memmap_init_reserved_pages()
> >> >    for_each_mem_region() {
> >> >        ...
> >> >	memblock_set_node(start, end, &memblock.reserved, nid);
> >> >    }
> >> >
> >> >We leverage the iteration here to set nid to all regions in memblock.reserved.
> >> >But memblock_set_node() may call memblock_double_array() to expand the array,
> >> >which may get a range before current start. So we would miss to set the
> >> >correct nid to the new reserved region.
> >> >
> >> >I have tried to create a case in memblock test. This would happen when there
> >> >are 126 memblock.reserved regions. And the last region is across the last two
> >> >node.
> >> >
> >> >One way to fix this is compare type->max in memblock_set_node(). Then check
> >> >this return value in memmap_init_reserved_pages(). If we found the size
> >> >changes, repeat the iteration.
> >> >
> >> >But this is a very trivial one, not sure it worth fix.
> >> >
> >> 
> >> Hi, Mike
> >> 
> >> I have done a user space test which shows we may have a chance to leave a
> >> region with non-nid set.
> >> 
> >> Not sure you are ok with my approach of fixing.
> >
> >Wouldn't it be better to check for a change in reserved.max in
> >memmap_init_reserved_pages()?
> > 
> 
> Sounds better.
> 
> Previously I thought we need to hide detail from user, but actually it is
> already in memblock.c :-)
> 
> If you agree, I would like to prepare a fix.

Sure :)
 
> >> -- 
> >> Wei Yang
> >> Help you, Help me

-- 
Sincerely yours,
Mike.


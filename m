Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A9C36005
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TueZFVSlfkUTp0jdNfdYcZQNu83RAWuxPbzRk33Y34A=; b=4nE0El1PsGjtZePuiPQ4+7nsMq
	DU88FBC+w4qKHhS45pBwQndK0+zifKpsST1QA6fvW5kt/lFqC+1ZP9qtS5XxfbsixYLh6GmlAAZ9N
	LO67G98VZ0ae0lTiMxLMaPFkdOCnvjFk5u8KNz7baAby6WHJhr1czom7AfGBvsGw/kCqe7pp9fXGI
	NgReRBOnWS8CkRhNV17W0cMQ6oauLODGvPqfxV3amRmzETnVyF1tOHDs8sgxGrZGbTZ5ngeRI76LY
	RFjrvqcw2EsZYXjPb8NY60NwF75MjgqR3gS5+0PkE9Ma41MIw+yajMyYu8yOVFbBNuaDwmQsbI0TP
	wQQ2xYkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS2-0000000CU88-3nxz;
	Thu, 20 Mar 2025 15:04:55 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trzrP-00000005rhE-2u3f;
	Tue, 11 Mar 2025 13:41:32 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-ac2b10bea16so255272366b.0;
        Tue, 11 Mar 2025 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741700489; x=1742305289; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TueZFVSlfkUTp0jdNfdYcZQNu83RAWuxPbzRk33Y34A=;
        b=FutUqZlvQG36z607dw3hW9Pka4y+AxmTKzvi15aRhWEy/ggcjUw1KsdrFvc8gqsVcH
         MQ++ApfDldaQThgzy0KPJ11UOwJdMb5+6ecw5acCeVS2tJ28SER5LfWSKe88gU+YKQ6N
         H9y93gV2RpJn6EkdsnYcIEO/xGQR122wkRGFu8curIZZOAJJBSOeas1GWPamLFu0Ym7P
         tCFw+tsfJY0IrKkkQM4Z6N+aqqYhhyjlKP4k/3vIWXwYPOHu0cPVcXzMdZ2SjHJS7J7y
         AmAlVrENoao2O7ONGjx7tYhYaw9ajN22gvCQD2su/BUPHFWTDNHLjO4OyxUw7IbjSuDs
         stRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700489; x=1742305289;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TueZFVSlfkUTp0jdNfdYcZQNu83RAWuxPbzRk33Y34A=;
        b=rtBwLjnfSJOj8lpyqPzfn0z2YVgjgy9rCWbtXC4MmqLk4/XRell3Uq6gDMdrhQMv1h
         lqwmtasXpp0LPLHEcpZh3mx0bz0S5U21l1zXhD/s9dBeRMfzwYn2BxQKxPVDqtEYsIcD
         7uUYypCu/sahd7Or+7vnWiiFZ9vJfBrvMwX52bGx5knGkfyVBPvPz4C40w1M0LyoCMjk
         wm83iiWJQuyIEtBtqgNFNI1JWVqzDprQT1GsMr2FTTO4wqwh4Zc5qc6mgteZwgKCjdtw
         l/5+IrNwPzFoXfwkSsU3mSbvauZO0SEXHe9Qx+AheVi7lRbjHkHbzkfxmaksv01f4Unh
         Gevw==
X-Forwarded-Encrypted: i=1; AJvYcCUcmoD4t9v+v619z8wqEF3TSvuGpnoaUkWHsQFojTNAmv1P0Hu1Y+gRpWbYuBF4O2jktCHFIQ==@lists.infradead.org, AJvYcCWBpHa0jkvrI7fB417mAKsV2Be3mkeEZfscJDY5y3zwsGFWWkgj59/NMb82y+4RY1n9flUhRSX0kwbh9INDnUQhaA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyuvuQJbgfHKCWIm6LRtw3IYP+94Ydwh5CHWlxaDbHTPsyjqyiZ
	QqVGZKKYZGJA8vRhkXEQYTr/4d26861Rf3dgyDp4TnwRMLFycogO
X-Gm-Gg: ASbGncsrp6mE7jxTtd3tnauO00KB4fNAErXyPZKFgbsscBOQaCPyR51ZIgqyQixuipY
	HMJwGKDEoYfWBjJRFChMdbYRXLrfL2k6mJj8Uy7AGnco5zZT+0jERoMAcNQXHA6jjv4n8goDLVQ
	WF4mQmyBZ3T3QlfFCOMOt456OB3q1dzfeZlbYxXlW3apSmOVXbj9EMYzdbK2wKNxxqXFGH/j17C
	DCvpUpnVHx04ohGLqaMSLBEAr8Oo1AFBASNteTKmD5ltDPSuE1hjWr/iA634qBrnqmZmmNQvTiR
	sQ8gCoX/5ubkQSLxFpizVxvlfBzbZEUNp4qjyYepOq7u9bc2bUSiM6c=
X-Google-Smtp-Source: AGHT+IEqvcT3nUuyCclAJyMA5I1jSzcLHsXRqFYyLbC3aVoohYneT0bwBO9KyAHB0hhKMZdf6pm4uw==
X-Received: by 2002:a17:906:6a07:b0:ac2:c75d:f30a with SMTP id a640c23a62f3a-ac2c75dfff9mr258917866b.37.1741700488456;
        Tue, 11 Mar 2025 06:41:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653d1esm481132766b.125.2025.03.11.06.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Mar 2025 06:41:27 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:41:26 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
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
Message-ID: <20250311134126.xfjdq6sq7jtcotck@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
 <20250310095124.pa7dwgqhxglqrfes@master>
 <Z8_Ju0p63GBCdSG9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8_Ju0p63GBCdSG9@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_064131_730753_43962FEE 
X-CRM114-Status: GOOD (  29.71  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Mar 11, 2025 at 07:27:23AM +0200, Mike Rapoport wrote:
>Hi Wei,
>
>On Mon, Mar 10, 2025 at 09:51:24AM +0000, Wei Yang wrote:
>> On Sun, Feb 23, 2025 at 12:22:29AM +0000, Wei Yang wrote:
>> >On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>> >>Hi,
>> >>
>> >>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>> >>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>> >>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >>> >
>> >>> >to denote areas that were reserved for kernel use either directly with
>> >>> >memblock_reserve_kern() or via memblock allocations.
>> >>> >
>> >>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >>> >---
>> >>> > include/linux/memblock.h | 16 +++++++++++++++-
>> >>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>> >>> > 2 files changed, 39 insertions(+), 9 deletions(-)
>> >>> >
>> >>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >>> >index e79eb6ac516f..65e274550f5d 100644
>> >>> >--- a/include/linux/memblock.h
>> >>> >+++ b/include/linux/memblock.h
>> >>> >@@ -50,6 +50,7 @@ enum memblock_flags {
>> >>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>> >>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> >>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>> >>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>> >>> 
>> >>> Above memblock_flags, there are comments on explaining those flags.
>> >>> 
>> >>> Seems we miss it for MEMBLOCK_RSRV_KERN.
>> >>
>> >>Right, thanks!
>> >> 
>> >>> > 
>> >>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> >>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> >>> > again:
>> >>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>> >>> > 					    flags);
>> >>> >-	if (found && !memblock_reserve(found, size))
>> >>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>> >>> 
>> >>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>> >>> correct, the reserved region's nid is not used.
>> >>
>> >>We use nid of reserved regions in reserve_bootmem_region() (commit
>> >>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>> >>know the distribution of reserved memory among the nodes before
>> >>memmap_init_reserved_pages().
>> >> 
>> >
>> >I took another look into this commit. There maybe a very corner case in which
>> >will leave a reserved region with no nid set.
>> >
>> >memmap_init_reserved_pages()
>> >    for_each_mem_region() {
>> >        ...
>> >	memblock_set_node(start, end, &memblock.reserved, nid);
>> >    }
>> >
>> >We leverage the iteration here to set nid to all regions in memblock.reserved.
>> >But memblock_set_node() may call memblock_double_array() to expand the array,
>> >which may get a range before current start. So we would miss to set the
>> >correct nid to the new reserved region.
>> >
>> >I have tried to create a case in memblock test. This would happen when there
>> >are 126 memblock.reserved regions. And the last region is across the last two
>> >node.
>> >
>> >One way to fix this is compare type->max in memblock_set_node(). Then check
>> >this return value in memmap_init_reserved_pages(). If we found the size
>> >changes, repeat the iteration.
>> >
>> >But this is a very trivial one, not sure it worth fix.
>> >
>> 
>> Hi, Mike
>> 
>> I have done a user space test which shows we may have a chance to leave a
>> region with non-nid set.
>> 
>> Not sure you are ok with my approach of fixing.
>
>Wouldn't it be better to check for a change in reserved.max in
>memmap_init_reserved_pages()?
> 

Sounds better.

Previously I thought we need to hide detail from user, but actually it is
already in memblock.c :-)

If you agree, I would like to prepare a fix.

>> -- 
>> Wei Yang
>> Help you, Help me
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me


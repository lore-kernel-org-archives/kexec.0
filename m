Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB9AC36002
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fIk/wLn8siLSomZZskx1hmM4iyC641S3xGJlKKijlM=; b=vW9JXlrBGjE0PWz2xiTfQyGaTw
	kHqtvek72rEsoyp6c/UEs2sps1g3QK9chrXlSEzK8f81YLcTK71a/xjCai/8djhpIIHzBcdV35XrS
	rj4ftP+FpR/DWidJbmpqAW3iQkv14nZx/4CUNgxsu+BddggWelzftpBDeZOCO0kJf9A78OptiskME
	zc4tKcz1hf8xzo9Lgo7cJbb//w4WLUnkx9XrzZOMv4oJqEBR/t4hLJcJRXY2YmLJno0Wsn3nqmWxC
	A29ZULWCqedGFnIZZ2VjzyZy8ZbfpJX8XBlbSEv6Rwm+0CVQKkq32sS9VKorTXJBDeD8GnIl9WBZ+
	jNkhftrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS2-0000000CU7E-1SFd;
	Thu, 20 Mar 2025 15:04:54 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trZnL-000000029Vo-3QEv;
	Mon, 10 Mar 2025 09:51:37 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-ac2ae81dd81so53665566b.0;
        Mon, 10 Mar 2025 02:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741600294; x=1742205094; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fIk/wLn8siLSomZZskx1hmM4iyC641S3xGJlKKijlM=;
        b=EX0stzQdVxuZLvUJ9yz2Fw2H1pCiUIufDdk4D999Kt4bSTJdmYNcZNMhELY8UDvwv6
         OoxNQYd2nFtlZEdQZWddMZFxq58KDqOUlsEUQ8GwisEmznZbYpFX7CHLW+msm3bopE+L
         jDZvfRAaKRBnyBgxDX6uJ3IL5fzYA6evyDXujRh6ma+nG7L2UeJWfwOysve/Q5wstGgJ
         AmSWtsXNUJ1EO/CZWpo/fk7zpjr7tjr7uQUeS6ZMJao4Og5ZVuq8/X5a8/r7s2Vsuz72
         IfDbUhqrUdwyCrXIalc22rEmtKLYZzIRL+8zY85tnnRY15mWSV+MRthZy9kuElegyEB6
         GnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600294; x=1742205094;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7fIk/wLn8siLSomZZskx1hmM4iyC641S3xGJlKKijlM=;
        b=gDsy0Q0s/DzreItM7FhmEqSrSApxA65NPAMB0KU3Rc/Q/YnK0T5N+zoc4wzmSLY2ez
         C0nCGyf4OGWcFDz5LMudDlDkmNmwFN71Mfqo4IDnSTW7flx3FJflk/9F2dFM5M/GkrSN
         iXIIMCZ3ztTRg/1w6eHxzjyKsmMFI9urtseO8NVft2kSj+LoFYQLY9a95NY+bIj69Y/1
         jHAUHEc3kLKIAMsqPA6BbRvO5u2F309UmcNRthKz7FSQevELvNJAxy7fk6MLordkTWkG
         E/0l89ZPDTCCFDD0vhGg4WHfj/81vNxCfX2rvxW5iyDKNFW2ArZNY6a4GMsZYd+D6x2P
         UAiA==
X-Forwarded-Encrypted: i=1; AJvYcCV27x5P1QPQpprWe0+loywbYOR1mgH1G3fy8pQNxSTDY3MRRDOnitz3cwL/W5x0mlVrbRkHUg==@lists.infradead.org, AJvYcCWWqlT080e5GGc0vFZZ1zR16hLV251kyU4gJYHp2d2pSyoEG9D4mALY+1fzGd7JmDHSg7OcTNmvg90LOILcFutT2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwC4uwoLKw+bRymnGrHGsR3FDmw0kHCxBvoPXpzQe0b5BxPjliK
	2UZpsh6MVBcDOwU0Y4dx7f5XW1ed8P7G8H44c4E/hQx2qyVNYZGr
X-Gm-Gg: ASbGnctNEbe9vMQkqEWBfVbjhbnJlUeeg/6cvi3ixZlsBDmflwINQ4bfLat3OD+rp9D
	R7XwhtR0dxv8KRBc8d69fXYppxA1nPiqZQcSkrQCqNq3/7duEQbnn4A7jI/grlRjIS2+HltspLp
	LTKROXSDtBXzbR0hdTjY2r3eTFSNWJL+yO+4lqdEO4+J8HCwSaS1gO+KSrVSViLN/TpZQGaptc9
	OBtV9YPG0AJmGMQoPbcPJCh23CeNG8sIVEzgnQTgnoagCBcPV82hzGcn2mFx63COt3iaIUBCZ+s
	/Jc4NGgy0OzN4fEfuQBgqfcdPU6VEWSNWjZo94YzQWsJK5I90otaSpE=
X-Google-Smtp-Source: AGHT+IEnsaBC89bibOD1BqC+ZZ1kovv3JGu+umNRENY/jx8wzQl9KTymklI/3Rp6DH54iA+FTxPRUw==
X-Received: by 2002:a17:907:3f2a:b0:abf:5fa3:cf96 with SMTP id a640c23a62f3a-ac252a879d7mr1234111666b.14.1741600293920;
        Mon, 10 Mar 2025 02:51:33 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac255589a30sm594247266b.107.2025.03.10.02.51.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Mar 2025 02:51:25 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:51:24 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
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
Message-ID: <20250310095124.pa7dwgqhxglqrfes@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223002229.xuk6xlp23zr72hkc@master>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_025135_855710_734A6302 
X-CRM114-Status: GOOD (  24.20  )
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

On Sun, Feb 23, 2025 at 12:22:29AM +0000, Wei Yang wrote:
>On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>>Hi,
>>
>>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>> >
>>> >to denote areas that were reserved for kernel use either directly with
>>> >memblock_reserve_kern() or via memblock allocations.
>>> >
>>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> >---
>>> > include/linux/memblock.h | 16 +++++++++++++++-
>>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>>> > 2 files changed, 39 insertions(+), 9 deletions(-)
>>> >
>>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> >index e79eb6ac516f..65e274550f5d 100644
>>> >--- a/include/linux/memblock.h
>>> >+++ b/include/linux/memblock.h
>>> >@@ -50,6 +50,7 @@ enum memblock_flags {
>>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>>> 
>>> Above memblock_flags, there are comments on explaining those flags.
>>> 
>>> Seems we miss it for MEMBLOCK_RSRV_KERN.
>>
>>Right, thanks!
>> 
>>> > 
>>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>> > again:
>>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>>> > 					    flags);
>>> >-	if (found && !memblock_reserve(found, size))
>>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>>> 
>>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>>> correct, the reserved region's nid is not used.
>>
>>We use nid of reserved regions in reserve_bootmem_region() (commit
>>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>>know the distribution of reserved memory among the nodes before
>>memmap_init_reserved_pages().
>> 
>
>I took another look into this commit. There maybe a very corner case in which
>will leave a reserved region with no nid set.
>
>memmap_init_reserved_pages()
>    for_each_mem_region() {
>        ...
>	memblock_set_node(start, end, &memblock.reserved, nid);
>    }
>
>We leverage the iteration here to set nid to all regions in memblock.reserved.
>But memblock_set_node() may call memblock_double_array() to expand the array,
>which may get a range before current start. So we would miss to set the
>correct nid to the new reserved region.
>
>I have tried to create a case in memblock test. This would happen when there
>are 126 memblock.reserved regions. And the last region is across the last two
>node.
>
>One way to fix this is compare type->max in memblock_set_node(). Then check
>this return value in memmap_init_reserved_pages(). If we found the size
>changes, repeat the iteration.
>
>But this is a very trivial one, not sure it worth fix.
>

Hi, Mike

I have done a user space test which shows we may have a chance to leave a
region with non-nid set.

Not sure you are ok with my approach of fixing.

-- 
Wei Yang
Help you, Help me


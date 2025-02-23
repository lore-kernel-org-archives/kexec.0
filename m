Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E435C35FFF
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6kBdqL5Mv/zHgRCB8+EQApG54lUy8sBQC0RT66qpTY=; b=OG+9QK0+Vw2AOHUFgtKyrCsApf
	Fl3txUHV9+FCZ78A4NZ1vI721gBmWP4D1e1AoDmUqAebTDXVYjF0Rp6VjaO3ByvJ8FxXnnrQYtJM8
	NU9bjRrnsJAp+gfm2WZ3OJSheYE34ClZPrJa4dO+iwNyeKKpWa1s/l8v5i2T9ndYOmKM7IluxHPvI
	XVuDAGCxqJ9n8VetAG1rmN+965/wQGhIamVgucCIkik02T0vYKod/LGzsYz2blkF7VBp89T7B+oFD
	NC/Qosdx+46uNNLDFRQu5Se4cgyT6Dxi2GWQ91nUiQIZLv/BrBgBiIk4T79xyPp8i32dyVgpQoYHt
	rryoE5Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRx-0000000CTz3-3A9E;
	Thu, 20 Mar 2025 15:04:49 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlzlQ-00000009Ql2-3fJ5;
	Sun, 23 Feb 2025 00:22:34 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso5344107a12.2;
        Sat, 22 Feb 2025 16:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740270151; x=1740874951; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6kBdqL5Mv/zHgRCB8+EQApG54lUy8sBQC0RT66qpTY=;
        b=AahB46zxTa8FPqI+Hl6gpW8fB12SWv4u41Rt3kxrblxa8eEcG10yw/Yy80bh5/x+W4
         tQVY9PsoIeDCunDyLqXKWRa2jB1LO3ZFAK3tzauo12c9c0+uFCc4sCKUDL6o6uisqKdD
         XW2QcGdGN77V2M6tDN3k2kkjVcT+Us1poOiyQaPPgQyJ7YavorouJZKuLFHWoLTP16R+
         Db/rP/1UcJZj8aVi3pLMs91k0Vzg4DhXCfLgWxfkebHoe3GipizWal0V3jxudOMasyFz
         lyf6JSLL1JfCMb/E8ueIMj/hKQbDyDMfYuJS+Hae2cxyj8Sa/+r1KHrYkGQ1ubIc2uQN
         uVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740270151; x=1740874951;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b6kBdqL5Mv/zHgRCB8+EQApG54lUy8sBQC0RT66qpTY=;
        b=EFZ8p48RgYrXD6LdNAX0mIB8Xhmcs+wqFNhb4qlttxVeZNZuCqx2xBgJjEBe6Ns+Ch
         UMl+SgNPH/EzAFAgO8Dysqrp2hbju+dD90mlHMng5zgeIHg7rGtmYtFv069e5imZC4sx
         HHk04J0uWL9BRzV0nx83PNqYzxw0HlvNWjWcj8yYFEnNd6nXy3/oUeQTyI56gGg1XuaT
         ae/2eYQsQ26v8ciRB9361X4BzZ5i7sShKpSBSbMf5FN0E18q5uUrODuEvzeaGchmQCLh
         T4XiPRlIV8m8ZQVuBclXGHEgxdxqdqEgxMD3BhD1ucacAv3v1UMALgqP8OFlkGJyq/jj
         wsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp+peZyDr32DUqrGxddcCo2PPhSAvnh1GIH7gI8mKrb/g5A+dC3MfFVPDtGmQesZzls8HiDV4dlJtQDwZznz2MTw==@lists.infradead.org, AJvYcCX49fa/8AnczGNogXeqg93HSxH1gXqlfPlPPMzR1n6mureJJ0hI1K38D28gDIgiDmsLLJAX8A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyPni03GKNRtY8v9owfZgsZfsEZSDTpYd8tuoG2udO702X1rkFX
	xDfg8WCnDm9aU8UlE/CJF1Ir+jkkvFKDAtHylZmG8MkuAWntLksE
X-Gm-Gg: ASbGncs/KqRy/2b9cJ/RqZN1N198eubMvZM88DfLTFpMJrstR6xZZbH/2BL4B2qn7JD
	R0NaY8NwRymA00pQgZirxFjvJw/BWgAaiJAWs6nyfe7WFljqHPCDAqSPcTLn/pv8yrVfH4AdxJT
	sIZrFQywmWelP5rI8At6/aHfnXWkBBj6sm0tc89JeCt6Q6hBNPC1Od+DyHJSWUCGCHE2ju3don/
	6o+RsYSrueO/wxLmuXIZYgJp2qwmyDZE+rnK8OvqZCl7JaZUPn5CmLnRpQgYEDqKsMnXj7BeCt8
	s76+fbicin/hYzdr1VDLOb11hQ==
X-Google-Smtp-Source: AGHT+IHi6/1q2H/JzaBPY2EM3gZK+t9ZOl1hJ37YMXiB93ksHODnJQh+Uw5lQW63dWTHlum7aHYuYw==
X-Received: by 2002:a05:6402:440b:b0:5e0:4064:add6 with SMTP id 4fb4d7f45d1cf-5e0b722d3e0mr7683404a12.31.1740270150552;
        Sat, 22 Feb 2025 16:22:30 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e09072247esm6510575a12.51.2025.02.22.16.22.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Feb 2025 16:22:30 -0800 (PST)
Date: Sun, 23 Feb 2025 00:22:29 +0000
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
Message-ID: <20250223002229.xuk6xlp23zr72hkc@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WHL_Xqgoln9oLg@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250222_162232_994945_8ADC6BE4 
X-CRM114-Status: GOOD (  22.55  )
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

On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> >to denote areas that were reserved for kernel use either directly with
>> >memblock_reserve_kern() or via memblock allocations.
>> >
>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> >---
>> > include/linux/memblock.h | 16 +++++++++++++++-
>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>> > 2 files changed, 39 insertions(+), 9 deletions(-)
>> >
>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> >index e79eb6ac516f..65e274550f5d 100644
>> >--- a/include/linux/memblock.h
>> >+++ b/include/linux/memblock.h
>> >@@ -50,6 +50,7 @@ enum memblock_flags {
>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>> 
>> Above memblock_flags, there are comments on explaining those flags.
>> 
>> Seems we miss it for MEMBLOCK_RSRV_KERN.
>
>Right, thanks!
> 
>> > 
>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>> > again:
>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>> > 					    flags);
>> >-	if (found && !memblock_reserve(found, size))
>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>> 
>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>> correct, the reserved region's nid is not used.
>
>We use nid of reserved regions in reserve_bootmem_region() (commit
>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>know the distribution of reserved memory among the nodes before
>memmap_init_reserved_pages().
> 

I took another look into this commit. There maybe a very corner case in which
will leave a reserved region with no nid set.

memmap_init_reserved_pages()
    for_each_mem_region() {
        ...
	memblock_set_node(start, end, &memblock.reserved, nid);
    }

We leverage the iteration here to set nid to all regions in memblock.reserved.
But memblock_set_node() may call memblock_double_array() to expand the array,
which may get a range before current start. So we would miss to set the
correct nid to the new reserved region.

I have tried to create a case in memblock test. This would happen when there
are 126 memblock.reserved regions. And the last region is across the last two
node.

One way to fix this is compare type->max in memblock_set_node(). Then check
this return value in memmap_init_reserved_pages(). If we found the size
changes, repeat the iteration.

But this is a very trivial one, not sure it worth fix.

-- 
Wei Yang
Help you, Help me


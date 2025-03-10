Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6350EC3600C
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJwceBGDF2wkWgWu1pdO+uwWw+syZobUsImQSfkS6Tw=; b=IkZSV/Tw/fCY7MBG2k3uH5uIxP
	By42LgbE2dTanmuwAvkHg54YbH+ye22SDreu5HhtrTP6aKJTX2cq+U63293MTdIp15ge1QyOi7E2I
	F1mv/JHDsUrWG9FN/+PgJqMJqILi2gMTIShhiCjLs2APIizv+YpjY+/5TdX59U795l+mRG4X5M/z7
	AeAo1jtSOZleP4WZrbdzbaEvz5MBO3iCqJ3yEGSmdCsf0ZIT/CKYBKxc5/1ywjTcQk0No/FxLWdfs
	SIvxYU7mXMvQdu8I9OFQVfrndUP9SMZqwQmQVvtmREDg7NI5pYzwTimw+k9hjVsHDspH1rNmXzDNa
	UTWtdWzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS1-0000000CU4q-0GRg;
	Thu, 20 Mar 2025 15:04:53 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trXzy-00000001p5b-1UKB;
	Mon, 10 Mar 2025 07:56:31 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so3831638a12.1;
        Mon, 10 Mar 2025 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741593389; x=1742198189; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJwceBGDF2wkWgWu1pdO+uwWw+syZobUsImQSfkS6Tw=;
        b=KOREfeZslGPx1kzmopAhrCwmZLDTGzimHm1+tDa45z1ctRPzD5QFefqxKP19RAZogA
         niZF6P26x19YYc/ua5fY0bTaJueVr7xlwM3kBJ4NRfwjnA/QbAXrb8LQzFtNZ4w2L8n9
         FYKRlO0jge0kjFfbOQQGrwvSdoltqKhdWsFhizyB01nk9SMu7kPKP8AAAG/Mgmx4s5Iv
         kN3Jo/x+TzQraTQESzs2xXWsRkm/qj3zYFN05RBmpU1err+RkvDiVsAKfdVG7a9vUTWf
         9F4jB6LY9eZ9pJgkRuZ03n4MY9rkjd+GWxDJTvlve7ypaHfD20AI+i65oNm/cKkdPt5e
         iPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593389; x=1742198189;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJwceBGDF2wkWgWu1pdO+uwWw+syZobUsImQSfkS6Tw=;
        b=sXPZM1rB8TrVjvuFADh3ynqJD2eEdYgy7X1LC/T5DboEc0hX2NoTFAfE/PSrSQmisb
         ytzZ99M6QholmbT7xuc3LbuEVH/7xHcS7NR0dx4ahqYjoOMrrhaj8q6Z5R1wD1HYnznM
         qFU8Ptvypj3dwza5TDARobwmrgHxxeE4S8aXcSbPAmg+I4upNdDVOBUZcQ8vt6Xkxo/H
         apJ5SwHFNaxi7fWnsEe9p7Te5ZDrQePQL0l2QQM+rncyHmV+dRKzrsxW3sU3Zu67MHym
         mHd9IpXzugRLiD6NLXNM0s+9gCdfxi2TpZqSkobdCnRRtbXSZmws1YWRC+QU+9z+jCQu
         KZrg==
X-Forwarded-Encrypted: i=1; AJvYcCVEoew0TySmAVr3OUj4S43wBmKSJ+UMC6UWznRddk2l3FiPCTyQI3d0qk57OcKYZ0R+Xj9fK6zzpLbAf05Ls4002w==@lists.infradead.org, AJvYcCWR1Ny9E7pVC5Yl2m7EiTxGBX1Iq2sDmxChVVqb/zAHfW5M+qzWQEcT0BcG/7q7SEYdUsnTQQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywm5CGVUF7r+jgAMUCs/QWcz5ckmN/geIn0a7/rh8XA9rmlI1W3
	jY7Ua6D2oamvoFY3pjyJ2LZTiu9ha5oFdz8OuQxUY+NLdiFEMwou
X-Gm-Gg: ASbGncv5Pebv2gQtZgr0zIx0Zxpim+vCEk6Nktu91SVQpSLnmYCM3vBRf/myxU2KHve
	/nybuUn3yl0JSs6ERhSzx5KOPozEKISnokhteFFvK8XqbrZyBgHdH4VdFKDwDW+VjR4+xbA/ubf
	MaxSMbR/ohqAzD4KYiLfeCPj+QIdVvxAxeovIcM+fIuOCWbdgJNLpcDfLe3rgGiN2P4VYARposs
	O/UX8vroVhQtNHtms69jlBJztsaUHbpYw9p3J8fnk0ddLP7+BA2EBgswID5Vb+XN5bGdWdTX0dw
	0+GNk7hk4qt2oQ6dWsJw+gAIOacL7Bnkyf1fCd2MH2Er
X-Google-Smtp-Source: AGHT+IEQ2uBHwcOdkgr7aGqLMWG+rbjuDIjMsdHGAG+hCMaeoXtOhIX4RmiolWfrWI8fpuA/uaZyUw==
X-Received: by 2002:a05:6402:268a:b0:5e0:49e4:2180 with SMTP id 4fb4d7f45d1cf-5e5e24688d1mr34122496a12.25.1741593388499;
        Mon, 10 Mar 2025 00:56:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac279b3e463sm371805666b.72.2025.03.10.00.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Mar 2025 00:56:28 -0700 (PDT)
Date: Mon, 10 Mar 2025 07:56:27 +0000
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
Message-ID: <20250310075627.5hettrn2j2ien5bj@master>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250224013131.fzz552bn7fs64umq@master>
 <Z711VP45tjBi0kwx@kernel.org>
 <20250226020915.ytxusrrl7rv4g64l@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226020915.ytxusrrl7rv4g64l@master>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_005630_514739_867ECE8E 
X-CRM114-Status: GOOD (  29.96  )
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

On Wed, Feb 26, 2025 at 02:09:15AM +0000, Wei Yang wrote:
>On Tue, Feb 25, 2025 at 09:46:28AM +0200, Mike Rapoport wrote:
>>On Mon, Feb 24, 2025 at 01:31:31AM +0000, Wei Yang wrote:
>>> On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
>>> >Hi,
>>> >
>>> >On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
>>> >> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
>>> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>> >> >
>>> >> >to denote areas that were reserved for kernel use either directly with
>>> >> >memblock_reserve_kern() or via memblock allocations.
>>> >> >
>>> >> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>>> >> >---
>>> >> > include/linux/memblock.h | 16 +++++++++++++++-
>>> >> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
>>> >> > 2 files changed, 39 insertions(+), 9 deletions(-)
>>> >> >
>>> >> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>> >> >index e79eb6ac516f..65e274550f5d 100644
>>> >> >--- a/include/linux/memblock.h
>>> >> >+++ b/include/linux/memblock.h
>>> >> >@@ -50,6 +50,7 @@ enum memblock_flags {
>>> >> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>>> >> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
>>> >> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
>>> >> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
>>> >> 
>>> >> Above memblock_flags, there are comments on explaining those flags.
>>> >> 
>>> >> Seems we miss it for MEMBLOCK_RSRV_KERN.
>>> >
>>> >Right, thanks!
>>> > 
>>> >> > 
>>> >> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>> >> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>>> >> > again:
>>> >> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
>>> >> > 					    flags);
>>> >> >-	if (found && !memblock_reserve(found, size))
>>> >> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
>>> >> 
>>> >> Maybe we could use memblock_reserve_kern() directly. If my understanding is
>>> >> correct, the reserved region's nid is not used.
>>> >
>>> >We use nid of reserved regions in reserve_bootmem_region() (commit
>>> >61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
>>> >know the distribution of reserved memory among the nodes before
>>> >memmap_init_reserved_pages().
>>> > 
>>> >> BTW, one question here. How we handle concurrent memblock allocation? If two
>>> >> threads find the same available range and do the reservation, it seems to be a
>>> >> problem to me. Or I missed something?
>>> >
>>> >memblock allocations end before smp_init(), there is no possible concurrency.
>>> > 
>>> 
>>> Thanks, I still have one question here.
>>> 
>>> Below is a simplified call flow.
>>> 
>>>     mm_core_init()
>>>         mem_init()
>>>             memblock_free_all()
>>>                 free_low_memory_core_early()
>>>                     memmap_init_reserved_pages()
>>>                         memblock_set_node(..., memblock.reserved, )   --- (1)
>>>                     __free_memory_core()
>>>         kmem_cache_init()
>>>             slab_state = UP;                                          --- (2)
>>> 
>>> And memblock_allloc_range_nid() is not supposed to be called after
>>> slab_is_available(). Even someone do dose it, it will get memory from slab
>>> instead of reserve region in memblock.
>>> 
>>> From the above call flow and background, there are three cases when
>>> memblock_alloc_range_nid() would be called:
>>> 
>>>   * If it is called before (1), memblock.reserved's nid would be adjusted correctly.
>>>   * If it is called after (2), we don't touch memblock.reserved.
>>>   * If it happens between (1) and (2), it looks would break the consistency of
>>>     nid information in memblock.reserved. Because when we use
>>>     memblock_reserve_kern(), NUMA_NO_NODE would be stored in region.
>>> 
>>> So my question is if the third case happens, would it introduce a bug? If it
>>> won't happen, seems we don't need to specify the nid here?
>>
>>We don't really care about proper assignment of nodes between (1) and (2)
>>from one side and the third case does not happen on the other side. Nothing
>>should call membloc_alloc() after memblock_free_all(). 
>>
>
>My point is if no one would call memblock_alloc() after memblock_free_all(),
>which set nid in memblock.reserved properly, it seems not necessary to do
>__memblock_reserve() with exact nid during memblock_alloc()? 
>
>As you did __memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN) in this
>patch.
>

Hi, Mike

Do you think my understanding is reasonable?

-- 
Wei Yang
Help you, Help me


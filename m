Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3321C2BA1B
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 05:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LtqkvatmL8zEprV8JDrvPTk9OulcQe853ibSUZCYUc=; b=RP3x5j6Y4/2/awGaBm3yACT5fT
	ydffUaNFdTQCBiTfv/iyOun+c9bZ4L7EQ+7Lv2chio3691UoZgBfdW4JswkowLfQ2hVCrV2WznaE3
	GzmEflFnhttvQk9pblcDTciNc4maAC005IaZJgV/q3u50VwYcnNzxofgJ77Tk2ji5ysl/gdO552tM
	ZGBmnRjSFmmZxRGSET3cLNF6S8bFgmb0vgNIcVVOhPRSl3JC1et2J+HlnfoBwg43QL+3QTx6yEt0b
	j1sT6e/z56ahJAxlNxHnL+/Mj3JkKKlTbQOypiqL+B0WfDGwXUCsHGTuznNdiIgSJdIMKz/sHio/5
	jWodImpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trs9c-00000004eb8-3O3g;
	Tue, 11 Mar 2025 05:27:48 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trs9a-00000004eZZ-05cd;
	Tue, 11 Mar 2025 05:27:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C2F1CA46861;
	Tue, 11 Mar 2025 05:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB76C4CEEC;
	Tue, 11 Mar 2025 05:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741670864;
	bh=6FrJToULI5AieC/xcPkMqRkdPc73MU/g7qUb/+Gf2LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAHpdUKSmv1QM82YGoNX6ldSWprWPtoQeq7oZVYRSenmRL5V3mQA0Z/8J1J7rkbXY
	 DCZ1PolWSm96XtMjC6zHeV/4BIYLkdQBd+2LSkhUUHx/NvSeQhtKi3xVRFBvvahBI6
	 Fgecu8QW9SZnOgCJFzyGzUd8oW5EhoPWaTHjItebVqj/yACpIkHUi3606UEwiKBAbx
	 3YfDwolecrwr/CHlFMVtqpXQ8QtwdePj5lo049ABQgMlHqkjpQCaCVHGRbh/9KJaaJ
	 GKa8u7BRKr01NRTAB8Jp1oImuXWXsRmL8WzrwbdwZpVY+aPZzBz/SBsDbDXNSbRoaJ
	 K0Cd6UgpZbrJA==
Date: Tue, 11 Mar 2025 07:27:23 +0200
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
Message-ID: <Z8_Ju0p63GBCdSG9@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-3-rppt@kernel.org>
 <20250218155004.n53fcuj2lrl5rxll@master>
 <Z7WHL_Xqgoln9oLg@kernel.org>
 <20250223002229.xuk6xlp23zr72hkc@master>
 <20250310095124.pa7dwgqhxglqrfes@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310095124.pa7dwgqhxglqrfes@master>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_222746_186219_4CAF8541 
X-CRM114-Status: GOOD (  32.19  )
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

On Mon, Mar 10, 2025 at 09:51:24AM +0000, Wei Yang wrote:
> On Sun, Feb 23, 2025 at 12:22:29AM +0000, Wei Yang wrote:
> >On Wed, Feb 19, 2025 at 09:24:31AM +0200, Mike Rapoport wrote:
> >>Hi,
> >>
> >>On Tue, Feb 18, 2025 at 03:50:04PM +0000, Wei Yang wrote:
> >>> On Thu, Feb 06, 2025 at 03:27:42PM +0200, Mike Rapoport wrote:
> >>> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >>> >
> >>> >to denote areas that were reserved for kernel use either directly with
> >>> >memblock_reserve_kern() or via memblock allocations.
> >>> >
> >>> >Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>> >---
> >>> > include/linux/memblock.h | 16 +++++++++++++++-
> >>> > mm/memblock.c            | 32 ++++++++++++++++++++++++--------
> >>> > 2 files changed, 39 insertions(+), 9 deletions(-)
> >>> >
> >>> >diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >>> >index e79eb6ac516f..65e274550f5d 100644
> >>> >--- a/include/linux/memblock.h
> >>> >+++ b/include/linux/memblock.h
> >>> >@@ -50,6 +50,7 @@ enum memblock_flags {
> >>> > 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
> >>> > 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> >>> > 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
> >>> >+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
> >>> 
> >>> Above memblock_flags, there are comments on explaining those flags.
> >>> 
> >>> Seems we miss it for MEMBLOCK_RSRV_KERN.
> >>
> >>Right, thanks!
> >> 
> >>> > 
> >>> > #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> >>> >@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >>> > again:
> >>> > 	found = memblock_find_in_range_node(size, align, start, end, nid,
> >>> > 					    flags);
> >>> >-	if (found && !memblock_reserve(found, size))
> >>> >+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
> >>> 
> >>> Maybe we could use memblock_reserve_kern() directly. If my understanding is
> >>> correct, the reserved region's nid is not used.
> >>
> >>We use nid of reserved regions in reserve_bootmem_region() (commit
> >>61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")) but KHO needs to
> >>know the distribution of reserved memory among the nodes before
> >>memmap_init_reserved_pages().
> >> 
> >
> >I took another look into this commit. There maybe a very corner case in which
> >will leave a reserved region with no nid set.
> >
> >memmap_init_reserved_pages()
> >    for_each_mem_region() {
> >        ...
> >	memblock_set_node(start, end, &memblock.reserved, nid);
> >    }
> >
> >We leverage the iteration here to set nid to all regions in memblock.reserved.
> >But memblock_set_node() may call memblock_double_array() to expand the array,
> >which may get a range before current start. So we would miss to set the
> >correct nid to the new reserved region.
> >
> >I have tried to create a case in memblock test. This would happen when there
> >are 126 memblock.reserved regions. And the last region is across the last two
> >node.
> >
> >One way to fix this is compare type->max in memblock_set_node(). Then check
> >this return value in memmap_init_reserved_pages(). If we found the size
> >changes, repeat the iteration.
> >
> >But this is a very trivial one, not sure it worth fix.
> >
> 
> Hi, Mike
> 
> I have done a user space test which shows we may have a chance to leave a
> region with non-nid set.
> 
> Not sure you are ok with my approach of fixing.

Wouldn't it be better to check for a change in reserved.max in
memmap_init_reserved_pages()?
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871F9C9833E
	for <kexec@archiver.kernel.org>; Mon, 28 Sep 2026 08:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6oX7WoY9qy+38lv9uTWDEFP6iRKHKXco4d1bWNWC4k=; b=L7Tn0AQRR/dB3+nuMm4WdbuUj0
	KsFLd2iKj4bDbFNF6OLXWVKEAnfbJCjiYFRol+p3CJffbGksM+LX56SSU2c9L/XExpmHl5VDv6AJb
	0OkiTAd/HFurtlOlxA2I6bLvwgO+htBOOjHTVaxxTYrqOnIxgZNbNw/PbEdmSvKuDAnrjkXkHSkSR
	uaC9in1/d4rIYZ1hukaXPtwvP2V3Ty2D5jG0AUYQJ81KRpafhuAtgP+H4bQQ5pUDBqEvGBuXUpTEe
	fZWE9UbsWBIrfMrYVFWdE488+BKRezeSTIiNBs4JMNrRxH/9qJVnY+so5oNOejX0CV8bzJJ2T+EAc
	NYfABd4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB6KT-0000000007Z-1ppS;
	Mon, 28 Sep 2026 08:03:17 +0000
Received: from out-160.mta0.migadu.com ([2001:41d0:1004:224b::a0] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB6KN-0000000006w-3vaj
	for kexec@lists.infradead.org;
	Mon, 28 Sep 2026 08:03:13 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=u6pM4Q2lirOQrXvVOmhw6eCdvf86YRNbjnR3yNkFQzk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790582588; v=1; x=1791187388;
 b=C+V5Fg7yUDtnG95PdYyQlpKrqN/I0S/X42BAIMYGwTLCGzp4vAUZid0wtjsNCaEZFEsjqFB+
 y46+C0Knmw9IqwGouFl4z0q9eUZEllrBPQRgyYhcIQKi9YaOwn5MwUkGYSVRKEaW8FzJnOV8jZZ
 PolBC5842VTOJPZssiW6x/6g=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 6cea94b206c11561;
	Mon, 28 Sep 2026 08:03:07 +0000
X-Mizu-Trace-ID: 6cea94b206c11561
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 16:01:16 +0800
From: Dave Young <ruirui.yang@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, akpm@linux-foundation.org,
	axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, baoquan.he@linux.dev,
	brendan.jackman@linux.dev, dakr@kernel.org,
	driver-core@lists.linux.dev, gregkh@linuxfoundation.org,
	hannes@cmpxchg.org, jan.kiszka@siemens.com, kasong@tencent.com,
	kbingham@kernel.org, liam@infradead.org, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, mhocko@suse.com,
	osalvador@suse.de, qi.zheng@linux.dev, rafael@kernel.org,
	rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
	vbabka@kernel.org, weixugc@google.com, yuanchu@google.com,
	ziy@nvidia.com, devel@lists.crash-utility.osci.io,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 10/13] mm/sparse: remove SECTION_MARKED_PRESENT
Message-ID: <aroezLexo1WoeYI7@darkstar>
References: <20260921-b4-sparsemem_cleanups-v2-10-54d81d65e125@kernel.org>
 <20260927192013.144672-1-devnexen@gmail.com>
 <655c509e-318f-48bc-8183-2b1274dd05ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655c509e-318f-48bc-8183-2b1274dd05ac@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_010312_118653_5970F018 
X-CRM114-Status: GOOD (  17.50  )
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

Cced kexec list.

On Mon, Sep 28, 2026 at 09:28:08AM +0200, David Hildenbrand (Arm) wrote:
> On 9/27/26 21:20, David Carlier wrote:
> > On Mon, Sep 21, 2026 at 09:59:02PM +0200, David Hildenbrand (Arm) wrote:
> >>  enum {
> >> -	SECTION_MARKED_PRESENT_BIT,
> >>  	SECTION_HAS_MEM_MAP_BIT,
> >>  	SECTION_IS_ONLINE_BIT,
> >>  	SECTION_IS_EARLY_BIT,
> > 
> > Hi David,
> 
> Hi!
> 
> > 
> > It seems dropping SECTION_MARKED_PRESENT_BIT shifts the other section flags down
> > one bit. crash hardcodes SECTION_HAS_MEM_MAP as (1UL << 1) in
> > pfn_to_map(), so it now tests SECTION_IS_ONLINE: offline and
> > ZONE_DEVICE sections no longer resolve to a struct page. makedumpfile
> > only checks bit 0 and is fine.
> 
> Thanks. To be expected when relying on kernel internals.
> 
> Which makes me wonder why makedumpfile
> (https://github.com/makedumpfile/makedumpfile) not require any such information.
> 
> > 
> > Keep bit 0 reserved, or export the bits via vmcoreinfo?
> We could export it, or crash can simply detect the change based on the kernel
> version. I remember the latter was done in makedumpfile in the past (although we
> export it).
> 
> I can send a separate patch to export it.

Thanks David.   Checking kernel internals via kernel version is not a good idea
due to the downstream kernels.

> 
> -- 
> Cheers,
> 
> David


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6984CAC59D
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PvexwmzCNrp51tkFXBAFmsX6wCYeaz9zSCCiWiVuAwY=; b=I7ULf1pPImUtw7xwbxLihPI9ZQ
	MJ7iN2V+XL/0mVseYLQTK/aFPufans7q9w+RLVDaDYZ8OqhISZzLFLfnnh/MNdbzx84ItMqDXMctm
	ERXNiywl7+Y2gnzfkLhSJ+uWSFu+tJkHMCCqGbX5EQ06UwZ5bqZGEPmuW6Md/goIXGTBDwdWiZ53L
	4HvWaB0a5J1cftRM1HAwb4YKtlhLLplGgmIcmAH3OnI4WVK8mUnewZI7/DGcL26Iyr1TuTy+o3YFK
	tDdc360XtLTLXNnzAiYIAOve4KW3zk1xIfDVGS/LK9qZh36fpBmm8yqrS90tf0BiTIM0G0+6WdyNp
	tdg172ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyr6l-0000000BGyd-2YMC;
	Wed, 17 Sep 2025 12:17:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyh2W-00000009qpO-1oS4
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 01:32:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 839A343C6A;
	Wed, 17 Sep 2025 01:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CFFC4CEEB;
	Wed, 17 Sep 2025 01:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758072775;
	bh=VPxe/khPNBojBygLvAaLupb67EgQP1yBXlhF6g/LkIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cz58pDdzIZYmmzo1HFNNAI/yk1M/cOWjkyECmslTAF0/3PdlsvOf6t+VaaqFMj723
	 j+22m+BYb06quci5edCqkXAKoOvCNtTOG6bD3BJs854pxcHjlvyZO20jrNXGZ75yS8
	 WpG/k+1TgXypKIZ6/Ilu+GD9PEv4t2pV2hIAiytM=
Date: Tue, 16 Sep 2025 18:32:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He
 <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
 <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, James Morse
 <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 ntfs3@lists.linux.dev, kexec@lists.infradead.org,
 kasan-dev@googlegroups.com, iommu@lists.linux.dev, Kevin Tian
 <kevin.tian@intel.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>
Subject: Re: [PATCH v3 13/13] iommufd: update to use mmap_prepare
Message-Id: <20250916183253.a966ce2ed67493b5bca85c59@linux-foundation.org>
In-Reply-To: <a2674243-86a2-435e-9add-3038c295e0c7@lucifer.local>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
	<59b8cf515e810e1f0e2a91d51fc3e82b01958644.1758031792.git.lorenzo.stoakes@oracle.com>
	<20250916154048.GG1086830@nvidia.com>
	<a2674243-86a2-435e-9add-3038c295e0c7@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_183256_483494_10949636 
X-CRM114-Status: GOOD (  10.52  )
X-Mailman-Approved-At: Wed, 17 Sep 2025 05:17:58 -0700
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

On Tue, 16 Sep 2025 17:23:31 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Andrew - Jason has sent a conflicting patch against this file so it's not
> reasonable to include it in this series any more, please drop it.

No probs.

All added to mm-new, thanks.  emails suppressed due to mercy.


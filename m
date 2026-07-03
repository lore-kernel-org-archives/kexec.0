Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F6C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 09:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vK3N7aTACID0By/7KCnIUNlw/QfW3yZgLaxjGYBSv0=; b=egqb5VFMwtyr8fHHXGY3Yy3C2F
	8rvDH7qI9/T3jVh6O8BoFN2yXEggu6IiQjSpcfMPYQPPi089O/QMXYPNl8tOfq8pAsil2Ktrx5bsQ
	oq/O7SPiC+JjtKpx9kGLvwPApWZLUzhXVLJ2am7fLOnLuE3nwSZmNsNiYjGqkLQagqarTQn1qhyG9
	WeH8MFqN1PfRKWq3FONp89kdxGg/l4FZTfVBoLi+haHsRkJPH8SB0LPX64KFcwJXhy5rNEfslpI6t
	pVRLVZPwAL4OT8ViO0qd9vdGQ79z1fsylzcBsKyw13oRPnZ0JE8K5arJMHmf6JhB2LYwyUJtIK+Ax
	D2B4xVpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfZnY-00000006R0w-1zMn;
	Fri, 03 Jul 2026 09:03:00 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfZnV-00000006Qyi-0swk
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 09:02:59 +0000
X-UUID: f54cf2ee76bd11f1aa26b74ffac11d73-20260703
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:aaff1f12-1d33-4415-ba58-b834be07f4bb,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:aaff1f12-1d33-4415-ba58-b834be07f4bb,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:9719779c97f4ff0272f18ecf2c5f68b0,BulkI
	D:260702200044ZYHCF6SH,BulkQuantity:1,Recheck:0,SF:10|64|66|78|80|81|82|83
	|102|127|136|841|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,Fil
	e:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DK
	R:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f54cf2ee76bd11f1aa26b74ffac11d73-20260703
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 560380739; Fri, 03 Jul 2026 17:02:46 +0800
Date: Fri, 3 Jul 2026 17:02:41 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	"Andersen, Tycho" <Tycho.Andersen@amd.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Matlack <dmatlack@google.com>,
	James Gowans <jgowans@amazon.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Praveen Kumar <kpraveen.lkml@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vishal Annapurve <vannapurve@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>, linux-mm@kvack.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	jianghaoran@kylinos.cn
Subject: Re: [Hypervisor Live Update] Notes from June 1, 2026
Message-ID: <20260703090241.GA148322@chenghao-pc>
References: <aiWW6ZwwalqQmVcB@google.com>
 <20260702060202.GA78893@chenghao-pc>
 <20260702-pay-effect-93be8ab0@mheyne-amazon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702-pay-effect-93be8ab0@mheyne-amazon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_020257_555401_9638591D 
X-CRM114-Status: GOOD (  44.80  )
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

On Thu, Jul 02, 2026 at 12:00:16PM +0000, Maximilian Heyne wrote:
> On Thu, Jul 02, 2026 at 02:02:02PM +0800, Chenghao Duan wrote:
> > On Sun, Jun 07, 2026 at 12:06:01PM -0400, Pasha Tatashin wrote:
> > > Hi everybody,
> > > 
> > > Here are the notes from the Hypervisor Live Update call that happened on 
> > > Monday, June 1. Thanks to everybody who was involved!
> > > 
> > > These notes are intended to bring people up to speed who could not 
> > > attend the call as well as keep the conversation going in between 
> > > meetings.
> > > 
> > > ----->o-----
> > > LPC 2026 Call for Proposals
> > > 
> > > The Call for Proposals for the Live Update Microconference at LPC 2026 
> > > is officially open. Please submit your topics and proposals before the 
> > > deadline on July 24th.
> > > 
> > > https://lore.kernel.org/all/ahcc3Qyuy7Oy03Iq@plex
> > > 
> > > ----->o-----
> > > KHO Xarray Implementation & Core Data Structures
> > > 
> > > Pratyush is collaborating with Mike on a KHO fallback allocation 
> > > strategy for memblock. Alongside this, Pratyush is designing a 
> > > serialized, sparse "KHO Xarray" data structure to lift current mapping 
> > > restrictions across all three memfd types (shared, hugeTLB, and 
> > > guest_memfd). By allowing runtime page faults and allocation tracking 
> > > post-preservation, this avoids flat vmalloc array scalability 
> > > limitations.
> > > 
> > > Potential wider use cases for the KHO Xarray were discussed:
> > > - MSHV sparse bitmap tracking.
> > > - IOMMU page table tracking (Samiullah will evaluate domain/device tree 
> > >   association fit).
> > > - PCI/VFIO sparse tracking via Bus/Device/Function (BDF) key spaces.
> > > 
> > > Slab/Cache Preservation vs. Linked Blocks:
> > > David Matlack noted that using an Xarray page per PCI device would be 
> > > too expensive given their small struct sizes. Pratyush suggested 
> > > preserving slab caches via dedicated kmem_cache flags to manage small, 
> > > arbitrary allocations. As an immediate alternative, Pasha's ongoing LUO 
> > > limits refactor series introduces a highly compact block-linked list 
> > > structure optimized for runtime file/session tracking. David Matlack 
> > > will review if this fits the PCI core tracking requirements.
> > > 
> > > ----->o-----
> > > LUO Limit Removal & PCI Core Status
> > > 
> > > LUO Refactor: Pasha is updating the LUO series to address Pratyush's 
> > > comments (primarily renaming iterator functions) and plans to send out 
> > > v2 shortly. Given that LUO is not yet in fleet production, the group 
> > > agreed to fast-track this into the upcoming merge window to align with 
> > > systemd's fdstore integration.
> > > 
> > > PCI Core v6: David Matlack sent out v6 incorporating two critical fixes 
> > > spotted by Sachiko regarding get/put semantics and double-retrieval 
> > > failures. Review tags from the live update team are needed to help 
> > > secure Bjorn's Ack once he returns from vacation next week.
> > > 
> > > ----->o-----
> > > IOMMU Persistence & Process Memory
> > > 
> > > IOMMU v3: Samiullah is addressing recent review feedback on the IOMMU 
> > > persistence series and intends to post v3 by the end of this week. The 
> > > associated development roadmap document has received positive 
> > > stakeholder attention.
> > > 
> > > CRIU & vm_splice: Maximilian's investigation into optimizing vm_splice 
> > > for copy-less data preservation remains deferred but remains in the 
> > > pipeline, with potential future collaboration with Google's tmpfs splice 
> > > efforts.
> > 
> > I’ve also been researching a combination solution integrating CRIU and
> > KHO. My approach stores all image data dumped by CRIU into memfd, then
> > persists those memfd objects via KHO/LUO.
> 
> I've experimented with exactly the same approach plus if a process
> already has memfd's, don't dump (to yet another memfd) but preserve this
> memfd directly via KHO.
> 
> > 
> > I’ve reviewed the historical meeting notes and would like to clarify:
> > does the CRIU solution discussed in the meetings aim to save the full
> > set of a process’s metadata and data, or only the anonymous memory and
> > shared memory allocated during the process runtime?
> 
> I've been the only one bringing this up in the meetings and my idea is
> to enable a reboot with negigible process downtime. So save the state of
> a process, kexec and resume the process. Currently, preservation and
> restorations are quite slow when processes have a lot of anonymous
> memory as this needs to be moved to a preservable memfd first. So what
> I'm researching is how I can convert anonymous memory efficiently into
> something that can be preserved (currently memfd).
> 
> And to answer your question, I'd say save data and metadata in memfd's.
> As the alternative would be to save the metadata on disk which would be
> slow.
> 

Thank you very much for your explanation.

I know vmsplice enables zero-copy operations on user memory pages. When
used together with splice, this syscall can establish references between
user pages and file descriptors. Could this be the optimal solution to
our current performance bottlenecks?

Or are there any other better alternatives already available?

Chenghao
> > 
> > Chenghao
> > > 
> > > ----->o-----
> > > guest_memfd Enlightenment & VMM Documentation
> > > 
> > > Tarun debriefed the community on his upstream presentation regarding the 
> > > initial guest_memfd preservation patch series (currently covering fully 
> > > shared mappings with page-sized folios).
> > > 
> > > Key design and architecture alignments include:
> > > - VM File Association: guest_memfd requires an active 'struct kvm' 
> > >   context to be retrieved. VMMs must preserve the parent VM file 
> > >   alongside guest_memfd, using LUO tokens to re-link them on the 
> > >   incoming kernel path. This sets the stage for future private 
> > >   mapping/secure EPT table tracking.
> > > - Relaxed Fault Logic: The group agreed to drop strict upfront pre-fault 
> > >   checks. Instead, standard runtime page-fault semantics will apply. If 
> > >   a guest page fault occurs post-preservation, it will bubble up via 
> > >   standard KVM_RUN ioctl exits to the VMM, which can safely pause vCPUs 
> > >   and retry the fault post-kexec.
> > > - Centralized VMM Documentation: Pasha and David Matlack proposed 
> > >   creating a centralized guide under live_update/vmm detailing the 
> > >   overall live update flow, timing constraints, and subsystem 
> > >   requirements to assist external QEMU and VMM developers.
> > > 
> > > ----->o-----
> > > Next meeting will be on Monday, June 15 at 8am PDT (UTC-7), everybody is
> > > welcome: https://meet.google.com/rjn-dmzu-hgq
> > > 
> > > Note: I am going to be traveling on June 15th, David Matlack is going to
> > > be hosting it.
> > > 
> > > Topics for the next meeting:
> > > - Presentation of VFIO roadmap (Vipin and David Matlack)
> > > - Status of KHO Xarray development and slab preservation feasibility
> > > - Review of PCI core changes v7 and upstream merge coordination
> > > - IOMMU persistence v3 review feedback
> > > - Detailed review of guest_memfd v2 and VMM interaction documentation
> > > - Review and coordination of LPC 2026 Microconference topic submissions
> > > - later: KHO support for Confidential VMs including page table
> > >   preservation and pinning
> > > - later: versioning support for luod to negotiate
> > > - later: KHO enlightenment for ASI
> > > - later: update on PCI preservation series and next steps
> > > - later: testing methodology to allow downstream consumers to qualify
> > >   that live update works from one version to another
> > > - later: reducing blackout window during live update, including deferred
> > >   struct page initialization
> > > 
> > > Please let me know if you'd like to propose additional topics for
> > > discussion, thank you!
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC06C43327
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ufpz38PZ89vEi6JfZ4d7JjNoyyhbY1Q4z8DW9fL/CXE=; b=vXBaDFRMKzODaALrVNklGopfNd
	dyjNw5jVKtoJVi0MKTtjBDmnsP49pwZe2R018ZTS7HDvWmv9ov1RejZ9Gbz5rn45ZpbtayFR3t8kU
	pEp+3A//z/0iy8NCWYbhovSKI5qOHXpkpdzg8qNBx8Imf5ppKs+A8J8n7nQ2pi03FW2bqfcjbqGAp
	/9eBG34ov8FvP1laz0NYZ5u4Tmur4BqtzsdwFCIqYhCfQZzQOpdE34vji0HgIMnJ5/dcLZinF3YF7
	srmOXTGSzHVuohOkm3kVwRP6juaEakfaPyZZKmSmAjDHUEI+Tv7fei41UoY4p0ShOQuO11MZ1tF1T
	FSbMHE6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we8sw-0000000EItL-2UfH;
	Mon, 29 Jun 2026 10:06:38 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we8st-0000000EIsV-1CL4
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 10:06:37 +0000
X-UUID: 2f2bceb473a211f1aa26b74ffac11d73-20260629
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a4170e7c-60d6-477a-ab9a-3ae1869c716a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:a4170e7c-60d6-477a-ab9a-3ae1869c716a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:2a7575b6c648292453f8b8c6b6c0db8b,BulkI
	D:260625170616GCMKOUR7,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|136|841|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,
	File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
	,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2f2bceb473a211f1aa26b74ffac11d73-20260629
X-User: duanchenghao@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1146902853; Mon, 29 Jun 2026 18:06:23 +0800
Date: Mon, 29 Jun 2026 18:06:21 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org, rppt@kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	jianghaoran@kylinos.cn
Subject: Re: [PATCH v1 1/2] eventfd: luo: luo support for preserving eventfd
Message-ID: <20260629100621.GA215869@chenghao-pc>
References: <20260625054946.73445-1-duanchenghao@kylinos.cn>
 <20260625054946.73445-2-duanchenghao@kylinos.cn>
 <2vxzfr2bkn0j.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxzfr2bkn0j.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_030635_623419_2EF06AA8 
X-CRM114-Status: GOOD (  21.95  )
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

On Thu, Jun 25, 2026 at 11:06:04AM +0200, Pratyush Yadav wrote:
> On Thu, Jun 25 2026, Chenghao Duan wrote:
> 
> > This patch adds support for preserving eventfd file descriptors across
> > kexec live updates using the Live Update Orchestrator (LUO) framework.
> > Userspace applications using eventfd for event notification can now
> > maintain their state across kernel updates.
> >
> > Preserved State:
> > The following properties of the eventfd are preserved across kexec:
> > - Counter Value: The current 64-bit counter value, including any pending
> >   events that have been signaled but not yet consumed by readers.
> > - File Flags: The creation flags (EFD_SEMAPHORE, EFD_CLOEXEC, EFD_NONBLOCK)
> >   are preserved.
> >
> > Non-Preserved State:
> > - File Descriptor Number: The eventfd will be assigned a new fd number
> >   in the target process after restore.
> > - Wait Queue State: Any processes blocked on read() operations will be
> >   woken up and need to re-establish their blocking state.
> > - All other internal state is reset to default.
> >
> > Changes:
> > - fs/eventfd.c: Add eventfd_luo_get_state() to safely read eventfd state
> >   (count and flags), and eventfd_create() helper function.
> > - fs/eventfd_luo.c: New file implementing LUO file operations:
> >   preserve, freeze, unpreserve, retrieve, and finish callbacks.
> > - include/linux/eventfd.h: Export new functions.
> > - include/linux/kho/abi/eventfd.h: Define the ABI contract with
> >   eventfd_luo_ser structure for serialization.
> 
> Why do you need to preserve this? Why don't you create a fresh one after
> kexec? You just preserve the counter, which looks pretty much useless.
> You can just as well open a new eventfd after kexec and set the counter
> value if you care about it.

Thank you very much for your review and suggestions.

My original plan was to integrate KVM with eventfd. Eventfd serves as a
critical notification mechanism between guest and host, and it is widely
adopted in various scenarios such as networking, file systems, and
interrupt handling.

At present, however, I have only implemented the preserve and retrieve
logic for eventfd, and the integration with KVM has not yet been
completed.

I have a question and would greatly appreciate your help with it.
I have been closely following upstream developments for the liveupdate
feature. As I understand it, liveupdate is primarily targeted at cloud
virtual machine scenarios. The upstream community has completed the
core framework for liveupdate and memfd, and ongoing discussions are
focused on state preservation and restoration for VFIO and IOMMU.

I would like to clarify the following points regarding upstream’s
overall roadmap for the liveupdate feature:
1. What is the complete upstream plan for liveupdate?
2. What will the final deliverables look like once fully implemented?
3. Will any new kernel internal interfaces or dedicated userspace tools
be introduced?
4.  Does the upstream community maintain an official TODO list tracking
outstanding work items for liveupdate?

> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav


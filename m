Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A49CCD1BF
	for <kexec@archiver.kernel.org>; Tue, 28 Oct 2025 06:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zuGj1hW8mWz3shIq2GZWCMOifU7nzT6tSAo/1NZESWI=; b=OTjTMKj19l2LXo+C54nwvhM8jK
	Cny8gIb6EA6SM3XNh/fCFtez6oE/8k+R86wSfSTIeBMM1q0LtsezZZsAaBfCkfbXo1hX/++ojMhbu
	P/h0Z93yfEM1Ip79y2fRhbsQApt0Ty7RtD78VTMpAQdhgofMBQEQPDroD96eqvdO2JQsf7YBwj291
	G4z2SVLIzmEy8MB7vRxLTaUnLpqjGmGW/K+MqH5Ma+ISCp2oySu0jfChWENlv51o6hr+1gJuRzpdB
	s9d2E+6AepeIA5qiRztsTozk8iG15+3yQ1lZf8DDihwWik+EBGv0CGZddigrKfbyIxzoz1/M1FXXt
	iCYqQACA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDd7t-0000000FKU7-19oI;
	Tue, 28 Oct 2025 06:24:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDd7q-0000000FKTH-0Yeu
	for kexec@lists.infradead.org;
	Tue, 28 Oct 2025 06:24:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761632647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuGj1hW8mWz3shIq2GZWCMOifU7nzT6tSAo/1NZESWI=;
	b=OEkby+cC18FNzCPYjanW751CFC2bNEujudiWZRHA0pKGQP43LiEUXsRoSEzjy36u0l/pSw
	YbQNVKj2mR70SKtbUKeYDPlJ7CRtsJudKPsD/BQXZHylViRDu+P0V7Y2a8ca6D3SB+b83o
	hXoVXb7B1VVPKToyzK0OWnnNqnZEF+8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-92njuEYVOgKUgJEjxNPoCA-1; Tue,
 28 Oct 2025 02:24:03 -0400
X-MC-Unique: 92njuEYVOgKUgJEjxNPoCA-1
X-Mimecast-MFC-AGG-ID: 92njuEYVOgKUgJEjxNPoCA_1761632641
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EEE81956080;
	Tue, 28 Oct 2025 06:24:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.212])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C6FA1800353;
	Tue, 28 Oct 2025 06:23:58 +0000 (UTC)
Date: Tue, 28 Oct 2025 14:23:53 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH 0/4] powerpc/kdump: Support high crashkernel reservation
Message-ID: <aQBheTeMycPuDHJ+@MiWiFi-R3L-srv>
References: <20251027151338.819957-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20251027151338.819957-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tVIDdPR_BpRQ4zPZuo_dBJjRS7TSB0ryXFIUEWZskrI_1761632641
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_232410_253589_B24FFF0B 
X-CRM114-Status: GOOD (  17.85  )
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

Cc kexec mailing list.

On 10/27/25 at 08:43pm, Sourabh Jain wrote:
> Add support for reserving crashkernel memory in higher address ranges
> using the crashkernel=xxM,high command-line option.
> 
> With this feature, most of the crashkernel memory for kdump will be
> reserved in high memory regions, while only a small portion (64 MB) will
> be reserved in low memory for the kdump kernel. This helps free up low
> memory for other components that require allocations in that region.
> 
> For example, if crashkernel=2G,high is specified, the kernel will reserve
> 2 GB of crashkernel memory near the end of system RAM and an additional
> 64 MB of low memory (below 1 GB) for RTAS to function properly.
> 
> Currently, this feature is supported only on PPC64 systems with 64-bit
> RTAS instantiation and Radix MMU enabled.
> 
> Two critical changes were made to support this feature:
> 
>  - CPU feature discovery is now performed before crashkernel
>    reservation. This ensures the MMU type is determined before reserving
>    crashkernel memory. (Patch 01/04)
> 
>  - RTAS instantiation has been moved to 64-bit mode. (Patch 02/04)
> 
> Apply the following patch first, and then apply this patch series:
> https://lore.kernel.org/all/20251024170118.297472-1-sourabhjain@linux.ibm.com/
> 
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> 
> Sourabh Jain (4):
>   powerpc/mmu: do MMU type discovery before crashkernel reservation
>   powerpc: move to 64-bit RTAS
>   powerpc/kdump: consider high crashkernel memory if enabled
>   powerpc/kdump: add support for high crashkernel reservation
> 
>  arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
>  arch/powerpc/include/asm/crash_reserve.h |  8 +++++
>  arch/powerpc/include/asm/kexec.h         |  1 +
>  arch/powerpc/include/asm/mmu.h           |  1 +
>  arch/powerpc/include/asm/rtas.h          | 11 ++++++
>  arch/powerpc/kernel/prom.c               | 28 ++++++++-------
>  arch/powerpc/kernel/prom_init.c          | 26 +++++++++++---
>  arch/powerpc/kernel/rtas.c               |  5 +++
>  arch/powerpc/kernel/rtas_entry.S         | 17 ++++++++-
>  arch/powerpc/kexec/core.c                | 45 +++++++++++++++++-------
>  arch/powerpc/kexec/elf_64.c              | 10 ++++--
>  arch/powerpc/kexec/file_load_64.c        |  5 +--
>  arch/powerpc/kexec/ranges.c              | 24 +++++++++++--
>  arch/powerpc/mm/init_64.c                | 27 ++++++++------
>  14 files changed, 161 insertions(+), 48 deletions(-)
> 
> -- 
> 2.51.0
> 



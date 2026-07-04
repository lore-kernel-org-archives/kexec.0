Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC79C43458
	for <kexec@archiver.kernel.org>; Sat,  4 Jul 2026 00:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+/wZjP3VRbBrZYdXJhzA9JgmkyKgho4uGcN4xy9Q+s=; b=JYAcWKCQG2mBpKNt9D6paQ8H8W
	757nHxPVehUkmg5ntXkLY97UVBcsTZ9fYtiqIlZOOD7gX9U41Sq5AhnwhzM4V3BzJ3ZsdjbTa2FpV
	q3tQRaHrOrfb5UwMGaJQ9lHimd3y69X68xT1B49eHXCTGh2WD2Tjn5JmjS9wkje7iDIBkVipSDUUt
	BVcu9ss+FojVNnqGMcA4VkiMqA3vwdWc1NHLd3xoK/i8NWc25HrmlzsanC4rYrH9gKUipa1+SsJ1/
	DY1KCVl7YgH0Atejb1s6xxj8iEUODz0sZXvJkLNjKbXOFgAtWPMoDzO5AnhlkxqvcWJXrdKPgOB9K
	eehUjaRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfocA-00000008493-3YjP;
	Sat, 04 Jul 2026 00:52:14 +0000
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfoc5-0000000848C-0OE2
	for kexec@lists.infradead.org;
	Sat, 04 Jul 2026 00:52:13 +0000
Received: by mail-yx1-xb12a.google.com with SMTP id 956f58d0204a3-66493875766so1456862d50.0
        for <kexec@lists.infradead.org>; Fri, 03 Jul 2026 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1783126327; x=1783731127; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+/wZjP3VRbBrZYdXJhzA9JgmkyKgho4uGcN4xy9Q+s=;
        b=fU2/munT/63bQSfma9I4+Ezvgi81TtG8mKytnvKpYt2DYKrbD8xiRTBUqxGJTZOgHc
         aVixJdfeLKgnO6wXc7SFXrvYZjWJ1QVzBFSDGm5IqES/zS//ZEXAUvMqdmq08zWkWrz2
         Mv/sK2R7Lj0cV3SDWSxH8JQGXaI9UsmPzxueiqcIR7Zbze0WY8KozXeYafCuxajZ1qy1
         lBmiJvJ8NgS8nwWC9A3tIL1vctymIMiQrOYKSj+ga7wSPWn+q7sswZfeNMuKMDs9lmoz
         OFdj75NPDjzpX1wvs09aeOv6NgE3eYqi7PV/SkhXYwYm9YkAGgzd7aaqGECqsP23gjfa
         S+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783126327; x=1783731127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+/wZjP3VRbBrZYdXJhzA9JgmkyKgho4uGcN4xy9Q+s=;
        b=UC3GVpS/lyLYBmV9EWb8Um5f37wUK3JG5OMJZLNwJsBhmTv2iPesVx2JmUPt4z3IvT
         haX1EspYaP+LGgXHDteiTQg/Dd0fZbO1mbp+Fn0n2GS3xgm1ybbo8sxTepqNMhGERlLn
         O4FMxTL/HEs7hE+SvFFJ+fEMj71FSBJlJlKTQATeLoQjnKYvWoIMJJrilVQ5ieATt2v6
         /O6RF7n2JFYwI1mAqRHgZtDv7MF41igBe/hUR2E4rTJwKpVl9SE8T+jrQ9nLQ51dUyz4
         Y17Jiw16OfrxHTEpW0teG/Sw0nrYJ6uKus291W2M4PXaWPT+8EeDdf0PPJbpFg1qi/Rt
         mr+w==
X-Forwarded-Encrypted: i=1; AHgh+RqvbCfYUkSTINUP/3oRmNdRce78aFaxwKIjokClpnQy0JhFx1e/54ctZbYziMvaEG4zWjcSkQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzuWnB1k+XvRBa9tOH6e95Q8ze2oITXdJJliTWygCxsMkZhCbeF
	Ae7CQ3gJW7kppM/kkDemHVbXazO2er7ig0Rye25P017zljakHObxTtOeK6lXpnpAtWg=
X-Gm-Gg: AfdE7cma1RNpIyuxz07b7d3egmrM3tbw11IK8P/9j5B4ovQm5HkhGKc7WcYFTxImBJg
	ngQPtasCo0+PSJyNyEF2sAWW8C2/5mNb0PTfMKCJy3r2S1W2YhGufX+ew96ci3xNLYzi7zllEYc
	sUI3oi2Yfdi7ZgbODSnx9j4n+lMqNBImMgq7TgqGvBhEI0mx5HyOGvPZFWNuHe0Xh9fF22QuYlu
	kExu+mA9jMzW/3fag5IRhJlLc0vQH1AlxBqhcMENS3qu6rJBMmJ2NpG8wSGPCzoyVEnd94iEIgh
	SAWO8E477FVLhMBpcv6KMxlHf0wjaXMgR1KqjGUH7MPv9WW3pqvyKG0MgIs0eFzuHGrkavQ/DL6
	rwsbursf3j9pxzURE5LZMCO1K0llekv/C0g0JKeFgBbDtmRnJ87UATul8No0fg/1W0CZvrWktaL
	LzfvDNhxX8VYtg3XwoX5o4FKbjrox9rw9N/jOlN/n2iiWPBc3JwJmwOnTkuI8sX7nTX0YqGU5dB
	U0p7tkPdWQ7+3dFb93KrRg=
X-Received: by 2002:a05:690e:4506:10b0:665:1e31:9164 with SMTP id 956f58d0204a3-66652eb898dmr968746d50.47.1783126327338;
        Fri, 03 Jul 2026 17:52:07 -0700 (PDT)
Received: from google.com (212.255.145.34.bc.googleusercontent.com. [34.145.255.212])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6664083f9f6sm1511013d50.16.2026.07.03.17.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 17:52:06 -0700 (PDT)
Date: Fri, 3 Jul 2026 20:52:05 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Graf <graf@amazon.com>, "Andersen, Tycho" <Tycho.Andersen@amd.com>, 
	Anthony Yznaga <anthony.yznaga@oracle.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, David Matlack <dmatlack@google.com>, 
	"Heyne, Maximillian" <mheyne@amazon.de>, James Gowans <jgowans@amazon.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Praveen Kumar <kpraveen.lkml@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, 
	Luca Boccassi <luca.boccassi@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Jork Loeser <jloeser@linux.microsoft.com>, Chenghao Duan <duanchenghao@kylinos.cn>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [Hypervisor Live Update] Notes from June 15 and June 29, 2026
Message-ID: <akhY7Njh6LqzyWyz@google.com>
References: <20260704004316.1109918-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704004316.1109918-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_175209_173106_E5B5160A 
X-CRM114-Status: GOOD (  23.06  )
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

Adding missing CCs to the mailing lists.

On 07-03 20:43, Pasha Tatashin wrote:
> Hi everybody,
> 
> Here are the combined notes from our last two Hypervisor Live Update
> calls, held on June 15 and June 29. These notes are intended to bring
> those who could not attend up to speed and to keep the momentum going
> between meetings.
> 
> ----->o-----
> LPC 2026 Call for Proposals
> 
> The Call for Proposals for the Live Update Microconference at LPC 2026
> in Prague is open. Please make sure to submit your topics and abstracts
> before the upcoming deadline on July 24th.
> 
> https://lore.kernel.org/all/ahcc3Qyuy7Oy03Iq@plex
> 
> ----->o-----
> VFIO & PCIe Persistence Roadmap
> 
> * Roadmap Recap (June 15): Vipin Sharma outlined the five-milestone
>   roadmap for preserving PCIe endpoint functions (and upstream bridges)
>   across live updates without disrupting registers or ongoing DMA.
> 
> * Status Update (June 29): Vipin has addressed feedback on the v4
>   submission. Revision v5 is currently undergoing internal validation
>   and is on track for the mailing list before our next sync.
> 
> PCIe Core Updates
> 
> * v6/v7 Evolution: David Matlack is preparing the v7 PCI series. The
>   group aligned on deploying an FLB reference-counting model to maintain
>   symmetry for incoming/outgoing sessions across kexec.
> 
> * Pratyush Yadav suggested that drivers should explicitly isolate
>   structural "probe" routines from "retrieve" logic and separate
>   "shutdown" from "finish" callbacks. David is evaluating the
>   feasibility of deferring probes until the retrieve phase to improve
>   driver cleanliness.
> 
> * David is refactoring the PCI series to utilize KHO blocks.
> 
> IOMMU & Dependency Management
> 
> * v3 Status: Samiullah has posted v3 of the IOMMU persistence series,
>   addressing hot-plug handling and context entry preservation.
> 
> * Dependency Policy: The group agreed that the Live Update framework
>   will not enforce a hardcoded preservation sequence. Instead,
>   individual subsystem file handlers will verify dependency states
>   locally during their freeze/finish callbacks.
> 
> LUO, KHO
> 
> * Terminology Updates: "Scratch" memory is now designated as
>   "unpreserved memory" (memblock perspective). KHO "Scratch" is renamed
>   to "KHO boot memory".
> 
> * LUO Limits: Limits on the number of sessions and preserved files have
>   been removed and landed in upstream Linux.
> 
> Guest Memory (guest_memfd)
> 
> * Naming Conventions: Regarding the KVM file binding debate, the team is
>   moving away from the debugfs-based incremented value approach (due to
>   production compilation concerns). We are exploring using unique names
>   derived from user-space file-handler compatibility strings. Tarun will
>   escalate this to the KVM maintainers.
> 
> ----->o-----
> Action Items & Next Steps
> 
> Pasha: Consult with Mike regarding KHO component splitting without
> versioning support.
> 
> David M: Send next version of the FLB ref-count patch; refactor PCI
> series to use KHO blocks; share recording link from June 29.
> 
> Pratyush: Implement rename of KHO scratch/boot mem.
> 
> Vipin: Submit VFIO v5.
> 
> Group: Review Guest Memory Preservation V3 series (Pasha/David).
> 
> ----->o-----
> 
> Next meeting will be on Monday, July 13 at 8am PDT (UTC-7), everybody is
> welcome!
> 
> Join Here: https://meet.google.com/rjn-dmzu-hgq
> 
> Please let me know if you'd like to propose additional topics for
> discussion, thank you!
> 
> Best regards,
> Pasha


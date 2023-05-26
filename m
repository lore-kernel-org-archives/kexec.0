Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76CC7EE23
	for <kexec@archiver.kernel.org>; Fri, 26 May 2023 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1KdHrAs0xVgxiEFvEP1I5iiGTaekcsKEttqf0v/1B1M=; b=Mb8INwvzYmZ5fS
	o3ZvzVEBo/IlcjgDM9dAkFKJdnvBofQ9GytDFbivkKAYFp2U1A8FRv9D08Kk4I/1aK7WseGUWQNc0
	Uspg9MNd8jNJARgOWewpPT/BKxheEGyWZ0yQ1m7EtRwcF/WXEydfQZQ83ijKOkGJgYXeyQVDXeZ71
	11U5ml61058R0KoTH2O9umGVA7nOhIr8pJYxRaapchd5sQhIrOnihCHMYQPaZLGxb2O6tgViWdXrp
	CwCmDzchWvQ/dQGodhDdEqxh5gIGZIsjleBAaVxeg3qpexpoNREOzRb+hznVAEemTNqiNwBeRxMnV
	/nkqzpSb1STmWXSMcYbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Z0Z-002uUz-1T;
	Fri, 26 May 2023 15:05:35 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Xwg-002iLK-0V
	for kexec@lists.infradead.org;
	Fri, 26 May 2023 13:57:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685109450; x=1716645450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oBqZOBHuiqIEWF5UrD9YR5/Y0jvlkS5A+MMqZPCEAqs=;
  b=kO3u9ID49T2b3tZVNG7egU+HlRhZBcrzxyMAO4GKtZ/uzI536NBp/sDF
   bEKhhKtTN8OG9SwgFzTgjfXgpV4uNOlzAcGqWtGkg14/Zm5eHL4IMrRF2
   v0T7pUBzACv3U1jMUcj5LbOHmmf57bqr1As8wfNXW0iZS0J3cj9Nwu2Kf
   w=;
X-IronPort-AV: E=Sophos;i="6.00,194,1681171200"; 
   d="scan'208";a="333831818"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 13:57:22 +0000
Received: from EX19MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id 845CE8064D;
	Fri, 26 May 2023 13:57:20 +0000 (UTC)
Received: from EX19D008UEC001.ant.amazon.com (10.252.135.232) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 13:57:20 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D008UEC001.ant.amazon.com (10.252.135.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 26 May 2023 13:57:19 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.026; Fri, 26 May 2023 13:57:18 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"jason.zeng@intel.com" <jason.zeng@intel.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "lei.l.li@intel.com" <lei.l.li@intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "mgalaxy@akamai.com" <mgalaxy@akamai.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "fam.zheng@bytedance.com"
	<fam.zheng@bytedance.com>, "Woodhouse, David" <dwmw@amazon.co.uk>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "yuleixzhang@tencent.com"
	<yuleixzhang@tencent.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [RFC v3 00/21] Preserved-over-Kexec RAM
Thread-Topic: [RFC v3 00/21] Preserved-over-Kexec RAM
Thread-Index: AQHZfMp2lJg8EKfTcU+6dylzOaNCcq9sul0A
Date: Fri, 26 May 2023 13:57:18 +0000
Message-ID: <a4f62a8e1b0f43db005cc1117c06c00e6c0c85ff.camel@amazon.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.223]
Content-ID: <1652FBAFA9EDC04894CB1A78E19DF4F0@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_065730_338048_F7345579 
X-CRM114-Status: GOOD (  25.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 2023-04-26 at 17:08 -0700, Anthony Yznaga wrote:
> Sending out this RFC in part to guage community interest.
> This patchset implements preserved-over-kexec memory storage or PKRAM as a
> method for saving memory pages of the currently executing kernel so that
> they may be restored after kexec into a new kernel. The patches are adapted
> from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
> introduce the PKRAM kernel API.
> 
> One use case for PKRAM is preserving guest memory and/or auxillary
> supporting data (e.g. iommu data) across kexec to support reboot of the
> host with minimal disruption to the guest.

Hi Anthony,

Thanks for re-posting this - I'm been wanting to re-kindle the discussion
on preserving memory across kexec for a while now.

There are a few aspects at play in this space of memory management
designed specifically for the virtualisation and live update (kexec) use-
case which I think we should consider:

1. Preserving userspace-accessible memory across kexec: this is what pkram
addresses.

2. Preserving kernel state: This would include memory required for kexec
with DMA passthrough devices, like IOMMU root page and page tables, DMA-
able buffers for drivers, etc. Also certain structures for improved kernel
boot performance after kexec, like a PCI device cache, clock LPJ and
possible others, sort of what Xen breadcrumbs [0] achieves. The pkram RFC
indicates that this should be possible, though IMO this could be more
straight forward to do with a new filesystem with first-class support for
kernel persistence via something like inode types for kernel data.

3. Ensuring huge/gigantic memory allocations: to improve the TLB perf of
2-stage translations it's beneficial to allocate guest memory in large
contiguous blocks, preferably PUD-level blocks for multi-GiB guests. If
the buddy allocator is used this may be a challenge both from an
implementation and a fragmentation perspective, and it may be desirable to
have stronger guarantees about allocation sizes.

4. Removing struct page overhead: When doing the huge/gigantic
allocations, in generally it won't be necessary to have 4 KiB struct
pages. This is something with dmemfs [1, 2] tries to achieve by using a
large chunk of reserved memory and managing that by a new filesystem.

5. More "advanced" memory management APIs/ioctls for virtualisation: Being
able to support things like DMA-driven post-copy live migration, memory
oversubscription, carving out chunks of memory from a VM to launch side-
car VMs, more fine-grain control of IOMMU or MMU permissions, etc. This
may be easier to achieve with a new filesystem, rather than coupling to
tempfs semantics and ioctls.

Overall, with the above in mind, my take is that we may have a smoother
path to implement a more comprehensive solution by going the route of a
new purpose-built file system on top of reserved memory. Sort of like
dmemfs with persistence and specifically support for kernel persistence.

Does my take here make sense?

I'm hoping to put together an RFC for something like the above (dmemfs
with persistence) soon, focusing on how the IOMMU persistence will work.
This is an important differentiating factor to cover in the RFC, IMO.

> PKRAM provides a flexible way
> for doing this without requiring that the amount of memory used by a fixed
> size created a prior.

AFAICT the main down-side of what I'm suggesting here compared to pkram,
is that as you say here: pkram doesn't require the up-front reserving of
memory - allocations from the global shared pool are dynamic. I'm on the
fence as to whether this is actually a desirable property though. Carving
out a large chunk of system memory as reserved memory for a persisted
filesystem (as I'm suggesting) has the advantages of removing struct page
overhead, providing better guarantees about huge/gigantic page
allocations, and probably makes the kexec restore path simpler and more
self contained.

I think there's an argument to be made that having a clearly-defined large
range of memory which is persisted, and the rest is normal "ephemeral"
kernel memory may be preferable.

Keen to hear your (and others) thoughts!

JG

[0] http://david.woodhou.se/live-update-handover.pdf
[1] https://lwn.net/Articles/839216/
[2] https://lkml.org/lkml/2020/12/7/342
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

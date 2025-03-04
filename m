Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F12C021B8
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 04:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8QNG9Tzo6lIVKKqIyvnewf5NhMdnqlRqTf63SVtc9A=; b=0R9JV37IXFyS++ek6+Vdk4VDPW
	l/M25vPKwFsxVaoPndH0CibJWj3AgcAmoVbF3g131wyFWnBVlzOWm9sTliu+6anHko1l3Qwa0laWs
	tH/L8xJyg/9O/X9XEfrq/RTocRitvtqVRYsKfdMHu3dWctoTKBaHBNOaVpPvieuDdfndhzuFYPfgY
	EmdbV2Lezm5DeAzl/P3CvDnxcfSPAZUvl4M1KzyjAJKtzYUa2/Nx0RCNzNSUjbsw9BEoEBR74aQig
	p4Ev7OHy7hs+5j4olys9xj+CrZ+xjdN3R0nsgydhL/BniQArakV5xrZ9Uo1Ifk0yqpBuKwb2bAgjV
	D+cJuBfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpJlz-000000031QG-0cNd;
	Tue, 04 Mar 2025 04:20:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpJlv-000000031Ot-1Es8
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 04:20:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741062042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H8QNG9Tzo6lIVKKqIyvnewf5NhMdnqlRqTf63SVtc9A=;
	b=fK1JvS0X3EsvBY1vrnhj9pHFnsAAQ2FftLYrmZ6WX1t9BbRUAWCf2W6ibxUXwqze1j98p1
	jqgw/YiVbjEo+kXNMvjOnlVM4t3VnsZ4yOIV3f9doYHbJJ2LrqzZHZcZhlTKWSXOX9eMN9
	i/szce2BU7H/Ut1FcFzCkWrZ2vmH8ws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-C1m5irFeO22yySSrr7fZHg-1; Mon,
 03 Mar 2025 23:20:27 -0500
X-MC-Unique: C1m5irFeO22yySSrr7fZHg-1
X-Mimecast-MFC-AGG-ID: C1m5irFeO22yySSrr7fZHg_1741062026
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5581E1800264;
	Tue,  4 Mar 2025 04:20:26 +0000 (UTC)
Received: from localhost (unknown [10.72.112.52])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD28519560AA;
	Tue,  4 Mar 2025 04:20:23 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:20:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Donald Dutile <ddutile@redhat.com>,
	David Hildenbrand <david@redhat.com>, Jiri Bohac <jbohac@suse.cz>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_202047_411183_7180F6AD 
X-CRM114-Status: GOOD (  48.36  )
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

On 03/03/25 at 09:17am, Donald Dutile wrote:
> 
> 
> On 3/3/25 3:25 AM, David Hildenbrand wrote:
> > On 20.02.25 17:48, Jiri Bohac wrote:
> > > Hi,
> > > 
> > > this series implements a way to reserve additional crash kernel
> > > memory using CMA.
> > > 
> > > Link to the v1 discussion:
> > > https://lore.kernel.org/lkml/ZWD_fAPqEWkFlEkM@dwarf.suse.cz/
> > > See below for the changes since v1 and how concerns from the
> > > discussion have been addressed.
> > > 
> > > Currently, all the memory for the crash kernel is not usable by
> > > the 1st (production) kernel. It is also unmapped so that it can't
> > > be corrupted by the fault that will eventually trigger the crash.
> > > This makes sense for the memory actually used by the kexec-loaded
> > > crash kernel image and initrd and the data prepared during the
> > > load (vmcoreinfo, ...). However, the reserved space needs to be
> > > much larger than that to provide enough run-time memory for the
> > > crash kernel and the kdump userspace. Estimating the amount of
> > > memory to reserve is difficult. Being too careful makes kdump
> > > likely to end in OOM, being too generous takes even more memory
> > > from the production system. Also, the reservation only allows
> > > reserving a single contiguous block (or two with the "low"
> > > suffix). I've seen systems where this fails because the physical
> > > memory is fragmented.
> > > 
> > > By reserving additional crashkernel memory from CMA, the main
> > > crashkernel reservation can be just large enough to fit the
> > > kernel and initrd image, minimizing the memory taken away from
> > > the production system. Most of the run-time memory for the crash
> > > kernel will be memory previously available to userspace in the
> > > production system. As this memory is no longer wasted, the
> > > reservation can be done with a generous margin, making kdump more
> > > reliable. Kernel memory that we need to preserve for dumping is
> > > never allocated from CMA. User data is typically not dumped by
> > > makedumpfile. When dumping of user data is intended this new CMA
> > > reservation cannot be used.
> > 
> > 
> > Hi,
> > 
> > I'll note that your comment about "user space" is currently the case, but will likely not hold in the long run. The assumption you are making is that only user-space memory will be allocated from MIGRATE_CMA, which is not necessarily the case. Any movable allocation will end up in there.
> > 
> > Besides LRU folios (user space memory and the pagecache), we already support migration of some kernel allocations using the non-lru migration framework. Such allocations (which use __GFP_MOVABLE, see __SetPageMovable()) currently only include
> > * memory balloon: pages we never want to dump either way
> > * zsmalloc (->zpool): only used by zswap (-> compressed LRU pages)
> > * z3fold (->zpool): only used by zswap (-> compressed LRU pages)
> > 
> > Just imagine if we support migration of other kernel allocations, such as user page tables. The dump would be missing important information.
> > 
> IOMMUFD is a near-term candidate for user page tables with multi-stage iommu support with going through upstream review atm.
> Just saying, that David's case will be a norm in high-end VMs with performance-enhanced guest-driven iommu support (for GPUs).

Thank both for valuable inputs, David and Don. I agree that we may argue
not every system have ballon or enabling swap for now, while future
extending of migration on other kernel allocation could become obstacle
we can't detour.

If we have known for sure this feature could be a bad code, we may need
to stop it in advance.

Thoughts, Jiri?

> 
> > Once that happens, it will become a lot harder to judge whether CMA can be used or not. At least, the kernel could bail out/warn for these kernel configs.
> > 
> I don't think the aforementioned focus is to use CMA, but given its performance benefits, it won't take long to be the next perf improvement step taken.
> 
> > > 
> > > There are five patches in this series:
> > > 
> > > The first adds a new ",cma" suffix to the recenly introduced generic
> > > crashkernel parsing code. parse_crashkernel() takes one more
> > > argument to store the cma reservation size.
> > > 
> > > The second patch implements reserve_crashkernel_cma() which
> > > performs the reservation. If the requested size is not available
> > > in a single range, multiple smaller ranges will be reserved.
> > > 
> > > The third patch updates Documentation/, explicitly mentioning the
> > > potential DMA corruption of the CMA-reserved memory.
> > > 
> > > The fourth patch adds a short delay before booting the kdump
> > > kernel, allowing pending DMA transfers to finish.
> > 
> > 
> > What does "short" mean? At least in theory, long-term pinning is forbidden for MIGRATE_CMA, so we should not have such pages mapped into an iommu where DMA can happily keep going on for quite a while.
> > 
> Hmmm, in the case I mentioned above, should there be a kexec hook in multi-stage IOMMU support for the hypervisor/VMM to invalidate/shut-off stage 2 mappings asap (a multi-microsecond process) so
> DMA termination from VMs is stunted ?  is that already done today (due to 'simple', single-stage, device assignment in a VM)?
> 
> > But that assumes that our old kernel is not buggy, and doesn't end up mapping these pages into an IOMMU where DMA will just continue. I recall that DRM might currently be a problem, described here [1].
> > 
> > If kdump starts not working as expected in case our old kernel is buggy, doesn't that partially destroy the purpose of kdump (-> debug bugs in the old kernel)?
> > 
> > 
> > [1] https://lore.kernel.org/all/Z6MV_Y9WRdlBYeRs@phenom.ffwll.local/T/#u
> > 
> 



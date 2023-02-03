Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3B8C61DA4
	for <kexec@archiver.kernel.org>; Fri,  3 Feb 2023 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gsYmuKAt0xr3sOuJ+7tztm0ftEoRz5zpUg1pt28NU/Q=; b=4f8ek4Y1BAumE6
	blGF+nGm8MViTGqbLYzst4UGNtRSzYAiRkt9xcbXUmRirYBRNrtAJcvcTix/Wm5YdH8iSERQZUHqt
	kkl5VkkOQhnnLjhms+4pe7famgY1iRiNSUSGIn/2vnA6HkvVWNr0jUJempj8M2+DjY4Id7vH7fJ0V
	mdGSZ6BE78iB2oZOUNYE0LKqJ6HYccZ++8MgWaxUZdHXKwD2Kgi7KeffpIjYXxY4s9yp2rV5CA55M
	PC++UGK9etw6Es5vHjZUgoeTmrs+FYBCoqpDtB5FNvf5ETjqmdSjxRFMJQSJj7ATTFSv1W4rQWwr+
	uQX6k5+wo9zO2TiNr3XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNsni-001GSa-8I; Fri, 03 Feb 2023 09:56:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNsnZ-001GQ5-It
	for kexec@lists.infradead.org; Fri, 03 Feb 2023 09:56:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675418160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyrHUWDaMHGpU/h3pd9OdJtLfT/5AhrHaHQApE/AY8o=;
	b=horYnx58p++pIRQEhuhqLtAfT6+wa7OR4Q6aR7I87HeP2Rw97NKaoYeKasb7O2lbhhwQIT
	3Stc0bsBuie7vgKkiRvTr7buVG+s14MNvQudXwa+PK7FVFZNbGxN2WdMZh4R0kX8TI7wRj
	Axa2XLUdXqY4OMPPSdkGMRZUWOJeuew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-jI0Q8GThOhSzi3_s9BuNXw-1; Fri, 03 Feb 2023 04:55:55 -0500
X-MC-Unique: jI0Q8GThOhSzi3_s9BuNXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A3B2183B3C1;
	Fri,  3 Feb 2023 09:55:55 +0000 (UTC)
Received: from localhost (ovpn-12-127.pek2.redhat.com [10.72.12.127])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F09BC2166B34;
	Fri,  3 Feb 2023 09:55:53 +0000 (UTC)
Date: Fri, 3 Feb 2023 17:55:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9zaJim2oGgXMiOS@MiWiFi-R3L-srv>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
 <Y9AXKgJvUuilsWUX@arm.com>
 <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
 <Y9qca12Y/oCxcaFW@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9qca12Y/oCxcaFW@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_015601_700238_7C6CD524 
X-CRM114-Status: GOOD (  36.07  )
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

Hi Catalin,

On 02/01/23 at 05:07pm, Catalin Marinas wrote:
> On Wed, Feb 01, 2023 at 01:57:17PM +0800, Baoquan He wrote:
> > On 01/24/23 at 05:36pm, Catalin Marinas wrote:
> > > On Tue, Jan 17, 2023 at 11:49:20AM +0800, Baoquan He wrote:
> > > > On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> > > > suitable memory region up down. If the 'xM' of crashkernel high memory
> > > > is reserved from high memory successfully, it will try to reserve
> > > > crashkernel low memory later accoringly. Otherwise, it will try to search
> > > > low memory area for the 'xM' suitable region.
> > > > 
> > > > While we observed an unexpected case where a reserved region crosses the
> > > > high and low meomry boundary. E.g on a system with 4G as low memory end,
> > > > user added the kernel parameters like: 'crashkernel=512M,high', it could
> > > > finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> > > > This looks very strange because we have two low memory regions
> > > > [4G-126M, 4G] and [1G, 1G+128M]. Much explanation need be given to tell
> > > > why that happened.
> > > > 
> > > > Here, for crashkernel=xM,high, search the high memory for the suitable
> > > > region above the high and low memory boundary. If failed, try reserving
> > > > the suitable region below the boundary. Like this, the crashkernel high
> > > > region will only exist in high memory, and crashkernel low region only
> > > > exists in low memory. The reservation behaviour for crashkernel=,high is
> > > > clearer and simpler.
> > > 
> > > Well, I guess it depends on how you look at the 'high' option: is it
> > > permitting to go into high addresses or forcing high addresses only?
> > > IIUC the x86 implementation has a similar behaviour to the arm64 one, it
> > > allows allocation across boundary.
> > 
> > Hmm, x86 has no chance to allocate a memory region across 4G boundary
> > because it reserves many small regions to map firmware, pci bus, etc
> > near 4G. E.g one x86 system has /proc/iomem as below. I haven't seen a
> > x86 system which doesn't look like this.
> > 
> > [root@ ~]# cat /proc/iomem 
> [...]
> > fffc0000-ffffffff : Reserved
> > 100000000-13fffffff : System RAM
> 
> Ah, that's why we don't see this problem on x86.
> 
> Alright, for consistency I'm fine with having the same logic on arm64. I
> guess we don't need the additional check on whether the 'high'
> allocation reserved at least 128MB in the 'low' range. If it succeeded
> and the start is below 4GB, it's guaranteed that it got the full
> allocation in the 'low' range. I haven't checked whether your patch
> cleaned this up already, if not please do in the next version.
> 
> And as already asked, please fold the comments with the same patch, it's
> easier to read.

I have updated patch according to you and Simon's suggestion, and resend
v2.

By the way, could you please have a look at below patchset, to see what
solution we should take to solve the spotted problem on arm64?

===
arm64, kdump: enforce to take 4G as the crashkernel low memory end
https://lore.kernel.org/all/20220828005545.94389-1-bhe@redhat.com/T/#u

After thorough discussion, I think the problem and root cuase have been
very clear to us. However, which way to choose to solve it haven't been
decided. In our distors, RHEL and Fedora, we enabed both CONFIG_ZONE_DMA
CONFIG_ZONE_DMA32 by default, need set crashkernel= in cmdline. And we
don't set 'rodata=' kernel parameter unless have to. I am fine with
taking off the protection on crashkernel region, or taking the way where
my patchset is done.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

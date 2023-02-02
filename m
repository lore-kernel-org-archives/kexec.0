Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24B6C636CD
	for <kexec@archiver.kernel.org>; Thu,  2 Feb 2023 02:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iv9LZWWZF3/6NdNVqr9f3pKatvi5LvTTR0QlQlXTDT8=; b=bO26mLs9z+G0f0
	1635HWlLQEQG8ZVz3n3q2N1llU618xlgoHCoLTBnireJghMiTtlrpYBJ62kqzBHAPQt5VZsd2PEta
	1P6r21TadGSHrbh0njtWU95nFO5nVswTd9hhrGJknaNgmW9N6EquHHH7YEl84ycMz25uK7tkZFUll
	C9+gJR93WvET+D5diltwBiw05eXCiNC3tRt0W37gltFA7XBGE0jMEoXDjWE6FgxraNfkdNH7vfwug
	puaFxoJ23RN0nDaFncU4l4oVmZO1lmTL4x3sMiGRrlJlGFnv+Us3I/Up36GvSu/VDdE1YvbwnJEzp
	Wyu9HSEjPvyW6aWpLBOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNPlM-00EBjm-VG; Thu, 02 Feb 2023 02:55:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNPlF-00EBiq-PB
	for kexec@lists.infradead.org; Thu, 02 Feb 2023 02:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675306539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XLBXtd6NgriQ7A5ZWXztbyUCM7WFy5RfjYy2td4k7fE=;
	b=gENN3IK9RW/Jy52NGL29T2RTuld/0LMbwlSxtl+BJlaAvuj5Egl4TY4ZKOm6BVEAB1/3ST
	oj2W9AxAfxD7Up+sX4Use7hLF4Nou0Kt5x66/cVnls/r0uuZK95LMcjz1F71azw2bezJuo
	/IvSbDV2d+7ZBIeP35abi1EgDdzrXzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-efmawRduNwu8WBWqSoSN_g-1; Wed, 01 Feb 2023 21:55:36 -0500
X-MC-Unique: efmawRduNwu8WBWqSoSN_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFBA6101A521;
	Thu,  2 Feb 2023 02:55:35 +0000 (UTC)
Received: from localhost (ovpn-12-116.pek2.redhat.com [10.72.12.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 983BE43FBA;
	Thu,  2 Feb 2023 02:55:34 +0000 (UTC)
Date: Thu, 2 Feb 2023 10:55:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH 1/2] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
Message-ID: <Y9smIopkS8C+TG/5@MiWiFi-R3L-srv>
References: <20230117034921.185150-1-bhe@redhat.com>
 <20230117034921.185150-2-bhe@redhat.com>
 <Y9AXKgJvUuilsWUX@arm.com>
 <Y9n/PTEv7oOObuLi@MiWiFi-R3L-srv>
 <Y9qca12Y/oCxcaFW@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9qca12Y/oCxcaFW@arm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_185541_912156_7E947BC5 
X-CRM114-Status: GOOD (  33.90  )
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

Yes, that checking has been cleaned away in this patch.

> 
> And as already asked, please fold the comments with the same patch, it's
> easier to read.

Sure, will do. Thanks a lot for reviewing.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFA7C7EE22
	for <kexec@archiver.kernel.org>; Mon, 15 May 2023 10:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h6zaw5Al0SgNbP3wHE4lfdXTpk09zSWwtAUK5S0udPk=; b=bVdUiolSgKvY3w
	AsVb/fCPwwVtV5fMFjS+xaXuUydlZdOwJPEED0So4LweXV4fgnLCEIUHQAuIuKqo4L49SyGpabSqe
	XdgwKKqo3D5pqz4DinghKqHLW7Jw3U89Za5EuqHJ0etoeFBl14Rx7E78wTBrPYZ5Pk7166Oxf/mFs
	2PohEu163JmU8eawDZBmsIIMNSXxsp6y/J/UL3OerhSUKWK5vAtpyijmnq5g7z5x+cIHsp7Elk4C/
	lqgoxv/+KLsU/VwlzPplQKMyV39JRnIx8kE8OZa3j5ECQCtc9xhB2PZjFoCARqtxE+1z6+OTeHbf4
	XoZGjCkt9qlHS525QyoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyV6u-001go0-2n;
	Mon, 15 May 2023 10:07:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyV6s-001gn7-0H
	for kexec@lists.infradead.org;
	Mon, 15 May 2023 10:07:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684145237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G8znqVw87JzE/GiUPHNFG+C6yuIz096Ng+G8V1HRe2s=;
	b=iNhDqatZS9w87+NN8jXh8hxQcV+PEXKYiqJ8PgsseTYwHTOSHKYqPwrU8xf0fwsp2kasN/
	71dyGv3cnn4wvRjuHR+uLN2X2UVFGa4gHiuu4RmixIRhVC9nGsWigS0/79MD2aulf5RUjT
	t4o5TqCa4WNryxu7m1mJGT6pkz0Ui94=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-wcpg3rWqOrmEqBjfNuUdxw-1; Mon, 15 May 2023 06:07:13 -0400
X-MC-Unique: wcpg3rWqOrmEqBjfNuUdxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22CE43C0F22F;
	Mon, 15 May 2023 10:07:13 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B7FF63ABB;
	Mon, 15 May 2023 10:07:12 +0000 (UTC)
Date: Mon, 15 May 2023 18:07:09 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, horms@kernel.org,
	thunder.leizhen@huawei.com, John.p.donnelly@oracle.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] arm64: kdump: simplify the reservation behaviour
 of crashkernel=,high
Message-ID: <ZGIETQZWp3scdS/m@MiWiFi-R3L-srv>
References: <20230515060259.830662-1-bhe@redhat.com>
 <20230515060259.830662-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230515060259.830662-2-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_030718_230225_F4B72D12 
X-CRM114-Status: GOOD (  21.80  )
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

On 05/15/23 at 02:02pm, Baoquan He wrote:
> On arm64, reservation for 'crashkernel=xM,high' is taken by searching for
> suitable memory region top down. If the 'xM' of crashkernel high memory
> is reserved from high memory successfully, it will try to reserve
> crashkernel low memory later accoringly. Otherwise, it will try to search
> low memory area for the 'xM' suitable region. Please see the details in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> While we observed an unexpected case where a reserved region crosses the
> high and low meomry boundary. E.g on a system with 4G as low memory end,
> user added the kernel parameters like: 'crashkernel=512M,high', it could
> finally have [4G-126M, 4G+386M], [1G, 1G+128M] regions in running kernel.
> The crashkernel high region crossing low and high memory boudary will bring
> issues:
> 
> 1) For crashkernel=x,high, if getting crashkernel high region across
> low and high memory boundary, then user will see two memory regions in
> low memory, and one memory region in high memory. The two crashkernel
> low memory regions are confusing as shown in above example.
> 
> 2) If people explicityly specify "crashkernel=x,high crashkernel=y,low"
> and y <= 128M, when crashkernel high region crosses low and high memory
> boundary and the part of crashkernel high reservation below boundary is
> bigger than y, the expected crahskernel low reservation will be skipped.
> But the expected crashkernel high reservation is shrank and could not
> satisfy user space requirement.
> 
> 3) The crossing boundary behaviour of crahskernel high reservation is
> different than x86 arch. On x86_64, the low memory end is 4G fixedly,
> and the memory near 4G is reserved by system, e.g for mapping firmware,
> pci mapping, so the crashkernel reservation crossing boundary never happens.
> From distros point of view, this brings inconsistency and confusion. Users
> need to dig into x86 and arm64 system details to find out why.
> 
> For kernel itself, the impact of issue 3) could be slight. While issue
> 1) and 2) cause actual impact because it brings obscure semantics and
> behaviour to crashkernel=,high reservation.
> 
> Here, for crashkernel=xM,high, search the high memory for the suitable
> region only in high memory. If failed, try reserving the suitable
> region only in low memory. Like this, the crashkernel high region will
> only exist in high memory, and crashkernel low region only exists in low
> memory. The reservation behaviour for crashkernel=,high is clearer and
> simpler.
> 
> Note: RPi4 has different zone ranges than normal memory. Its DMA zone is
> 0~1G, and DMA32 zone is 1G~4G if CONFIG_ZONE_DMA|DMA32 are enabled by
> default. The low memory end is 1G in order to validate all devices, high
> memory starts at 1G memory. However, for being consistent with normla
> arm64 system, its low memory end is still 1G, while reserving crashkernel
> high memory from 4G if crashkernel=size,high specified. This will remove
> confusion.
> 
> With above change applied, summary of arm64 crashkernel reservation range:
> 1)
> RPi4(zone DMA:0~1G; DMA32:1G~4G):
>  crashkernel=size
>   0~1G: low memory | 1G~top: high memory
> 
>  crashkernel=size,high
>   0~1G: low memory | 4G~top: high memory
> 
> 2)
> Other normal system:
>  crashkernel=size
>  crashkernel=size,high
>   0~4G: low memory | 4G~top: high memory
> 
> 3)
> Systems w/o zone DMA|DMA32
>  crashkernel=size
>  crashkernel=size,high
>   0~top: low memory
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> 
> arm64: kdump: fix warning reported by static checker
> Signed-off-by: Baoquan He <bhe@redhat.com>

Sorry, forgot cleaning up this relic of local patch merging, have resent
one to remove it, and add Catalin's Reviewed-by tag.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

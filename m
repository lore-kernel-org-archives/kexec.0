Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E07C04AA5
	for <kexec@archiver.kernel.org>; Thu, 25 Aug 2022 07:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l9gPZP+z3gILSNdWJAkM62jXdd/TFPVyIDe1Qzqmb5E=; b=YKndU87tIkav2e
	EuqJpB2+0beP1ApR6HFZSUzJZo/YLNXKwWZ12DkGUN5UEjnqvaAwYob0DYOTSYKe2ExOt2wUeZQz1
	wTkPZ2n3Pc0zlAf0Qyya6khk09jc3NbMO3KEWyEK2ntWH6CXFZsUP+JoTl/f/o5Ky5g+Z9gav8Kl2
	MSArktxqsp0o2WFbB9zqMaHm67mkadxMgdqHhbz1WvnjTqEv2ZAby40oObaJEqaBbYC5z1t2eXN1R
	/46CB5VozDnttJ8XJnYdtFCl8lSdEBy1egA2yxuStk8rRbCg0XzO8WAPPVf8uqZNS+G4QmqcbpP73
	VzpoAZ/Enh0xsXAxJxyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR7Op-009JbB-NL; Thu, 25 Aug 2022 07:35:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR7OY-009IxQ-LY
	for kexec@lists.infradead.org; Thu, 25 Aug 2022 07:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661412914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/KHHMrmA8HFk2ILFS/S3jVPvSPT7uexAlYEbMs4sA0E=;
	b=Q3K/ktaL5djNo+d21CTG4/pXOhIM2T3IO+teGDrAo/LQKNI7uQr+8EaAofeoupR5mEq5Wi
	NEifuG0AkNrBb8I7bOBZ5l8g9eBErhdsVFaxCTcpXAJZlHC9pe3ZYbnIEL7SCBUyqq5k41
	vQ5RhxLWmOM12KwCHAKqb47mtMnw8c4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-ZtJcIqVGOgGj1CQMWQiYuw-1; Thu, 25 Aug 2022 03:35:11 -0400
X-MC-Unique: ZtJcIqVGOgGj1CQMWQiYuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DCB53C10682;
	Thu, 25 Aug 2022 07:35:10 +0000 (UTC)
Received: from localhost (ovpn-13-108.pek2.redhat.com [10.72.13.108])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 905CB2166B26;
	Thu, 25 Aug 2022 07:35:09 +0000 (UTC)
Date: Thu, 25 Aug 2022 15:35:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	kexec@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Rapoport <rppt@linux.ibm.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Mike Rapoport <mike.rapoport@gmail.com>
Subject: Re: [PATCH 0/5] arm64/mm: remap crash kernel with base pages even if
 rodata_full disabled
Message-ID: <YwcmKAink5XvoaTe@MiWiFi-R3L-srv>
References: <20220819041156.873873-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220819041156.873873-1-rppt@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_003518_793404_C3E761C6 
X-CRM114-Status: GOOD (  22.14  )
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

Add kexec list in CC

On 08/19/22 at 07:11am, Mike Rapoport wrote:
> From: Mike Rapoport <mike.rapoport@gmail.com>
> 
> Hi,
> 
> There were several rounds of discussion how to remap with base pages only
> the crash kernel area, the latest one here:
> 
> https://lore.kernel.org/all/1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com
> 
> and this is my attempt to allow having both large pages in the linear map
> and protection for the crash kernel memory.
> 
> For server systems it is important to protect crash kernel memory for
> post-mortem analysis, and for that protection to work the crash kernel
> memory should be mapped with base pages in the linear map. 
> 
> On the systems with ZONE_DMA/DMA32 enabled, crash kernel reservation
> happens after the linear map is created and the current code forces using
> base pages for the entire linear map, which results in performance
> degradation.
> 
> These patches enable remapping of the crash kernel area with base pages
> while keeping large pages in the rest of the linear map.
> 
> The idea is to align crash kernel reservation to PUD boundaries, remap that
> PUD and then free the extra memory.

Hi Mike,

Thanks for the effort to work on this issue. While I have to say this
isnt's good because it can only be made relying on a prerequisite that
there's big enough memory. If on a system, say 2G memory, it's not easy
to succeed on getting one 1G memory. While we only require far smaller
region than 1G, e.g about 200M which should be easy to get. So the way
taken in this patchset is too quirky and will cause regression on
systemswith small memory. This kind of sytems with small memory exists
widely on virt guest instance.

The crashkernel reservation happens after linear map because the
reservation needs to know the dma zone boundary, arm64_dma_phys_limit.
If we can deduce that before bootmem_init(), the reservation can be
done before linear map. I will make an attempt on that. If still can't
be accepted, we would like to take off the crashkernel region protection
on arm64 for now.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

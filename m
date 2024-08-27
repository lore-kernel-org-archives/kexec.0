Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC658C54742
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 22:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LB3ohFSqEeGbpEMQm6vK3C/bMwOoXN71bZfboUxL5p8=; b=Qhz4emHMmXihWK
	k2Tx6iYDdv3BrrEWIRy+uAMBhcUZo2dSdJAextqENM46/DiLLphRHzjcXwXOzLN0jcx1G8wyOx8xl
	ZiJgD/ciDCWO9iFDK7pWOXeqyScCKtI+uGDgglwnpyPRTpY5gPqAexqO31om5k3LPRH/FymXOzT4l
	fSOBER+t7rZuTuo4b8yS9YLEdXa2YtqpRPuNypoH0W9PpzLNkRL+Qw0RPr4oCSmQDm9e4Pv1571co
	fE0mrBVCi5jJG/lVjo76aFrvEO7haGqy1PNNloimEVdv9IAhYbDsoV9Ql6NfjvM1SArj55tIvwAdc
	L2i1wE4muQtVge9XwNJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj4z6-0000000D3g2-0pSY;
	Tue, 27 Aug 2024 22:48:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj4z3-0000000D3f0-1RAm
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 22:48:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724798896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVWzv4d3wS++awPAHCsT183EQ2Vo8jOynbbMBJW0NUY=;
	b=VdKCj9jLtt6t+0mArfENWFGYZG4J1JJ9AO7X7VHUsKhAQatunReflzpQ822m23e3KGliVL
	KejDAouzlko4MNIenDjQb+NQxYUAQ8m0Q026DVWL+fSWNgDuej3TvgERwZZrYCSC5unGUT
	iDcElz4CP7tViyV+I/GvqV7jNdgZaDo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-M6HYJC8xM8-rvrkCJ4lelQ-1; Tue,
 27 Aug 2024 18:48:13 -0400
X-MC-Unique: M6HYJC8xM8-rvrkCJ4lelQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A89DC19560B0;
	Tue, 27 Aug 2024 22:48:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F1161955D8C;
	Tue, 27 Aug 2024 22:48:07 +0000 (UTC)
Date: Wed, 28 Aug 2024 06:48:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: k-hagio-ab@nec.com, lijiang@redhat.com,
	Kuan-Ying Lee <kuan-ying.lee@canonical.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org
Subject: Re: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in
 vmcoreinfo
Message-ID: <Zs5Xo5eVUvGMbtSv@MiWiFi-R3L-srv>
References: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
 <20240827122459.GA4679@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240827122459.GA4679@willie-the-truck>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_154817_482331_8DD49F95 
X-CRM114-Status: GOOD (  15.05  )
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

On 08/27/24 at 01:24pm, Will Deacon wrote:
> On Mon, Aug 26, 2024 at 02:52:02PM +0800, Kuan-Ying Lee wrote:
> > Since arm64 supports 5-level page tables, we need to add this
> > information to vmcoreinfo to make debug tools know if 5-level
> > page table is enabled or not.
> > 
> > Missing this information will break the debug tool like crash [1].
> > 
> > [1] https://github.com/crash-utility/crash
> > 
> > Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
> > ---
> >  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
> >  arch/arm64/kernel/vmcore_info.c                | 3 +++
> >  2 files changed, 9 insertions(+)
> 
> In which case, wouldn't you also want to know about pgtable_l4_enabled()?

That is a good question. I guess it's deduced in code, mostly needed for
different PAGE_OFFSET, how to transfer virtual addr to physical addr,
etc.

Add Crash utility experts here.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

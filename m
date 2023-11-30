Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB9FC4167B
	for <kexec@archiver.kernel.org>; Thu, 30 Nov 2023 12:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RXLTetKzVWJoVzcXJFAAlrn+IXrL6oxxBE0/jAIOgVM=; b=ukUQG8f4A77v1U
	Gu3szbgmgfTcOOyDbE+/VPfDzhsUbRbOytFPIYqwHvQPClPqzr5Q4ak8ddxUtI9/y1lA00E7TgDzA
	oyEcdnPK7mSlMW2IFbRjpuWT08xUhLj2qsms42OPoiTROKkMKpEkWOIx3iCwZ2LlJaTtIRlxDlNvu
	H8boAl7i0KSCNug41WWBoodIFB0tAPcHHQYK1EjvBUdnOkmxrVT8PVIHiCRLyVjtKrV9VkKd1DDnm
	828pcl+F/wOVrVza2QSidO5yk3VIymWcFxjlQDJCShN3vzZTJntwQiHBN1jQAtt8kXm/45PzBqXtS
	iF2q2RlKtykmma0xmFhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8fn8-00AnJW-1d;
	Thu, 30 Nov 2023 12:05:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8fn2-00AnHU-37
	for kexec@lists.infradead.org;
	Thu, 30 Nov 2023 12:05:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701345907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B80Gpj6tociNz1RbRJ/cNcWm35Kf/1SWUfnQzVTmpWk=;
	b=ZXV0DA1OehStHU5dyFh3ewkIgPxU3z+BvcCL3vXk6Iz1ZzUdIRx9FBZn5cjY0F2tpzH9TK
	6Ne9bkJftuvnMmtGevcn8CeprWP8o9iM3V8QM5mLwYhA2sk09YoW2vfRwc9gAr/bireFho
	g5w13T1fBSBU9oyzWUS3hXH0P2SZSdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-BqfA4TXcMKOdz47HbkXqIQ-1; Thu, 30 Nov 2023 07:05:03 -0500
X-MC-Unique: BqfA4TXcMKOdz47HbkXqIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48461811E86;
	Thu, 30 Nov 2023 12:05:03 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D1A42026D68;
	Thu, 30 Nov 2023 12:05:02 +0000 (UTC)
Date: Thu, 30 Nov 2023 20:04:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWhg_b3O6piZtkQ-@tiehlicka>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_040509_092742_ACF7BBFA 
X-CRM114-Status: GOOD (  23.63  )
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

On 11/30/23 at 11:16am, Michal Hocko wrote:
> On Thu 30-11-23 11:00:48, Baoquan He wrote:
> [...]
> > Now, we are worried if there's risk if the CMA area is retaken into kdump
> > kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
> > or DMA will interfere with kdump kernel's normal memory accessing?
> > Because kdump kernel usually only reset and initialize the needed
> > device, e.g dump target. Those unneeded devices will be unshutdown and
> > let go. 
> 
> I do not really want to discount your concerns but I am bit confused why
> this matters so much. First of all, if there is a buggy RDMA driver
> which doesn't use the proper pinning API (which would migrate away from
> the CMA) then what is the worst case? We will get crash kernel corrupted
> potentially and fail to take a proper kernel crash, right? Is this
> worrisome? Yes. Is it a real roadblock? I do not think so. The problem
> seems theoretical to me and it is not CMA usage at fault here IMHO. It
> is the said theoretical driver that needs fixing anyway.
> 
> Now, it is really fair to mention that CMA backed crash kernel memory
> has some limitations
> 	- CMA reservation can only be used by the userspace in the
> 	  primary kernel. If the size is overshot this might have
> 	  negative impact on kernel allocations
> 	- userspace memory dumping in the crash kernel is fundamentally
> 	  incomplete.

I am not sure if we are talking about the same thing. My concern is:
====================================================================
1) system corrutption happened, crash dumping is prepared, cpu and
interrupt controllers are shutdown;
2) all pci devices are kept alive;
3) kdump kernel boot up, initialization is only done on those devices
which drivers are added into kdump kernel's initrd;
4) those on-flight DMA engine could be still working if their kernel
module is not loaded;

In this case, if the DMA's destination is located in crashkernel=,cma
region, the DMA writting could continue even when kdump kernel has put
important kernel data into the area. Is this possible or absolutely not
possible with DMA, RDMA, or any other stuff which could keep accessing
that area?

The existing crashkernel= syntax can gurantee the reserved crashkernel
area for kdump kernel is safe.
=======================================================================

The 1st kernel's data in the ,cma area is ignored once crashkernel=,cma
is taken.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

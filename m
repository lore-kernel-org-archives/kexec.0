Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C44FD6DDEA
	for <kexec@archiver.kernel.org>; Fri, 15 Nov 2024 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5/Gv1K21sheGKIrlLPLsT5HVFSu0SIwMyx7mgZQnuI=; b=ruyUVkE0+qpbfdfHNHE1l14zcU
	MywprS8yXqEhqp3mETlU7AitWD+g00zz6bYx8+6auOTrB4RYc2R+o5/Q1kVfe7XAobdQ0tErlt2yD
	EadhSPRFdbLFHGaxyTNS//yDne1jBPXqC2bYG9TATAkvufKFFuqEDYPySmQR2neO4t6x7qLwkoOd1
	yCYWPIkRPleIefZPvKJ+63cGLnKhk7bbgYFXgFGpCKX91o4BxTMXpiV8UsSAekYRYER2DY7JU+qwJ
	CkhAosw1ts+3eVvdp0QPj9mLE7bM+6V/N+Z5bx4j7xIVejaZJtVx4xPhSsKqc2fFK9jMuLF1APWxi
	df030KWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBsxn-00000002FMf-1zvA;
	Fri, 15 Nov 2024 09:50:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBswt-00000002F51-2kDt
	for kexec@lists.infradead.org;
	Fri, 15 Nov 2024 09:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731664146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5/Gv1K21sheGKIrlLPLsT5HVFSu0SIwMyx7mgZQnuI=;
	b=FxIXpwQqjFhsUeXhb39lYHLfWkpTz2ZmEPm5ZGsp5ISTEihusQhedTmIqiFNAoWzNCsWpY
	5OIO/x0nkoeDwI1ig2IQ/ZJXd/NKyPf/pc136G6FWnHrHtJEaKgklYd47VLgEfpw4wY16t
	fYvy9UM0Fl/2limzUpf6NXwdzrp/5bg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-YdO3XG1bNzqs4Bb4j1wJcg-1; Fri,
 15 Nov 2024 04:49:02 -0500
X-MC-Unique: YdO3XG1bNzqs4Bb4j1wJcg-1
X-Mimecast-MFC-AGG-ID: YdO3XG1bNzqs4Bb4j1wJcg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE9CB1955E92;
	Fri, 15 Nov 2024 09:48:59 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3935D3003B71;
	Fri, 15 Nov 2024 09:48:58 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:48:53 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 00/11] fs/proc/vmcore: kdump support for virtio-mem on
 s390
Message-ID: <ZzcZBU0USDP/CHcv@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <ZzcKY8hap3OMqTjC@MiWiFi-R3L-srv>
 <d7353fde-f560-4925-8ef8-0fe10654e87f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7353fde-f560-4925-8ef8-0fe10654e87f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_014907_765006_0CFE4229 
X-CRM114-Status: GOOD (  29.96  )
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

On 11/15/24 at 09:55am, David Hildenbrand wrote:
> On 15.11.24 09:46, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > This is based on "[PATCH v3 0/7] virtio-mem: s390 support" [1], which adds
> > > virtio-mem support on s390.
> > > 
> > > The only "different than everything else" thing about virtio-mem on s390
> > > is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> > > during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> > > crash kernel must detect memory ranges of the crashed/panicked kernel to
> > > include via PT_LOAD in the vmcore.
> > > 
> > > On other architectures, all RAM regions (boot + hotplugged) can easily be
> > > observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> > > the elfcore hdr.
> > > 
> > > On s390, information about "ordinary" memory (heh, "storage") can be
> > > obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> > > that information is stored early during boot in the "physmem" memblock
> > > data structure.
> > > 
> > > But virtio-mem memory is always detected by as device driver, which is
> > > usually build as a module. So in the crash kernel, this memory can only be
> >                                         ~~~~~~~~~~~
> >                                         Is it 1st kernel or 2nd kernel?
> > Usually we call the 1st kernel as panicked kernel, crashed kernel, the
> > 2nd kernel as kdump kernel.
> 
> It should have been called "kdump (2nd) kernel" here indeed.
> 
> > > properly detected once the virtio-mem driver started up.
> > > 
> > > The virtio-mem driver already supports the "kdump mode", where it won't
> > > hotplug any memory but instead queries the device to implement the
> > > pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> > > the vmcore.
> > > 
> > > With this series, if the virtio-mem driver is included in the kdump
> > > initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> > > now detect the device RAM ranges on s390 once it probes the devices, to add
> > > them to the vmcore using the same callback mechanism we already have for
> > > pfn_is_ram().
> > 
> > Do you mean on s390 virtio-mem memory region will be detected and added
> > to vmcore in kdump kernel when virtio-mem driver is initialized? Not
> > sure if I understand it correctly.
> 
> Yes exactly. In the kdump kernel, the driver gets probed and registers the
> vmcore callbacks. From there, we detect and add the device regions.

I see now, thanks for your confirmation.



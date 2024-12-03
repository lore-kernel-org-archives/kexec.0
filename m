Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE5E69EA6
	for <kexec@archiver.kernel.org>; Tue,  3 Dec 2024 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D5AHi0uk+oN+zpkzvh/QNmG2L3UPAKNwXGcHrJAQaZM=; b=qvDc9+kUf1LHG/Uf+m6N2uUS4/
	4Usv1IE379dE6Wggi5xQjl3MiOPTIJ6lMs6fRx/MPA5y4V1dEzUDrpFcVdm3LgM6GRXaPJl0bH6uJ
	AEJkMEldD1/NLhlFS93XYCwFPECJubM4Q99HZM7LcvCw13NOc0PNnxO8FS9oP7KInjfQH8g2aq3lk
	NUiVn//pPunUdNXk+liuqH8juAJU+FAxPgQ00ly9YG2GLS/gNlYmiQGyax2OHiwwd/Lc3cGJdLk8P
	34kkG0zXWsN6crdW5dap3h8ePdxlnTX7ab9DTcvav5TcEWb7Fo1DJT56Fg1eo+jsbuunmZTGjwySF
	K0Jt0hgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQbH-00000009ABO-31zZ;
	Tue, 03 Dec 2024 10:57:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQMb-000000096zW-3FFs
	for kexec@lists.infradead.org;
	Tue, 03 Dec 2024 10:42:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733222560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5AHi0uk+oN+zpkzvh/QNmG2L3UPAKNwXGcHrJAQaZM=;
	b=IBf3vuaiex7xxuF0Uw9ZzOY9JXxPRGRVWxeBhqeAZEgumQRHc4QDka4xrtoh+gbe7BSNhf
	Vp5ECnlOkaBRnbXhnxsBg0E9tEyUP3ja5Wyro5lCqMnZR82B0N/ZaCXnuxUFwtOz/HNebt
	LTlWOBNfgzEgW5M+0QpMmPV8itCPgUM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-P5838zgdOW6m0hg0rLlvbA-1; Tue,
 03 Dec 2024 05:42:36 -0500
X-MC-Unique: P5838zgdOW6m0hg0rLlvbA-1
X-Mimecast-MFC-AGG-ID: P5838zgdOW6m0hg0rLlvbA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE7BF19560BD;
	Tue,  3 Dec 2024 10:42:32 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A28330000DF;
	Tue,  3 Dec 2024 10:42:29 +0000 (UTC)
Date: Tue, 3 Dec 2024 18:42:25 +0800
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
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
Message-ID: <Z07gkXQDrNfL10hu@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com>
 <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
 <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
 <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
 <a7ccbd86-2a62-4191-8742-ce45b6e8f73c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ccbd86-2a62-4191-8742-ce45b6e8f73c@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_024241_884197_36CDA169 
X-CRM114-Status: GOOD (  34.58  )
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

On 11/29/24 at 11:38am, David Hildenbrand wrote:
> On 25.11.24 15:41, Baoquan He wrote:
> > On 11/22/24 at 10:30am, David Hildenbrand wrote:
> > > On 22.11.24 10:16, Baoquan He wrote:
> > > > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > > ......snip...
> > > > > @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> > > > >    		return -EINVAL;
> > > > >    	}
> > > > > +	/* We'll recheck under lock later. */
> > > > > +	if (data_race(vmcore_opened))
> > > > > +		return -EBUSY;
> > > > 
> > > 
> > > Hi,
> > > 
> > > > As I commented to patch 7, if vmcore is opened and closed after
> > > > checking, do we need to give up any chance to add device dumping
> > > > as below?
> > > > 
> > > > fd = open(/proc/vmcore);
> > > > ...do checking;
> > > > close(fd);
> > > > 
> > > > quit any device dump adding;
> > > > 
> > > > run makedumpfile on s390;
> > > >     ->fd = open(/proc/vmcore);
> > > >       -> try to dump;
> > > >     ->close(fd);
> > > 
> > > The only reasonable case where this could happen (with virtio_mem) would be
> > > when you hotplug a virtio-mem device into a VM that is currently in the
> > > kdump kernel. However, in this case, the device would not provide any memory
> > > we want to dump:
> > > 
> > > (1) The memory was not available to the 1st (crashed) kernel, because
> > >      the device got hotplugged later.
> > > (2) Hotplugged virtio-mem devices show up with "no plugged memory",
> > >      meaning there wouldn't be even something to dump.
> > > 
> > > Drivers will be loaded (as part of the kernel or as part of the initrd)
> > > before any kdump action is happening. Similarly, just imagine your NIC
> > > driver not being loaded when you start dumping to a network share ...
> > > 
> > > This should similarly apply to vmcoredd providers.
> > > 
> > > There is another concern I had at some point with changing the effective
> > > /proc/vmcore size after someone already opened it, and might assume the size
> > > will stay unmodified (IOW, the file was completely static before vmcoredd
> > > showed up).
> > > 
> > > So unless there is a real use case that requires tracking whether the file
> > > is no longer open, to support modifying the vmcore afterwards, we should
> > > keep it simple.
> > > 
> > > I am not aware of any such cases, and my experiments with virtio_mem showed
> > > that the driver get loaded extremely early from the initrd, compared to when
> > > we actually start messing with /proc/vmcore from user space.

It's OK, David, I don't have strong opinion about the current
implementation. I raised this concern because

1) I saw the original vmcoredd only warn when doing register if
vmcore_opened is true;

2) in patch 1, it says vmcore_mutex is introduced to protect vmcore
modifications from concurrent opening. If we are confident, the old
vmcoredd_mutex can guarantee it, I could be wrong here.

Anyway, it's just a tiny concern, I believe it won't cause issue at
present. So it's up to you. 

Thanks



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9165D58D54
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 14:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=46wCtS3Eh2MWHiDHvSqDOE0J1G+zlgwVIrX5wgmHpV8=; b=VbtfcxRTYE9L+xZqXqkzg3lO5N
	1LWdNj+q2NAVK0Wyx0wccEaGSEKGoBUO7tiomyVyfAuBRA3uMOSDokgJc6AUIF4HQ8gySAe4bEVDe
	N9a6RWjyNA1A6HXB0QhtIKGdwIWQgnO8FdrsNUGNwbyaYw4PVWSI9zLdbtK/1JFInDjBJbdK5tldW
	42gxX4pvVcQtNX3myrTp9dT4goofcaRE5DMi6y4J8mEN0sWJU3+gx8UzTzpZWzyHUjoMtmKLhKbsJ
	Ypy8AiBJIhoMR70bqNl7MyfRNb2CGCzU6PRkE7WaqF3QJIvGE7AWsJLmErZSZ+zl/e040yTpmx3AN
	HP/0mQ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFaHr-00000008Kf8-3ioB;
	Mon, 25 Nov 2024 14:42:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFaHp-00000008Ke1-2SW4
	for kexec@lists.infradead.org;
	Mon, 25 Nov 2024 14:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732545719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46wCtS3Eh2MWHiDHvSqDOE0J1G+zlgwVIrX5wgmHpV8=;
	b=gxPMeu9PHHjx6Oyw0VNLauLKzVKRu1D9xMcMQwofSnaL8kP9FkK6M8j+uTAMuCt9Z3AkpA
	ho14xvXB/ZfQAoJnlcha+8azbdAvhKambU7YABobi0QP1WpVhmwcmz3ZozrdOoYMoh33v1
	5D47O7PspPaBzeH6NQABUnBAULsRGDE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-bEyv-BAOPx6TDm6pRFxqBA-1; Mon,
 25 Nov 2024 09:41:55 -0500
X-MC-Unique: bEyv-BAOPx6TDm6pRFxqBA-1
X-Mimecast-MFC-AGG-ID: bEyv-BAOPx6TDm6pRFxqBA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BFA41954B0A;
	Mon, 25 Nov 2024 14:41:52 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28945195E483;
	Mon, 25 Nov 2024 14:41:50 +0000 (UTC)
Date: Mon, 25 Nov 2024 22:41:45 +0800
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
Message-ID: <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com>
 <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
 <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_064201_701230_23C328FB 
X-CRM114-Status: GOOD (  31.59  )
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

On 11/22/24 at 10:30am, David Hildenbrand wrote:
> On 22.11.24 10:16, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > ......snip...
> > > @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> > >   		return -EINVAL;
> > >   	}
> > > +	/* We'll recheck under lock later. */
> > > +	if (data_race(vmcore_opened))
> > > +		return -EBUSY;
> > 
> 
> Hi,
> 
> > As I commented to patch 7, if vmcore is opened and closed after
> > checking, do we need to give up any chance to add device dumping
> > as below?
> > 
> > fd = open(/proc/vmcore);
> > ...do checking;
> > close(fd);
> > 
> > quit any device dump adding;
> > 
> > run makedumpfile on s390;
> >    ->fd = open(/proc/vmcore);
> >      -> try to dump;
> >    ->close(fd);
> 
> The only reasonable case where this could happen (with virtio_mem) would be
> when you hotplug a virtio-mem device into a VM that is currently in the
> kdump kernel. However, in this case, the device would not provide any memory
> we want to dump:
> 
> (1) The memory was not available to the 1st (crashed) kernel, because
>     the device got hotplugged later.
> (2) Hotplugged virtio-mem devices show up with "no plugged memory",
>     meaning there wouldn't be even something to dump.
> 
> Drivers will be loaded (as part of the kernel or as part of the initrd)
> before any kdump action is happening. Similarly, just imagine your NIC
> driver not being loaded when you start dumping to a network share ...
> 
> This should similarly apply to vmcoredd providers.
> 
> There is another concern I had at some point with changing the effective
> /proc/vmcore size after someone already opened it, and might assume the size
> will stay unmodified (IOW, the file was completely static before vmcoredd
> showed up).
> 
> So unless there is a real use case that requires tracking whether the file
> is no longer open, to support modifying the vmcore afterwards, we should
> keep it simple.
> 
> I am not aware of any such cases, and my experiments with virtio_mem showed
> that the driver get loaded extremely early from the initrd, compared to when
> we actually start messing with /proc/vmcore from user space.

Hmm, thanks for sharing your thoughts. I personally think if we could,
we had better make code as robust as possible. Here, since we have
already integrated the lock with one vmcore_mutex, whether the vmcoredd 
is added before or after /proc/vmcore opening/closing, it won't harm.
The benefit is it works well with the current kwown case, virtio-mem 
probing, makedumpfile running. And it also works well with other
possible cases, e.g if you doubt virtio-mem dumping and want to debug,
you set rd.break or take any way to drop into emengency shell of kdump
kernel, you can play it to poke virtio-mem module again and run makedumpfile
manually or reversing the order or taking any testing. Then kernel
implementation should not preset that user space have to run the
makedumpfile after the much earlier virtio-mem probing. If we implement
codes according to preset userspace scenario, that limit the future
adapttion, IMHO.



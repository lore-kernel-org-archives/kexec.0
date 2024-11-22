Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A495FE65D2E
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9p/amWDuKtYCK1WkCl/Fua58/N/1s7xV60ca3EpfR4=; b=b1dsqO1c2LouZL0t8501pggJMm
	lUI8l+/57L/hA6egX8AMpnRjRoTRy3BiLD9MO7KgJV95uBIBeBswUG3g3LT0TB/tQ4BOrAFxGf1GE
	Sx8pDOzQLtoh5Fhw62fyhps5Z0EfPVqHhASX4qvAOE6tOjQKwf1iBJguVhVSQ8a5HEF54UzAPMaHo
	DVpvmb0frtPhJ5yUtMjAY8KUmpZhTRRvNBApsFRBwLM4QUsgxV6BFFLJ/GyhF1sZ/51aKMjTyQLMe
	4dl6vqMKfXvvO9Fknx+/eXtA3BGHhmeEPsm81i9+t6QatGU77YDZgUlsiVCRLnk+Yh9f8TqHDHCPc
	80kzlLeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEOSb-00000001r5t-0xcd;
	Fri, 22 Nov 2024 07:52:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEOSY-00000001r56-1V1q
	for kexec@lists.infradead.org;
	Fri, 22 Nov 2024 07:52:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732261929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9p/amWDuKtYCK1WkCl/Fua58/N/1s7xV60ca3EpfR4=;
	b=IdaxZiYCLJXc1cpUUwgm40ChhPj+YmwfURKzOWPhI/vRpNRQWLo9nqGGMDfs3Rknbr6xH8
	4tNzHs/iTyCtQS/rRVxINg+NPpZyr+irUEPlEX1fg+TwPSrkWmEc+8BwWYWX6ykKs7gBOt
	RwN9Zd82ZMwx1BryAiT07hxosHO8zbU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-HBEew0p3NECkehH9sfpIIQ-1; Fri,
 22 Nov 2024 02:52:04 -0500
X-MC-Unique: HBEew0p3NECkehH9sfpIIQ-1
X-Mimecast-MFC-AGG-ID: HBEew0p3NECkehH9sfpIIQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53B6E1955F3D;
	Fri, 22 Nov 2024 07:52:01 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B9441955F43;
	Fri, 22 Nov 2024 07:51:59 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:51:54 +0800
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
Subject: Re: [PATCH v1 07/11] fs/proc/vmcore: introduce
 PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
Message-ID: <Z0A4Gl1dUINrTTUX@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com>
 <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
 <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
 <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
 <3ed18ba1-e4b1-461e-a3a7-5de2df59ca60@redhat.com>
 <Zz63aGL7NcrONk+p@MiWiFi-R3L-srv>
 <c353466b-6860-4ca2-a4fa-490648246ddc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c353466b-6860-4ca2-a4fa-490648246ddc@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_235210_480938_0F270714 
X-CRM114-Status: GOOD (  23.47  )
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

On 11/21/24 at 08:47pm, David Hildenbrand wrote:
> > > 
> > > That would work, but I don't completely like it.
> > > 
> > > (a) I want s390x to select NEED_PROC_VMCORE_DEVICE_RAM instead. Staring at a
> > > bunch of similar cases (git grep "config NEED" | grep Kconfig, git grep
> > > "config ARCH_WANTS" | grep Kconfig), "select" is the common way to do it.
> > > 
> > > So unless there is a pretty good reason, I'll keep
> > > NEED_PROC_VMCORE_DEVICE_RAM as is.
> > 
> > That's easy to satify, see below:
> 
> Yes, this is mostly what I have right now, except
> 
> > 
> > ============simple version=====
> > fs/proc/Kconfig:
> > config NEED_PROC_VMCORE_DEVICE_RAM
> >          def n
> 
> using "bool" here like other code. (I assume you meant "def_bool n", "bool"
> seems to achieve the same thing)

Yes, you are right. I didn't check it carefully.

> 
> > 
...... 
> > ===================
> > fs/proc/Kconfig:
> > config PROVIDE_PROC_VMCORE_DEVICE_RAM
> >          def_bool n
> > 
> > config NEED_PROC_VMCORE_DEVICE_RAM
> >          def_bool n
> > 
> > config PROC_VMCORE_DEVICE_RAM
> >          def_bool y
> >          depends on PROC_VMCORE
> >          depends on NEED_PROC_VMCORE_DEVICE_RAM
> >          depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> > 
> > drivers/virtio/Kconfig:
> > config VIRTIO_MEM
> >          select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> >                                                ~~~~~~~~~~~~~~
> > 
> > arch/s390/Kconfig:
> > config S390
> >          select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> >                                             ~~~~~~~~~~~~~~
> > ========================
> > 
> > One last thing I haven't got well, If PROC_VMCORE_DEVICE_RAM has had
> > dependency on PROC_VMCORE, can we take off the ' if PROC_VMCORE' when
> > select PROVIDE_PROC_VMCORE_DEVICE_RAM and NEED_PROC_VMCORE_DEVICE_RAM?
> 
> We could; it would mean that in a .config file you would end up with
> "NEED_PROC_VMCORE_DEVICE_RAM=y" with "#PROC_VMCORE" and no notion of
> "PROC_VMCORE_DEVICE_RAM".

Fair enough. I didn't think of this. Then keeping it is obvisouly
better. Thanks.

> 
> I don't particularly like that -- needing something that apparently does not
> exist. Not sure if there is a best practice here, staring at some examples I
> don't seem to find a consistent rule. I can just drop it, not the end of the
> world.
> 
> 
> Did you get to look at the other code changes in this patch set? Your
> feedback would be highly appreciated!

Will try. While I may not have valuable input about virtio-mem code.



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E0BD63954
	for <kexec@archiver.kernel.org>; Wed, 20 Nov 2024 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZ8zkxd9i0HO8zyxRsaMmA5VwckXIWnTVoItJwHtzes=; b=RjndzgBQkJnmaynhjie3QuE/Xg
	oMFigA6A9gESgAHARC63b+YUSvpv1349UrFGO48b32Gxun2cD4MKKBZ/O6jKXgC4quqCq+A+rDQ64
	+km8ln8L64ttxTHA91OZbbBYgifzHC0CxxsTc5U299WKann2SpuP8viPr3xJb3X+K1rSn8+Y4zl/U
	rygcha9sWCG5tBZBq4qf2nPwjHlxXoRdqM6zhEDZ/ivdGzcAJ7Zlg69253FkPE2AjJ4CXo70F5nOK
	LSEi6LeLOaxO+Y5apecTsk07Wkg34X3wsMDhRlgmX7r5btakhn90biy2SuRIYL/am7VBTZACEoJQm
	rRvgTJqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDlKn-0000000FTpz-2kzc;
	Wed, 20 Nov 2024 14:05:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDlKk-0000000FTpO-3kyO
	for kexec@lists.infradead.org;
	Wed, 20 Nov 2024 14:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lZ8zkxd9i0HO8zyxRsaMmA5VwckXIWnTVoItJwHtzes=;
	b=F9K8hgRl2sETTB7vRmR3Eotyb83iLiXGkRcowtRtc60CUunj+l9YHPaTfzdV7UNvaykPpy
	oQgSowT9aqXuLPEUlUk79ApclKoMSLHEkaaBQMNYD/Zmhdl4cIFdT2gzLH9E8E5lVyt7Cq
	ZR5GdjypIw4wGGIHwqpaAfeceoh+H+0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-fEP9m0A0NhyClwF0cvKrGQ-1; Wed,
 20 Nov 2024 09:05:28 -0500
X-MC-Unique: fEP9m0A0NhyClwF0cvKrGQ-1
X-Mimecast-MFC-AGG-ID: fEP9m0A0NhyClwF0cvKrGQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 307F91953944;
	Wed, 20 Nov 2024 14:05:25 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFA9230001A0;
	Wed, 20 Nov 2024 14:05:22 +0000 (UTC)
Date: Wed, 20 Nov 2024 22:05:15 +0800
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
Message-ID: <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com>
 <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
 <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241120_060531_112034_0FD1D17E 
X-CRM114-Status: GOOD (  45.99  )
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

On 11/20/24 at 11:48am, David Hildenbrand wrote:
> On 20.11.24 11:13, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > s390 allocates+prepares the elfcore hdr in the dump (2nd) kernel, not in
> > > the crashed kernel.
> > > 
> > > RAM provided by memory devices such as virtio-mem can only be detected
> > > using the device driver; when vmcore_init() is called, these device
> > > drivers are usually not loaded yet, or the devices did not get probed
> > > yet. Consequently, on s390 these RAM ranges will not be included in
> > > the crash dump, which makes the dump partially corrupt and is
> > > unfortunate.
> > > 
> > > Instead of deferring the vmcore_init() call, to an (unclear?) later point,
> > > let's reuse the vmcore_cb infrastructure to obtain device RAM ranges as
> > > the device drivers probe the device and get access to this information.
> > > 
> > > Then, we'll add these ranges to the vmcore, adding more PT_LOAD
> > > entries and updating the offsets+vmcore size.
> > > 
> > > Use Kconfig tricks to include this code automatically only if (a) there is
> > > a device driver compiled that implements the callback
> > > (PROVIDE_PROC_VMCORE_DEVICE_RAM) and; (b) the architecture actually needs
> > > this information (NEED_PROC_VMCORE_DEVICE_RAM).
> > > 
> > > The current target use case is s390, which only creates an elf64
> > > elfcore, so focusing on elf64 is sufficient.
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   fs/proc/Kconfig            |  25 ++++++
> > >   fs/proc/vmcore.c           | 156 +++++++++++++++++++++++++++++++++++++
> > >   include/linux/crash_dump.h |   9 +++
> > >   3 files changed, 190 insertions(+)
> > > 
> > > diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> > > index d80a1431ef7b..1e11de5f9380 100644
> > > --- a/fs/proc/Kconfig
> > > +++ b/fs/proc/Kconfig
> > > @@ -61,6 +61,31 @@ config PROC_VMCORE_DEVICE_DUMP
> > >   	  as ELF notes to /proc/vmcore. You can still disable device
> > >   	  dump using the kernel command line option 'novmcoredd'.
> > > +config PROVIDE_PROC_VMCORE_DEVICE_RAM
> > > +	def_bool n
> > > +
> > > +config NEED_PROC_VMCORE_DEVICE_RAM
> > > +	def_bool n
> > > +
> > > +config PROC_VMCORE_DEVICE_RAM
> > > +	def_bool y
> > > +	depends on PROC_VMCORE
> > > +	depends on NEED_PROC_VMCORE_DEVICE_RAM
> > > +	depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> > 
> > Kconfig item is always a thing I need learn to master.
> 
> Yes, it's usually a struggle to get it right. It took me a couple of
> iterations to get to this point :)
> 
> > When I checked
> > this part, I have to write them down to deliberate. I am wondering if
> > below 'simple version' works too and more understandable. Please help
> > point out what I have missed.
> > 
> > ===========simple version======
> > config PROC_VMCORE_DEVICE_RAM
> >          def_bool y
> >          depends on PROC_VMCORE && VIRTIO_MEM
> >          depends on NEED_PROC_VMCORE_DEVICE_RAM
> > 
> > config S390
> >          select NEED_PROC_VMCORE_DEVICE_RAM
> > ============

Sorry, things written down didn't correctly reflect them in my mind. 

===========simple version======
fs/proc/Kconfig:
config PROC_VMCORE_DEVICE_RAM
        def_bool y
        depends on PROC_VMCORE && VIRTIO_MEM
        depends on NEED_PROC_VMCORE_DEVICE_RAM

arch/s390/Kconfig:
config NEED_PROC_VMCORE_DEVICE_RAM
        def y
==================================


> 
> So the three changes you did are
> 
> (a) Remove the config option but select/depend on them.
> 
> (b) Remove the "depends on PROC_VMCORE" from PROC_VMCORE_DEVICE_RAM,
>     and the "if PROC_VMCORE" from s390.
> 
> (c) Remove the PROVIDE_PROC_VMCORE_DEVICE_RAM
> 
> 
> Regarding (a), that doesn't work. If you select a config option that doesn't
> exist, it is silently dropped. It's always treated as if it wouldn't be set.
> 
> Regarding (b), I think that's an anti-pattern (having config options enabled
> that are completely ineffective) and I don't see a benefit dropping them.
> 
> Regarding (c), it would mean that s390x unconditionally includes that code
> even if virtio-mem is not configured in.
> 
> So while we could drop PROVIDE_PROC_VMCORE_DEVICE_RAM -- (c), it would that
> we end up including code in configurations that don't possibly need it.
> That's why I included that part.
> 
> > 
> > 
> > ======= config items extracted from this patchset====
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
> > config VIRTIO_MEM
> > 	depends on X86_64 || ARM64 || RISCV
> >           ~~~~~ I don't get why VIRTIO_MEM dones't depend on S390 if
> >                 s390 need PROC_VMCORE_DEVICE_RAM.
> 
> This series depends on s390 support for virtio-mem, which just went
> upstream.

Got It, I just applied this series on top of the latest mainline's
master branch. Thanks for telling.

> 
> 
> commit 38968bcdcc1d46f2fdcd3a72599d5193bf8baf84
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Oct 25 16:14:49 2024 +0200
> 
>     virtio-mem: s390 support
> 
> 
> >          ......
> >          select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> > 
> > config S390
> >          select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> > =================================================
> > 
> 
> Thanks for having a look!
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED96E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=erQix5YBM/Y/uEtirG3GeKXgXkkPiaihYorhESefFJA=; b=LVD5/v2a6AOO+HzHXtow/beG7D
	HfH1Mwlgid8Y3+hc/VcVqcxdcCoHrya+BqzGoVB5q/jnKAdRsMAsmZ8UUamyspkzCfhCBez+PWTp8
	DEtJG7NEnL1TO4OtrASZZKgoDQ4XdGg0aSXjJgFbfLgPRPKvW6TN3wZ1bYJaHrAoByiJWVYl1bade
	nh0/GFKes3yD7PMDkGwJ+lHsFrhiaj3mt8isgC9Y98kqIS69EOJ38MoMdyHL6I7nAuMe/NyYQR+HV
	T5cP9pmoOn/LGm/KiL/lzeAk0QSuLMP7iZ6WlcPbGrnTqf0AjaSAZ4rahaFrU6dBJVw7BCxfI7Db6
	fuu9ej3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVVZC-00000008VgE-3BzV;
	Wed, 08 Jan 2025 12:53:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUna-00000008Lo1-0yta
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 12:04:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736337873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=erQix5YBM/Y/uEtirG3GeKXgXkkPiaihYorhESefFJA=;
	b=IOWixmGP5ZUn/6fGnTatTloCNAy3Kyc1pDFhyxaDiTCJj79AMqo9gLk7Rwxw+4x6pW6AeQ
	rau4Q/E+yJo36H7weB+tBQP/Y43dPCdW4qSYPwfw89C0e3qzsmvCf0TmfdWok3wLwN5NSC
	20o3r8Of7BHR5CvNQ8Sba4LLrEhfA6Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Dn0FQicSP3OuJ4XUKKsYEw-1; Wed, 08 Jan 2025 07:04:32 -0500
X-MC-Unique: Dn0FQicSP3OuJ4XUKKsYEw-1
X-Mimecast-MFC-AGG-ID: Dn0FQicSP3OuJ4XUKKsYEw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43623bf2a83so120744765e9.0
        for <kexec@lists.infradead.org>; Wed, 08 Jan 2025 04:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337870; x=1736942670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erQix5YBM/Y/uEtirG3GeKXgXkkPiaihYorhESefFJA=;
        b=o1N6U4jzIXhk1qlTQip0H79loMDPB+6MO2OPrtUdNRkmvNBZzjIG932e+PK+2pOtdq
         euf5P1hSd733jolv/V1oGGts5tcj+GZSuiJ7X+dpqWbf0KkICdvYbUTosrSF7/aFpWz2
         XNf8WygupRdi4X1mf8NWPUFWFyQQxhC/r5HkpXWSCgMWslv7J36dxADFvZ0jfSLjFDEf
         KYzRNH/QH/ELQ+mh3H8D/NiSqXXsPg8qZJGOGP5eN7oaU33bQe+MjUImCekQ13lmYQ7T
         Pb7YK7eO7Zc8+omqYawjTuS3cXKDNTYRCVUP67XiIjIPf4yeg7SILJvdYXB/+6p6fbBg
         leGw==
X-Forwarded-Encrypted: i=1; AJvYcCUW7yv5oEcNMeWR+HyHtm0NWq94ztwSRMU+U2WfiKy198TaGgKjncYicc0RAIAjmd7dPBYBzg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+d6OCvxr73Wp0506o+Hkxk/zRURCUCu7I+Uv2gWSg+CcaRzSJ
	EXvYaS1cuQlrBzGX8sFkkJu9a2jxMA30vQrUiOz5by389MNJ+zjQy8QEx51W350OikaYpyQkHAh
	6qr4szmJFg30Bx+GeCE5nu8nCIeEQZ1RZov7bwhkajUCHfngn4WZpCxhfkg==
X-Gm-Gg: ASbGncsJpdgOY3oNFnhIcliBnI2KkDW7FtcFUqgndWAOsKv9PdL4FERA9HpePOPP1LN
	n/8zNpcgrzuvdJtQZYdyd5JcKfj7vQKCIEMGkPFSVbazV1+Ixlj3zZczYVsg2aCQZHh3VH69Mj7
	z/c/KWyK3Um5TTxR95gRWsCnznUKWdYlbwtw/avbHqBhNHgBAANyB4ld62STGJO1vx7pI9biwPJ
	5eBpKnNviD2C6EbYsdLBlBVo8dwTEvkCdw2VCReJQ1peLJD1Rc=
X-Received: by 2002:a05:600c:5251:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-436e2700050mr18200155e9.33.1736337869682;
        Wed, 08 Jan 2025 04:04:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUR05pl8seK2xsW/qB5D6saVHw6QWnqhWJEnho0PIwlVj0Pr14aAjP/a/iJR8rsa6d05BmGw==
X-Received: by 2002:a05:600c:5251:b0:434:f4f9:8104 with SMTP id 5b1f17b1804b1-436e2700050mr18199815e9.33.1736337869281;
        Wed, 08 Jan 2025 04:04:29 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8bea5sm18342805e9.31.2025.01.08.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:04:28 -0800 (PST)
Date: Wed, 8 Jan 2025 07:04:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] fs/proc/vmcore: kdump support for virtio-mem on
 s390
Message-ID: <20250108070407-mutt-send-email-mst@kernel.org>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pqrO_E7GzpPSK9a1GMcbpScWwCo1MVmL83GBQSCgSq4_1736337870
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_040434_345108_6F464C7E 
X-CRM114-Status: GOOD (  37.30  )
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

On Wed, Dec 04, 2024 at 01:54:31PM +0100, David Hildenbrand wrote:
> The only "different than everything else" thing about virtio-mem on s390
> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> kdump kernel must detect memory ranges of the crashed kernel to
> include via PT_LOAD in the vmcore.
> 
> On other architectures, all RAM regions (boot + hotplugged) can easily be
> observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> the elfcore hdr.
> 
> On s390, information about "ordinary" memory (heh, "storage") can be
> obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> that information is stored early during boot in the "physmem" memblock
> data structure.
> 
> But virtio-mem memory is always detected by as device driver, which is
> usually build as a module. So in the crash kernel, this memory can only be
> properly detected once the virtio-mem driver started up.
> 
> The virtio-mem driver already supports the "kdump mode", where it won't
> hotplug any memory but instead queries the device to implement the
> pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> the vmcore.
> 
> With this series, if the virtio-mem driver is included in the kdump
> initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> now detect the device RAM ranges on s390 once it probes the devices, to add
> them to the vmcore using the same callback mechanism we already have for
> pfn_is_ram().
> 
> To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
> add new PT_LOAD entries that describe these memory ranges, and update
> all offsets vmcore size so it is all consistent.
> 
> My testing when creating+analyzing crash dumps with hotplugged virtio-mem
> memory (incl. holes) did not reveal any surprises.
> 
> Patch #1 -- #7 are vmcore preparations and cleanups
> Patch #8 adds the infrastructure for drivers to report device RAM
> Patch #9 + #10 are virtio-mem preparations
> Patch #11 implements virtio-mem support to report device RAM
> Patch #12 activates it for s390, implementing a new function to fill
>           PT_LOAD entry for device RAM

Who is merging this?
virtio parts:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v1 -> v2:
> * "fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex"
>  -> Extend patch description
> * "fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex"
>  -> Extend patch description
> * "fs/proc/vmcore: disallow vmcore modifications while the vmcore is open"
>  -> Disallow modifications only if it is currently open, but warn if it
>     was already open and got closed again.
>  -> Track vmcore_open vs. vmcore_opened
>  -> Extend patch description
> * "fs/proc/vmcore: prefix all pr_* with "vmcore:""
>  -> Added
> * "fs/proc/vmcore: move vmcore definitions out if kcore.h"
>  -> Call it "vmcore_range"
>  -> Place vmcoredd_node into vmcore.c
>  -> Adjust patch subject + description
> * "fs/proc/vmcore: factor out allocating a vmcore range and adding it to a
>    list"
>  -> Adjust to "vmcore_range"
> * "fs/proc/vmcore: factor out freeing a list of vmcore ranges"
>  -> Adjust to "vmcore_range"
> * "fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
>    ranges in 2nd kernel"
>  -> Drop PROVIDE_PROC_VMCORE_DEVICE_RAM for now
>  -> Simplify Kconfig a bit
>  -> Drop "Kdump:" from warnings/errors
>  -> Perform Elf64 check first
>  -> Add regions also if the vmcore was opened, but got closed again. But
>     warn in any case, because it is unexpected.
>  -> Adjust patch description
> * "virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM"
>  -> "depends on VIRTIO_MEM" for PROC_VMCORE_DEVICE_RAM
> 
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> David Hildenbrand (12):
>   fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
>   fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
>   fs/proc/vmcore: disallow vmcore modifications while the vmcore is open
>   fs/proc/vmcore: prefix all pr_* with "vmcore:"
>   fs/proc/vmcore: move vmcore definitions out of kcore.h
>   fs/proc/vmcore: factor out allocating a vmcore range and adding it to
>     a list
>   fs/proc/vmcore: factor out freeing a list of vmcore ranges
>   fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
>     ranges in 2nd kernel
>   virtio-mem: mark device ready before registering callbacks in kdump
>     mode
>   virtio-mem: remember usable region size
>   virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
>   s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
> 
>  arch/s390/Kconfig             |   1 +
>  arch/s390/kernel/crash_dump.c |  39 ++++-
>  drivers/virtio/virtio_mem.c   | 103 ++++++++++++-
>  fs/proc/Kconfig               |  19 +++
>  fs/proc/vmcore.c              | 283 ++++++++++++++++++++++++++--------
>  include/linux/crash_dump.h    |  41 +++++
>  include/linux/kcore.h         |  13 --
>  7 files changed, 407 insertions(+), 92 deletions(-)
> 
> 
> base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
> -- 
> 2.47.1



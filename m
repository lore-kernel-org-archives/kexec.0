Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC796D11185
	for <kexec@archiver.kernel.org>; Mon,  4 Nov 2024 06:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qRjTOCEwVL6GYNnP7Sc9R/ebfIqpZTNNkBQkUszDHpw=; b=C2m1wqHB54gguc
	xBup9MPb5+Cyxa0YxoOW6VnXu3Fu421KXZsS+RHqrYb2b+Blb1lNxiB5tJmmoAKnR9CtrmW00q49j
	1t+Q3ySJpHTaYE/cazKeMzW+bjQ6hYnLn8dZd7sgWkvoRzF2NsFdJBI3/7hMyYrIg1zeT7Nu/hQYM
	HtJpKwJIoRvFDmcvfSTXQVI30UGrAPwwMzIVI1Blk3BVPXdWk63rek198cJFoETUUWRVtwswIBovw
	B1Pewjgcq93DxUnIO/CY9Y3veStOoZUOdZcf62mz9rI4YOPASsLi675g75icBvQ8h44etcnmGwt50
	GDGegRuuMHIBmcwL2IxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qSq-0000000CkZB-2LLf;
	Mon, 04 Nov 2024 06:21:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7qSn-0000000CkYk-282p
	for kexec@lists.infradead.org;
	Mon, 04 Nov 2024 06:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730701280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Yt6e01JiHs6xDUFc4KUXQd8i1elq2u0nXKuucFyQGQ=;
	b=C5nfLtGxsFHw+kCR4Io+aPSPNXA28rScFPcj4q+oa91Snmr4y5FMvfG5XImTGPkgV284JT
	R2hJCqOCUjttUjZ1atgBQDsfMDmc/EIuH6Mxc2tznvZ7+0EjoPn4yht0UtiY2Z95kcWiA6
	2f6EQdmcR1PKOeUcYq613TEbo3rqZMQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-b2Wj_TLPNE6Ox6N8IQMnvg-1; Mon,
 04 Nov 2024 01:21:16 -0500
X-MC-Unique: b2Wj_TLPNE6Ox6N8IQMnvg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A026619560B4;
	Mon,  4 Nov 2024 06:21:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA7C11956052;
	Mon,  4 Nov 2024 06:21:10 +0000 (UTC)
Date: Mon, 4 Nov 2024 14:21:06 +0800
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
Message-ID: <Zyhn0oz+ze0xY2AR@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_222121_649077_10B838C4 
X-CRM114-Status: GOOD (  28.06  )
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

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> This is based on "[PATCH v3 0/7] virtio-mem: s390 support" [1], which adds
> virtio-mem support on s390.
> 
> The only "different than everything else" thing about virtio-mem on s390
> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> crash kernel must detect memory ranges of the crashed/panicked kernel to
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
> Note that makedumfile is shaky with v6.12-rcX, I made the "obvious" things
> (e.g., free page detection) work again while testing as documented in [2].
> 
> Creating the dumps using makedumpfile seems to work fine, and the
> dump regions (PT_LOAD) are as expected. I yet have to check in more detail
> if the created dumps are good (IOW, the right memory was dumped, but it
> looks like makedumpfile reads the right memory when interpreting the
> kernel data structures, which is promising).
> 
> Patch #1 -- #6 are vmcore preparations and cleanups

Thanks for CC-ing me, I will review the patch 1-6, vmcore part next
week.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

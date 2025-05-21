Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FECC54E65
	for <kexec@archiver.kernel.org>; Wed, 21 May 2025 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b//tAtpqR3EMFEEGzwUIttSzLXmrWZQCdWQOg6sR/1Y=; b=PmvIln030y/VQThUknsuByLTbu
	8wYHwfR6oKZqOqm/pVRJH0Nr2bS8z/r3GOGXZAYdslkgMtUx5I7CY8bQNOJxpKnL59xcD+t0X40LJ
	ySLvL0Oob67Yje2k+9do7fesKr+UIWP+uDvagoYaT5dIorNnl9JjZX1s4F0stOb6bh5LKI3MObgcd
	8MTmr9kOFxhbCmI/zveE3hhme8EeQNqP6C+WnO8OXXdAR+0XwV8AQ8oVnMKFXuytING5uQwqh3a91
	VLWcaDT0OKYjNhxjaCEoTW4H6hesQ497PHwM+cNZnS0SKAmRyFfeCnB1SVq7Rv5fx2pO79WFa4PS2
	YaOnTrGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgju-0000000FVMH-0pFE;
	Wed, 21 May 2025 10:31:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgiR-0000000FTuD-2gkK
	for kexec@lists.infradead.org;
	Wed, 21 May 2025 10:30:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747823425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b//tAtpqR3EMFEEGzwUIttSzLXmrWZQCdWQOg6sR/1Y=;
	b=Amv9W6PwYuGy/qXrBosDpwd9m5IN5mXNhWC+GL62DsLHHg/tbUlxZQTB4fn9k8LNQLDMLJ
	7rjbgXtt/2Zr03tKLWpZaGjguW8ubpIc1CarGJ4pjsuVeuFY9TUUsOfEk1kaa3wDmDSwdm
	A8rrquVYOl9Qv8Ijxs6EOh4JzXz3yEU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-btUfwaYUMESeBfS1WcEr9A-1; Wed,
 21 May 2025 06:30:21 -0400
X-MC-Unique: btUfwaYUMESeBfS1WcEr9A-1
X-Mimecast-MFC-AGG-ID: btUfwaYUMESeBfS1WcEr9A_1747823420
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0C59195608A;
	Wed, 21 May 2025 10:30:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8755530001AA;
	Wed, 21 May 2025 10:30:17 +0000 (UTC)
Date: Wed, 21 May 2025 18:30:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Alexander Graf <graf@amazon.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	nh-open-source@amazon.com
Subject: Re: [External] [PATCH v3] kexec: Enable CMA based contiguous
 allocation
Message-ID: <aC2rNv49pzy1Wh3D@MiWiFi-R3L-srv>
References: <20250513180229.7494-1-graf@amazon.com>
 <CACSyD1OU1zjvc2YdQpi-F_qZ0EWyb6jLNODJkRDPQa6m1eObJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1OU1zjvc2YdQpi-F_qZ0EWyb6jLNODJkRDPQa6m1eObJg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_033027_822758_BD3B6261 
X-CRM114-Status: GOOD (  24.18  )
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

On 05/21/25 at 03:47pm, Zhongkun He wrote:
> On Wed, May 14, 2025 at 2:40 AM Alexander Graf <graf@amazon.com> wrote:
......
> >  /**
> >   * kexec_locate_mem_hole - find free memory for the purgatory or the next kernel
> >   * @kbuf:      Parameters for the memory search.
> > @@ -648,6 +684,13 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> >         if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
> >                 return 0;
> >
> > +       /*
> > +        * Try to find a free physically contiguous block of memory first. With that, we
> > +        * can avoid any copying at kexec time.
> > +        */
> > +       if (!kexec_alloc_contig(kbuf))
> > +               return 0;
> 
> IIUC, The kexec_locate_mem_hole() function is also used in
> the KEXEC_TYPE_CRASH kimage, but kexec_alloc_contig() does not skip it.
> This can cause kdump to fail and lead to CMA memory leakage.

That is true and good catch, and fix is needed to skip cma alloc for
kdump.

> 
> So I ran some tests, as listed below:
> The CMA memory decreases with each execution of the kdump-config
> reload operation.
> 
> /home/hezhongkun.hzk# kdump-config reload
> unloaded kdump kernel.
> Creating symlink /var/lib/kdump/vmlinuz.
> Creating symlink /var/lib/kdump/initrd.img.
> kexec_file_load failed: Cannot assign requested address
> failed to load kdump kernel ... failed!
> 
> [ 1387.536346] kexec_file: allocated 1817 DMA pages at 0x11b16e
> [ 1399.147677] kexec_file: allocated 113 DMA pages at 0x119087
> [ 1399.148915] kexec_file: allocated 5 DMA pages at 0x1140f8
> [ 1399.150266] kexec_file: allocated 2 DMA pages at 0x1118fd
> [ 1399.151474] kexec_file: allocated 8302 DMA pages at 0x11b900
> 
> /home/hezhongkun.hzk# cat /proc/meminfo | grep Cma
> CmaTotal:        1048576 kB
> CmaFree:          679972 kB
> /home/hezhongkun.hzk# cat /proc/meminfo | grep Cma
> CmaTotal:        1048576 kB
> CmaFree:          639016 kB
> /home/hezhongkun.hzk# cat /proc/meminfo | grep Cma
> CmaTotal:        1048576 kB
> CmaFree:          557104 kB
> 
> cat /proc/meminfo | grep Cma
> CmaTotal:        1048576 kB
> CmaFree:          557104 kB
> 
> > +
> >         if (!IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
> >                 ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
> >         else
> > @@ -693,6 +736,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
> >         /* Ensure minimum alignment needed for segments. */
> >         kbuf->memsz = ALIGN(kbuf->memsz, PAGE_SIZE);
> >         kbuf->buf_align = max(kbuf->buf_align, PAGE_SIZE);
> > +       kbuf->cma = NULL;
> >
> >         /* Walk the RAM ranges and allocate a suitable range for the buffer */
> >         ret = arch_kexec_locate_mem_hole(kbuf);
> > @@ -705,6 +749,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
> >         ksegment->bufsz = kbuf->bufsz;
> >         ksegment->mem = kbuf->mem;
> >         ksegment->memsz = kbuf->memsz;
> > +       kbuf->image->segment_cma[kbuf->image->nr_segments] = kbuf->cma;
> >         kbuf->image->nr_segments++;
> >         return 0;
> >  }
> > diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> > index d35d9792402d..29e6cebe0c43 100644
> > --- a/kernel/kexec_internal.h
> > +++ b/kernel/kexec_internal.h
> > @@ -10,7 +10,7 @@ struct kimage *do_kimage_alloc_init(void);
> >  int sanity_check_segment_list(struct kimage *image);
> >  void kimage_free_page_list(struct list_head *list);
> >  void kimage_free(struct kimage *image);
> > -int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
> > +int kimage_load_segment(struct kimage *image, int idx);
> >  void kimage_terminate(struct kimage *image);
> >  int kimage_is_destination_range(struct kimage *image,
> >                                 unsigned long start, unsigned long end);
> > --
> > 2.34.1
> >
> >
> >
> >
> > Amazon Web Services Development Center Germany GmbH
> > Tamara-Danz-Str. 13
> > 10243 Berlin
> > Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> > Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> > Sitz: Berlin
> > Ust-ID: DE 365 538 597
> >
> >
> 



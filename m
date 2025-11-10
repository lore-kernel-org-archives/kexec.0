Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5C2CCF9E3
	for <kexec@archiver.kernel.org>; Mon, 10 Nov 2025 07:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQeFfemk8R9pFVPJVE7vGo0yI2GmBM6W7T4hZkmc8fU=; b=cWcZVet1oZP+FaNVe2u8Scd2x5
	mOj/wsUKZnmqI4xH3FRzY7D0baXORJBqNAYSWLLgwHoCp5tF8vu7MqCPs5glYyndDNbyJGp2aao5/
	5V5NOa9uAKRdHG1GyhQsgYMEbQ02hwxSa7tvq/5MPLq3HoVil3rsSuYu3JZe6XuEXICR7/OAcix0F
	VI3pADuvrCQrBe+YJzrcdYWUUISOEOvst8aD24V4sZ9B+rIIFh6X9jKCKjTEkafHzpC5Im8p3pQ7N
	kIfgvNjdwguEuEM2Bl9/Xn1wJ2yYPdsMlZNYucvVi97NNoZ5gNxKgdzyb8ysrN2wbiXNb9UHmcGj/
	ZqjTpV9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIM1P-00000004sX6-1ddT;
	Mon, 10 Nov 2025 07:09:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIM1L-00000004sVp-0T1l
	for kexec@lists.infradead.org;
	Mon, 10 Nov 2025 07:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762758536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQeFfemk8R9pFVPJVE7vGo0yI2GmBM6W7T4hZkmc8fU=;
	b=f/rZ/COQx53+jEPS0DMLIJs01tNJZU+sHaEu1MUyj3DEFLSqcPR5VP4qI4HIOsem5Bk4tR
	fdor4GUMCE8jdBNqbjvyljLgMrXnwK1H0NBLRCjpuwnZkI2pZrUxAsH6RbXNPnoFloeRNC
	TJXAqxJBX5E/VXOcxSdto4VeJnljO5o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-eeRdVSlDPZqYg8Icnng9Iw-1; Mon,
 10 Nov 2025 02:08:53 -0500
X-MC-Unique: eeRdVSlDPZqYg8Icnng9Iw-1
X-Mimecast-MFC-AGG-ID: eeRdVSlDPZqYg8Icnng9Iw_1762758531
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65A95195608F;
	Mon, 10 Nov 2025 07:08:50 +0000 (UTC)
Received: from localhost (unknown [10.72.112.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B262E19560A7;
	Mon, 10 Nov 2025 07:08:47 +0000 (UTC)
Date: Mon, 10 Nov 2025 15:08:41 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Aditya Gupta <adityag@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>, Jiri Bohac <jbohac@suse.cz>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v3 5/5] crash: export crashkernel CMA reservation to
 userspace
Message-ID: <aRGPee9izxWPRHj5@MiWiFi-R3L-srv>
References: <20251110043143.484408-1-sourabhjain@linux.ibm.com>
 <20251110043143.484408-6-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110043143.484408-6-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251109_230859_221170_8F0D39F6 
X-CRM114-Status: GOOD (  25.46  )
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

On 11/10/25 at 10:01am, Sourabh Jain wrote:
> Add a sysfs entry /sys/kernel/kexec/crash_cma_ranges to expose all
> CMA crashkernel ranges.

I am not against this way. While wondering if it's more appropriate to
export them into iomem_resource just like crashk_res and crashk_low_res
doing.

> 
> This allows userspace tools configuring kdump to determine how much
> memory is reserved for crashkernel. If CMA is used, tools can warn
> users when attempting to capture user pages with CMA reservation.
> 
> The new sysfs hold the CMA ranges in below format:
> 
> cat /sys/kernel/kexec/crash_cma_ranges
> 100000000-10c7fffff
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Pingfan Liu <piliu@redhat.com>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
>  - Add the missing hunk to export crash_cma_ranges sysfs
> 
> ---
>  .../ABI/testing/sysfs-kernel-kexec-kdump        | 10 ++++++++++
>  kernel/kexec_core.c                             | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> index 00c00f380fea..f59051b5d96d 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> +++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> @@ -49,3 +49,13 @@ Description:	read only
>  		is used by the user space utility kexec to support updating the
>  		in-kernel kdump image during hotplug operations.
>  User:		Kexec tools
> +
> +What:		/sys/kernel/kexec/crash_cma_ranges
> +Date:		Nov 2025
> +Contact:	kexec@lists.infradead.org
> +Description:	read only
> +		Provides information about the memory ranges reserved from
> +		the Contiguous Memory Allocator (CMA) area that are allocated
> +		to the crash (kdump) kernel. It lists the start and end physical
> +		addresses of CMA regions assigned for crashkernel use.
> +User:		kdump service
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 7476a46de5d6..da6ff72b4669 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1271,6 +1271,22 @@ static ssize_t crash_size_store(struct kobject *kobj,
>  }
>  static struct kobj_attribute crash_size_attr = __ATTR_RW(crash_size);
>  
> +static ssize_t crash_cma_ranges_show(struct kobject *kobj,
> +				     struct kobj_attribute *attr, char *buf)
> +{
> +
> +	ssize_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < crashk_cma_cnt; ++i) {
> +		len += sysfs_emit_at(buf, len, "%08llx-%08llx\n",
> +				     crashk_cma_ranges[i].start,
> +				     crashk_cma_ranges[i].end);
> +	}
> +	return len;
> +}
> +static struct kobj_attribute crash_cma_ranges_attr = __ATTR_RO(crash_cma_ranges);
> +
>  #ifdef CONFIG_CRASH_HOTPLUG
>  static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
>  			       struct kobj_attribute *attr, char *buf)
> @@ -1289,6 +1305,7 @@ static struct attribute *kexec_attrs[] = {
>  #ifdef CONFIG_CRASH_DUMP
>  	&crash_loaded_attr.attr,
>  	&crash_size_attr.attr,
> +	&crash_cma_ranges_attr.attr,
>  #ifdef CONFIG_CRASH_HOTPLUG
>  	&crash_elfcorehdr_size_attr.attr,
>  #endif
> -- 
> 2.51.1
> 



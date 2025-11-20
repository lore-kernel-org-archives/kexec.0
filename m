Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFE4CF857D
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 09:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvIUpsoLZ7xdtMtpTpJeKuy6wYQI8+9FP33pXkKgVbw=; b=1Qb25hTmd5PxnMqHzpZKZaiuJM
	31pefNVLuPOiQVNMYAp/LCXYOrlLhPYLaoS5pf8FhriHHk2IF+TEUfT6ko5zsr9bdN0w/cU+KQUtg
	BJlT0IZFO43eNSXMG0Zg0EkI3D49H2K1vcf+UXoRMDvjmItCPX6YbJtXIrd4dy1RSHrVRYKaaDvln
	JqA7hxv1xo/S0bkpV9+14vHuynUK81sBZMX0eB1VDRnrCvotXOY36Zhg6lAinqn6DQjm66sDPAwm2
	ln2Q/MWDMPQqbAMX63oleODKYEFS6orh/1UUvJezRcPUUFDn/06/Q0O5l/xAajMU2vA5+Z+/4GCVz
	s2yWk9Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM1Rd-00000006T7J-46fg;
	Thu, 20 Nov 2025 09:59:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM1Ra-00000006T6s-0xCM
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 09:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763632751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvIUpsoLZ7xdtMtpTpJeKuy6wYQI8+9FP33pXkKgVbw=;
	b=gghxkviyH5lNcThMOmC5nmKphAl0dbUI0ve0grgC5F/YdWbcAajEDzWda4LnjnX5atshA9
	d/C9YB8C0yiM7OqPTA3hg1R6vh5B32hfr4bctBGWjijRQ+zVzfTyk7ryPBZ4Gyd6tDHYiZ
	9wdMvHUNLz8UHaYg6NpxVryfs7yW0gY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-Yej5Cc9sP6qjJ7YJ90kSXA-1; Thu,
 20 Nov 2025 04:59:07 -0500
X-MC-Unique: Yej5Cc9sP6qjJ7YJ90kSXA-1
X-Mimecast-MFC-AGG-ID: Yej5Cc9sP6qjJ7YJ90kSXA_1763632746
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 666E01956094;
	Thu, 20 Nov 2025 09:59:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99C6230044DB;
	Thu, 20 Nov 2025 09:59:01 +0000 (UTC)
Date: Thu, 20 Nov 2025 17:58:56 +0800
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
Subject: Re: [PATCH v6] crash: export crashkernel CMA reservation to userspace
Message-ID: <aR7mYAIBI1zYJ3rg@MiWiFi-R3L-srv>
References: <20251118071023.1673329-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118071023.1673329-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_015914_340245_C5573A1B 
X-CRM114-Status: GOOD (  29.89  )
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

On 11/18/25 at 12:40pm, Sourabh Jain wrote:
> Add a sysfs entry /sys/kernel/kexec_crash_cma_ranges to expose all
> CMA crashkernel ranges.
> 
> This allows userspace tools configuring kdump to determine how much
> memory is reserved for crashkernel. If CMA is used, tools can warn
> users when attempting to capture user pages with CMA reservation.
> 
> The new sysfs hold the CMA ranges in below format:
> 
> cat /sys/kernel/kexec_crash_cma_ranges
> 100000000-10c7fffff
> 
> The reason for not including Crash CMA Ranges in /proc/iomem is to avoid
> conflicts. It has been observed that contiguous memory ranges are sometimes
> shown as two separate System RAM entries in /proc/iomem. If a CMA range
> overlaps two System RAM ranges, adding crashk_res to /proc/iomem can create
> a conflict. Reference [1] describes one such instance on the PowerPC
> architecture.
> 
> Link: https://lore.kernel.org/all/20251016142831.144515-1-sourabhjain@linux.ibm.com/ [1]
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
> 
> Changelog:
> 
> v4 -> v5:
>  https://lore.kernel.org/all/20251114152550.ac2dd5e23542f09c62defec7@linux-foundation.org/
>  - Splitted patch from the above patch series.
>  - Code to create kexec node under /sys/kernel is added, eariler it was
>    done in [02/05] of the above patch series.
> 
> v5 -> v6:
>  - Add Crash CMA Range sysfs interface under /sys/kernel
> 
> Note:
> This patch is dependent on the below patch:
> https://lore.kernel.org/all/20251117035153.1199665-1-sourabhjain@linux.ibm.com/
> 
> ---
>  .../ABI/testing/sysfs-kernel-kexec-kdump      | 10 +++++++++
>  kernel/ksysfs.c                               | 21 +++++++++++++++++++
>  2 files changed, 31 insertions(+)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> index 96b24565b68e..f6089e38de5f 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> +++ b/Documentation/ABI/testing/sysfs-kernel-kexec-kdump
> @@ -41,3 +41,13 @@ Description:	read only
>  		is used by the user space utility kexec to support updating the
>  		in-kernel kdump image during hotplug operations.
>  User:		Kexec tools
> +
> +What:		/sys/kernel/kexec_crash_cma_ranges
> +Date:		Nov 2025
> +Contact:	kexec@lists.infradead.org
> +Description:	read only
> +		Provides information about the memory ranges reserved from
> +		the Contiguous Memory Allocator (CMA) area that are allocated
> +		to the crash (kdump) kernel. It lists the start and end physical
> +		addresses of CMA regions assigned for crashkernel use.
> +User:		kdump service
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index eefb67d9883c..0ff2179bc603 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -135,6 +135,24 @@ static ssize_t kexec_crash_loaded_show(struct kobject *kobj,
>  }
>  KERNEL_ATTR_RO(kexec_crash_loaded);
>  
> +#ifdef CONFIG_CRASH_RESERVE
> +static ssize_t kexec_crash_cma_ranges_show(struct kobject *kobj,
> +				    struct kobj_attribute *attr, char *buf)
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
> +KERNEL_ATTR_RO(kexec_crash_cma_ranges);
> +#endif /* CONFIG_CRASH_RESERVE */
> +
>  static ssize_t kexec_crash_size_show(struct kobject *kobj,
>  				       struct kobj_attribute *attr, char *buf)
>  {
> @@ -260,6 +278,9 @@ static struct attribute * kernel_attrs[] = {
>  #ifdef CONFIG_CRASH_DUMP
>  	&kexec_crash_loaded_attr.attr,
>  	&kexec_crash_size_attr.attr,
> +#ifdef CONFIG_CRASH_RESERVE
> +	&kexec_crash_cma_ranges_attr.attr,
> +#endif
>  #endif
>  #endif
>  #ifdef CONFIG_VMCORE_INFO
> -- 
> 2.51.1
> 



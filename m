Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F8ED73E86
	for <kexec@archiver.kernel.org>; Fri, 30 Jan 2026 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Upt8qGT6DRoB1WlixiUcm116BMhY/lFaYw+vAb5KVA=; b=UTfr6KLOYz2+oYiV9lo/Ubch1j
	h2LITQjREQ6ASOl7XOT8x5uKN02oq+3x1sOxXuKSGXsPC5sebjyycar4YCoRXLd+JjouwiurkgjqQ
	wb2apjTAAzYQtF0+rn1kzJuZYBOgj1YZ3PoZ3o6IaDcdGUNO0usVncd3VtDzpxh0KvKEXxZkwi2Ym
	tTrvD70sCcazXjFBPmDK+V/AvYke6rwJBdpSuTNgwK14ZDpWsOv/FtsWLsjrilD1roWlFiRMViz7w
	hW4YZlwFPoboEKvoW1/2A0VmzaN38qbOtJlcpgs7WgHGQ2Uh8x8K3i5wkYvlmsebqAeF3mQfkiRVs
	7PbpybDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vldoA-00000000sWY-1V9c;
	Fri, 30 Jan 2026 02:00:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vldo6-00000000sVl-3zeA
	for kexec@lists.infradead.org;
	Fri, 30 Jan 2026 02:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769738420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Upt8qGT6DRoB1WlixiUcm116BMhY/lFaYw+vAb5KVA=;
	b=Ig5gtvhjfu+lJ7zEnnXEazDQSXO67ahhFYmfXsHtbYImBh+XbmiIBQLVxdE74mBzV5B9ex
	WOnZ3ebyS9Ve9oCQcb5piF4MJurlc8WmPB2D5zywX8ViTq6GwRIQ/TJvbxzmzVgTbE45O0
	lY6WEs2g/E2EpwAEU3xLmVHF7l0ebOw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-E3KnMXnaNlmyYXYZVeQpYA-1; Thu,
 29 Jan 2026 21:00:14 -0500
X-MC-Unique: E3KnMXnaNlmyYXYZVeQpYA-1
X-Mimecast-MFC-AGG-ID: E3KnMXnaNlmyYXYZVeQpYA_1769738412
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B34241956046;
	Fri, 30 Jan 2026 02:00:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.123])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27BEA1956056;
	Fri, 30 Jan 2026 02:00:08 +0000 (UTC)
Date: Fri, 30 Jan 2026 09:59:58 +0800
From: Baoquan He <bhe@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, kexec@lists.infradead.org, dyoung@redhat.com,
	tony.luck@intel.com, xueshuai@linux.alibaba.com, vgoyal@redhat.com,
	zhiquan1.li@intel.com, olja@meta.com
Subject: Re: [PATCH] vmcore_info: expose hardware error recovery statistics
 via sysfs
Message-ID: <aXwQngYZx9Nk7hbv@fedora>
References: <20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-vmcoreinfo_sysfs-v1-1-164c1fe1fe07@debian.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_180023_086339_575476DC 
X-CRM114-Status: GOOD (  29.84  )
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

On 01/29/26 at 05:34am, Breno Leitao wrote:
> Add a sysfs file at /sys/kernel/vmcore_stats and expose hardware error
> recovery statistics that are already tracked by the kernel. This allows
> userspace monitoring tools to track recovered hardware errors without
> requiring kernel crashes.

I don't understand. If w/o requring kernel crashes, why do you call it
vmcore_stats? It's a normal showing of hardware error recovery
statistics tracked by kernel, can we name it /sys/kernel/hwerr_stats?
It's obviously having nothiing to do with vmcore, isn't it?

> 
> This is useful to track recoverable hardware errors in a time series,
> even if the host doesn't crash.
> 
> Create a generic vmcore_stats sysfs, and add a section for
> hwerr_recovery that shows the counts per subsystem and timestamps:
> 
>   - cpu: CPU-related errors (MCE, ARM processor errors)
>   - memory: Memory-related errors
>   - pci: PCI/PCIe AER non-fatal errors
>   - cxl: CXL errors
>   - other: Other hardware errors
> 
> Example output:
>   hwerr_recovery:
>     cpu: 0 (0)
>     memory: 2 (1738148257)
>     pci: 1 (1738147000)
>     cxl: 0 (0)
>     other: 0 (0)
> 
> The value in parentheses is the timestamp (seconds since epoch) of the
> last error of that type, or 0 if no errors have occurred.
> 
> These statistics provide visibility into the health of the system's
> hardware and can be used by system administrators to proactively detect
> failing components before they cause system crashes.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> To: akpm@linux-foundation.org
> Cc: kexec@lists.infradead.org
> To: bhe@redhat.com
> Cc: linux-kernel@vger.kernel.org
> Cc: dyoung@redhat.com
> Cc: tony.luck@intel.com
> Cc: xueshuai@linux.alibaba.com
> Cc: vgoyal@redhat.com
> Cc: zhiquan1.li@intel.com
> Cc: olja@meta.com
> ---
>  .../ABI/testing/sysfs-kernel-vmcore_stats          | 23 ++++++++++++++++
>  kernel/vmcore_info.c                               | 31 ++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-vmcore_stats b/Documentation/ABI/testing/sysfs-kernel-vmcore_stats
> new file mode 100644
> index 0000000000000..b42f18d24c00b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-vmcore_stats
> @@ -0,0 +1,23 @@
> +What:		/sys/kernel/vmcore_stats
> +Date:		January 2026
> +KernelVersion:	6.20
> +Contact:	Breno Leitao <leitao@debian.org>
> +Description:
> +		Shows statistics related to vmcore functionality. Currently
> +		includes hardware error recovery statistics.
> +
> +		Format:
> +		  Recovered hardware errors:
> +		    metric: count (timestamp)
> +
> +		Statistics about recoverable hardware errors that the kernel
> +		has handled since boot. Each metric shows the count and
> +		timestamp (seconds since epoch) of the last error in
> +		parentheses (0 if no errors have occurred).
> +
> +		Metrics:
> +		    - cpu: CPU-related errors (MCE, ARM processor errors)
> +		    - memory: Memory-related errors
> +		    - pci: PCI/PCIe AER non-fatal errors
> +		    - cxl: CXL (Compute Express Link) errors
> +		    - other: Other hardware errors
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index fe9bf8db1922e..5974b4be08cbc 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c
> @@ -6,6 +6,8 @@
>  
>  #include <linux/buildid.h>
>  #include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> @@ -135,6 +137,31 @@ void hwerr_log_error_type(enum hwerr_error_type src)
>  }
>  EXPORT_SYMBOL_GPL(hwerr_log_error_type);
>  
> +/* sysfs interface for hardware error recovery statistics */
> +static ssize_t vmcore_stats_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf,
> +			  "Recovered hardware errors:\n"
> +			  "  cpu: %d (%lld)\n"
> +			  "  memory: %d (%lld)\n"
> +			  "  pci: %d (%lld)\n"
> +			  "  cxl: %d (%lld)\n"
> +			  "  other: %d (%lld)\n",
> +			  atomic_read(&hwerr_data[HWERR_RECOV_CPU].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_CPU].timestamp),
> +			  atomic_read(&hwerr_data[HWERR_RECOV_MEMORY].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_MEMORY].timestamp),
> +			  atomic_read(&hwerr_data[HWERR_RECOV_PCI].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_PCI].timestamp),
> +			  atomic_read(&hwerr_data[HWERR_RECOV_CXL].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_CXL].timestamp),
> +			  atomic_read(&hwerr_data[HWERR_RECOV_OTHERS].count),
> +			  (long long)READ_ONCE(hwerr_data[HWERR_RECOV_OTHERS].timestamp));
> +}
> +
> +static struct kobj_attribute vmcore_stats_attr = __ATTR_RO(vmcore_stats);
> +
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
>  	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
> @@ -244,6 +271,10 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	arch_crash_save_vmcoreinfo();
>  	update_vmcoreinfo_note();
>  
> +	/* Create /sys/kernel/vmcore_stats */
> +	if (sysfs_create_file(kernel_kobj, &vmcore_stats_attr.attr))
> +		pr_warn("Failed to create vmcore_stats sysfs file\n");
> +
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
> change-id: 20260129-vmcoreinfo_sysfs-ff4687979cd5
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DE6EB594D
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 02:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0WoVHm/wpm3VeRQ1Osn5LCFxSpKgojYv3/htjRdiuo=; b=fuBEoMPOSYIU98k6RFbDVzLD8m
	ybUDRBHzcgrrSApqrvKamYeWl/aBY4mEJsei3kC1K3e/tKG9f0ILLb8sQBl1s1lGMZtBMcQaeg0EM
	T/bRphHZCwpkl/C8wNJp6ENk16lepRp4GSUlFcT8k40+HS/CfLFwvcYB3L+MV2s+rAnbTzZSR3kPK
	KSLz41MWw6zJfZaII7gb4ynKib8yY1AguVakWav64RqBSi8LXNQsS3ot+Vfjosla60NWU3Pjer3Vg
	F89FdW9xEd0Huna1pLO5yw8rU37h5VJwDMe7myB1EbkWcsbOhhu1b8y9MCT7wLYqrS1LfF63zIUhm
	t9aB6KQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzXf-000000007Bz-1Lsl;
	Wed, 11 Feb 2026 02:01:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpzXc-000000007BA-0p7U
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 02:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770775278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l0WoVHm/wpm3VeRQ1Osn5LCFxSpKgojYv3/htjRdiuo=;
	b=L3gzn5vJ9RJZMN6asM/LCDHqTt8c2KcyKc/cew4vF+GsvKy2CiLRGHgLyBiMrbXrqeNG7q
	+CFZbS5D3VaguvqbzUUy9yntNMUXnCPC7DqUxRB2ies+KXQLLAAOw3qeawls9vPtKXXCWr
	Uh5+erv6zED0UGpZ995Egeyn80Tq99o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-YPSwdpkMMt-d41HpU6MD2g-1; Tue,
 10 Feb 2026 21:01:15 -0500
X-MC-Unique: YPSwdpkMMt-d41HpU6MD2g-1
X-Mimecast-MFC-AGG-ID: YPSwdpkMMt-d41HpU6MD2g_1770775274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 455D418003F5;
	Wed, 11 Feb 2026 02:01:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.131])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18F421800464;
	Wed, 11 Feb 2026 02:01:09 +0000 (UTC)
Date: Wed, 11 Feb 2026 10:01:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, dyoung@redhat.com, tony.luck@intel.com,
	xueshuai@linux.alibaba.com, vgoyal@redhat.com,
	zhiquan1.li@intel.com, olja@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Message-ID: <aYvi4Y_HNqk_u1-v@fedora>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
 <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
MIME-Version: 1.0
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 6846ZdDbJdG0Vtz4_rpKflUXdUGK__2D6feGsw58NcU_1770775274
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_180120_312137_04900050 
X-CRM114-Status: GOOD (  26.57  )
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

Hi Breno,

On 02/02/26 at 06:27am, Breno Leitao wrote:
> Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
> hardware error recovery statistics that are already tracked by the
> kernel. This allows userspace monitoring tools to track recovered
> hardware errors without requiring kernel crashes.
> 
> This is useful to track recoverable hardware errors in a time series,
> even if the host doesn't crash.
> 
> The sysfs directory contains one file per error subsystem:
> 
>   /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
>   /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
>   /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
>   /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
>   /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors
> 
> Each file contains a single integer representing the count of recovered
> errors for that subsystem.
> 
> These statistics provide visibility into the health of the system's
> hardware and can be used by system administrators to proactively detect
> failing components before they cause system crashes.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
> index e2784038bbed7..b7fcd21be7c59 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c

Since we agreed hwerr_recovery_stats has nothing to do with vmcore, it
seems inappropriate to put its sysfs handling code in
kernel/vmcore_info.c. File kernel/vmcore_info.c is only used to build
vmcore info for later vmcore dumping. And hwerr_log_error_type() should
not be put in kernel/vmcore_info.c. either. I didn't check this
carefully before, sorry. Please reconsider if these can be handled better.

Thanks
Baoquan

> @@ -6,6 +6,8 @@
>  
>  #include <linux/buildid.h>
>  #include <linux/init.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> @@ -139,6 +141,56 @@ void hwerr_log_error_type(enum hwerr_error_type src)
>  }
>  EXPORT_SYMBOL_GPL(hwerr_log_error_type);
>  
> +/* sysfs interface for hardware error recovery statistics */
> +#define HWERR_ATTR_RO(_name, _type)					\
> +static ssize_t _name##_show(struct kobject *kobj,			\
> +			    struct kobj_attribute *attr, char *buf)	\
> +{									\
> +	return sysfs_emit(buf, "%d\n",					\
> +			  atomic_read(&hwerr_data[_type].count));	\
> +}									\
> +static struct kobj_attribute hwerr_##_name##_attr = __ATTR_RO(_name)
> +
> +HWERR_ATTR_RO(cpu, HWERR_RECOV_CPU);
> +HWERR_ATTR_RO(memory, HWERR_RECOV_MEMORY);
> +HWERR_ATTR_RO(pci, HWERR_RECOV_PCI);
> +HWERR_ATTR_RO(cxl, HWERR_RECOV_CXL);
> +HWERR_ATTR_RO(others, HWERR_RECOV_OTHERS);
> +
> +static struct attribute *hwerr_recovery_stats_attrs[] = {
> +	&hwerr_cpu_attr.attr,
> +	&hwerr_memory_attr.attr,
> +	&hwerr_pci_attr.attr,
> +	&hwerr_cxl_attr.attr,
> +	&hwerr_others_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group hwerr_recovery_stats_group = {
> +	.attrs = hwerr_recovery_stats_attrs,
> +};
> +
> +static struct kobject *hwerr_recovery_stats_kobj;
> +
> +static int __init hwerr_recovery_stats_init(void)
> +{
> +	hwerr_recovery_stats_kobj = kobject_create_and_add("hwerr_recovery_stats",
> +							   kernel_kobj);
> +	if (!hwerr_recovery_stats_kobj) {
> +		pr_warn("Failed to create hwerr_recovery_stats kobject\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (sysfs_create_group(hwerr_recovery_stats_kobj,
> +			       &hwerr_recovery_stats_group)) {
> +		kobject_put(hwerr_recovery_stats_kobj);
> +		pr_warn("Failed to create hwerr_recovery_stats sysfs group\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
>  	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
> @@ -248,6 +300,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	arch_crash_save_vmcoreinfo();
>  	update_vmcoreinfo_note();
>  
> +	/* Create /sys/kernel/hwerr_recovery_stats/ directory */
> +	hwerr_recovery_stats_init();
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.47.3
> 



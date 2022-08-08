Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4665EC00140
	for <kexec@archiver.kernel.org>; Mon,  8 Aug 2022 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SiDPq+GnQWWgy1cvac0WN2tz8o/DQ52nOWEZUi2VTnQ=; b=GXBu61nsy9c3++
	7v4P81LASNQaxrrwMnpeLVOTA8ew2h1oQfNIThGIIb5fYVJWMysjhBjGvg4fHtPLOQVBKhfLUl6Gr
	dr7Wdam+qW59gxxfHjL9B/yQfSO0fRMSL0cTlx4tupYA46o0/r4d5fqUqVhFxR9htRnH+t95uGOOe
	VO0CIv/ZOylL/TISidN8gV0MFuX7AiKTiMq/+rwDDQUDkvxiJa1cVc5myWBSq4nPnTorrFwcdGto9
	bV3YqM5wDHqqIohJLMa+uqQBLzrkbhtICaDO46YD0Pq9NMLGb4m+oi5iLF9Hgm8Brpjb/cuh0mZ9X
	ZkUrelcolIeOwnwxMbxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL0CB-00CzXA-TM; Mon, 08 Aug 2022 10:41:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oL0C7-00CzUR-UY
	for kexec@lists.infradead.org; Mon, 08 Aug 2022 10:41:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659955270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJLPOegk0UFvhgGoFsMnh0SPzQgLjSOmQFmdJ12d4pE=;
	b=UWkddwi3Zq/XNfSa+xv85keVZrx1gdpiiNkTXd6rV+wArpBrTaHBcs9b0DVf+v0zSXIUo4
	WEQijwXliacx4ObLjNbT5mXUNcONOTVx7XnE/DbzU9YqFksHL1aYHVKPhkNzOOOJv4esI+
	FU2WOzxnBJCwXEn4EbDNQddw/ZUeNE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-Nc3ZIis2O86ADhrOetFMjw-1; Mon, 08 Aug 2022 06:41:07 -0400
X-MC-Unique: Nc3ZIis2O86ADhrOetFMjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4192A8041B5;
	Mon,  8 Aug 2022 10:41:06 +0000 (UTC)
Received: from localhost (ovpn-12-221.pek2.redhat.com [10.72.12.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 380041121314;
	Mon,  8 Aug 2022 10:41:04 +0000 (UTC)
Date: Mon, 8 Aug 2022 18:41:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v10 7/8] crash: memory and cpu hotplug sysfs attributes
Message-ID: <YvDoPTSkYo6dg+Di@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220721181747.1640-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220808_034112_111979_880EB44D 
X-CRM114-Status: GOOD (  37.44  )
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

On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> This introduces the crash_hotplug attribute for memory and CPUs
> for use by userspace.  This change directly facilitates the udev
> rule for managing userspace re-loading of the crash kernel upon
> hot un/plug changes.
> 
> For memory, this changeset introduces the crash_hotplug attribute
> to the /sys/devices/system/memory directory. For example:
> 
>  # udevadm info --attribute-walk /sys/devices/system/memory/memory81
>   looking at device '/devices/system/memory/memory81':
>     KERNEL=="memory81"
>     SUBSYSTEM=="memory"
>     DRIVER==""
>     ATTR{online}=="1"
>     ATTR{phys_device}=="0"
>     ATTR{phys_index}=="00000051"
>     ATTR{removable}=="1"
>     ATTR{state}=="online"
>     ATTR{valid_zones}=="Movable"
> 
>   looking at parent device '/devices/system/memory':
>     KERNELS=="memory"
>     SUBSYSTEMS==""
>     DRIVERS==""
>     ATTRS{auto_online_blocks}=="offline"
>     ATTRS{block_size_bytes}=="8000000"
>     ATTRS{crash_hotplug}=="1"
> 
> For CPUs, this changeset introduces the crash_hotplug attribute
> to the /sys/devices/system/cpu directory. For example:
> 
>  # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
>   looking at device '/devices/system/cpu/cpu0':
>     KERNEL=="cpu0"
>     SUBSYSTEM=="cpu"
>     DRIVER=="processor"
>     ATTR{crash_notes}=="277c38600"
>     ATTR{crash_notes_size}=="368"
>     ATTR{online}=="1"
> 
>   looking at parent device '/devices/system/cpu':
>     KERNELS=="cpu"
>     SUBSYSTEMS==""
>     DRIVERS==""
>     ATTRS{crash_hotplug}=="1"
>     ATTRS{isolated}==""
>     ATTRS{kernel_max}=="8191"
>     ATTRS{nohz_full}=="  (null)"
>     ATTRS{offline}=="4-7"
>     ATTRS{online}=="0-3"
>     ATTRS{possible}=="0-7"
>     ATTRS{present}=="0-3"
> 
> With these sysfs attributes in place, it is possible to efficiently
> instruct the udev rule to skip crash kernel reloading.
> 
> For example, the following is the proposed udev rule change for RHEL
> system 98-kexec.rules (as the first lines of the rule file):
> 
>  # The kernel handles updates to crash elfcorehdr for cpu and memory changes
>  SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>  SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
> When examined in the context of 98-kexec.rules, the above change
> tests if crash_hotplug is set, and if so, it skips the userspace
> initiated unload-then-reload of the crash kernel.
> 
> Cpu and memory checks are separated in accordance with
> CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
> If an architecture supports, for example, memory hotplug but not
> CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
> attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
> attribute file will NOT be present. Thus the udev rule will skip
> userspace processing of memory hot un/plug events, but the udev
> rule will fail for CPU events, thus allowing userspace to process
> cpu hot un/plug events (ie the unload-then-reload of the kdump
> capture kernel).
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>  Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>  drivers/base/cpu.c                             | 14 ++++++++++++++
>  drivers/base/memory.c                          | 13 +++++++++++++
>  include/linux/crash_core.h                     |  6 ++++++
>  5 files changed, 59 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 0f56ecd8ac05..494d7a63c543 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -293,6 +293,14 @@ The following files are currently defined:
>  		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>  		       kernel configuration option.
>  ``uevent``	       read-write: generic udev file for device subsystems.
> +``crash_hotplug``      read-only: when changes to the system memory map
> +		       occur due to hot un/plug of memory, this file contains
> +		       '1' if the kernel updates the kdump capture kernel memory
> +		       map itself (via elfcorehdr), or '0' if userspace must update
> +		       the kdump capture kernel memory map.
> +
> +		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
> +		       configuration option.
>  ====================== =========================================================
>  
>  .. note::
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index c6f4ba2fb32d..13e33d098645 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -750,6 +750,24 @@ will receive all events. A script like::
>  
>  can process the event further.
>  
> +When changes to the CPUs in the system occur, the sysfs file
> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
> +or '0' if userspace must update the kdump capture kernel list of CPUs.
> +
> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
> +option.
> +
> +To skip userspace processing of CPU hot un/plug events for kdump
> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
> +file can be used in a udev rule as follows:
> +
> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> +
> +For a cpu hot un/plug event, if the architecture supports kernel updates
> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
> +the unload-then-reload of the kdump capture kernel.
> +
>  Kernel Inline Documentations Reference
>  ======================================
>  
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 4c98849577d4..bd470236d9a2 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
>  static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>  #endif
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +#include <linux/crash_core.h>
> +static ssize_t crash_hotplug_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
> +}
> +static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +#endif
> +
>  static void cpu_device_release(struct device *dev)
>  {
>  	/*
> @@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
>  #ifdef CONFIG_NO_HZ_FULL
>  	&dev_attr_nohz_full.attr,
>  #endif
> +#ifdef CONFIG_HOTPLUG_CPU
> +	&dev_attr_crash_hotplug.attr,
> +#endif
>  #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>  	&dev_attr_modalias.attr,
>  #endif
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index bc60c9cd3230..63c1754a52b6 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(auto_online_blocks);
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +#include <linux/crash_core.h>
> +static ssize_t crash_hotplug_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
> +}
> +static DEVICE_ATTR_RO(crash_hotplug);
> +#endif
> +
>  /*
>   * Some architectures will have custom drivers to do this, and
>   * will not need to do it from userspace.  The fake hot-add code
> @@ -887,6 +897,9 @@ static struct attribute *memory_root_attrs[] = {
>  
>  	&dev_attr_block_size_bytes.attr,
>  	&dev_attr_auto_online_blocks.attr,
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +	&dev_attr_crash_hotplug.attr,
> +#endif
>  	NULL
>  };
>  
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index c9705b6872e7..3964e9924ea5 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -109,5 +109,11 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image,
>  {
>  }
>  #endif
> +#ifndef crash_hotplug_cpu_support
> +static inline int crash_hotplug_cpu_support(void) { return 0; }
> +#endif
> +#ifndef crash_hotplug_memory_support
> +static inline int crash_hotplug_memory_support(void) { return 0; }
> +#endif
>  
>  #endif /* LINUX_CRASH_CORE_H */
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

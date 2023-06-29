Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAFBEB64D9
	for <kexec@archiver.kernel.org>; Thu, 29 Jun 2023 20:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=luJpEdesbwRNd6H8v8lW0S9oIYA/hSnbsYijEw9ZVq4=; b=3prqZ7d+wjOgIx
	qOC7jl0IY7xfSp8fcpS9TaptWuZuxk7nFH3VuOJlCG2m5UQ28kJhy7f3UQvOwLi6QHv1oGtqtzoEE
	iFNLnzaBeM9F8K5gY35VcNZJIGYIfkSp6jwriJdIEmXhq55cPCpQOUTKOhYxA6DAZYdNBU/PX9cD6
	ApcaYZjMaG0TPAcZQQkHa81ysg0jbGFbMr7ESrPqCu0xXdG3OKqf3gW5iSnntAl2hiEm+jVTPfGlv
	YAQtm8f8zRPL6wmSrBeGNMh7Yf5r0j1jSyKMD4e7Bp4f0k5WrboH0lv7yBbjH/EwoS68VLX+gIx/D
	eQONdbn4Na/1kyWmcmDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEyjP-002AGI-2t;
	Thu, 29 Jun 2023 20:59:11 +0000
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qEyjL-002AFE-2A;
	Thu, 29 Jun 2023 20:59:07 +0000
Message-ID: <c9d4e623-5c8c-885f-4343-980798647a0a@infradead.org>
Date: Thu, 29 Jun 2023 13:59:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
Content-Language: en-US
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 david@redhat.com, osalvador@suse.de, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 bhe@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org
Cc: hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
 akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
 zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
 seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, sourabhjain@linux.ibm.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-7-eric.devolder@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230629192119.6613-7-eric.devolder@oracle.com>
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

Hi--

On 6/29/23 12:21, Eric DeVolder wrote:
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
>  .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
>  .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>  Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>  drivers/base/cpu.c                             | 16 ++++++++++++++--
>  drivers/base/memory.c                          | 13 +++++++++++++
>  include/linux/kexec.h                          |  8 ++++++++
>  7 files changed, 77 insertions(+), 2 deletions(-)
> 

> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 1b02fe5807cc..eb99d79223a3 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -291,6 +291,14 @@ The following files are currently defined:
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

Did you test build the documentation?
It looks to me like the end-of-table '=' signs line needs 3 more === to be long
enough for the text above it.

>  
>  .. note::
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index e6f5bc39cf5c..54581c501562 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -741,6 +741,24 @@ will receive all events. A script like::
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

    i.e.

> +file can be used in a udev rule as follows:
> +
> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> +
> +For a cpu hot un/plug event, if the architecture supports kernel updates

         CPU
for consistency

> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
> +the unload-then-reload of the kdump capture kernel.
> +
>  Kernel Inline Documentations Reference
>  ======================================
>  

Thanks.
-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

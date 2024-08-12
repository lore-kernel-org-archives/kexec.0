Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFBBC3DA7F
	for <kexec@archiver.kernel.org>; Mon, 12 Aug 2024 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2xmzxJ8vyhCS/PRiFh8ueyUBI5z0FJhfNd8Bc1/fPZ4=; b=125XtHylUr2sZC
	/8WVkM253d488TEZQy6TgYXPiSbkGfW2+KHwrGwt6qicNmtfPLlVMTGx5qLmPJvcVYQlx0bOpp+b1
	1adcXjDGvLpDbo26XKtuOjLzKDd7gLx8yVu530VwIl0StQ56FBgivQzKa5/MJt26qHSHPnaHmg2Ic
	P3rXXSVTmoj+6dYcoceOP/RkgkuPMVhusLBpcoo7mfqfrocnfeAq910Fehrr2CGNfp+Ywfmg5yo6n
	kD2RmJSNGzCrC3ftcb9HmWYQ5mSK/Mn82iII1bUPMtTSLh3fpXfaiD99CHLr3KCk7kdHRYTA2s84N
	H/YS6s3gMn0xkbNeQPKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdNou-0000000GwNT-3JW4;
	Mon, 12 Aug 2024 05:42:16 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdNoc-0000000GwJE-0KQZ
	for kexec@lists.infradead.org;
	Mon, 12 Aug 2024 05:41:59 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so4529848a12.2
        for <kexec@lists.infradead.org>; Sun, 11 Aug 2024 22:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723441315; x=1724046115; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6CTGoNaTe2XWjeAV+ihoGUgx18k2VPP6Soz43dQHSQ=;
        b=TSOMUE8rQbZUEhCiJj7DS0k1IEedfU3irYDFwllrtT3nnpNDq0W8dZZUbd0wzso0jI
         e30APwxQRB+L5QGnICrOqUEtSuxHCHkAVnf/LGEFJkcs2INYhwGWLjp1NdyMNkRqH1C7
         n4YeYm/XbyMUHC+d3oIzdTMjYHbJzUWwltGN1bnDmAN+NobocdFSBvNnO0iDuFISI4pu
         ayF8PUV9AjrSVcr2bye0c+hscTSsHm0hc8BMCMMsBFYj0lDhvVY7m/NTqovWSqqX742P
         puBTJ9Q+M/WMAaN8h6gWcb/kWlAJRYsqY1ExjPRI+mccXn9v+qWtFVfG/7XNYgnIPVoQ
         chUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723441315; x=1724046115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6CTGoNaTe2XWjeAV+ihoGUgx18k2VPP6Soz43dQHSQ=;
        b=PVcM9kHu+6UWdHhnBYCAN8YQc5tsnntcAuBCAd7fyWF6t3lUwF7Ro5O8YqDPi7c9sR
         +SevC1ot2HY9LkQqzZtzk1EWUUo7KFbLBpCBHfYCQaheYQqe7xIa5NtUcFji4LotWxaa
         Vw0X6R4D6yhZDsXkRzkAURtrm7tZ6jayFWnQ4XXhLGsZA5LSr4EtthUE+p1M/6rTms1q
         j48KA2iJ2Fh0V70MrIjGQXIANTxVQK75QRov+KGkd6QRWFkTE2KzuYLKYCyhN9VRCkkj
         2OuOu4FJzp/575oi/wFCh4+lbHu927jvMQjT427hR1eThqYgIA8xWyRbcflXQpehJdXh
         Zlaw==
X-Forwarded-Encrypted: i=1; AJvYcCVpuaBujzUmn/q5EkhjoHnr9xweDkd6Mou6anvpAmbr6tzxXU0EVWoF+jm8iOyPeHbvCkOpBJdSLTGz1JmC7CXEGdBa4ZQ5LS5M
X-Gm-Message-State: AOJu0YzC5UZnL0haWDOfH8XgNyVZzMMZoVbBDu6bPj7ELksdrj53OQHx
	exoTs7J5cRIKqjbj3joSoCB0j5MMNKWEbApPpTROsxd3Ni96+D83wsctFzH+p98=
X-Google-Smtp-Source: AGHT+IGoauMHKJ2VwPdWETVSbpWk0FENKo/8XPyLz6nP7e203aXrsJPM4FhHzcZITRY1Du0txiAk8g==
X-Received: by 2002:a17:906:d247:b0:a72:6375:5fc4 with SMTP id a640c23a62f3a-a80aa55409amr560097366b.11.1723441315427;
        Sun, 11 Aug 2024 22:41:55 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e1334sm198172066b.79.2024.08.11.22.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 22:41:55 -0700 (PDT)
Date: Mon, 12 Aug 2024 07:41:52 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: bhe@redhat.com, Hari Bathini <hbathini@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, Petr =?UTF-8?B?VGVzYcWZ?=
 =?UTF-8?B?w61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
Message-ID: <20240812074152.321febe5@mordecai.tesarici.cz>
In-Reply-To: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240811_224158_157321_8B28CE58 
X-CRM114-Status: GOOD (  37.87  )
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

On Mon, 12 Aug 2024 09:46:51 +0530
Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> Commit 79365026f869 ("crash: add a new kexec flag for hotplug support")
> generalizes the crash hotplug support to allow architectures to update
> multiple kexec segments on CPU/Memory hotplug and not just elfcorehdr.
> Therefore, update the relevant kernel documentation to reflect the same.
> 
> No functional change.
> 
> Cc: Petr Tesarik <petr@tesarici.cz>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>

It's perfect now.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
> 
> Changelog:
> 
> Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
>   - Update crash_hotplug sysfs document as suggested by Petr T
>   - Update an error message in crash_handle_hotplug_event and
>     crash_check_hotplug_support function.
> 
> ---
>  .../ABI/testing/sysfs-devices-memory          |  6 ++--
>  .../ABI/testing/sysfs-devices-system-cpu      |  6 ++--
>  .../admin-guide/mm/memory-hotplug.rst         |  5 +--
>  Documentation/core-api/cpu_hotplug.rst        | 10 +++---
>  kernel/crash_core.c                           | 33 +++++++++++--------
>  5 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
> index a95e0f17c35a..cec65827e602 100644
> --- a/Documentation/ABI/testing/sysfs-devices-memory
> +++ b/Documentation/ABI/testing/sysfs-devices-memory
> @@ -115,6 +115,6 @@ What:		/sys/devices/system/memory/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for memory hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel updates relevant kexec
> +		segments on memory hot un/plug and/or on/offline events, avoiding the
> +		need to reload kdump kernel.
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 325873385b71..1a31b7c71676 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -703,9 +703,9 @@ What:		/sys/devices/system/cpu/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for CPU hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel updates relevant kexec
> +		segments on memory hot un/plug and/or on/offline events, avoiding the
> +		need to reload kdump kernel.
>  
>  What:		/sys/devices/system/cpu/enabled
>  Date:		Nov 2022
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 098f14d83e99..cb2c080f400c 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -294,8 +294,9 @@ The following files are currently defined:
>  ``crash_hotplug``      read-only: when changes to the system memory map
>  		       occur due to hot un/plug of memory, this file contains
>  		       '1' if the kernel updates the kdump capture kernel memory
> -		       map itself (via elfcorehdr), or '0' if userspace must update
> -		       the kdump capture kernel memory map.
> +		       map itself (via elfcorehdr and other relevant kexec
> +		       segments), or '0' if userspace must update the kdump
> +		       capture kernel memory map.
>  
>  		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>  		       configuration option.
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index dcb0e379e5e8..a21dbf261be7 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -737,8 +737,9 @@ can process the event further.
>  
>  When changes to the CPUs in the system occur, the sysfs file
>  /sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
> -updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
> -or '0' if userspace must update the kdump capture kernel list of CPUs.
> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr and
> +other relevant kexec segment), or '0' if userspace must update the kdump
> +capture kernel list of CPUs.
>  
>  The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>  option.
> @@ -750,8 +751,9 @@ file can be used in a udev rule as follows:
>   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>  
>  For a CPU hot un/plug event, if the architecture supports kernel updates
> -of the elfcorehdr (which contains the list of CPUs), then the rule skips
> -the unload-then-reload of the kdump capture kernel.
> +of the elfcorehdr (which contains the list of CPUs) and other relevant
> +kexec segments, then the rule skips the unload-then-reload of the kdump
> +capture kernel.
>  
>  Kernel Inline Documentations Reference
>  ======================================
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6e..c1048893f4b6 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
>  	crash_hotplug_lock();
>  	/* Obtain lock while reading crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return 0;
>  	}
> @@ -520,18 +520,25 @@ int crash_check_hotplug_support(void)
>  }
>  
>  /*
> - * To accurately reflect hot un/plug changes of cpu and memory resources
> - * (including onling and offlining of those resources), the elfcorehdr
> - * (which is passed to the crash kernel via the elfcorehdr= parameter)
> - * must be updated with the new list of CPUs and memories.
> + * To accurately reflect hot un/plug changes of CPU and Memory resources
> + * (including onling and offlining of those resources), the relevant
> + * kexec segments must be updated with latest CPU and Memory resources.
>   *
> - * In order to make changes to elfcorehdr, two conditions are needed:
> - * First, the segment containing the elfcorehdr must be large enough
> - * to permit a growing number of resources; the elfcorehdr memory size
> - * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> - * Second, purgatory must explicitly exclude the elfcorehdr from the
> - * list of segments it checks (since the elfcorehdr changes and thus
> - * would require an update to purgatory itself to update the digest).
> + * Architectures must ensure two things for all segments that need
> + * updating during hotplug events:
> + *
> + * 1. Segments must be large enough to accommodate a growing number of
> + *    resources.
> + * 2. Exclude the segments from SHA verification.
> + *
> + * For example, on most architectures, the elfcorehdr (which is passed
> + * to the crash kernel via the elfcorehdr= parameter) must include the
> + * new list of CPUs and memory. To make changes to the elfcorehdr, it
> + * should be large enough to permit a growing number of CPU and Memory
> + * resources. One can estimate the elfcorehdr memory size based on
> + * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
> + * excluded from SHA verification by default if the architecture
> + * supports crash hotplug.
>   */
>  static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>  {
> @@ -540,7 +547,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  	crash_hotplug_lock();
>  	/* Obtain lock while changing crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return;
>  	}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

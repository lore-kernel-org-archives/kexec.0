Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CA8C3DA4A
	for <kexec@archiver.kernel.org>; Thu,  8 Aug 2024 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9p1Kz24Z9QjUMCfjsXBIRZcRAcTrQ1yO+J2yb1WWyzQ=; b=0Sre3+5oP5/Quc
	lNq5V1vL7yzY93PJtZ6LNeDft0s07BZTDzutF0CDGETZS6E8FR4ZgZWoVsUwCD64W+upKLJvxwoSb
	Q/C07i7KNL3OPVcSMXWYKgFwkjbzdGG6AQBUyjKP8X98H3E+tNmVsuRInQQSvZ87+l9A7+DSrc32v
	8kQm24oNyiFedU24PPo5pc3x9NFlkdj4qgMAX6A9j6mtAjSvZMagx/B4Gs9bnJqMrvq8/A6eC/JSi
	WMrR1rxTwTeC2Cq4RxPg86zNQ0M8PNrPgiEqx3q+tTEM7leW6LvibymMqTgWwWw7xDPCth50VWZ29
	yJ6ZoTw7L9yzQIRCFXOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc1Ft-000000083ZB-2iO5;
	Thu, 08 Aug 2024 11:24:29 +0000
Received: from bee.tesarici.cz ([2a03:3b40:fe:2d4::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc1Fq-000000083Yk-3dFj
	for kexec@lists.infradead.org;
	Thu, 08 Aug 2024 11:24:28 +0000
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 477831D4DE1;
	Thu,  8 Aug 2024 13:24:24 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723116264; bh=oxYbYN2Mz8ixrMDkxJac4yjjhQ3W1I56nPlRCKBOi98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u575P61E87M/BWliYygQAQzNdqCpWX5mQfndINSrY9sqCM6Ih+NlOCPeUzzJ7LY9D
	 Guxqb0VT3HvrWgzxbA2zWw9CZ4UxMjVhJZII6HiRDG6DiTukh4FmZqTzGPtBMfrPCG
	 a5nkkuFSFNrSxmHgfKxA7PQJECNgHHin2ViNz/lIbhVmQZ7U+Jfc60tnQPzbzidTS4
	 DwQelkG0R9+71o6d4RuCUwFWLenWl+MOuHV7QiUV3SvbmH7zd/u8gcvEDPLYDtYpjR
	 w2lg8pOVlgsFNqOXDS8PF6mXg0itfu8eae9hVqFa6w1rraU9c8wS3jyhneU4NbRQ6a
	 Jnn1H/Cw4qzag==
Date: Thu, 8 Aug 2024 13:24:23 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: bhe@redhat.com, Hari Bathini <hbathini@linux.ibm.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH] Document/kexec: Generalize crash hotplug description
Message-ID: <20240808132423.0f313ffe@meshulam.tesarici.cz>
In-Reply-To: <20240805050829.297171-1-sourabhjain@linux.ibm.com>
References: <20240805050829.297171-1-sourabhjain@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_042427_084991_6A7B3FC8 
X-CRM114-Status: GOOD (  16.46  )
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

Hi Sourabh,

sorry for late reply, was on vacation and then catching up...

On Mon,  5 Aug 2024 10:38:29 +0530
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
> ---
> 
> Discussion about the documentation update:
> https://lore.kernel.org/all/68d0328d-531a-4a2b-ab26-c97fd8a12e8b@linux.ibm.com/
> 
> ---
>  .../ABI/testing/sysfs-devices-memory          |  6 ++--
>  .../ABI/testing/sysfs-devices-system-cpu      |  6 ++--
>  .../admin-guide/mm/memory-hotplug.rst         |  5 ++--
>  Documentation/core-api/cpu_hotplug.rst        | 10 ++++---
>  kernel/crash_core.c                           | 29 ++++++++++++-------
>  5 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
> index a95e0f17c35a..421acc8e2c6b 100644
> --- a/Documentation/ABI/testing/sysfs-devices-memory
> +++ b/Documentation/ABI/testing/sysfs-devices-memory
> @@ -115,6 +115,6 @@ What:		/sys/devices/system/memory/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for memory hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel update of kexec
> +		segments on memory hot un/plug and/or on/offline events,
> +		avoiding the need to reload kdump kernel.

This sentence somehow lacks a verb. My suggestion:

  (RO) indicates whether or not the kernel updates relevant kexec
  segments on memory hot un/plug and/or on/offline events, avoiding the
  need to reload kdump kernel.

> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 325873385b71..f4ada1cd2f96 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -703,9 +703,9 @@ What:		/sys/devices/system/cpu/crash_hotplug
>  Date:		Aug 2023
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:
> -		(RO) indicates whether or not the kernel directly supports
> -		modifying the crash elfcorehdr for CPU hot un/plug and/or
> -		on/offline changes.
> +		(RO) indicates whether or not the kernel update of kexec
> +		segments on CPU hot un/plug and/or on/offline events,
> +		avoiding the need to reload kdump kernel.

Same as above.

Otherwise LGTM.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

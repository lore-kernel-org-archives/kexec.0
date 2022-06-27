Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464CAC433EF
	for <kexec@archiver.kernel.org>; Mon, 27 Jun 2022 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1IpCpXnHJ62QuS2eIqeMdnfBp8bmHpleRggFEczJmIU=; b=fp/rmLZ1jnxR3p
	yoeeadwN9IzyIIXaUq8tpMPouqxKvhyZ9YIwN84F5IAYdId22E576mDBWnnRl45OAxPm9J64NOdve
	ambckmi0Ec2MoaZKOwiS90GmieiYPNNH9OerXeWyLVHQHmp2cTIN1YTMJqiXEmJ1n6ZdTvM7Pmb1y
	Q+nHFk2I5dbmKN8/Qm9Yzeqz7+U1mR5DKu2JAarno0D5V6eblnZ04TOGCVDByITllUePA5G9jQthV
	fRiwP1fLgnOyIA4oaQ1nrgeC2IIw8U0BTApfmkFIYJXFBp/GIjkGELWR/C4fYDWFbCy4VCVsdDQZl
	uEMYRgMod1vuZo2iQChw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5m61-0009tG-Ox; Mon, 27 Jun 2022 10:35:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5m5v-0009oW-H9
	for kexec@lists.infradead.org; Mon, 27 Jun 2022 10:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656326149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKvZnCkoXt+4PjaORqXBx6ym+v+SmPmR3DG/cTeVOIc=;
	b=bvx7XfFxHZENvjkYnQvaecbq1O7sdEfZzEseZV16bsuoVVOZC8wWGVc64uwtbPeRdYBkcY
	RGjzhw9oQYT5+unzQnMUPEVvrqg7GLODKk9SHJ/Ea976CSeuRYAmxn45Q583OvNJ4OPnEk
	Ef+aabyKprS/fij7N/HdUJfgoTIB33w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-MRuSKrRuP0GnZrfy_gPN4Q-1; Mon, 27 Jun 2022 06:35:48 -0400
X-MC-Unique: MRuSKrRuP0GnZrfy_gPN4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE66F101A586;
	Mon, 27 Jun 2022 10:35:47 +0000 (UTC)
Received: from localhost (ovpn-13-65.pek2.redhat.com [10.72.13.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CA9E492CA3;
	Mon, 27 Jun 2022 10:35:46 +0000 (UTC)
Date: Mon, 27 Jun 2022 18:35:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Tao Liu <ltao@redhat.com>
Cc: vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2] kdump: round up the total memory size to 128M for
 crashkernel reservation
Message-ID: <YrmH/728erRohHeU@MiWiFi-R3L-srv>
References: <20220627074440.187222-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220627074440.187222-1-ltao@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_033551_824167_BDE7B5A2 
X-CRM114-Status: GOOD (  28.20  )
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

On 06/27/22 at 03:44pm, Tao Liu wrote:
> The total memory size we get in kernel is usually slightly less than
> the actual memory size because BIOS/firmware will reserve some memory
> region. So it won't export all memory as usable.
> 
> E.g, on my x86_64 kvm guest with 1G memory, the total_mem value shows:
> UEFI boot with ovmf:   0x3faef000
> Legacy boot kvm guest: 0x3ff7ec00
> 
> When specifying crashkernel=1G-2G:128M, if we have a 1G memory machine,
> we get total size 1023M from firmware. Then it will not fall into
> 1G-2G, thus no memory reserved. User will never know this, it is hard
> to let user know the exact total value in kernel.
> 
> One way is to use dmi/smbios to get physical memory size, but it's not
> reliable as well. According to Prarit hardware vendors sometimes screw
> this up. Thus round up total size to 128M to work around this problem.
> 
> This patch is a resend of [1] and rebased onto v5.19-rc2, and the
> original credit goes to Dave Young <dyoung@redhat.com>.

This should be put into cover letter, or put together with change log.
Other than this, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> [1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html
> 
> Signed-off-by: Tao Liu <ltao@redhat.com>
> ---
> v1 -> v2:
> Modified commit log based on Baoquan's advice.
> ---
>  kernel/crash_core.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 71122e01623c..b58b27cbdb61 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/sizes.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -43,6 +44,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  					unsigned long long *crash_base)
>  {
>  	char *cur = cmdline, *tmp;
> +	unsigned long long total_mem = system_ram;
> +
> +	/*
> +	 * Firmware sometimes reserves some memory regions for its own use,
> +	 * so the system memory size is less than the actual physical memory
> +	 * size. Work around this by rounding up the total size to 128M,
> +	 * which is enough for most test cases.
> +	 */
> +	total_mem = roundup(total_mem, SZ_128M);
>  
>  	/* for each entry of the comma-separated list */
>  	do {
> @@ -87,13 +97,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  			return -EINVAL;
>  		}
>  		cur = tmp;
> -		if (size >= system_ram) {
> +		if (size >= total_mem) {
>  			pr_warn("crashkernel: invalid size\n");
>  			return -EINVAL;
>  		}
>  
>  		/* match ? */
> -		if (system_ram >= start && system_ram < end) {
> +		if (total_mem >= start && total_mem < end) {
>  			*crash_size = size;
>  			break;
>  		}
> -- 
> 2.33.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

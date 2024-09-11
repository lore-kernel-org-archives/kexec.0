Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B72EE49B3
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dvmxp+YmUBR2sE+qXGKfmyG2BcH1crQ+gwqCp/ipVNE=; b=JICrVKhd5ibUnP
	gbxpfXSoUTTbRn21AG81TNRazJ+T+J2zOI05eYplOGA5GlwwOMTcpiTiItEoVbIWFEt02x938K/oC
	Li+EFBQjD7+pugSsVr6ib86YjiXTcvrYfbL2b4z64OVvDQwZntiNzzlj8mfM6eWBO38HBOlHhmfYz
	+nbYU8tx+/iGKw9KsKiAmYwnn6FxSsmr1IPiTyFwAYgM0zYYBVACZiEbAR6YSekiFXIZT8YXlKFVe
	jVgeidzukbtOeyFv1XdrJFYD48OJVwzeIFkBcv/41ikvMm24pJRW4ne/N6kM4sGWlU4RCVaAxqJFj
	HQQDnItgz4fnRtN+whCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soOKX-00000009u3r-3iyy;
	Wed, 11 Sep 2024 14:28:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soOCv-00000009sOA-3FjP
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 14:20:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726064432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UKjQHKbbUWDKvrveJtrSaJsbUem/1dqSveBkM7kg2E=;
	b=OTmlSU92Jdo8s/WNvOA+o0PwlkYA6eayr5RtdiDwI6aQpOk9J+BVyzpothTGgHyHKAHtra
	EO55NJtHqXisugzNgz5LuERt0Eiz/Jiknmm3yo/7wavtrHbWZO2i9XtSdT6us3Q4gSICxt
	V95+7QsVi6TRXN9+EkSdYpPkYMCIdcQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-lXe3ob0CMI-wwPAWC2bJCA-1; Wed,
 11 Sep 2024 10:20:26 -0400
X-MC-Unique: lXe3ob0CMI-wwPAWC2bJCA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53DF01955E8C;
	Wed, 11 Sep 2024 14:20:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5FA30001A1;
	Wed, 11 Sep 2024 14:20:20 +0000 (UTC)
Date: Wed, 11 Sep 2024 22:20:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: akpm@linux-foundation.org, Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND v2] kexec/crash: no crash update when kexec in
 progress
Message-ID: <ZuGnH5R+FOC481V3@MiWiFi-R3L-srv>
References: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240911112111.108056-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_072033_911114_3087B69E 
X-CRM114-Status: GOOD (  24.24  )
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

On 09/11/24 at 04:51pm, Sourabh Jain wrote:
> The following errors are observed when kexec is done with SMT=off on
> powerpc.
> 
> [  358.458385] Removing IBM Power 842 compression device
> [  374.795734] kexec_core: Starting new kernel
> [  374.795748] kexec: Waking offline cpu 1.
> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  374.935833] kexec: Waking offline cpu 2.
> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> snip..
> [  375.515823] kexec: Waking offline cpu 6.
> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [  375.695836] kexec: Waking offline cpu 7.
> 
> To avoid kexec kernel boot failure on PowerPC, all the present CPUs that
> are offline are brought online during kexec. For more information, refer
> to commit e8e5c2155b00 ("powerpc/kexec: Fix orphaned offline CPUs across
> kexec"). Bringing the CPUs online triggers the crash hotplug handler,
> crash_handle_hotplug_event(), to update the kdump image. Since the
> system is on the kexec kernel boot path and the kexec lock is held, the
> crash_handle_hotplug_event() function fails to acquire the same lock to
> update the kdump image, resulting in the error messages mentioned above.
> 
> To fix this, return from crash_handle_hotplug_event() without printing
> the error message if kexec is in progress.
> 
> The same applies to the crash_check_hotplug_support() function. Return
> 0 if kexec is in progress because kernel is not in a position to update
> the kdump image.

LGTM, thanks.

Acked-by: Baoquan he <bhe@redhat.com>

> 
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
> 
> Since v1:
>  - Keep the kexec_in_progress check within kexec_trylock() - Baoquan He
>  - Include the reason why PowerPC brings offline CPUs online
>    during the kexec kernel boot path - Baoquan He
>  - Rebased on top of #next-20240910 to avoid conflict with the patch below
>    https://lore.kernel.org/all/20240812041651.703156-1-sourabhjain@linux.ibm.com/T/#u
> 
> V2 RESEND:
>  - Update linuxppc-dev mailing list address
> ---
>  kernel/crash_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index c1048893f4b6..078fe5bc5a74 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -505,7 +505,8 @@ int crash_check_hotplug_support(void)
>  	crash_hotplug_lock();
>  	/* Obtain lock while reading crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return 0;
>  	}
> @@ -547,7 +548,8 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  	crash_hotplug_lock();
>  	/* Obtain lock while changing crash information */
>  	if (!kexec_trylock()) {
> -		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> +		if (!kexec_in_progress)
> +			pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
>  		crash_hotplug_unlock();
>  		return;
>  	}
> -- 
> 2.46.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

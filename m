Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B44C3DA64
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b1t2oly11y7UE65bwYNkiZChLETVGsJVtueDRaPSwUo=; b=QTbkVwBQsjbrte
	VMVTJ/bRujFDRQMN/fPs+NT02Vc1P3x7mo5wd+9JM7bcwppmtOeO/qo13yKvqfQpe9YmCpUCPyvRb
	2fQd6bqyYcVjmeT4COLpZt2hcYNOB6MC7Np3ifVzahqlIFfUSkZhM/mNI4oX4OxjVyRm6OMN9FpKO
	qA6dqIdi//aRwOmVbxBxH23BlsZAh1DExszuE5HnGulhtmOvyr1JNM6h0R4zpXOcdf2WB1Enr0oEz
	nMuMlwveYUZ60emeWHQ41DEObeUNwKy1A+lwc5PxlBKa7qyKl81MQdUeqmqIqV/HJBHG8Wtz10Rgr
	I0moHp9VRjekMIlwq8Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQTv-00000004DIe-1M5Q;
	Thu, 01 Aug 2024 07:44:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQTs-00000004DI9-2Tqj
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 07:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722498250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLqIFQo3+YskQXU1q1/o1FuHxtOKeaCtnjOaWo5ax7o=;
	b=MatGiVwWF7zzwVnn+Zv4oit/NsFSyovehKfbFX3ddosB3cBmFrz7kZgYbhN6RZoSb+o6+S
	GYPns7e6r3ovXmwdtxUkX9cMbi/TzNh2oPSXW3ruOVeQu5K8cc+zGh7xeLsvalwAVc3lcX
	A7hqF1/k7SOWU9qdph7prTvHOWF2cWE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-xDoMx_joMCmj2w8WRsGSAQ-1; Thu,
 01 Aug 2024 03:44:07 -0400
X-MC-Unique: xDoMx_joMCmj2w8WRsGSAQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB9CD1955D4A;
	Thu,  1 Aug 2024 07:44:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2525A1955E80;
	Thu,  1 Aug 2024 07:44:01 +0000 (UTC)
Date: Thu, 1 Aug 2024 15:43:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <Zqs8veRya7v/pXEt@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240801_004412_729909_83FB4218 
X-CRM114-Status: GOOD (  26.12  )
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

On 07/31/24 at 08:57pm, Sourabh Jain wrote:
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
> During kexec, the offline CPUs are brought online, which triggers the

Is this a generic action or specific on ppc about the offline CPUs being
brought line during kexec? 

> crash hotplug handler `crash_handle_hotplug_event()` to update the kdump
> image. Given that the system is on the kexec path and the kexec lock is
> taken, the `crash_handle_hotplug_event()` function fails to take the
> same lock to update the kdump image, resulting in the above error
> messages.
> 
> To fix this, let's return from `crash_handle_hotplug_event()` if kexec
> is in progress.
> 
> The same applies to the `crash_check_hotplug_support()` function.
> Return 0 if kexec is in progress.
> 
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> Cc: linuxppc-dev@ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Reported-by: Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/crash_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6e..d37a16d5c3a1 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -502,6 +502,9 @@ int crash_check_hotplug_support(void)
>  {
>  	int rc = 0;
>  
> +	if (kexec_in_progress)
> +		return 0;
> +
>  	crash_hotplug_lock();
>  	/* Obtain lock while reading crash information */
>  	if (!kexec_trylock()) {
> @@ -537,6 +540,9 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>  {
>  	struct kimage *image;
>  
> +	if (kexec_in_progress)
> +		return;
> +
>  	crash_hotplug_lock();
>  	/* Obtain lock while changing crash information */
>  	if (!kexec_trylock()) {
> -- 
> 2.45.2
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

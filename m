Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85893C3DA7F
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 02:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5Zk3kPjT9k1GXy+HrJvgwfOFvIHw9CDo9lBP+Vmi8lA=; b=WgpgpFlPMsyxsv
	sd9FXFgqQMT0iL+AZ52y/n9fZswXjXlNhHTHMU/6S6zAB+TOTNZ/hVhEVYrwidpqL+DmQIzfSrrfA
	K6UOcqlQkEs5CxnXRwTym/iVUHvQIFKNmuhbA9cZHw0toutkeCfu8z7zugiFpdutGdj63f1MT+BH5
	0rCFQTjjE0i+jrsPItnrPTo8iGuiZ55wlKTefAOcGVL1RaKlcq8m19G09EcDWj+OysWl8Mf8eXWJC
	g5IvdnUzYlgNxM9TWDLHT6GjeGx3P7TfmgyXqJHPsVD7ZWStVfOtbyt+9UngIc5vYaOgBQczifskV
	mWIou8IStk5tfNDl9V5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZLeg-00000003THo-0c0j;
	Thu, 01 Aug 2024 02:35:02 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZLdu-00000003T4Q-0yDT
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 02:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722479650;
	bh=Gu2oyGDEAOsWLaCjYmOjBBoAxVuypoP0T7mtfNUrOe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FVItAq7My3D+6l6w5F3oHYc0k/3sDN59MWvfcvkBTPwR3I7RuQEHaarKI6eeQi6BU
	 VNgqhNcym8wNRNd+j+ELofxI5vnpmW2pKeizWjBFbsfeUP+BnA3tFNV3eV2O50QgJb
	 sJCABPs3XXemxvf13dvkurBg7v+bRc2Rsl5cbEAVbOKSnlf3E0N26IoLkcJJLyuTsR
	 le81sMw7Boden5CLaQwdCc/Z0zbRoArk69fLqP5YH420VQyngkAi6BgoTHE6Io31/g
	 iTE6qiEV+almyOg7vxWGzOudUSS1u33Kt+KlLnlz3YU9V9qNAi6VmiQaee+bNcowiG
	 ym2XE9POb+QIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WZChf4Bkyz4x6r;
	Thu,  1 Aug 2024 12:34:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, bhe@redhat.com
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini
 <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
In-Reply-To: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
Date: Thu, 01 Aug 2024 12:34:10 +1000
Message-ID: <87v80lnf8d.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_193414_611463_80A87986 
X-CRM114-Status: GOOD (  23.92  )
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:
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

Are they actually errors though? Do they block the actual kexec from
happening? Or are they just warnings in dmesg?

Because the fix looks like it could be racy.

cheers

> During kexec, the offline CPUs are brought online, which triggers the
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

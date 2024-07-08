Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7368CC3DA41
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qXOcjt5oEXOpS9Uart9Aoa0aUqWYqh2U3nxgtimu/E8=; b=2S2joBABNRv+wI
	FzNvYKT0uselCqEwSXtpWa72AysX00SkCx30ogRXSOLXMu6yN+tyJFg9kci+rY6pLkE1bCGyX7tzc
	Z4lMfERSzLDthEZel/PwCy5se1REoq88qg20E7Hog5g9DDEDyB49jdVitX4MYuBRoEJLXck4JDcPc
	X8d6dag6OxG8FeTMOJ3vY5LIgdxjKf5O2gw6KgMs3wqFGVE380B3obm8S4MzegSCdYQECl0BRU9e+
	7I4S99ycDOYBQEM6qpGmdHk3e/OJy47BERgtFeMKZs+sTbQHaM7Oq8N8QX9tYIoh5X1YJueGcFwt2
	P4N+vQwCVCS4/Urw20pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQlda-00000003SS1-2rgp;
	Mon, 08 Jul 2024 10:30:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQldY-00000003SPs-0jyz
	for kexec@lists.infradead.org;
	Mon, 08 Jul 2024 10:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720434623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AYQmiTsgRA3vCHaOY9rCNaFtQPp/45UJlUSuU8mqRLA=;
	b=O8ryILJrMlYqBy6l5LE/S23bOUn3mCjXn5feJ4sRT+2c02t0vJbiwmEpY0jSKKA4qnOmPO
	hO9fd/77diTWSGFvDcAvYSRUtLdkBTnNOZQFfAVt1zAo7o/jqLXv4j2ZmbmDrldyLwU6u3
	m9BROgmPqndeFohXnU03PIeG+vrj8as=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-qHw-2d5cN9yWPtrNv2F86g-1; Mon,
 08 Jul 2024 06:30:20 -0400
X-MC-Unique: qHw-2d5cN9yWPtrNv2F86g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 649131955F3B;
	Mon,  8 Jul 2024 10:30:18 +0000 (UTC)
Received: from localhost (unknown [10.72.116.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B0861955F40;
	Mon,  8 Jul 2024 10:30:16 +0000 (UTC)
Date: Mon, 8 Jul 2024 18:30:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Aditya Gupta <adityag@linux.ibm.com>,
	Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
Message-ID: <Zou/tF+wmuEKVT7c@MiWiFi-R3L-srv>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
 <20240707152456.87899-2-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20240707152456.87899-2-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_033024_307139_9139BE7B 
X-CRM114-Status: GOOD (  15.96  )
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

On 07/07/24 at 08:54pm, Sourabh Jain wrote:
> Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
> support) has introduced a new kexec flag to generalize hotplug support.
> The newly introduced kexec flags for hotplug allow architectures to
> exclude all the required kexec segments from SHA calculation so that
> the kernel can update them on hotplug events. This was not possible
> earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
> only for the elfcorehdr segment.
> 
> To enable architectures to control the list of kexec segments to exclude
> when hotplug support is enabled, add a new architecture-specific
> function named arch_do_exclude_segment. During the SHA calculation, this
> function gets called to let the architecture decide whether a specific
> kexec segment should be considered for SHA calculation or not.
> 
> Note: To avoid breaking backward compatibility, the new kexec flag
> KEXEC_CRASH_HOTPLUG_SUPPORT is not used for x86 for now.
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Simon Horman <horms@kernel.org>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kexec/arch/arm/kexec-arm.c             |  5 ++++
>  kexec/arch/arm64/kexec-arm64.c         |  5 ++++
>  kexec/arch/cris/kexec-cris.c           |  4 +++
>  kexec/arch/hppa/kexec-hppa.c           |  5 ++++
>  kexec/arch/i386/kexec-x86.c            |  8 ++++++
>  kexec/arch/ia64/kexec-ia64.c           |  4 +++
>  kexec/arch/loongarch/kexec-loongarch.c |  5 ++++
>  kexec/arch/m68k/kexec-m68k.c           |  5 ++++
>  kexec/arch/mips/kexec-mips.c           |  4 +++
>  kexec/arch/ppc/kexec-ppc.c             |  4 +++
>  kexec/arch/ppc64/kexec-ppc64.c         |  5 ++++
>  kexec/arch/s390/kexec-s390.c           |  5 ++++
>  kexec/arch/sh/kexec-sh.c               |  5 ++++
>  kexec/arch/x86_64/kexec-x86_64.c       |  8 ++++++
>  kexec/kexec-syscall.h                  |  1 +
>  kexec/kexec.c                          | 40 ++++++++++++++++++++++----
>  kexec/kexec.h                          |  2 ++
>  17 files changed, 109 insertions(+), 6 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

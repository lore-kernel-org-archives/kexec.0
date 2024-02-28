Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56136C5478C
	for <kexec@archiver.kernel.org>; Wed, 28 Feb 2024 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ndTmQI76Or6VO1B0RK5/h/Ycjfwwq7Q0P9ij7wx3ltE=; b=VM0zzO7wTzWc3t
	3EdwGSt3txMO4cPkWNp83u2xJUePiLdEd9JXvHwMsYjTTJyXn0vSwO0EDwOjT9xdZ8T7T7RaxuLm1
	90/n/nl778D0GcXfsfkIWuLhnH5/9evmuQ5FZ6eDiBxiRRaLCPZbJZ9rrfsqJ0HwkeTFcrCfhaKCA
	zO+xAUN6ye4HucKH5eTRPfcgKwCuPKBDjpC/YeKdhUUZ8CZer1hVgx4nd4EWwe2fbwyF670vGC9XL
	zkeAH0sryRVFvs6GUtFbidbRc0ScME2ZFI5RsvUm2ETmaYz0J+o1ZHL+j/jc5kbJPCkE70tbNspg6
	yvM3iXrDtBreSsNQmpHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfJyF-00000009SqE-0VqG;
	Wed, 28 Feb 2024 13:27:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfJyC-00000009SoP-3hGq
	for kexec@lists.infradead.org;
	Wed, 28 Feb 2024 13:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709126855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kEfwbgk+HJXxJPFthOIkO9PMTrZebAOuLRXMpclJ/tY=;
	b=CdY2I4LTe6ySvhKUd5OXvK28CMprZtY2PBLDW4XFHiESApTPt/4BiAluWOvJF+zzEyMqqC
	nJAa6ultmka3u5QI6BYTXaIFOkI7ZDS8oZVEr1p1dFzIcU6dH+nveaXJejk2dEE9pXbUBE
	FuWuv8ygOZdLewAxrLeQv8n8nvLOyys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-klg8Z8ybN-SVy6j-IZi_eg-1; Wed, 28 Feb 2024 08:27:32 -0500
X-MC-Unique: klg8Z8ybN-SVy6j-IZi_eg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6817C8871C2;
	Wed, 28 Feb 2024 13:27:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E66E9492BE2;
	Wed, 28 Feb 2024 13:27:29 +0000 (UTC)
Date: Wed, 28 Feb 2024 21:27:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Kexec-ml <kexec@lists.infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH linux-next v2 0/3] powerpc/kexec: split CONFIG_CRASH_DUMP
 out from CONFIG_KEXEC_CORE
Message-ID: <Zd80vHHS2Jrobvtq@MiWiFi-R3L-srv>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240226103010.589537-1-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240228_052737_105805_7AA6BBE8 
X-CRM114-Status: GOOD (  15.62  )
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

On 02/26/24 at 04:00pm, Hari Bathini wrote:
> This patch series is a follow-up to [1] based on discussions at [2]
> about additional work needed to get it working on powerpc.
> 
> The first patch in the series makes struct crash_mem available with or
> without CONFIG_CRASH_DUMP enabled. The next patch moves kdump specific
> code for kexec_file_load syscall under CONFIG_CRASH_DUMP and the last
> patch splits other kdump specific code under CONFIG_CRASH_DUMP and
> removes dependency with CONFIG_CRASH_DUMP for CONFIG_KEXEC_CORE.
> 
> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
> [2] https://lore.kernel.org/all/9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com/
> 
> Changes in v2:
> * Fixed a compile error for POWERNV build reported by Sourabh.
> 
> Hari Bathini (3):
>   kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
>   powerpc/kexec: split CONFIG_KEXEC_FILE and CONFIG_CRASH_DUMP
>   powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency

I have acked patch 1. And patch 2 and 3 looks good to me, leave these
two to powerpc experts to have a careful reviewing. Thanks for these
great work.


> 
>  arch/powerpc/Kconfig                 |   9 +-
>  arch/powerpc/include/asm/kexec.h     |  98 +++++-----
>  arch/powerpc/kernel/prom.c           |   2 +-
>  arch/powerpc/kernel/setup-common.c   |   2 +-
>  arch/powerpc/kernel/smp.c            |   4 +-
>  arch/powerpc/kexec/Makefile          |   3 +-
>  arch/powerpc/kexec/core.c            |   4 +
>  arch/powerpc/kexec/elf_64.c          |   4 +-
>  arch/powerpc/kexec/file_load_64.c    | 269 ++++++++++++++-------------
>  arch/powerpc/platforms/powernv/smp.c |   2 +-
>  include/linux/crash_core.h           |  12 +-
>  11 files changed, 209 insertions(+), 200 deletions(-)
> 
> -- 
> 2.43.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

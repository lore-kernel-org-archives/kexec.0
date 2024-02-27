Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589E9C5478C
	for <kexec@archiver.kernel.org>; Tue, 27 Feb 2024 10:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BzNtrmcz0QGayZtwR53kcBUesgzKBA9Jm+xeVoM5dkA=; b=AsFLACgsjId4nL
	RFbb8GyJuDjlzv0Ok37sEb20n7GM5fEZxmVlsz5LUXkc7rShc3QKld37jk3cGkGbRpThEy/gB5wc1
	Bea1DyAJHK2ZYDhCuyeRRwgsBI8eC1aUMABl9zMtvOLdFV48eHqi68W7xuuHnVeS1bKG6PY4zrVRK
	zFzXxzcPqOjBQZhKqJTB3zTpsrqJ18bLMmTNdYXrqK30nr0w9Q9HXGnhuCBjT2T47RQlUeIXtLR1T
	gI2fJ+h3AlIXYiaagXbeMYaUQI+Yzfv4XdmINYYM1K2vwX8r9KCgtHbPQZLHe3JyLO84MirdBErT5
	qTxOJ9j98rbVeMidhY9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rev5I-00000004q6J-18sK;
	Tue, 27 Feb 2024 10:53:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rev5F-00000004q5L-0q6G
	for kexec@lists.infradead.org;
	Tue, 27 Feb 2024 10:53:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709031190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/R0zYYMzMrd102J3JgHM4IsC1fahdOwS+2IaXy3PeY=;
	b=HxIk1ZH+dDU6pL3VUiyakUlPW8oq1icTPVqGq62TrDsRjAOzE6PuTQYU84dnVtjA9n2xyX
	/U1Y7JFIJF2NzgSeh5R8ZEpMtPCxCLFXWUnUBvyfSKkQBDmUXoI+pIcqkoEmeAmpIU+897
	OFrG1BoOug458/Iwzjo2Ko+3ynxDvyM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-3FvsOudxP5y2P_M0yYeEmA-1; Tue,
 27 Feb 2024 05:53:06 -0500
X-MC-Unique: 3FvsOudxP5y2P_M0yYeEmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A73F33C1E9C4;
	Tue, 27 Feb 2024 10:53:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 74B271C06713;
	Tue, 27 Feb 2024 10:53:01 +0000 (UTC)
Date: Tue, 27 Feb 2024 18:52:57 +0800
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
Subject: Re: [PATCH linux-next v2 1/3] kexec/kdump: make struct crash_mem
 available without CONFIG_CRASH_DUMP
Message-ID: <Zd2/CRHtB4kETwtp@MiWiFi-R3L-srv>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
 <20240226103010.589537-2-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240226103010.589537-2-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_025313_340974_657A0A06 
X-CRM114-Status: GOOD (  20.06  )
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
> struct crash_mem defined under include/linux/crash_core.h represents
> a list of memory ranges. While it is used to represent memory ranges
> for kdump kernel, it can also be used for other kind of memory ranges.
> In fact, KEXEC_FILE_LOAD syscall in powerpc uses this structure to
> represent reserved memory ranges and exclude memory ranges needed to
> find the right memory regions to load kexec kernel. So, make the

We may be able to refactor code to make struct crash_mem only used for
crash handling, or get another data structure for loading kexec kernel.
Anyway, for the time being, this is the simplest way we can take. Thanks
for the work on ppc to make crash split out from the kexec code.

Acked-by: Baoquan He <bhe@redhat.com>

> definition of crash_mem structure available for !CONFIG_CRASH_DUMP
> case too.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
> 
> * No changes in v2.
> 
>  include/linux/crash_core.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 23270b16e1db..d33352c2e386 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -8,6 +8,12 @@
>  
>  struct kimage;
>  
> +struct crash_mem {
> +	unsigned int max_nr_ranges;
> +	unsigned int nr_ranges;
> +	struct range ranges[] __counted_by(max_nr_ranges);
> +};
> +
>  #ifdef CONFIG_CRASH_DUMP
>  
>  int crash_shrink_memory(unsigned long new_size);
> @@ -51,12 +57,6 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
>  /* Alignment required for elf header segment */
>  #define ELF_CORE_HEADER_ALIGN   4096
>  
> -struct crash_mem {
> -	unsigned int max_nr_ranges;
> -	unsigned int nr_ranges;
> -	struct range ranges[] __counted_by(max_nr_ranges);
> -};
> -
>  extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mstart,
>  				   unsigned long long mend);
> -- 
> 2.43.2
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

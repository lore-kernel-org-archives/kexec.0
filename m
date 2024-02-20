Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20DDC5475B
	for <kexec@archiver.kernel.org>; Tue, 20 Feb 2024 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2ap1Mgdg6V19FxjgvMQ9QCnwPdPpl++Ca+zYxNwBMHM=; b=BJp45lkJFMnc3O
	gQf5F4c3P7OAcG4tzxqICJASFtvDwCw8a+1ucgBpTXNpHtxYjSDgvJgRSuJJDJWuAjzYk5LTQ+9WT
	HCW5/nXbYXRJzQ1xLIRUJSogimjX8kY4ThCgV+ltUxUmrFEfQcwchud2pg98sfBi4aOCa250E96Ii
	cS/VhIoa9yHhXCrLeE9/3LLrwpeFaVpgWmDkz29kwMITVE3XZhv6WidUZ0Izghek9ddfEgw9JznmF
	hUb+8AJ69mi42Mz2wu5uy4y86iME8E90zsHAy6au/ooDigW/vtHDy/k/J85E2QQVZSZjEvI/CW43l
	l23qhfSVlzTckKClb5rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcQW8-0000000EyY5-0KSd;
	Tue, 20 Feb 2024 13:50:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcQW5-0000000EyXF-2bvt
	for kexec@lists.infradead.org;
	Tue, 20 Feb 2024 13:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708437036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GAc6rry3Nc1ghTKhHNX98UJdceAOZ+259mLdb94DPrE=;
	b=Qrzm067kLWDhKC8o16hwbcIVFHyS31MJiBcsK9Cgf7hIOqXvXoabuyU17u3m7NTIia6RTE
	nKoeycSgqC5nnDh3lZN8KcVp6ZbeE65bihV5NIXEPB+D6rtdQ+GGsVZHXJiSaOGTNPWQDI
	pehkMTJ2H3zKuEuGXxmFtSKlUcEat6I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-wGfgPk9mM22_nJxY97dI-w-1; Tue, 20 Feb 2024 08:50:32 -0500
X-MC-Unique: wGfgPk9mM22_nJxY97dI-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B54D185A782;
	Tue, 20 Feb 2024 13:50:32 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C3E25C185C3;
	Tue, 20 Feb 2024 13:50:29 +0000 (UTC)
Date: Tue, 20 Feb 2024 21:50:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Kexec-ml <kexec@lists.infradead.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH linux-next 1/3] kexec/kdump: make struct crash_mem
 available without CONFIG_CRASH_DUMP
Message-ID: <ZdSuIjknfxg22VSF@MiWiFi-R3L-srv>
References: <20240213113150.1148276-1-hbathini@linux.ibm.com>
 <20240213113150.1148276-2-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240213113150.1148276-2-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_055037_769651_C79F91EE 
X-CRM114-Status: GOOD (  19.18  )
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

On 02/13/24 at 05:01pm, Hari Bathini wrote:
> struct crash_mem defined under include/linux/crash_core.h represents
> a list of memory ranges. While it is used to represent memory ranges

From its name, it's not only representing memory ranges, it's
representing crash memory ranges. Except of this, the whole series looks
good to me. Thanks for the effort.

> for kdump kernel, it can also be used for other kind of memory ranges.
> In fact, KEXEC_FILE_LOAD syscall in powerpc uses this structure to
> represent reserved memory ranges and exclude memory ranges needed to
> find the right memory regions to load kexec kernel. So, make the
> definition of crash_mem structure available for !CONFIG_CRASH_DUMP
> case too.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
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
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

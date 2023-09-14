Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F3ACA0ECD
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 04:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+xRKhatft0/SY4TGc5ILoqnNyXaoeUew2m1ppXlnZmY=; b=3hHja4SaDuZ14a
	wn2qqEJh1xqWm3ywwDUNUIESL5cdlVfdGcy8fcAalZw4rzPeLT1wSRmryP4EDzc0blHycCCkfGc7b
	15JM1M52FSPY9F3zR2T7ulKfzKdNB9EGFeFLJcR1ExbN9XMgCtsVFb9ox36G1UDoDa11quRPKfhZ+
	F4+BOVwcdll9SPTbNxhhEAYjncuB8kHTkY9m4s1DOepu9jiGXAQdzyxbHVReSrW/2l/EG9Wcdbg75
	jkC8HicIiM9rLJOa9BWlq+/QFFdYbaagahvqpqDq5S8he5+aqljcAYy6dorHHisGgm2vvk8Av8x6r
	lcAeqzenbsLBVYw/9/vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgeB3-007MsT-0R;
	Thu, 14 Sep 2023 04:42:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgeB0-007Mrj-2B
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 04:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694666521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gXhGZ4r4I1glj6Lql+/mnOOXVMF05GnccbGV18evrsY=;
	b=dBV4gTF28Wspc2sW4neV2zf1Bn3vxH2Tt2DmRsvyS30c5+Fdr7E19p0ZSpxfqiaxfxwFU6
	029f0PIeK65oFs1hN7YA3oW1Cp8fG7HIBJOcHcQy+3ALrXbvTaboQjDG61S3zMAtj6aCAV
	CU/Oa9MReSW1l1VoO0INzF+DblDcAZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-Y8Vp1GdGOnaFVVQXkIOowA-1; Thu, 14 Sep 2023 00:41:58 -0400
X-MC-Unique: Y8Vp1GdGOnaFVVQXkIOowA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086B2101A529;
	Thu, 14 Sep 2023 04:41:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01CD92026D4B;
	Thu, 14 Sep 2023 04:41:56 +0000 (UTC)
Date: Thu, 14 Sep 2023 12:41:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Kexec-ml <kexec@lists.infradead.org>,
	Dave Young <dyoung@redhat.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 2/2] powerpc/fadump: make is_kdump_kernel() return
 false when fadump is active
Message-ID: <ZQKPEd09+XvnQ5RN@MiWiFi-R3L-srv>
References: <20230912082950.856977-1-hbathini@linux.ibm.com>
 <20230912082950.856977-2-hbathini@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230912082950.856977-2-hbathini@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_214202_929358_2F3FD5C1 
X-CRM114-Status: GOOD (  19.46  )
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

On 09/12/23 at 01:59pm, Hari Bathini wrote:
> Currently, is_kdump_kernel() returns true in crash dump capture kernel
> for both kdump and fadump crash dump capturing methods, as both these
> methods set elfcorehdr_addr. Some restrictions enforced for crash dump
> capture kernel, based on is_kdump_kernel(), are specifically meant for
> kdump case and not desirable for fadump - eg. IO queues restriction in
> device drivers. So, define is_kdump_kernel() to return false when f/w
> assisted dump is active.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kexec.h |  8 ++++++--
>  arch/powerpc/kernel/crash_dump.c | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index a1ddba01e7d1..e1b43aa12175 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -99,10 +99,14 @@ void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_co
>  
>  void kexec_copy_flush(struct kimage *image);
>  
> -#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_PPC_RTAS)
> +#if defined(CONFIG_CRASH_DUMP)
> +bool is_kdump_kernel(void);
> +#define is_kdump_kernel			is_kdump_kernel
> +#if defined(CONFIG_PPC_RTAS)
>  void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
>  #define crash_free_reserved_phys_range crash_free_reserved_phys_range
> -#endif
> +#endif /* CONFIG_PPC_RTAS */
> +#endif /* CONFIG_CRASH_DUMP */
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops kexec_elf64_ops;
> diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
> index 9a3b85bfc83f..2086fa6cdc25 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -19,6 +19,7 @@
>  #include <linux/uio.h>
>  #include <asm/rtas.h>
>  #include <asm/inst.h>
> +#include <asm/fadump.h>
>  
>  #ifdef DEBUG
>  #include <asm/udbg.h>
> @@ -92,6 +93,17 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
>  	return csize;
>  }
>  
> +/*
> + * Return true only when kexec based kernel dump capturing method is used.
> + * This ensures all restritions applied for kdump case are not automatically
> + * applied for fadump case.
> + */
> +bool is_kdump_kernel(void)
> +{
> +	return !is_fadump_active() && elfcorehdr_addr != ELFCORE_ADDR_MAX;
> +}
> +EXPORT_SYMBOL_GPL(is_kdump_kernel);
> +
>  #ifdef CONFIG_PPC_RTAS
>  /*
>   * The crashkernel region will almost always overlap the RTAS region, so
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

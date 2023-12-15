Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D239AC4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 03:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u/elnMP2RzQtij+yg+jpMrIug2/icnhAd91TT9iRrR0=; b=W+VAJp0XxnblEU
	O9wNdetENIiIS3e743EhcFL7lcHUfkqCpK8gPMN+exLsTaeIp3AdDxdLxYGnJ9kNVkRLHtx6j4Rf1
	NrWEsnGangBOW2S6SWaLaqkmkm+s1fbod19j56xXPt+olH/MvN403yIebwq/KURmMfWB0PXIo0zKa
	3ggUwpmKYi+Ft4eHEEo3uh9SUFSp4c3QRBXCawbZqO2kMVg6j1PjQkE9NKxYxDaiYYUzwEzOFBVmh
	GJnq4OqDFlO75Ll9kuYQ1gLRKj7MoByKkxZC329dUeKvSaSu7DR4pofFeeH1XvM3bhjUpDEmNUGcN
	qWLWoxIf3POMlRYwT7qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDyrj-001u0Y-22;
	Fri, 15 Dec 2023 03:27:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDyrh-001u09-0X
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 03:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwL29/cvUYFmPMFizthvB5mbwWT7pj5mVWcUZ0VQ95E=;
	b=SdpO9BQaaq6+8Yp+Ixl36T6hv7/PCRybo8GMsu6AEU+sk5PnFIBysgBI2NmniRuA2y8ZVs
	P46obyMCAg2OKv6CrdXPYTFGS4lY/llb5wV7ocPYuz3bzH/PGkvJL7g648ag0yksAa9obj
	2e5VAobBiwwEmyMxkXVUM/ozV6EeYgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-YCg3eLfLP4ybHpWIskAtsg-1; Thu, 14 Dec 2023 22:27:48 -0500
X-MC-Unique: YCg3eLfLP4ybHpWIskAtsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD7A6101A555;
	Fri, 15 Dec 2023 03:27:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB4140C6EB9;
	Fri, 15 Dec 2023 03:27:46 +0000 (UTC)
Date: Fri, 15 Dec 2023 11:27:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH 1/3] x86/crash: remove the unused image parameter from
 prepare_elf_headers()
Message-ID: <ZXvHrx9ODn1yW9hf@MiWiFi-R3L-srv>
References: <20231214163842.129139-1-ytcoode@gmail.com>
 <20231214163842.129139-2-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231214163842.129139-2-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_192753_271324_6613BB26 
X-CRM114-Status: GOOD (  18.67  )
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

On 12/15/23 at 12:38am, Yuntao Wang wrote:
> The image parameter is no longer in use, remove it. Also, tidy up the code
> formatting.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  arch/x86/kernel/crash.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c92d88680dbf..792231a56d11 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -198,8 +198,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  }
>  
>  /* Prepare elf headers. Return addr and size */
> -static int prepare_elf_headers(struct kimage *image, void **addr,
> -					unsigned long *sz, unsigned long *nr_mem_ranges)
> +static int prepare_elf_headers(void **addr, unsigned long *sz,
> +			       unsigned long *nr_mem_ranges)
>  {
>  	struct crash_mem *cmem;
>  	int ret;
> @@ -221,7 +221,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>  	*nr_mem_ranges = cmem->nr_ranges;
>  
>  	/* By default prepare 64bit headers */
> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> +	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
>  
>  out:
>  	vfree(cmem);
> @@ -349,7 +349,7 @@ int crash_load_segments(struct kimage *image)
>  				  .buf_max = ULONG_MAX, .top_down = false };
>  
>  	/* Prepare elf headers and add a segment */
> -	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
> +	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
>  	if (ret)
>  		return ret;
>  
> @@ -452,7 +452,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>  	 * memory resources.
>  	 */
> -	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
> +	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
>  		pr_err("unable to create new elfcorehdr");
>  		goto out;
>  	}
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

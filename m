Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E07C4332F
	for <kexec@archiver.kernel.org>; Wed, 23 Nov 2022 09:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AGoAYDr2ps/42U7aLJjgMjruuq9B1uvidjZajlUd89w=; b=K1rkX5qrREEy0m
	d8Y3DVlhakForbUf7eRQJY3vAOUlkI/lMc5r8zX58BDbo3E84BQT2ZzPi5Hdq6kRkMO+dI8VIL4sK
	uLlvaTO5IWMS9wh54ZDlbK8Nmn5VUmwDLFd07wg5knebnt8FL+zvtlwx94bDt816IT2xHO4b3eVqe
	AFQPv+gPUNsozpJNQF/2e6lU8DAmCOGjno/Cup9m4f1OpmQ5K3B+LJps6lAIfue0TXsZV5ficNA7Q
	zWQE2rFIElLIG6P2jhmu6s19aoaIzogFsGL2nn8hXqAOk9y4azYHNLGl939nrh3wflQ7JAzq+TLTL
	8OoGYFA+xUvGJHt1jRqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxlul-00Fs0z-Ea; Wed, 23 Nov 2022 09:19:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxlui-00FrzM-Ti
	for kexec@lists.infradead.org; Wed, 23 Nov 2022 09:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669195167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aK7FG2L1PbYXzCkxJlo0c+C2rvK2f9QzG4uJLco5WU0=;
	b=cnzntXDhk5sJqIqZjUUXxsmvUE3im+gug7VwEJxDaDwAU0OkZ8KIIgi0mc8NUhP6ngm9Fy
	FNiT7mAj9iHIAPip/y8+uV5HBRBT1OcCfgkvWqZxqleFFo8E56EItDrq7tJUJSgNNUx+jr
	pzT91Vp4JNNmaBoF5D+Cw4ho3x2T/Y8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-tJtivWKBNduayrvGkcJG2A-1; Wed, 23 Nov 2022 04:19:23 -0500
X-MC-Unique: tJtivWKBNduayrvGkcJG2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48BF91C004EB;
	Wed, 23 Nov 2022 09:19:23 +0000 (UTC)
Received: from localhost (ovpn-13-118.pek2.redhat.com [10.72.13.118])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 46DC3112131B;
	Wed, 23 Nov 2022 09:19:21 +0000 (UTC)
Date: Wed, 23 Nov 2022 17:19:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kexec: Fix double-free of elf header buffer
Message-ID: <Y33lkRP23X3tN1Px@MiWiFi-R3L-srv>
References: <20221122115122.13937-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221122115122.13937-1-tiwai@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221123_011929_053390_E577E797 
X-CRM114-Status: GOOD (  21.01  )
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

CC kexec@lists.infradead.org

On 11/22/22 at 12:51pm, Takashi Iwai wrote:
> The recent fix for memory leaks forgot to clear the error path that
> already does vfree() for the elf headers.  This may result in a
> double-free.

Good catch. 

The log can be improved to make the issue more obvious. How about this:
======
With commit b3e34a47f989 ("x86/kexec: fix memory leak of elf header
buffer"), freeing up image->elf_headers in error path of
crash_load_segments() is not needed, because later
kimage_file_post_load_cleanup() will cover it. And not clearing it could 
result in a double-free.

Drop the superfluous vfree() call at the error path of
crash_load_segments().
========

Other than the log part, LGTM. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Drop the superfluous vfree() call at the error path of
> crash_load_segments().
> 
> Fixes: b3e34a47f989 ("x86/kexec: fix memory leak of elf header buffer")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  arch/x86/kernel/crash.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9730c88530fc..305514431f26 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -401,10 +401,8 @@ int crash_load_segments(struct kimage *image)
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> -	if (ret) {
> -		vfree((void *)image->elf_headers);
> +	if (ret)
>  		return ret;
> -	}
>  	image->elf_load_addr = kbuf.mem;
>  	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>  		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> -- 
> 2.35.3
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

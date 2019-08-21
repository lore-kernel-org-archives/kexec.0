Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0F0x-0002Uj-P5
 for kexec@lists.infradead.org; Wed, 21 Aug 2019 01:02:18 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7L11sw4015177
 for <kexec@lists.infradead.org>; Tue, 20 Aug 2019 21:02:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ugnuqp94m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 20 Aug 2019 21:02:15 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Wed, 21 Aug 2019 02:02:14 +0100
References: <20190715082702.27308-1-svens@stackframe.org>
 <20190715082702.27308-7-svens@stackframe.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 6/7] kexec_elf: remove unused variable in
 kexec_elf_load()
In-reply-to: <20190715082702.27308-7-svens@stackframe.org>
Date: Tue, 20 Aug 2019 22:02:06 -0300
MIME-Version: 1.0
Message-Id: <87sgpvmiup.fsf@morokweng.localdomain>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org, deller@gmx.de, Sven Schnelle <svens@stackframe.org>


Sven Schnelle <svens@stackframe.org> writes:

> base was never assigned, so we can remove it.
>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  kernel/kexec_elf.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
> index e346659af324..9421eebbacf0 100644
> --- a/kernel/kexec_elf.c
> +++ b/kernel/kexec_elf.c
> @@ -350,7 +350,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>  			 struct kexec_buf *kbuf,
>  			 unsigned long *lowest_load_addr)
>  {
> -	unsigned long base = 0, lowest_addr = UINT_MAX;
> +	unsigned long lowest_addr = UINT_MAX;
>  	int ret;
>  	size_t i;
>  
> @@ -372,7 +372,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>  		kbuf->bufsz = size;
>  		kbuf->memsz = phdr->p_memsz;
>  		kbuf->buf_align = phdr->p_align;
> -		kbuf->buf_min = phdr->p_paddr + base;
> +		kbuf->buf_min = phdr->p_paddr;
>  		ret = kexec_add_buffer(kbuf);
>  		if (ret)
>  			goto out;
> @@ -382,9 +382,6 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>  			lowest_addr = load_addr;
>  	}
>  
> -	/* Update entry point to reflect new load address. */
> -	ehdr->e_entry += base;
> -
>  	*lowest_load_addr = lowest_addr;
>  	ret = 0;
>   out:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

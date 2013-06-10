Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Um2Hh-0002kN-5I
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 13:37:21 +0000
Received: by mail-vc0-f172.google.com with SMTP id ib11so4402438vcb.31
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 06:36:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370624161-2298-3-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-3-git-send-email-holzheu@linux.vnet.ibm.com>
Date: Mon, 10 Jun 2013 22:36:57 +0900
Message-ID: <CABOkKT13E-nkhu1j06OPqR2dMiK6WbTMp2rPj4mzom_+uDBziQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] s390/vmcore: Use ELF header in new memory feature
From: HATAYAMA Daisuke <d.hatayama@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

2013/6/8 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
<cut>
> @@ -417,27 +416,44 @@ static void s390_elf_corehdr_create(char **elfcorebuf, size_t *elfcorebuf_sz)
>         ptr = notes_init(phdr_notes, ptr, ((unsigned long) hdr) + hdr_off);
>         /* Init loads */
>         hdr_off = PTR_DIFF(ptr, hdr);
> -       loads_init(phdr_loads, ((unsigned long) hdr) + hdr_off);
> -       *elfcorebuf_sz = hdr_off;
> -       *elfcorebuf = (void *) relocate((unsigned long) hdr);
> -       BUG_ON(*elfcorebuf_sz > alloc_size);
> +       loads_init(phdr_loads, hdr_off);
> +       elfcorehdr_addr = (unsigned long long) hdr;
> +       elfcorehdr_size = (unsigned long long) hdr_off;
> +       elfcorehdr_newmem = hdr;
> +       BUG_ON(elfcorehdr_size > alloc_size);
> +       return 0;
>  }
>
>  /*
> - * Create kdump ELF core header in new kernel, if it has not been passed via
> - * the "elfcorehdr" kernel parameter
> + * Free ELF core header (new kernel)
>   */
> -static int setup_kdump_elfcorehdr(void)
> +void elfcorehdr_free(void)
>  {
> -       size_t elfcorebuf_sz;
> -       char *elfcorebuf;
> -
> -       if (!OLDMEM_BASE || is_kdump_kernel())
> -               return -EINVAL;
> -       s390_elf_corehdr_create(&elfcorebuf, &elfcorebuf_sz);
> -       elfcorehdr_addr = (unsigned long long) elfcorebuf;
> -       elfcorehdr_size = elfcorebuf_sz;
> -       return 0;
> +       if (!elfcorehdr_newmem)
> +               return;
> +       vfree(elfcorehdr_newmem);

kfree is correct here?

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

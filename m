Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-vb0-x22b.google.com ([2607:f8b0:400c:c02::22b])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Um2GQ-0002hZ-1P
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 13:36:03 +0000
Received: by mail-vb0-f43.google.com with SMTP id e12so1869793vbg.30
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 06:35:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370624161-2298-2-git-send-email-holzheu@linux.vnet.ibm.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-2-git-send-email-holzheu@linux.vnet.ibm.com>
Date: Mon, 10 Jun 2013 22:35:30 +0900
Message-ID: <CABOkKT33diYR+7Nt9HdRxxqnb1KGkUz8YLTjGODsv2s5vj+3og@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] vmcore: Introduce ELF header in new memory feature
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
> @@ -935,10 +967,17 @@ static int __init vmcore_init(void)
>  {
>         int rc = 0;
>
> -       /* If elfcorehdr= has been passed in cmdline, then capture the dump.*/
> -       if (!(is_vmcore_usable()))
> -               return rc;
> +       /*
> +        * If elfcorehdr= has not been passed in cmdline, try to get the
> +        * header from 2nd kernel, then capture the dump.
> +        */
> +       if (!(is_vmcore_usable())) {
> +               rc = elfcorehdr_alloc();
> +               if (rc)
> +                       return rc;
> +       }

Here you removed comment in the 1st path. Please keep it.

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

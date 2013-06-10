Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Um2St-00033I-CQ
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 13:48:56 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 14:44:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E2841219005E
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 14:51:38 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5ADm95W51773472
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 13:48:09 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5ADmJZk002705
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 07:48:19 -0600
Date: Mon, 10 Jun 2013 15:48:17 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/5] s390/vmcore: Use ELF header in new memory feature
Message-ID: <20130610154817.3275672f@holzheu>
In-Reply-To: <CABOkKT13E-nkhu1j06OPqR2dMiK6WbTMp2rPj4mzom_+uDBziQ@mail.gmail.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-3-git-send-email-holzheu@linux.vnet.ibm.com>
 <CABOkKT13E-nkhu1j06OPqR2dMiK6WbTMp2rPj4mzom_+uDBziQ@mail.gmail.com>
Mime-Version: 1.0
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
To: HATAYAMA Daisuke <d.hatayama@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 10 Jun 2013 22:36:57 +0900
HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:

> > -static int setup_kdump_elfcorehdr(void)
> > +void elfcorehdr_free(void)
> >  {
> > -       size_t elfcorebuf_sz;
> > -       char *elfcorebuf;
> > -
> > -       if (!OLDMEM_BASE || is_kdump_kernel())
> > -               return -EINVAL;
> > -       s390_elf_corehdr_create(&elfcorebuf, &elfcorebuf_sz);
> > -       elfcorehdr_addr = (unsigned long long) elfcorebuf;
> > -       elfcorehdr_size = elfcorebuf_sz;
> > -       return 0;
> > +       if (!elfcorehdr_newmem)
> > +               return;
> > +       vfree(elfcorehdr_newmem);  
> 
> kfree is correct here?

You are right, I fixed that!

Thanks!
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

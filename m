Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Um2Xh-00039C-NU
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 13:53:54 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 14:48:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4886017D8059
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 14:54:48 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5ADrH2k53477492
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 13:53:17 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5ADrRRb006219
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 07:53:27 -0600
Date: Mon, 10 Jun 2013 15:53:25 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/5] vmcore: Introduce ELF header in new memory feature
Message-ID: <20130610155325.5e75f243@holzheu>
In-Reply-To: <CABOkKT33diYR+7Nt9HdRxxqnb1KGkUz8YLTjGODsv2s5vj+3og@mail.gmail.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-2-git-send-email-holzheu@linux.vnet.ibm.com>
 <CABOkKT33diYR+7Nt9HdRxxqnb1KGkUz8YLTjGODsv2s5vj+3og@mail.gmail.com>
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

On Mon, 10 Jun 2013 22:35:30 +0900
HATAYAMA Daisuke <d.hatayama@gmail.com> wrote:

> 2013/6/8 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> <cut>
> > @@ -935,10 +967,17 @@ static int __init vmcore_init(void)
> >  {
> >         int rc = 0;
> >
> > -       /* If elfcorehdr= has been passed in cmdline, then capture the dump.*/
> > -       if (!(is_vmcore_usable()))
> > -               return rc;
> > +       /*
> > +        * If elfcorehdr= has not been passed in cmdline, try to get the
> > +        * header from 2nd kernel, then capture the dump.
> > +        */
> > +       if (!(is_vmcore_usable())) {
> > +               rc = elfcorehdr_alloc();
> > +               if (rc)
> > +                       return rc;
> > +       }
> 
> Here you removed comment in the 1st path. Please keep it.

Perhaps something like the following:

/*
 * If elfcorehdr= has been passed in cmdline, then capture the dump.
 * Otherwise, try to get the header from the 2nd kernel.
 */

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

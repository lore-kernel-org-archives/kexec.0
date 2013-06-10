Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ulx1n-000340-41
 for kexec@lists.infradead.org; Mon, 10 Jun 2013 08:00:35 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 10 Jun 2013 08:56:22 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 346601B08067
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 09:00:08 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5A7xu4G50069754
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 07:59:56 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r5A805nJ011382
 for <kexec@lists.infradead.org>; Mon, 10 Jun 2013 02:00:06 -0600
Date: Mon, 10 Jun 2013 10:00:00 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130610100000.23743ea1@holzheu>
In-Reply-To: <CAJGZr0+_W0dp2f9VtVAiUT2fqiwe91gHXd9zYzfMMzBZSZogww@mail.gmail.com>
References: <1370624161-2298-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1370624161-2298-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <CAJGZr0+_W0dp2f9VtVAiUT2fqiwe91gHXd9zYzfMMzBZSZogww@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Sat, 8 Jun 2013 11:38:00 +0400
Maxim Uvarov <muvarov@gmail.com> wrote:

[snip]

> > +static int copy_to(void *target, void *src, size_t size, int
> > userbuf) +{
> > +       if (userbuf) {
> > +               if (copy_to_user(target, src, size))
> > +                       return -EFAULT;
> > +               return 0;
> > +       } else {
> > +               memcpy(target, src, size);
> > +               return 0;
> > +       }
> > +}
> >  
> 
> It is better to do return 0 in the end of function.

Sure, I will change that.

Thanks!
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

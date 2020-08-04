Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2x4j-0007HC-Cc
 for kexec@lists.infradead.org; Tue, 04 Aug 2020 13:33:54 +0000
Received: by mail-il1-x12a.google.com with SMTP id 77so5705770ilc.5
 for <kexec@lists.infradead.org>; Tue, 04 Aug 2020 06:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <1596116005-27511-1-git-send-email-kernelfans@gmail.com>
 <ee585548-aefc-ff3f-6a79-e616b9e04f12@linux.ibm.com>
In-Reply-To: <ee585548-aefc-ff3f-6a79-e616b9e04f12@linux.ibm.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 4 Aug 2020 21:33:39 +0800
Message-ID: <CAFgQCTt=qjaYtOUvt7sy1PiSo1sDdGn9Dktyu9O26QXagvbNFQ@mail.gmail.com>
Subject: Re: [PATCHv4 1/2] powerpc/pseries: group lmb operation and memblock's
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
To: Laurent Dufour <ldufour@linux.ibm.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Kexec Mailing List <kexec@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Hari Bathini <hbathini@linux.ibm.com>, Nathan Fontenot <nfont@linux.vnet.ibm.com>

On Mon, Aug 3, 2020 at 9:52 PM Laurent Dufour <ldufour@linux.ibm.com> wrote:
>
> > @@ -603,6 +606,8 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
> >         }
> >
> >         lmb_set_nid(lmb);
> > +       lmb->flags |= DRCONF_MEM_ASSIGNED;
> > +
> >         block_sz = memory_block_size_bytes();
> >
> >         /* Add the memory */
>
> Since the lmb->flags is now set earlier, you should unset it in the case the
> call to __add_memory() fails, something like:
>
> @@ -614,6 +614,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>         rc = __add_memory(lmb->nid, lmb->base_addr, block_sz);
>         if (rc) {
>                 invalidate_lmb_associativity_index(lmb);
> +               lmb->flags &= ~DRCONF_MEM_ASSIGNED;
You are right. I will fix it in V5.

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

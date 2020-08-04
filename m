Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2x9R-0007XX-Oo
 for kexec@lists.infradead.org; Tue, 04 Aug 2020 13:38:46 +0000
Received: by mail-io1-xd43.google.com with SMTP id s189so34967228iod.2
 for <kexec@lists.infradead.org>; Tue, 04 Aug 2020 06:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <1596116005-27511-1-git-send-email-kernelfans@gmail.com>
 <1596116005-27511-2-git-send-email-kernelfans@gmail.com>
 <951e4406-1172-09a3-a8db-6f0a92aea2ed@linux.ibm.com>
In-Reply-To: <951e4406-1172-09a3-a8db-6f0a92aea2ed@linux.ibm.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 4 Aug 2020 21:38:33 +0800
Message-ID: <CAFgQCTs-A9=AEbU=x9OA6UyBd0wf20arLVtWKshu3oTo=BjGww@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] powerpc/pseries: update device tree before ejecting
 hotplug uevents
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

On Tue, Aug 4, 2020 at 12:29 AM Laurent Dufour <ldufour@linux.ibm.com> wrote:
>
[...]
> >       lmb_set_nid(lmb);
> >       lmb->flags |= DRCONF_MEM_ASSIGNED;
> > +     if (dt_update) {
> > +             ret = drmem_update_dt();
> > +             if (ret)
> > +                     pr_warn("%s fail to update dt, but continue\n", __func__);
> > +     }
> >
> >       block_sz = memory_block_size_bytes();
>
> In the case the call to __add_memory is failing, the flag DRCONF_MEM_ASSIGNED
> should be cleared as I mentioned in your previous patch. In addition to this,
Yes.
> the DT should be updated, or the caller should manage that but that will be hard
> since it doesn't know where the error happened in this function.
Yeah, it is hard to manage it by caller, so just updating dt  is a
easier method.
>
> >
> > @@ -625,7 +653,11 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
> >               invalidate_lmb_associativity_index(lmb);
> >               lmb_clear_nid(lmb);
> >               lmb->flags &= ~DRCONF_MEM_ASSIGNED;
> > -
> > +             if (dt_update) {
> > +                     ret = drmem_update_dt();
> > +                     if (ret)
> > +                             pr_warn("%s fail to update dt during rollback, but continue\n", __func__);
> > +             }
> >               __remove_memory(nid, base_addr, block_sz);
> >       }
> >
> > @@ -638,6 +670,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
> >       int lmbs_available = 0;
> >       int lmbs_added = 0;
> >       int rc;
> > +     bool dt_update = false;
> >
> >       pr_info("Attempting to hot-add %d LMB(s)\n", lmbs_to_add);
> >
> > @@ -664,7 +697,7 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
> >               if (rc)
> >                       continue;
> >
> > -             rc = dlpar_add_lmb(lmb);
> > +             rc = dlpar_add_lmb(lmb, dt_update);
> >               if (rc) {
> >                       dlpar_release_drc(lmb->drc_index);
> >                       continue;
> > @@ -678,16 +711,23 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add)
> >               lmbs_added++;
> >               if (lmbs_added == lmbs_to_add)
> >                       break;
> > +             else if (lmbs_added == lmbs_to_add - 1)
> > +                     dt_update = true;
>
> In the case the number of LMB to add is 1, dt_update is never set to true, and
> the device tree is never updated. You need to set dt_update to true earlier in
> the loop block.
Oh, I will fix it in V5
>
> >       }
> >
> >       if (lmbs_added != lmbs_to_add) {
> > +             bool rollback_dt_update = false;
> > +
> >               pr_err("Memory hot-add failed, removing any added LMBs\n");
> >
> >               for_each_drmem_lmb(lmb) {
> >                       if (!drmem_lmb_reserved(lmb))
> >                               continue;
> >
> > -                     rc = dlpar_remove_lmb(lmb);
> > +                     if (--lmbs_added == 0 && dt_update)
> > +                             rollback_dt_update = true;
>
> That test may have to be review to deal with error during the last LMB addition,
> the DT may have been updated before __add_memory() is failing in
> dlpar_add_lmb(). In that case, lmbs_added == 0 and that branch is not covered.
> That's not an issue if dlpar_add_lmb() is handling that case (see my comment above).
I will fix it in next version.

Thanks for your review.

Regards,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

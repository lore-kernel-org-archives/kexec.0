Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX0nz-008YIY-VB
 for kexec@lists.infradead.org; Thu, 15 Apr 2021 12:09:09 +0000
Date: Thu, 15 Apr 2021 14:09:02 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCHv5 2/2] powerpc/pseries: update device tree before
 ejecting hotplug uevents
Message-ID: <20210415120902.GI6564@kitsune.suse.cz>
References: <1597049570-19536-1-git-send-email-kernelfans@gmail.com>
 <1597049570-19536-2-git-send-email-kernelfans@gmail.com>
 <17369122-3e37-1360-0f68-827a8104cd35@linux.ibm.com>
 <CAFgQCTs58dOcO0CGVDD1WxiOE9yaPe_WG-U=t+=at45bAipQ_A@mail.gmail.com>
 <20210409163323.GP6564@kitsune.suse.cz>
 <CAFgQCTsTWiYcuiipWmnieuNTWTar30aAUOsE3L9CcrVBiQix3A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFgQCTsTWiYcuiipWmnieuNTWTar30aAUOsE3L9CcrVBiQix3A@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>, Nathan Lynch <nathanl@linux.ibm.com>, Kexec Mailing List <kexec@lists.infradead.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Hari Bathini <hbathini@linux.ibm.com>

Hello,

On Wed, Apr 14, 2021 at 11:08:19AM +0800, Pingfan Liu wrote:
> On Sat, Apr 10, 2021 at 12:33 AM Michal Such=E1nek <msuchanek@suse.de> wr=
ote:
> >
> > Hello,
> >
> > On Fri, Aug 28, 2020 at 04:10:09PM +0800, Pingfan Liu wrote:
> > > On Thu, Aug 27, 2020 at 3:53 PM Laurent Dufour <ldufour@linux.ibm.com=
> wrote:
> > > >
> > > > Le 10/08/2020 =E0 10:52, Pingfan Liu a =E9crit :
> > > > > A bug is observed on pseries by taking the following steps on rhe=
l:
> > > > > -1. drmgr -c mem -r -q 5
> > > > > -2. echo c > /proc/sysrq-trigger
> > > > >
> > > > > And then, the failure looks like:
> > > > > kdump: saving to /sysroot//var/crash/127.0.0.1-2020-01-16-02:06:1=
4/
> > > > > kdump: saving vmcore-dmesg.txt
> > > > > kdump: saving vmcore-dmesg.txt complete
> > > > > kdump: saving vmcore
> > > > >   Checking for memory holes                         : [  0.0 %] /=
                   Checking for memory holes                         : [100=
.0 %] |                   Excluding unnecessary pages                      =
 : [100.0 %] \                   Copying data                              =
        : [  0.3 %] -          eta: 38s[   44.337636] hash-mmu: mm: Hashing=
 failure ! EA=3D0x7fffba400000 access=3D0x8000000000000004 current=3Dmakedu=
mpfile
> > > > > [   44.337663] hash-mmu:     trap=3D0x300 vsid=3D0x13a109c ssize=
=3D1 base psize=3D2 psize 2 pte=3D0xc000000050000504
> > > > > [   44.337677] hash-mmu: mm: Hashing failure ! EA=3D0x7fffba40000=
0 access=3D0x8000000000000004 current=3Dmakedumpfile
> > > > > [   44.337692] hash-mmu:     trap=3D0x300 vsid=3D0x13a109c ssize=
=3D1 base psize=3D2 psize 2 pte=3D0xc000000050000504
> > > > > [   44.337708] makedumpfile[469]: unhandled signal 7 at 00007fffb=
a400000 nip 00007fffbbc4d7fc lr 000000011356ca3c code 2
> > > > > [   44.338548] Core dump to |/bin/false pipe failed
> > > > > /lib/kdump-lib-initramfs.sh: line 98:   469 Bus error            =
   $CORE_COLLECTOR /proc/vmcore $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-i=
ncomplete
> > > > > kdump: saving vmcore failed
> > > > >
> > > > > * Root cause *
> > > > >    After analyzing, it turns out that in the current implementati=
on,
> > > > > when hot-removing lmb, the KOBJ_REMOVE event ejects before the dt=
 updating as
> > > > > the code __remove_memory() comes before drmem_update_dt().
> > > > > So in kdump kernel, when read_from_oldmem() resorts to
> > > > > pSeries_lpar_hpte_insert() to install hpte, but fails with -2 due=
 to
> > > > > non-exist pfn. And finally, low_hash_fault() raise SIGBUS to proc=
ess, as it
> > > > > can be observed "Bus error"
> > > > >
> > > > >  From a viewpoint of listener and publisher, the publisher notifi=
es the
> > > > > listener before data is ready.  This introduces a problem where u=
dev
> > > > > launches kexec-tools (due to KOBJ_REMOVE) and loads a stale dt be=
fore
> > > > > updating. And in capture kernel, makedumpfile will access the mem=
ory based
> > > > > on the stale dt info, and hit a SIGBUS error due to an un-existed=
 lmb.
> > > > >
> > > > > * Fix *
> > > > > This bug is introduced by commit 063b8b1251fd
> > > > > ("powerpc/pseries/memory-hotplug: Only update DT once per memory =
DLPAR
> > > > > request"), which tried to combine all the dt updating into one.
> > > > >
> > > > > To fix this issue, meanwhile not to introduce a quadratic runtime
> > > > > complexity by the model:
> > > > >    dlpar_memory_add_by_count
> > > > >      for_each_drmem_lmb             <--
> > > > >        dlpar_add_lmb
> > > > >          drmem_update_dt(_v1|_v2)
> > > > >            for_each_drmem_lmb       <--
> > > > > The dt should still be only updated once, and just before the las=
t memory
> > > > > online/offline event is ejected to user space. Achieve this by tr=
acing the
> > > > > num of lmb added or removed.
> > > > >
> > > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > > > Cc: Hari Bathini <hbathini@linux.ibm.com>
> > > > > Cc: Nathan Lynch <nathanl@linux.ibm.com>
> > > > > Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> > > > > Cc: Laurent Dufour <ldufour@linux.ibm.com>
> > > > > To: linuxppc-dev@lists.ozlabs.org
> > > > > Cc: kexec@lists.infradead.org
> > > > > ---
> > > > > v4 -> v5: change dlpar_add_lmb()/dlpar_remove_lmb() prototype to =
report
> > > > >            whether dt is updated successfully.
> > > > >            Fix a condition boundary check bug
> > > > > v3 -> v4: resolve a quadratic runtime complexity issue.
> > > > >            This series is applied on next-test branch
> > > > >   arch/powerpc/platforms/pseries/hotplug-memory.c | 102 +++++++++=
++++++++++-----
> > > > >   1 file changed, 80 insertions(+), 22 deletions(-)
> > > > >
> > > > > diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/ar=
ch/powerpc/platforms/pseries/hotplug-memory.c
> > > > > index 46cbcd1..1567d9f 100644
> > > > > --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> > > > > +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > > > > @@ -350,13 +350,22 @@ static bool lmb_is_removable(struct drmem_l=
mb *lmb)
> > > > >       return true;
> > > > >   }
> > > > >
> > > > > -static int dlpar_add_lmb(struct drmem_lmb *);
> > > > > +enum dt_update_status {
> > > > > +     DT_NOUPDATE,
> > > > > +     DT_TOUPDATE,
> > > > > +     DT_UPDATED,
> > > > > +};
> > > > > +
> > > > > +/* "*dt_update" returns DT_UPDATED if updated */
> > > > > +static int dlpar_add_lmb(struct drmem_lmb *lmb,
> > > > > +             enum dt_update_status *dt_update);
> > > > >
> > > > > -static int dlpar_remove_lmb(struct drmem_lmb *lmb)
> > > > > +static int dlpar_remove_lmb(struct drmem_lmb *lmb,
> > > > > +             enum dt_update_status *dt_update)
> > > > >   {
> > > > >       unsigned long block_sz;
> > > > >       phys_addr_t base_addr;
> > > > > -     int rc, nid;
> > > > > +     int rc, ret, nid;
> > > > >
> > > > >       if (!lmb_is_removable(lmb))
> > > > >               return -EINVAL;
> > > > > @@ -372,6 +381,13 @@ static int dlpar_remove_lmb(struct drmem_lmb=
 *lmb)
> > > > >       invalidate_lmb_associativity_index(lmb);
> > > > >       lmb_clear_nid(lmb);
> > > > >       lmb->flags &=3D ~DRCONF_MEM_ASSIGNED;
> > > > > +     if (*dt_update) {
> > > Original, I plan to use it to exclude the case of DT_NOUPDATE, which =
is value 0.
> > > And I think it looks better by using if (*dt_update =3D=3D DT_TOUPDAT=
E)
> > > >
> > > > That test is wrong, you should do:
> > > >          if (*dt_update && *dt_update =3D=3D DT_TOUPDATE) {
> > > I think you mean  if (dt_update && *dt_update =3D=3D DT_TOUPDATE) {
> > > >
> > > > With the current code, the device tree is updated all the time.
> > > >
> > > > Another option would be to pass a valid pointer (!=3D NULL) only wh=
en DT update is
> > > > required, this way you don't need the DT_TOUPDATE value. The caller=
 would have
> > > > to set the pointer accordingly. The advantage with this option is t=
he caller is
> > > > guaranteed that its variable is not touched by the callee when no d=
evice tree is
> > > > requested. A simple boolean pointer would be enough without the nee=
d to this enum.
> > > It is expected that dlpar_remove_lmb/dlpar_add_lmb can report whether
> > > they successfully update dt or not. So the caller can handle the
> > > different cases.
> >
> > Is there any plan to refresh this patch to apply to master?
> >
> Spreading the failure and rollback logic around the code looks urgly.
> Even myself dislike it. But I have not found a better way out.
> =

> > I am using an older revision of this patch so I am not in the position
> > to repost an updated version.
> >
> > I lack some otimization in my patch so I probably have the quadratic
> > coplexity of the add mentioned above.
> >
> Do you have any good ideas?

I am not very familiar with the code and I am not sure I will have time
to look closer at it anytime soon.

Computation complexity is traded for code complexity and it is not clear
if the tradeoff is good.

As a way forward I would suggest to split the patch into a minimal
correctness fix and an additional optimization that avoids needless
computation.

That way the extra code complexity and the speed improvement brought by
the optimization can be reviewed more easily.

I don't have myself access to any big machine so can't tell if the
optimization solves a real world problem either.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

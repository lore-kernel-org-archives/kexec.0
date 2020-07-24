Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jywkt-000200-P2
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 12:24:52 +0000
Received: by mail-il1-x144.google.com with SMTP id b18so1855911ilo.12
 for <kexec@lists.infradead.org>; Fri, 24 Jul 2020 05:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
 <1595382730-10565-2-git-send-email-kernelfans@gmail.com>
 <87imee1hvt.fsf@linux.ibm.com>
In-Reply-To: <87imee1hvt.fsf@linux.ibm.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Fri, 24 Jul 2020 20:24:37 +0800
Message-ID: <CAFgQCTu_QO=50v2J0=aY2iV8P-oM82_Kfw9My600ZARUt01grw@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] powerpc/pseries: update device tree before ejecting
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
To: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, cheloha@linux.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>, ldufour@linux.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Hari Bathini <hbathini@linux.ibm.com>

On Thu, Jul 23, 2020 at 9:27 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
>
> Pingfan Liu <kernelfans@gmail.com> writes:
> > A bug is observed on pseries by taking the following steps on rhel:
> > -1. drmgr -c mem -r -q 5
> > -2. echo c > /proc/sysrq-trigger
> >
> > And then, the failure looks like:
> > kdump: saving to /sysroot//var/crash/127.0.0.1-2020-01-16-02:06:14/
> > kdump: saving vmcore-dmesg.txt
> > kdump: saving vmcore-dmesg.txt complete
> > kdump: saving vmcore
> >  Checking for memory holes                         : [  0.0 %] /                   Checking for memory holes                         : [100.0 %] |                   Excluding unnecessary pages                       : [100.0 %] \                   Copying data                                      : [  0.3 %] -          eta: 38s[   44.337636] hash-mmu: mm: Hashing failure ! EA=0x7fffba400000 access=0x8000000000000004 current=makedumpfile
> > [   44.337663] hash-mmu:     trap=0x300 vsid=0x13a109c ssize=1 base psize=2 psize 2 pte=0xc000000050000504
> > [   44.337677] hash-mmu: mm: Hashing failure ! EA=0x7fffba400000 access=0x8000000000000004 current=makedumpfile
> > [   44.337692] hash-mmu:     trap=0x300 vsid=0x13a109c ssize=1 base psize=2 psize 2 pte=0xc000000050000504
> > [   44.337708] makedumpfile[469]: unhandled signal 7 at 00007fffba400000 nip 00007fffbbc4d7fc lr 000000011356ca3c code 2
> > [   44.338548] Core dump to |/bin/false pipe failed
> > /lib/kdump-lib-initramfs.sh: line 98:   469 Bus error               $CORE_COLLECTOR /proc/vmcore $_mp/$KDUMP_PATH/$HOST_IP-$DATEDIR/vmcore-incomplete
> > kdump: saving vmcore failed
> >
> > * Root cause *
> >   After analyzing, it turns out that in the current implementation,
> > when hot-removing lmb, the KOBJ_REMOVE event ejects before the dt updating as
> > the code __remove_memory() comes before drmem_update_dt().
> > So in kdump kernel, when read_from_oldmem() resorts to
> > pSeries_lpar_hpte_insert() to install hpte, but fails with -2 due to
> > non-exist pfn. And finally, low_hash_fault() raise SIGBUS to process, as it
> > can be observed "Bus error"
> >
> > From a viewpoint of listener and publisher, the publisher notifies the
> > listener before data is ready.  This introduces a problem where udev
> > launches kexec-tools (due to KOBJ_REMOVE) and loads a stale dt before
> > updating. And in capture kernel, makedumpfile will access the memory based
> > on the stale dt info, and hit a SIGBUS error due to an un-existed lmb.
> >
> > * Fix *
> >   In order to fix this issue, update dt before __remove_memory(), and
> > accordingly the same rule in hot-add path.
> >
> > This will introduce extra dt updating payload for each involved lmb when hotplug.
> > But it should be fine since drmem_update_dt() is memory based operation and
> > hotplug is not a hot path.
>
> This is great analysis but the performance implications of the change
> are grave. The add/remove paths here are already O(n) where n is the
> quantity of memory assigned to the LP, this change would make it O(n^2):
>
> dlpar_memory_add_by_count
>   for_each_drmem_lmb             <--
>     dlpar_add_lmb
>       drmem_update_dt(_v1|_v2)
>         for_each_drmem_lmb       <--
>
> Memory add/remove isn't a hot path but quadratic runtime complexity
> isn't acceptable. Its current performance is bad enough that I have
Yes, the quadratic runtime complexity sounds terrible.
And I am curious about the bug. Does the system have thousands of lmb?

> internal bugs open on it.
>
> Not to mention we leak memory every time drmem_update_dt is called
> because we can't safely free device tree properties :-(
Do you know what block us to free it?
>
> Also note that this sort of reverts (fixes?) 063b8b1251fd
> ("powerpc/pseries/memory-hotplug: Only update DT once per memory DLPAR
> request").
Yes. And now, I think I need to bring up another method to fix it.

Thanks,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

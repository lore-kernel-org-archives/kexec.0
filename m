Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bilbo.ozlabs.org ([203.11.71.1] helo=ozlabs.org)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyUvW-00084Y-16
 for kexec@lists.infradead.org; Thu, 23 Jul 2020 06:41:59 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv3 2/2] powerpc/pseries: update device tree before ejecting
 hotplug uevents
In-Reply-To: <CAFgQCTsgX9XWJ476dxT2csTuuhpaO3KSZN-EewZiZ0mBj3N4aQ@mail.gmail.com>
References: <1595382730-10565-1-git-send-email-kernelfans@gmail.com>
 <1595382730-10565-2-git-send-email-kernelfans@gmail.com>
 <87pn8oqh86.fsf@mpe.ellerman.id.au>
 <CAFgQCTsgX9XWJ476dxT2csTuuhpaO3KSZN-EewZiZ0mBj3N4aQ@mail.gmail.com>
Date: Thu, 23 Jul 2020 16:41:50 +1000
Message-ID: <875zaeravl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>, Kexec Mailing List <kexec@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Hari Bathini <hbathini@linux.ibm.com>

Pingfan Liu <kernelfans@gmail.com> writes:
> On Wed, Jul 22, 2020 at 12:57 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Pingfan Liu <kernelfans@gmail.com> writes:
>> > A bug is observed on pseries by taking the following steps on rhel:
>>                                                                 ^
>>                                                                 RHEL
>>
>> I assume it happens on mainline too?
> Yes, it does.
>>
> [...]
>> > diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> > index 1a3ac3b..def8cb3f 100644
>> > --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> > +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> > @@ -372,6 +372,7 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>> >       invalidate_lmb_associativity_index(lmb);
>> >       lmb_clear_nid(lmb);
>> >       lmb->flags &= ~DRCONF_MEM_ASSIGNED;
>> > +     drmem_update_dt();
>>
>> No error checking?
> Hmm, here should be a more careful design. Please see the comment at the end.
>>
>> >       __remove_memory(nid, base_addr, block_sz);
>> >
>> > @@ -607,6 +608,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>> >
>> >       lmb_set_nid(lmb);
>> >       lmb->flags |= DRCONF_MEM_ASSIGNED;
>> > +     drmem_update_dt();
>>
>> And here ..
>> >
>> >       block_sz = memory_block_size_bytes();
>> >
>> > @@ -625,6 +627,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>> >               invalidate_lmb_associativity_index(lmb);
>> >               lmb_clear_nid(lmb);
>> >               lmb->flags &= ~DRCONF_MEM_ASSIGNED;
>> > +             drmem_update_dt();
>>
>>
>> And here ..
>>
>> >               __remove_memory(nid, base_addr, block_sz);
>> >       }
>> > @@ -877,9 +880,6 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>> >               break;
>> >       }
>> >
>> > -     if (!rc)
>> > -             rc = drmem_update_dt();
>> > -
>> >       unlock_device_hotplug();
>> >       return rc;
>>
>> Whereas previously we did check it.
>
> drmem_update_dt() fails iff allocating memory fail.

That's true currently, but it might change in future.

> And in the failed case, even the original code does not roll back the
> effect of __add_memory()/__remove_memory().

Yeah hard to know what the desired behaviour is. If something fails we
at least need to print a message though, not silently swallow it.

> And I plan to do the following in V4: if drmem_update_dt() fails in
> dlpar_add_lmb(), then bails out immediately.

That sounds reasonable.

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

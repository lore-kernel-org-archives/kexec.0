Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWOa7-007HGK-0N
 for kexec@lists.infradead.org; Tue, 13 Apr 2021 19:20:16 +0000
Received: by mail-io1-xd2f.google.com with SMTP id h141so9836174iof.2
 for <kexec@lists.infradead.org>; Tue, 13 Apr 2021 12:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618254007.git.ashish.kalra@amd.com>
 <c349516d85d9e3fc7404d564ff81d7ebecc1162c.1618254007.git.ashish.kalra@amd.com>
 <CABayD+cNLdoPHYvw0ZAXZS2wRg4cCFGTMvON0Ja2cWJ4juHNbA@mail.gmail.com>
 <CABayD+c2P9miY2pKG=k1Ey3cj6RZG98WgssLCnBJgoW9Fng7gg@mail.gmail.com>
 <20210413014821.GA3276@ashkalra_ubuntu_server>
 <CABayD+dqg+CYm4hAc6gRY6ygpbgpm-a7jo6ZGotbcA3arq9yQg@mail.gmail.com>
 <20210413114712.GA3996@ashkalra_ubuntu_server>
In-Reply-To: <20210413114712.GA3996@ashkalra_ubuntu_server>
From: Steve Rutherford <srutherford@google.com>
Date: Tue, 13 Apr 2021 12:19:37 -0700
Message-ID: <CABayD+fx5++vD0LHEysvQ4Wj9VDa_spUo2dUouCds5EiYFyHMg@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] x86/kvm: Add kexec support for SEV Live
 Migration.
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
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, Venu Busireddy <venu.busireddy@oracle.com>, Brijesh Singh <brijesh.singh@amd.com>, kexec@lists.infradead.org

On Tue, Apr 13, 2021 at 4:47 AM Ashish Kalra <ashish.kalra@amd.com> wrote:
>
> On Mon, Apr 12, 2021 at 07:25:03PM -0700, Steve Rutherford wrote:
> > On Mon, Apr 12, 2021 at 6:48 PM Ashish Kalra <ashish.kalra@amd.com> wrote:
> > >
> > > On Mon, Apr 12, 2021 at 06:23:32PM -0700, Steve Rutherford wrote:
> > > > On Mon, Apr 12, 2021 at 5:22 PM Steve Rutherford <srutherford@google.com> wrote:
> > > > >
> > > > > On Mon, Apr 12, 2021 at 12:48 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> > > > > >
> > > > > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > > > >
> > > > > > Reset the host's shared pages list related to kernel
> > > > > > specific page encryption status settings before we load a
> > > > > > new kernel by kexec. We cannot reset the complete
> > > > > > shared pages list here as we need to retain the
> > > > > > UEFI/OVMF firmware specific settings.
> > > > > >
> > > > > > The host's shared pages list is maintained for the
> > > > > > guest to keep track of all unencrypted guest memory regions,
> > > > > > therefore we need to explicitly mark all shared pages as
> > > > > > encrypted again before rebooting into the new guest kernel.
> > > > > >
> > > > > > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > > > > > ---
> > > > > >  arch/x86/kernel/kvm.c | 24 ++++++++++++++++++++++++
> > > > > >  1 file changed, 24 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > > > > > index bcc82e0c9779..4ad3ed547ff1 100644
> > > > > > --- a/arch/x86/kernel/kvm.c
> > > > > > +++ b/arch/x86/kernel/kvm.c
> > > > > > @@ -39,6 +39,7 @@
> > > > > >  #include <asm/cpuidle_haltpoll.h>
> > > > > >  #include <asm/ptrace.h>
> > > > > >  #include <asm/svm.h>
> > > > > > +#include <asm/e820/api.h>
> > > > > >
> > > > > >  DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
> > > > > >
> > > > > > @@ -384,6 +385,29 @@ static void kvm_pv_guest_cpu_reboot(void *unused)
> > > > > >          */
> > > > > >         if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> > > > > >                 wrmsrl(MSR_KVM_PV_EOI_EN, 0);
> > > > > > +       /*
> > > > > > +        * Reset the host's shared pages list related to kernel
> > > > > > +        * specific page encryption status settings before we load a
> > > > > > +        * new kernel by kexec. NOTE: We cannot reset the complete
> > > > > > +        * shared pages list here as we need to retain the
> > > > > > +        * UEFI/OVMF firmware specific settings.
> > > > > > +        */
> > > > > > +       if (sev_live_migration_enabled & (smp_processor_id() == 0)) {
> > > > > What happens if the reboot of CPU0 races with another CPU servicing a
> > > > > device request (while the reboot is pending for that CPU)?
> > > > > Seems like you could run into a scenario where you have hypercalls racing.
> > > > >
> > > > > Calling this on every core isn't free, but it is an easy way to avoid this race.
> > > > > You could also count cores, and have only last core do the job, but
> > > > > that seems more complicated.
> > > > On second thought, I think this may be insufficient as a fix, since my
> > > > read of kernel/reboot.c seems to imply that devices aren't shutdown
> > > > until after these notifiers occur. As such, a single thread might be
> > > > able to race with itself. I could be wrong here though.
> > > >
> > > > The heavy hammer would be to disable migration through the MSR (which
> > > > the subsequent boot will re-enable).
> > > >
> > > > I'm curious if there is a less "blocking" way of handling kexecs (that
> > > > strategy would block LM while the guest booted).
> > > >
> > > > One option that comes to mind would be for the guest to "mute" the
> > > > encryption status hypercall after the call to reset the encryption
> > > > status. The problem would be that the encryption status for pages
> > > > would be very temporarily inaccurate in the window between that call
> > > > and the start of the next boot. That isn't ideal, but, on the other
> > > > hand, the VM was about to reboot anyway, so a corrupted shared page
> > > > for device communication probably isn't super important. Still, I'm
> > > > not really a fan of that. This would avoid corrupting the next boot,
> > > > which is clearly an improvement.
> > > >
> > > > Each time the kernel boots it could also choose something like a
> > > > generation ID, and pass that down each time it calls the hypercall.
> > > > This would then let userspace identify which requests were coming from
> > > > the subsequent boot.
> > > >
> > > > Everything here (except, perhaps, disabling migration through the MSR)
> > > > seems kind of complicated. I somewhat hope my interpretation of
> > > > kernel/reboot.c is wrong and this race just is not possible in the
> > > > first place.
> > > >
> > >
> > > Disabling migration through the MSR after resetting the page encryption
> > > status is a reasonable approach. There is a similar window existing for
> > > normal VM boot during which LM is disabled, from the point where OVMF
> > > checks and adds support for SEV LM and the kernel boot checks for the
> > > same and enables LM using the MSR.
> >
> > I'm not totally confident that disabling LM through the MSR is
> > sufficient. I also think the newly booted kernel needs to reset the
> > state itself, since nothing stops the hypercalls after the disable
> > goes through. The host won't know the difference between early boot
> > (pre-enablement) hypercalls and racy just-before-restart hypercalls.
> > You might disable migration through the hypercall, get a late status
> > change hypercall, reboot, then re-enable migration, but still have
> > stale state.
> >
> > I _believe_ that the kernel doesn't mark it's RAM as private on boot
> > as an optimization (might be wrong about this), since it would have
> > been expensive to mark all of ram as encrypted previously. I believe
> > that is no longer a limitation given the KVM_EXIT, so we can reset
> > this during early boot instead of just before the kexec.
> >
>
> I was wondering if disabling both migration (via the MSR) and "muting"
> the hypercall using the "sev_live_migration_enabled" variable after the
> page encryption status has been reset, will reset the page encryption
> status of the guest to the (last known/good) configuration available to
> the guest at boot time (i.e, all RAM pages marked as private and UEFI
> setup shared MMIO/device regions, etc).
>
> But disabling migration and muting hypercalls after page encryption
> status reset is still "racy" with hypercalls on other vCPUS, and that
> can potentially mess-up the page encryption status available to guest
> after kexec.
>
> So probably, as you mentioned above, resetting the page encryption
> status during early boot (immediately after detecting host support for
> migration and enabling the hypercalls) instead of just before the kexec
> is a good fix.
That strategy sounds good to me.

Thanks,
Steve
>
> Thanks,
> Ashish
>
> > > > > > +               int i;
> > > > > > +               unsigned long nr_pages;
> > > > > > +
> > > > > > +               for (i = 0; i < e820_table->nr_entries; i++) {
> > > > > > +                       struct e820_entry *entry = &e820_table->entries[i];
> > > > > > +
> > > > > > +                       if (entry->type != E820_TYPE_RAM)
> > > > > > +                               continue;
> > > > > > +
> > > > > > +                       nr_pages = DIV_ROUND_UP(entry->size, PAGE_SIZE);
> > > > > > +
> > > > > > +                       kvm_sev_hypercall3(KVM_HC_PAGE_ENC_STATUS,
> > > > > > +                                          entry->addr, nr_pages, 1);
> > > > > > +               }
> > > > > > +       }
> > > > > >         kvm_pv_disable_apf();
> > > > > >         kvm_disable_steal_time();
> > > > > >  }
> > > > > > --
> > > > > > 2.17.1
> > > > > >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

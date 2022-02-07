From: Baoquan He <bhe@redhat.com>
Date: Mon, 7 Feb 2022 16:33:35 +0800
Subject: [PATCH V3] panic: Move panic_print before kmsg dumpers
In-Reply-To: <MWHPR21MB15933C9D208DF3973877B1C3D7279@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <YegytkfED+QI56Y8@alley> <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <MWHPR21MB1593A32A3433F5F262796FCFD75B9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20220122043351.GA2596@MiWiFi-R3L-srv>
 <MWHPR21MB15933573F5C81C5250BF6A1CD75E9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <YfE1zuhB2Qz73wqF@alley> <20220129080027.GC17613@MiWiFi-R3L-srv>
 <MWHPR21MB15933C9D208DF3973877B1C3D7279@MWHPR21MB1593.namprd21.prod.outlook.com>
Message-ID: <YgDZX4PYwhrA1+Ct@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/02/22 at 05:43pm, Michael Kelley (LINUX) wrote:
> From: Baoquan He <bhe@redhat.com> Sent: Saturday, January 29, 2022 12:00 AM
> > 
> > On 01/26/22 at 12:51pm, Petr Mladek wrote:
> > > On Mon 2022-01-24 16:57:17, Michael Kelley (LINUX) wrote:
> > > > From: Baoquan He <bhe@redhat.com> Sent: Friday, January 21, 2022 8:34 PM
> > > > >
> > > > > On 01/21/22 at 03:00pm, Michael Kelley (LINUX) wrote:
> > > > > > From: Baoquan He <bhe@redhat.com> Sent: Thursday, January 20, 2022 6:31 PM
> > > > > > >
> > > > > > > On 01/20/22 at 06:36pm, Guilherme G. Piccoli wrote:
> > > > > > > > Hi Baoquan, some comments inline below:
> > > > > > > >
> > > > > > > > On 20/01/2022 05:51, Baoquan He wrote:
> > > >
> > > > [snip]
> > > >
> > > > > > > > Do you think it should be necessary?
> > > > > > > > How about if we allow users to just "panic_print" with or without the
> > > > > > > > "crash_kexec_post_notifiers", then we pursue Petr suggestion of
> > > > > > > > refactoring the panic notifiers? So, after this future refactor, we
> > > > > > > > might have a much clear code.
> > > > > > >
> > > > > > > I haven't read Petr's reply in another panic notifier filter thread. For
> > > > > > > panic notifier, it's only enforced to use on HyperV platform, excepto of
> > > > > > > that, users need to explicitly add "crash_kexec_post_notifiers=1" to enable
> > > > > > > it. And we got bug report on the HyperV issue. In our internal discussion,
> > > > > > > we strongly suggest HyperV dev to change the default enablement, instead
> > > > > > > leave it to user to decide.
> > > > > > >
> > > > > >
> > > > > > Regarding Hyper-V:   Invoking the Hyper-V notifier prior to running the
> > > > > > kdump kernel is necessary for correctness.  During initial boot of the
> > > > > > main kernel, the Hyper-V and VMbus code in Linux sets up several guest
> > > > > > physical memory pages that are shared with Hyper-V, and that Hyper-V
> > > > > > may write to.   A VMbus connection is also established. Before kexec'ing
> > > > > > into the kdump kernel, the sharing of these pages must be rescinded
> > > > > > and the VMbus connection must be terminated.   If this isn't done, the
> > > > > > kdump kernel will see strange memory overwrites if these shared guest
> > > > > > physical memory pages get used for something else.
> > > >
> > > > In the Azure cloud, collecting data before crash dumps is a motivation
> > > > as well for setting crash_kexec_post_notifiers to true.   That way as
> > > > cloud operator we can see broad failure trends, and in specific cases
> > > > customers often expect the cloud operator to be able to provide info
> > > > about a problem even if they have taken a kdump.  Where did you
> > > > envision adding a comment in the code to help clarify these intentions?
> > > >
> > > > I looked at the code again, and should revise my previous comments
> > > > somewhat.   The Hyper-V resets that I described indeed must be done
> > > > prior to kexec'ing the kdump kernel.   Most such resets are actually
> > > > done via __crash_kexec() -> machine_crash_shutdown(), not via the
> > > > panic notifier. However, the Hyper-V panic notifier must terminate the
> > > > VMbus connection, because that must be done even if kdump is not
> > > > being invoked.  See commit 74347a99e73.
> > > >
> > > > Most of the hangs seen in getting into the kdump kernel on Hyper-V/Azure
> > > > were probably due to the machine_crash_shutdown() path, and not due
> > > > to running the panic notifiers prior to kexec'ing the kdump kernel.  The
> > > > exception is terminating the VMbus connection, which had problems that
> > > > are hopefully now fixed because of adding a timeout.
> > >
> > > My undestanding is that we could split the actions into three groups:
> > >
> > >   1. Actions that has to be before kexec'ing kdump kernel, like
> > >      resetting physicall memory shared with Hyper-V.
> > >
> > >      These operation(s) are needed only for kexec and can be done
> > >      in kexec.
> > >
> > >
> > >    2. Notify Hyper-V so that, for example, Azure cloud, could collect
> > >       data before crash dump.
> > >
> > >       It is nice to have.
> > >
> > >       It should be configurable if it is not completely safe. I mean
> > >       that there should be a way to disable it when it might increase
> > >       the risk that kexec'ing kdump kernel might fail.
> > >
> > >
> > >    3. Some actions are needed only when panic() ends up in the
> > >       infinite loop.
> > >
> > >       For example, unloading vmbus channel. At least the commit
> > >       74347a99e73ae00b8385f ("x86/Hyper-V: Unload vmbus channel in
> > >       hv panic callback") says that it is done in kdump path
> > >       out of box.
> > >
> > > All these operations are needed and used only when the kernel is
> > > running under Hyper-V.
> > >
> > > My mine intention is to understand if we need 2 or 3 notifier lists
> > > or the current one is enough.
> > >
> > > The 3 notifier lists would be:
> > >
> > >    + always do (even before kdump)
> > >    + optionally do before or after kdump
> > >    + needed only when kdump is not called
> > 
> > Totally agree with above suggesitons for Hyper-V. Cleanup as ablove
> > seems necesary. Stuffing them into panic_notifiers package is not
> > appropriate.
> 
> Baoquan -- if the concept of panic notifiers is broadened as Petr is
> proposing, with three different notifier lists, are you OK with the
> Hyper-V requirements being met that way?  Having a generic
> mechanism seems better to me than adding #ifdef CONFIG_HYPERV
> code into panic().

Yeah, after reading these two threads and rethinking, I think Petr's
proposing is reasonable. We may not call the 1st part which always do
(even before kdump) panic notifiers any more, they are split out from
the notifiers list and taken as a fixed code block, by the way.



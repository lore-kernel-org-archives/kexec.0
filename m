From: d.hatayama@fujitsu.com <d.hatayama@fujitsu.com>
Date: Mon, 24 Jan 2022 11:43:34 +0000
Subject: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
In-Reply-To: <20220122105514.GA18258@MiWiFi-R3L-srv>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley> <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
Message-ID: <TYAPR01MB650732FAB4E24D839DFF9EFD955E9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org


> On 01/21/22 at 05:31pm, Guilherme G. Piccoli wrote:
> ......
> > > IMHO, the right solution is to split the callbacks into 2 or more
> > > notifier list. Then we might rework panic() to do:
> > >
> > > void panic(void)
> > > {
> > >     [...]
> > >
> > >     /* stop watchdogs + extra info */
> > >     atomic_notifier_call_chain(&panic_disable_watchdogs_notifier_list, 0, buf);
> > >     atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
> > >     panic_print_sys_info();
> > >
> > >     /* crash_kexec + kmsg_dump in configurable order */
> > >     if (!_crash_kexec_post_kmsg_dump) {
> > >             __crash_kexec(NULL);
> > >             smp_send_stop();
> > >     } else {
> > >             crash_smp_send_stop();
> > >     }
> > >
> > >     kmsg_dump();
> > >     if (_crash_kexec_post_kmsg_dump)
> > >             __crash_kexec(NULL);
> > >
> > >     /* infinite loop or reboot */
> > >     atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
> > >     atomic_notifier_call_chain(&panic_rest_notifier_list, 0, buf);
> > >
> > >     console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> > > [...]
> > > Two notifier lists might be enough in the above scenario. I would call
> > > them:
> > >
> > >     panic_pre_dump_notifier_list
> > >     panic_post_dump_notifier_list
> > >
> > >
> > > It is a real solution that will help everyone. It is more complicated now
> > > but it will makes things much easier in the long term. And it might be done
> > > step by step:
> > >
> > >      1. introduce the two notifier lists
> > >      2. convert all users: one by one
> > >      3. remove the original notifier list when there is no user
> >
> > That's a great idea! I'm into it, if we have a consensus. The thing that
> > scares me most here is that this is a big change and consumes time to
> > implement - I'd not risk such time if somebody is really against that.
> > So, let's see more opinions, maybe the kdump maintainers have good input.
> 
> I am fine with it. As long as thing is made clear, glad to see code is
> refactored to be more understandable and improved. Earlier, during several
> rounds of discussion between you and Petr, seveal pitfalls have been
> pointed out and avoided.
> 
> Meanwhile, I would suggest Masa and HATAYAMA to help give input about
> panic_notifier usage and refactory. AFAIK, they contributed code and use
> panic_notifier in their product or environment a lot, that will be very
> helpful to get the first hand information from them.
> 
> Hi Masa, HATAYANA,
> 
> Any comment on this? (Please ignore this if it's not in your care.)
> 

Thanks for CCing to me. I like this patch set. I have same motivation.

For example, when I used crash_kexec_post_notifiers, I sometimes ran into
deadlock in printk's exclusion logic during the call of panic notifiers since
kaslr outputs kernel offset at panic by dump_kernel_offset() via panic notifers
(although this might never happen now thanks to lockless implementation).

The problem is that in the current design, we have to run all the
tasks registered, although most of them are actually unnecessary for
other users' requirements. Each user wants to call only their own handlers
in order to keep kdump as reliable as possible.

I've just started reading this patch set and have no other comments for now.

Thanks.
HATAYAMA, Daisuke


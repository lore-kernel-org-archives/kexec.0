From: Michael Kelley (LINUX) <mikelley@microsoft.com>
Date: Tue, 3 May 2022 17:44:03 +0000
Subject: [PATCH 19/30] panic: Add the panic hypervisor notifier list
In-Reply-To: <0147d038-571b-0802-c210-ccd4d52cd5dd@igalia.com>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-20-gpiccoli@igalia.com>
 <PH0PR21MB30256260CCF4CAB713BBB11ED7FC9@PH0PR21MB3025.namprd21.prod.outlook.com>
 <0147d038-571b-0802-c210-ccd4d52cd5dd@igalia.com>
Message-ID: <PH0PR21MB30257E4E6E16BB8FFDE8F312D7C09@PH0PR21MB3025.namprd21.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Friday, April 29, 2022 11:04 AM
> 
> On 29/04/2022 14:30, Michael Kelley (LINUX) wrote:
> > From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Wednesday, April 27, 2022
> 3:49 PM
> >> [...]
> >>
> >> @@ -2843,7 +2843,7 @@ static void __exit vmbus_exit(void)
> >>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> >>  		kmsg_dump_unregister(&hv_kmsg_dumper);
> >>  		unregister_die_notifier(&hyperv_die_report_block);
> >> -		atomic_notifier_chain_unregister(&panic_notifier_list,
> >> +		atomic_notifier_chain_unregister(&panic_hypervisor_list,
> >>  						&hyperv_panic_report_block);
> >>  	}
> >>
> >
> > Using the hypervisor_list here produces a bit of a mismatch.  In many cases
> > this notifier will do nothing, and will defer to the kmsg_dump() mechanism
> > to notify the hypervisor about the panic.   Running the kmsg_dump()
> > mechanism is linked to the info_list, so I'm thinking the Hyper-V panic report
> > notifier should be on the info_list as well.  That way the reporting behavior
> > is triggered at the same point in the panic path regardless of which
> > reporting mechanism is used.
> >
> 
> Hi Michael, thanks for your feedback! I agree that your idea could work,
> but...there is one downside: imagine the kmsg_dump() approach is not set
> in some Hyper-V guest, then we would rely in the regular notification
> mechanism [hv_die_panic_notify_crash()], right?
> But...you want then to run this notifier in the informational list,
> which...won't execute *by default* before kdump if no kmsg_dump() is
> set. So, this logic is convoluted when you mix it with the default level
> concept + kdump.

Yes, you are right.  But to me that speaks as much to the linkage
between the informational list and kmsg_dump() being the core
problem.  But as I described in my reply to Patch 24, I can live with
the linkage as-is.

FWIW, guests on newer versions of Hyper-V will always register a
kmsg dumper.  The flags that are tested to decide whether to
register provide compatibility with older versions of Hyper-V that 
don?t support the 4K bytes of notification info.

> 
> May I suggest something? If possible, take a run with this patch set +
> DEBUG_NOTIFIER=y, in *both* cases (with and without the kmsg_dump()
> set). I did that and they run almost at the same time...I've checked the
> notifiers called, it's like almost nothing runs in-between.
> 
> I feel the panic notification mechanism does really fit with a
> hypervisor list, it's a good match with the nature of the list, which
> aims at informing the panic notification to the hypervisor/FW.
> Of course we can modify it if you prefer...but please take into account
> the kdump case and how it complicates the logic.

I agree that the runtime effect of one list vs. the other is nil.  The
code works and can stay as you written it.

I was trying to align from a conceptual standpoint.  It was a bit
unexpected that one path would be on the hypervisor list, and the
other path effectively on the informational list.  When I see
conceptual mismatches like that, I tend to want to understand why,
and if there is something more fundamental that is out-of-whack.


> 
> Let me know your considerations, in case you can experiment with the
> patch set as-is.
> Cheers,
> 
> 
> Guilherme

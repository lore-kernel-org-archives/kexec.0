Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1brOov-00044D-BG
 for kexec@lists.infradead.org; Tue, 04 Oct 2016 12:27:42 +0000
Date: Tue, 4 Oct 2016 14:27:17 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
Message-ID: <20161004122717.GA4998@krava>
References: <1475514432-27682-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.20.1610041241160.7712@nanos>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610041241160.7712@nanos>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, dyoung@redhat.com

On Tue, Oct 04, 2016 at 12:58:04PM +0200, Thomas Gleixner wrote:
> On Mon, 3 Oct 2016, Prarit Bhargava wrote:
> > BUG: unable to handle kernel paging request at 0000000000841f1f
> > IP: [<ffffffff81014ec4>] uncore_change_context+0xd4/0x180
> ...
> >  [<ffffffff81015a60>] ? uncore_cpu_starting+0x130/0x130
> >  [<ffffffff81015acc>] uncore_event_cpu_online+0x6c/0x80
> >  [<ffffffff8108e819>] cpuhp_invoke_callback+0x49/0x100
> >  [<ffffffff8108ead1>] cpuhp_thread_fun+0x41/0x100
> >  [<ffffffff810b054f>] smpboot_thread_fn+0x10f/0x160
> >  [<ffffffff810b0440>] ? sort_range+0x30/0x30
> >  [<ffffffff810accd8>] kthread+0xd8/0xf0
> >  [<ffffffff816ff4bf>] ret_from_fork+0x1f/0x40
> >  [<ffffffff810acc00>] ? kthread_park+0x60/0x60
> 
> > arch/x86/events/intel/uncore.c:
> > 1137 static void uncore_change_type_ctx(struct intel_uncore_type *type, int old_     cpu,
> > 1138                                    int new_cpu)
> > 1139 {
> > 1140         struct intel_uncore_pmu *pmu = type->pmus;
> > 1141         struct intel_uncore_box *box;
> > 1142         int i, pkg;
> > 1143
> > 1144         pkg = topology_logical_package_id(old_cpu < 0 ? new_cpu : old_cpu);
> > 1145         for (i = 0; i < type->num_boxes; i++, pmu++) {
> > 1146                 box = pmu->boxes[pkg];
> > 
> > pmu->boxes[pkg] is garbage because pkg was returned as 0xffff.
> 
> And that's what needs to be fixed in the first place.

right, I'll check on that.. but I think we need this fix as well

> 
> > This patch adds the missing generic_processor_info() to
> > prefill_possible_map() to ensure the initialization of the boot cpu is
> > correct. 
> 
> > This results in smp_init_package_map() having correct data and
> > properly setting the package map for the hotplugged boot cpu, which in
> > turn resolves the kdump kernel panic on physically hotplugged cpus.
> 
> While it is the right thing to initialize the package map in that case, it
> still papers over a robustness issue in the uncore code, which needs to be
> fixed first.
> 
> > [2] prefill_possible_map() is called before smp_store_boot_cpu_info().
> > The comment beside the call to smp_store_boot_cpu_info() states that the
> > completed call results in "Final full version of the data".
> 
> I'm not sure what that [2] here means and I cannot figure out the meaning
> of this sentence either.
> 
> This changelog is incomprehensible in general and more a "oh look how I
> decoded this problem" report than something which clearly describes the
> problem at hand, the root cause and the fix. The latter wants a
> understandable explanation why prefill_possible_map() is the right place to
> do this.

I was wondering if acpi_boot_init was a better place for that, but then
Prarit suggested in our discussion that the prefill_possible_map() call
seems to be a hotplug cleanup.. so it seemed to fit

however it's difficult to say with complex code like this,
so any ideas are welcome ;-)

thanks,
jirka

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

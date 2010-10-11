Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P5QDy-0000X2-4g
	for kexec@lists.infradead.org; Mon, 11 Oct 2010 21:48:03 +0000
Subject: Re: [RFC PATCH] Bug during kexec...not all cpus are stopped
From: Alok Kataria <akataria@vmware.com>
In-Reply-To: <20101011213901.GR12743@redhat.com>
References: <1286570087.8769.27.camel@ank32.eng.vmware.com>
	<1286816964.1372.2.camel@ank32.eng.vmware.com>
	<m1lj64ppri.fsf@fess.ebiederm.org>
	<1286826083.1372.15.camel@ank32.eng.vmware.com>
	<20101011213901.GR12743@redhat.com>
Date: Mon, 11 Oct 2010 14:47:59 -0700
Message-Id: <1286833679.1372.26.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Reply-To: akataria@vmware.com
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "jeremy@xensource.com" <jeremy@xensource.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Daniel Hecht <dhecht@vmware.com>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>


On Mon, 2010-10-11 at 14:39 -0700, Vivek Goyal wrote:
> On Mon, Oct 11, 2010 at 12:41:23PM -0700, Alok Kataria wrote:

> > --
> > 
> > x86 smp_ops now has a new op, stop_other_cpus which takes a parameter "wait"
> > this allows the caller to specify if it wants to stop untill all the cpus
> > have processed the stop IPI. This is required specifically for the kexec case
> > where we should wait for all the cpus to be stopped before starting the new
> > kernel.
> 
> > We now wait for the cpus to stop in all cases except for panic/kdump where
> > we expect things to be broken and we are doing our best to make things
> > work anyway.
> 
> I don't think that kdump path uses smp_send_stop().

Right, this should be removed from the patch description.

Belows is the new patch description
----------------------------------------------
x86 smp_ops now has a new op, stop_other_cpus which takes a parameter "wait"
this allows the caller to specify if it wants to stop untill all the cpus
have processed the stop IPI. This is required specifically for the kexec case
where we should wait for all the cpus to be stopped before starting the new
kernel.
We now wait for the cpus to stop in all cases except for panic where
we expect things to be broken and we are doing our best to make things
work anyway.
----------------------------------------------

> 
> IIUC, on x86, we directly send NMI to other cpus.
> 
> native_machine_crash_shutdown()
>   kdump_nmi_shootdown_cpus()
>         nmi_shootdown_cpus()
>            smp_send_nmi_allbutself
>                 apic->send_IPI_allbutself(NMI_VECTOR);
> 
> So above description should be limited to only panic() path.
> 
> On a side note, I am wondering why panic() and kdump path can't share the
> shutdown routine.

The comment in native_stop_other_cpus (native_smp_send_stop earlier)
explains why

        /*
         * Use an own vector here because smp_call_function
         * does lots of things not suitable in a panic situation.
         * On most systems we could also use an NMI here,
         * but there are a few systems around where NMI
         * is problematic so stay with an non NMI for now
         * (this implies we cannot stop CPUs spinning with irq off
         * currently)
         */


Thanks,
Alok
> 
> Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

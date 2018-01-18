Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ec0FG-0007WC-8J
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 02:48:03 +0000
Date: Thu, 18 Jan 2018 10:47:41 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec reboot fails with extra wbinvd introduced for AME SME
Message-ID: <20180118024741.GA1831@dhcp-128-65.nay.redhat.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
 <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
 <20180104031537.GA1819@dhcp-128-65.nay.redhat.com>
 <20180117072123.GA1866@dhcp-128-65.nay.redhat.com>
 <CA+55aFxCuz2K_kE3Huu3Ar32LVmWav__2CPL_=zs2g0devx9-Q@mail.gmail.com>
 <20180118014705.GA1812@dhcp-128-65.nay.redhat.com>
 <CA+55aFzc9eXKOdhS-ygQPbr0_N84d8iE8WbSGOWmpJXr1rvDjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFzc9eXKOdhS-ygQPbr0_N84d8iE8WbSGOWmpJXr1rvDjQ@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Tony Luck <tony.luck@intel.com>, Yu Chen <yu.c.chen@intel.com>, Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Ingo Molnar <mingo@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>, ebiederm@redhat.com, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 01/17/18 at 06:14pm, Linus Torvalds wrote:
> On Wed, Jan 17, 2018 at 5:47 PM, Dave Young <dyoung@redhat.com> wrote:
> >
> > It does not work with just once wbinvd(), and it only works with
> > removing the wbinvd() for me.  Tom's new post works for me as well
> > since my cpu is an Intel i5-4200U.
> 
> Intriguing.
> 
> It's not like the wbinvd really should be that much of a deal.
> 
> I think Tom's patch is fine and should be applied, but it does worry
> me a bit that even a single wbinvd makes that much of a difference for
> you. There is very little logical reason I can think of that a wbinvd
> should make any difference what-so-ever on an i5-4200U.
> 
> I wonder if you have some system issues, and wbinvd just happens to
> trigger them. But I think we do wbinvd before a suspend-to-RAM too
> (it's "ACPI_FLUSH_CPU_CACHE()" in the ACPI code). And the dmr code
> dioes "wbinvd_on_all_cpus()" which does a cross-call etc.
> 
> Would you mind experimenting a bit with that wbinvd?
> 
> In particular, what happens if you enable it (so it's not hidden by
> the SME check), but you move it up to before interrupts are disabled?

Did several quick tests, probably need more tests, but till now the
results are:

void stop_this_cpu(void *dummy)
{
=====> add wbinvd here: kexec works
        local_irq_disable();
=====> add wbinvd here: kexec works
        /*
         * Remove this CPU:
         */
        set_cpu_online(smp_processor_id(), false);
=====> add wbinvd here: kexec does not work
 
        disable_local_APIC();
        mcheck_cpu_clear(this_cpu_ptr(&cpu_info));

[snip]

So it seems that it will not work after cpu offined..

> 
> I'm wondering if there is some issue with MCE generation and wbinvd
> and whatever, and doing it when the CPU is down and interrupts are
> disabled causes some system issue..
> 
> Does anybody have any other ideas?
> 
>                 Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

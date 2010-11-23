Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 23 Nov 2010 14:41:38 +0200
From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] Add call to non-crashing cores through IPI
Message-ID: <20101123124138.GI14080@gw.healthdatacare.com>
References: <20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
	<AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
	<AANLkTi=Ok09NjwZQCb5njqgLfT=K8Zd2fK1VteRb_MNv@mail.gmail.com>
	<AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
	<AANLkTimC04kAFws0rAyvfARauiNvyYriJnxJ6KH+UHtU@mail.gmail.com>
	<AANLkTikh11_Mx6Z2po9t3RDp68te5o5LdnR0hYOexF=T@mail.gmail.com>
	<AANLkTi=u6MPrA4JqJ1C3dAC5FLZCb7vKNtDV4-bOkSBy@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=u6MPrA4JqJ1C3dAC5FLZCb7vKNtDV4-bOkSBy@mail.gmail.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Per Fransson <per.fransson.ml@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, kexec@lists.infradead.org, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Maxim Uvarov <muvarov@gmail.com>, linux-arm-kernel@lists.infradead.org

On Tue, Nov 23, 2010 at 12:37:04PM +0000, Catalin Marinas wrote:
> On 23 November 2010 10:57, Per Fransson <per.fransson.ml@gmail.com> wrote:
> >>> Am I right that deadlock can occur only if the same IPI was sent?
> >>
> >> Not necessarily. It depends on whether the CPU issuing the IPI needs
> >> to wait for the completion of the cross-call. If you don't need to
> >> wait, you can send the IPI with the interrupts disabled (the platform
> >> smp_cross_call is already called with interrupts disabled).
> >>
> >
> > Well, smp_call_function() only optionally waits. As long as we choose not to,
> > using that function to ask the other cores to save their states and idle, should
> > be ok, right? In that case we don't need another ipi_msg_type and we can do
> > it with the interrupts of the ipi caller disabled.
> 
> I think that should work but we still have a WARN_ON_ONCE in the
> generic smp_call_function_*() if interrupts are disabled.

But when we are crashing we have oops_in_progress set:

        WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
                     && !oops_in_progress);

so this warning is never printed, right?

MW

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

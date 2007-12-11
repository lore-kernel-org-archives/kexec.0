Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.184])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J2B8m-0006Fu-DS
	for kexec@lists.infradead.org; Tue, 11 Dec 2007 19:51:46 +0000
Received: by rv-out-0910.google.com with SMTP id c24so2164927rvf
	for <kexec@lists.infradead.org>; Tue, 11 Dec 2007 11:51:39 -0800 (PST)
Message-ID: <86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
Date: Tue, 11 Dec 2007 11:51:39 -0800
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
In-Reply-To: <20071211192434.GD10999@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <86802c440712070122q6e5824bcp12e1c3f560e2ab53@mail.gmail.com>
	<20071207175832.GA18485@hmsreliant.think-freely.org>
	<m1k5nm2g3w.fsf@ebiederm.dsl.xmission.com>
	<20071211034349.GA3635@localhost.localdomain>
	<m1ejdt25x0.fsf@ebiederm.dsl.xmission.com>
	<20071211143910.GA10999@hmsreliant.think-freely.org>
	<m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
	<20071211182254.GB10999@hmsreliant.think-freely.org>
	<m1ejdtysqd.fsf@ebiederm.dsl.xmission.com>
	<20071211192434.GD10999@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Dec 11, 2007 11:24 AM, Neil Horman <nhorman@tuxdriver.com> wrote:
> On Tue, Dec 11, 2007 at 11:46:34AM -0700, Eric W. Biederman wrote:
> > Neil Horman <nhorman@tuxdriver.com> writes:
> >
> > Ok. My only remaining nit to pick is that fix_hypertransport_config
> > is right in the middle of the nvidia quirks, which can be a bit
> > confusing when reading through the code.  Otherwise I think this
> > is a version that we can merge.
> >
> Sure, I'll move it to the top of the file
>
> > Let's get a clean description on this thing and send it to the
> > current x86 maintainers. Thomas, Ingo, and HPA
> >
>
> Clean Summary:
>
> Recently a kdump bug was discovered in which a system would hang inside
> calibrate_delay during the booting of the kdump kernel.  This was caused by the
> fact that the jiffies counter was not being incremented during timer
> calibration.  The root cause of this problem was found to be a bios
> misconfiguration of the hypertransport bus.  On system affected by this hang,
> the bios had assigned APIC ids which used extended apic bits (more than the
> nominal 4 bit ids's), but failed to configure bit 18 of the hypertransport

should be bit 17.

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

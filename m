Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsOye-0002W8-O0
 for kexec@lists.infradead.org; Fri, 07 Oct 2016 06:49:53 +0000
Date: Fri, 7 Oct 2016 08:49:27 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
Message-ID: <20161007064927.GA2200@krava>
References: <1475514432-27682-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.20.1610041241160.7712@nanos>
 <57F39C09.10001@redhat.com>
 <alpine.DEB.2.20.1610041628120.5049@nanos>
 <20161005161455.GA26029@krava> <57F66CF7.7040204@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57F66CF7.7040204@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, dyoung@redhat.com

On Thu, Oct 06, 2016 at 11:25:43AM -0400, Prarit Bhargava wrote:
> 
> 
> On 10/05/2016 12:14 PM, Jiri Olsa wrote:
> > On Tue, Oct 04, 2016 at 04:38:16PM +0200, Thomas Gleixner wrote:
> >> On Tue, 4 Oct 2016, Prarit Bhargava wrote:
> >>> On 10/04/2016 06:58 AM, Thomas Gleixner wrote:
> >>>> While it is the right thing to initialize the package map in that case, it
> >>>> still papers over a robustness issue in the uncore code, which needs to be
> >>>> fixed first.
> >>>
> >>> I will include a separate patch with an error check for pkg == 0xffff in the
> >>> uncore code.
> >>
> >> 0xffff? That won't help. The id returned is -1 if the entry is not
> >> initialized. And aside of that just patching that particular place is not
> >> helping as the uncore code and also rapl is relying on the package map
> >> being populated.
> >>
> >> So we need a sanity check in the initialization code which prevents any of
> >> this being executed.
> > 
> > I still need to test this, but how about something like this?
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
> > index 28865938aadf..61d087a2f25d 100644
> > --- a/arch/x86/events/intel/rapl.c
> > +++ b/arch/x86/events/intel/rapl.c
> > @@ -598,8 +598,13 @@ static int rapl_cpu_online(unsigned int cpu)
> >  
> >  static int rapl_cpu_prepare(unsigned int cpu)
> >  {
> > -	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
> > +	struct rapl_pmu *pmu;
> > +	int pkg = topology_logical_package_id(cpu);
> > +
> > +	if (WARN_ON(pkg == -1))
> > +		return -EINVAL;
> >  
> > +	pmu = cpu_to_rapl_pmu(cpu);
> >  	if (pmu)
> >  		return 0;
> 
> I thought about doing this but it seems like every time some driver uses
> topology_logical_package_id() the driver would have to replicate the error
> checking code.

hm, unless we guarantee topology_logical_package_id always
returns sane values I dont see another way

jirka

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

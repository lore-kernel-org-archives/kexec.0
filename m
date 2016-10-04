Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1brQdZ-0000Eq-Ic
 for kexec@lists.infradead.org; Tue, 04 Oct 2016 14:24:06 +0000
Date: Tue, 4 Oct 2016 16:19:59 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] arch/x86: Fix kdump on x86 with physically hotadded CPUs
In-Reply-To: <20161004122717.GA4998@krava>
Message-ID: <alpine.DEB.2.20.1610041618390.5049@nanos>
References: <1475514432-27682-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.20.1610041241160.7712@nanos> <20161004122717.GA4998@krava>
MIME-Version: 1.0
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
To: Jiri Olsa <jolsa@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, dyoung@redhat.com

On Tue, 4 Oct 2016, Jiri Olsa wrote:
> On Tue, Oct 04, 2016 at 12:58:04PM +0200, Thomas Gleixner wrote:
> > > pmu->boxes[pkg] is garbage because pkg was returned as 0xffff.
> > 
> > And that's what needs to be fixed in the first place.
> 
> right, I'll check on that.. but I think we need this fix as well

That's right.
 
> I was wondering if acpi_boot_init was a better place for that, but then
> Prarit suggested in our discussion that the prefill_possible_map() call
> seems to be a hotplug cleanup.. so it seemed to fit

It's the right place for it.

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

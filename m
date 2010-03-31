Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nx6O8-0005xh-5b
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 22:27:52 +0000
Date: Wed, 31 Mar 2010 15:24:50 -0700
From: "David N. Lombard" <dnlombar@ichips.intel.com>
Subject: Re: kdump/kexec on EFI-enabled x2apic platforms
Message-ID: <20100331222449.GB8257@nlxcldnl2.cl.intel.com>
References: <20100329200104.GA23760@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100329200104.GA23760@sgi.com>
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
To: Jack Steiner <steiner@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, "gleb@redhat.com" <gleb@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>

On Mon, Mar 29, 2010 at 01:01:04PM -0700, Jack Steiner wrote:
> All -
> 
> I just started debugging kdump/kexec on our UV platform and
> have run into some problems. I suspect others have encountered these
> same or similar problems. Any help would be appreciated.
> 
> 
> 
> Our platform uses EFI boot. It is Nehalem based & has a large number of cpus.
> The BIOS enables x2apic mode and the kernel runs with interrupt remapping enabled.
> Note that some apicids have more than 8 bits - x2apic mode is required.

What are you using as a boot loader?  I've tested kexec with elilo 3.8 and
got good results.  But, that was early last year, so I'll need to try it out
with production hardware and the current firmware and sw stack.  I'll try to
get to that this week, and let you know the results.

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

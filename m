Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HghIC-0000eC-NW
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 09:12:21 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/10] safe_apic_wait_icr_idle - x86_64
Date: Wed, 25 Apr 2007 15:11:59 +0200
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
	<200704251426.14398.ak@suse.de>
	<1177505712.19745.18.camel@sebastian.intellilink.co.jp>
In-Reply-To: <1177505712.19745.18.camel@sebastian.intellilink.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704251511.59495.ak@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Fernando Luis =?iso-8859-15?q?V=E1zquez_Cao?= <fernando@oss.ntt.co.jp>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, Keith Owens <kaos@ocs.com.au>, akpm@linux-foundation.org

On Wednesday 25 April 2007 14:55:12 Fernando Luis V=E1zquez Cao wrote:
> On Wed, 2007-04-25 at 14:26 +0200, Andi Kleen wrote:
> > >  static __inline__ void apic_wait_icr_idle(void)
> > >  {
> > > -	while (apic_read( APIC_ICR ) & APIC_ICR_BUSY)
> > > +	while (apic_read(APIC_ICR) & APIC_ICR_BUSY)
> > >  		cpu_relax();
> > >  }
> > >  =

> > > +static __inline__ unsigned int safe_apic_wait_icr_idle(void)
> > =

> > This should be probably not inline -- too large
> Hello Andi,
> =

> Thank you for reviewing the patches. Do you want me to resend the whole
> patch or should I cook a new one that un-inlines the function instead?

I already did that.

Also will apply Keith's suggestion.

-Andi




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

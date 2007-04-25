Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.oss.ntt.co.jp ([222.151.198.98] helo=serv1.oss.ntt.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hgh1e-0000TR-EY
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 08:55:15 -0400
Subject: Re: [PATCH 2/10] safe_apic_wait_icr_idle - x86_64
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>
In-Reply-To: <200704251426.14398.ak@suse.de>
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
	<1177499715.17974.12.camel@sebastian.intellilink.co.jp>
	<200704251426.14398.ak@suse.de>
Date: Wed, 25 Apr 2007 21:55:12 +0900
Message-Id: <1177505712.19745.18.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
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
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, Keith Owens <kaos@ocs.com.au>, akpm@linux-foundation.org

On Wed, 2007-04-25 at 14:26 +0200, Andi Kleen wrote:
> >  static __inline__ void apic_wait_icr_idle(void)
> >  {
> > -	while (apic_read( APIC_ICR ) & APIC_ICR_BUSY)
> > +	while (apic_read(APIC_ICR) & APIC_ICR_BUSY)
> >  		cpu_relax();
> >  }
> >  
> > +static __inline__ unsigned int safe_apic_wait_icr_idle(void)
> 
> This should be probably not inline -- too large
Hello Andi,

Thank you for reviewing the patches. Do you want me to resend the whole
patch or should I cook a new one that un-inlines the function instead?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

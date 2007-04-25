Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hggh4-0008Uq-50
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 08:34:01 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 2/10] safe_apic_wait_icr_idle - x86_64
Date: Wed, 25 Apr 2007 14:26:14 +0200
References: <1177498984.16078.37.camel@sebastian.intellilink.co.jp>
	<1177499715.17974.12.camel@sebastian.intellilink.co.jp>
In-Reply-To: <1177499715.17974.12.camel@sebastian.intellilink.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200704251426.14398.ak@suse.de>
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
To: Fernando Luis =?utf-8?q?V=C3=A1zquez_Cao?= <fernando@oss.ntt.co.jp>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, mbligh@google.com, Keith Owens <kaos@ocs.com.au>, akpm@linux-foundation.org


>  static __inline__ void apic_wait_icr_idle(void)
>  {
> -	while (apic_read( APIC_ICR ) & APIC_ICR_BUSY)
> +	while (apic_read(APIC_ICR) & APIC_ICR_BUSY)
>  		cpu_relax();
>  }
>  
> +static __inline__ unsigned int safe_apic_wait_icr_idle(void)

This should be probably not inline -- too large

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WstQL-0004dM-Ck
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 12:39:10 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 22:38:43 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 207162BB004A
 for <kexec@lists.infradead.org>; Fri,  6 Jun 2014 22:38:41 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s56CGjuR46072020
 for <kexec@lists.infradead.org>; Fri, 6 Jun 2014 22:16:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s56CceRf010005
 for <kexec@lists.infradead.org>; Fri, 6 Jun 2014 22:38:40 +1000
Message-ID: <5391B5FE.2090508@linux.vnet.ibm.com>
Date: Fri, 06 Jun 2014 18:07:18 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
 <1401833365.3247.36.camel@pasglop> <5391B413.100@linux.vnet.ibm.com>
In-Reply-To: <5391B413.100@linux.vnet.ibm.com>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ego@linux.vnet.ibm.com, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, matt@ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki@in.ibm.com, ebiederm@xmission.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On 06/06/2014 05:59 PM, Srivatsa S. Bhat wrote:
 
> +bool kexec_cpu_wake(void)
> +{
> +	kexec_smp_down(NULL);
> +
> +	/* NOTREACHED */
> +	return true;
> +}
> +

This function doesn't have to return anything, so we can define it as void.
The bool is a remnant of my previous attempt at making this work. (But these
patches compile fine as they are, though).

Regards,
Srivatsa S. Bhat


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Smoj1-0008VR-CF
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 16:16:19 +0000
Message-Id: <4FF5D557020000780008DEA5@nat28.tlf.novell.com>
Date: Thu, 05 Jul 2012 16:56:39 +0100
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 1/5] xen: Always calculate max_cpus
 value
References: <20120705145839.GB2007@host-192-168-1-59.local.net-space.pl>
 <20120705150008.GC2007@host-192-168-1-59.local.net-space.pl>
In-Reply-To: <20120705150008.GC2007@host-192-168-1-59.local.net-space.pl>
Mime-Version: 1.0
Content-Disposition: inline
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, xen-devel <xen-devel@lists.xen.org>, anderson@redhat.com, crash-utility@redhat.com

>>> On 05.07.12 at 17:00, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> max_cpus is not available since 20374 changeset (Miscellaneous data
> placement adjustments). It was moved to __initdata section. This section
> is freed after Xen initialization. Assume that max_cpus is always
> equal to XEN_HYPER_SIZE(cpumask_t) * 8.

Using nr_cpu_ids, when available, would seem a better fit. And
I donm't see why, on dumps from old hypervisors, you wouldn't
want to continue using max_cpus. Oh, wait, I see - you would
have to be able to tell whether it actually sits in .init.data, which
might not be strait forward.

Jan

> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> 
> diff -Npru crash-6.0.8.orig/xen_hyper.c crash-6.0.8/xen_hyper.c
> --- crash-6.0.8.orig/xen_hyper.c	2012-06-29 16:59:18.000000000 +0200
> +++ crash-6.0.8/xen_hyper.c	2012-07-05 14:52:59.000000000 +0200
> @@ -1879,11 +1879,9 @@ xen_hyper_get_cpu_info(void)
>  	uint *cpu_idx;
>  	int i, j, cpus;
>  
> -	get_symbol_data("max_cpus", sizeof(xht->max_cpus), &xht->max_cpus);
>  	XEN_HYPER_STRUCT_SIZE_INIT(cpumask_t, "cpumask_t");
> -	if (XEN_HYPER_SIZE(cpumask_t) * 8 > xht->max_cpus) {
> -		xht->max_cpus = XEN_HYPER_SIZE(cpumask_t) * 8;
> -	}
> +	xht->max_cpus = XEN_HYPER_SIZE(cpumask_t) * 8;
> +
>  	if (xht->cpumask) {
>  		free(xht->cpumask);
>  	}
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org 
> http://lists.xen.org/xen-devel 




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 207.47.60.147.static.nextweb.net ([207.47.60.147]
	helo=rpc.xensource.com)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hljiv-0002Cy-0s
	for kexec@lists.infradead.org; Wed, 09 May 2007 06:48:47 -0400
Subject: Re: [PATCH] Handle maloc() failure in xen_get_nr_phys_cpus()
From: Ian Campbell <Ian.Campbell@XenSource.com>
In-Reply-To: <20070509095609.44BAA4F7D7@tabatha.lab.ultramonkey.org>
References: <20070509095609.44BAA4F7D7@tabatha.lab.ultramonkey.org>
Date: Wed, 09 May 2007 11:48:37 +0100
Message-Id: <1178707717.4742.7.camel@localhost.localdomain>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Wed, 2007-05-09 at 18:56 +0900, Simon Horman wrote:
> Currently xen_get_nr_phys_cpus() doesn't write to xen_phys_notes if
> allocation fails, but it doesn't return an error either, leaving
> xen_phys_notes wide open to be accessed by other functions later.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

Looks good to me.

Acked-by: Ian Campbell <ian.campbell@xensource.com>

> 
> Index: kexec-tools-unstable/kexec/crashdump-xen.c
> ===================================================================
> --- kexec-tools-unstable.orig/kexec/crashdump-xen.c	2007-05-09 18:44:48.000000000 +0900
> +++ kexec-tools-unstable/kexec/crashdump-xen.c	2007-05-09 18:50:14.000000000 +0900
> @@ -93,13 +93,12 @@ int xen_get_nr_phys_cpus(void)
>  	if ((cpus = kexec_iomem_for_each_line(match, NULL, NULL))) {
>  		n = sizeof(struct crash_note_info) * cpus;
>  		xen_phys_notes = malloc(n);
> -		if (xen_phys_notes) {
> -			memset(xen_phys_notes, 0, n);
> -			kexec_iomem_for_each_line(match,
> -						  xen_crash_note_callback,
> -						  NULL);
> +		if (!xen_phys_notes) {
> +			fprintf(stderr, "failed to allocate xen_phys_notes.\n");
> +			return -1;
>  		}
> -
> +		memset(xen_phys_notes, 0, n);
> +		kexec_iomem_for_each_line(match, xen_crash_note_callback, NULL);
>  		xen_phys_cpus = cpus;
>  	}
>  


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

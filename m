Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QHxXM-0005IJ-00
	for kexec@lists.infradead.org; Thu, 05 May 2011 12:20:09 +0000
Date: Thu, 5 May 2011 21:20:03 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] detect Xen dom0 properly to avoid conflict with
	pv_on_hvm domU
Message-ID: <20110505122003.GM22010@verge.net.au>
References: <20110504163232.GA24669@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110504163232.GA24669@aepfle.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Olaf Hering <olaf@aepfle.de>
Cc: kexec@lists.infradead.org

On Wed, May 04, 2011 at 06:32:32PM +0200, Olaf Hering wrote:
> A Xen HVM guest with PV drivers loaded has also a /proc/xen directory.
> But such a guest is an ordinary PC and the special handling for dom0
> breaks kdump in this environment.
> Test for /proc/xen/capabilities instead and cache the result.
> 
> Also make two variables static, they are only used in this file.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  kexec/crashdump-xen.c |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> Index: kexec-tools-0.8.15/kexec/crashdump-xen.c
> ===================================================================
> --- kexec-tools-0.8.15.orig/kexec/crashdump-xen.c
> +++ kexec-tools-0.8.15/kexec/crashdump-xen.c
> @@ -25,14 +25,19 @@ struct crash_note_info {
>  	unsigned long length;
>  };
>  
> -int xen_phys_cpus = 0;
> -struct crash_note_info *xen_phys_notes;
> +static int xen_phys_cpus;
> +static struct crash_note_info *xen_phys_notes;
> +static int is_dom0;

I think you need to explicitly initialise is_dom0 to 0.

Alternatively, is it really such a burden to call access()
each time xen_present() is called?  (I'm ambivalent with regards to this).

>  
>  int xen_present(void)
>  {
> -	struct stat buf;
> -
> -	return stat("/proc/xen", &buf) == 0;
> +	if (!is_dom0) {
> +		if (access("/proc/xen/capabilities", F_OK) == 0)
> +			is_dom0 = 1;
> +		else
> +			is_dom0 = -1;
> +	}
> +	return is_dom0 > 0;
>  }
>  
>  unsigned long xen_architecture(struct crash_elf_info *elf_info)
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

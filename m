Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UecAz-0005UJ-8K
 for kexec@lists.infradead.org; Tue, 21 May 2013 02:19:47 +0000
Date: Tue, 21 May 2013 11:15:16 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: non-cyclic default
Message-Id: <20130521111516.af6d1f8d14f39c8d34d9d18d@mxc.nes.nec.co.jp>
In-Reply-To: <E1UcggB-0005h5-8e@eag09.americas.sgi.com>
References: <E1UcggB-0005h5-8e@eag09.americas.sgi.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: cpw@sgi.com
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Wed, 15 May 2013 13:43:59 -0500
Cliff Wickman <cpw@sgi.com> wrote:

> From: Cliff Wickman <cpw@sgi.com>
> 
> Make non-cyclic the default, as it is faster.
> 
> Dumping a 1TB memory is successful with a crashkernel=512M.
> And allow -Y on the command line, as well as --non-cylic.
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>

This change causes the failure due to lack of memory, again.

I think reliability is more important than performance, it's desirable
that anyone can use makedumpfile safely without any considerations.

Only experts who can set "crashkernel" appropriately based on physical
memory size should use --non-cyclic option manually for performance.


Thanks
Atsushi Kumagai

> ---
>  makedumpfile.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Index: makedumpfile.mmap/makedumpfile.c
> ===================================================================
> --- makedumpfile.mmap.orig/makedumpfile.c
> +++ makedumpfile.mmap/makedumpfile.c
> @@ -8585,13 +8585,14 @@ main(int argc, char *argv[])
>  	initialize_tables();
>  
>  	/*
> -	 * By default, makedumpfile works in constant memory space.
> +	 * By default, makedumpfile makes one pass through page structures.
> +	 * Use --cyclic-buffer to work in constant memory space.
>  	 */
> -	info->flag_cyclic = TRUE;
> +	info->flag_cyclic = FALSE;
>  	
>  	info->block_order = DEFAULT_ORDER;
>  	message_level = DEFAULT_MSG_LEVEL;
> -	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:", longopts,
> +	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lMpRrsvXx:Y", longopts,
>  	    NULL)) != -1) {
>  		switch (opt) {
>  		case 'A':
> @@ -8694,6 +8695,8 @@ main(int argc, char *argv[])
>  			break;
>  		case 'Z':
>  			info->bufsize_cyclic = atoi(optarg);
> +			if (info->bufsize_cyclic)
> +				info->flag_cyclic = TRUE;
>  			break;
>  		case '?':
>  			MSG("Commandline parameter is invalid.\n");

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

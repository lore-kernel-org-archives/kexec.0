Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86] helo=ruth.realtime.net)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hem92-0008UB-5O
	for kexec@lists.infradead.org; Fri, 20 Apr 2007 01:58:57 -0400
In-Reply-To: <5129.1176956949@neuling.org>
References: <12001.1176881167@neuling.org> <5129.1176956949@neuling.org>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <46b0d1603ea2ab82b37daaa1888e8793@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] kexec-tools ppc64: add --reuseinitrd option 
Date: Fri, 20 Apr 2007 00:58:38 -0500
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
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org, Fastboot mailing list <fastboot@lists.osdl.org>


On Apr 18, 2007, at 11:29 PM, Michael Neuling wrote:

> Add a --reuseinitrd option so that initrds saved using the
> retain_initrd kernel option can be reused on the kexec boot.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Horms: This fixes comments from Milton.  Also adds sanity checks to 
> make
> sure the old initrd was retained, and that another initrd/ramdisk is 
> not
> being specified at the same time.
>
> fastboot is dead... love live kexec! Yay :-)
>

> -		checkprop(fn, dt);
> +		checkprop(fn, dt, len);
>
>  		/* Get the cmdline from the device-tree and modify it */
>  		if (!strcmp(dp->d_name, "bootargs")) {
> @@ -249,6 +263,10 @@ static void putprops(char *fn, struct di
>  			char temp_cmdline[COMMAND_LINE_SIZE] = { "" };
>  			char *param = NULL;
>  			cmd_len = strlen(local_cmdline);
> +			if (reuse_initrd &&
> +			    (strstr((char *)dt, "retain_initrd") == NULL))
> +				die("unrecoverable error: current boot didn't "
> +				    "retain the initrd for reuse.\n");

Although this seems efficent to look at what was in the device tree,
I'd prefer we actually looked at /proc/cmdline when we parse the
arg, so that we are sure to find what the kernel is actually
using for the command line.

Besides it will be eaiser for other archs to copy the check.

>  			if (cmd_len != 0) {
>  				param = strstr(local_cmdline, "crashkernel=");
>  				if (param)
> @@ -282,7 +300,7 @@ static void putprops(char *fn, struct di
>  	}
>
>  	fn[0] = '\0';
> -	checkprop(pathname, NULL);
> +	checkprop(pathname, NULL, 0);
>  }
>
>  /*
> @@ -343,7 +361,7 @@ static void putnode(void)
>  	putprops(dn, namelist, numlist);
>
>  	/* Add initrd entries to the second kernel */
> -	if (initrd_base && !strcmp(basename,"/chosen/")) {
> +	if (initrd_base && !strcmp(basename,"/chosen/") && !reuse_initrd) {

How does initrd_base get set if you disallow --initrd= ?

>
> @@ -148,6 +154,9 @@ int elf_ppc64_load(int argc, char **argv
>  	else
>  		fprintf(stdout, "Warning: append= option is not passed. Using the 
> first kernel root partition\n");
>
> +	if (ramdisk && reuse_initrd)
> +		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
> +

This check is generic, not elf specific, so it should be where
we pass the args.  Hmm, maybe this is that place and it just
wants abstracting, I don't have the tree in front of me.

>  	setup_memory_ranges(info->kexec_flags);
>
>  	/* Need to append some command line parameters internally in case of
>

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

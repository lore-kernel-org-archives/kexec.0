Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kcout02.prserv.net ([12.154.55.32])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hv8m9-00009T-Dc
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 05:24:52 -0400
In-Reply-To: <25445.1180941825@neuling.org>
References: <25445.1180941825@neuling.org>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <8f5d8a214e9042b0c556ac7256928a52@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline
Date: Mon, 4 Jun 2007 04:22:33 -0500
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
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org, Santhosh Rao <sonny@burdell.org>


On Jun 4, 2007, at 2:23 AM, Michael Neuling wrote:

> If the cmdline changes between boots, we can get misalignment of the
> bootargs entry, which in turn corrupts our device tree blob and hence
> kills our kexec boot.
...
> -		if ((len >= 8) && ((unsigned long)dt & 0x4))
> +		if ((len >= 8) && ((unsigned long)dt & 0x4)){
>  			dt++;
> +			dt_realigned = 1;
> +		}
>
>  		fd = open(pathname, O_RDONLY);
>  		if (fd == -1)
> @@ -283,6 +286,8 @@ static void putprops(char *fn, struct di
>  			strcat(local_cmdline, " ");
>  			cmd_len = strlen(local_cmdline);
>  			cmd_len = cmd_len + 1;
> +			if (dt_realigned && cmd_len < 8)
> +				dt--;
>  	

While this appears to fix the stated problem, did you explore my
suggestion of deleting and creating the property like we do for
the initrd base and size?

Deleting and recreating should also handle the case of no
boot-args in the original /chosen sub-tree (when the bootloader
didn't (need to) supply a command line).

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HlIxE-0002C0-50
	for kexec@lists.infradead.org; Tue, 08 May 2007 02:13:45 -0400
Date: Tue, 8 May 2007 15:13:39 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 4/5] Add proper node alignment for the powerpc device-tree
	cmdline.
Message-ID: <20070508061338.GE8170@verge.net.au>
References: <20070507235727.631477448@am.sony.com>>
	<463FBE34.7070504@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <463FBE34.7070504@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>

On Mon, May 07, 2007 at 05:03:00PM -0700, Geoff Levand wrote:
> Add proper node alignment for the powerpc device-tree cmdline.
> 
> Fixes the runtime error 'Invalid tag 3a scanning flattened device tree !'.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

This seems ok to me, though I don't know much about the device tree.

Milton, do you have any thoughts on this?

> 
> ---
>  kexec/arch/ppc64/fs2dt.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- kexec-tools-hacked.orig/kexec/arch/ppc64/fs2dt.c
> +++ kexec-tools-hacked/kexec/arch/ppc64/fs2dt.c
> @@ -283,6 +283,10 @@ static void putprops(char *fn, struct di
>  			strcat(local_cmdline, " ");
>  			cmd_len = strlen(local_cmdline);
>  			cmd_len = cmd_len + 1;
> +			if ((cmd_len >= 8) && ((unsigned long)dt & 0x4)) {
> +				fprintf(stderr, "Aligning cmdline %p\n", dt);
> +				dt++;
> +			}
>  			memcpy(dt, local_cmdline,cmd_len);
>  			len = cmd_len;
>  			*dt_len = cmd_len;
> 
> -- 
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

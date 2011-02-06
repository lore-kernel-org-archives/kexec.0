Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PmCby-0003XK-Ep
	for kexec@lists.infradead.org; Sun, 06 Feb 2011 21:57:39 +0000
Date: Mon, 7 Feb 2011 06:57:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH -next] Documentation: Improve crashkernel= description
Message-ID: <20110206215733.GB26233@verge.net.au>
References: <20110206154108.GA16542@laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110206154108.GA16542@laptop>
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
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Sun, Feb 06, 2011 at 05:41:08PM +0200, Ahmed S. Darwish wrote:
> (Also applicable over 2.6.38-rc3)
> 
> Had to explore two C code files to make sense of the 'crashkernel='
> kernel parameter values.  Improve the situation.
> 
> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> ---
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 89835a4..8f26b42 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -545,9 +545,12 @@ and is between 256 and 4096 characters. It is defined in the file
>  			Format:
>  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>  
> -	crashkernel=nn[KMG]@ss[KMG]
> -			[KNL] Reserve a chunk of physical memory to
> -			hold a kernel to switch to with kexec on panic.
> +	crashkernel=size[KMG][@offset[KMG]]
> +			[KNL] Using kexec, Linux can switch to a 'crash kernel'
> +			upon panic. This parameter reserves the physical
> +			memory region [offset, offset + size] for that kernel
> +			image. If the '@offset' part was ignored, Linux finds
> +			a suitable crash image start address automatically.

I think this would be further improved as:

			... If '@offset' is omitted then a suitable
			offset is selected automatically.

>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>  			[KNL] Same as above, but depends on the memory
> 
> regards,
> 
> -- 
> Darwish
> http://darwish.07.googlepages.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

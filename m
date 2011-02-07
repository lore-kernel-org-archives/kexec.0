Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PmPTY-0007Fh-HC
	for kexec@lists.infradead.org; Mon, 07 Feb 2011 11:41:49 +0000
Date: Mon, 7 Feb 2011 20:41:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 -next] Documentation: Improve crashkernel= description
Message-ID: <20110207114144.GC10983@verge.net.au>
References: <20110206154108.GA16542@laptop>
	<20110206215733.GB26233@verge.net.au>
	<20110206201448.4a259575.rdunlap@xenotime.net>
	<20110207113054.GA10388@laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110207113054.GA10388@laptop>
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

On Mon, Feb 07, 2011 at 01:30:54PM +0200, Ahmed S. Darwish wrote:
> 
> Had to explore two C code files to make sense of the 'crashkernel='
> kernel parameter values.  Improve the situation.
> 
> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>

Thanks, that looks looks a good improvement over the existing documentation.

Acked-by: Simon Horman <horms@verge.net.au>

> ---
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 89835a4..5ad9980 100644
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
> +			image. If '@offset' is omitted, then a suitable offset
> +			is selected automatically.
>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>  			[KNL] Same as above, but depends on the memory
> 
> -- 
> Darwish
> http://darwish.07.googlepages.com
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

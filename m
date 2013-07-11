Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ux712-0004iP-G8
 for kexec@lists.infradead.org; Thu, 11 Jul 2013 02:53:58 +0000
Date: Thu, 11 Jul 2013 11:45:05 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCHv2] calculate cyclic buffer size according to
 info->num_dumpfile
Message-Id: <20130711114505.68f54a24c9a1cf3d48a988e6@mxc.nes.nec.co.jp>
In-Reply-To: <1373450525-4872-1-git-send-email-maxim.uvarov@oracle.com>
References: <1373450525-4872-1-git-send-email-maxim.uvarov@oracle.com>
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
To: maxim.uvarov@oracle.com
Cc: usui@mxm.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, nishimura@mxp.nes.nec.co.jp, kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com

Hello Maxim,

On Wed, 10 Jul 2013 14:02:05 +0400
Maxim Uvarov <maxim.uvarov@oracle.com> wrote:

> Dump kernel work in limited memory space and makedumpfile buffers
> have to fit to empty memory due to not be killed with OOM-killer.
> 
> v2: avoid divide by zero
> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@oracle.com>

Thanks, I'll merge this v2 patch into v1.5.5.


Atsushi Kumagai

> ---
>  makedumpfile.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b42565c..14bacb2 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -2997,6 +2997,8 @@ out:
>  			 * Truncate the buffer size to free memory size.
>  			 */
>  			free_memory = get_free_memory_size();
> +			if (info->num_dumpfile > 1)
> +				free_memory /= info->num_dumpfile;
>  			if (info->bufsize_cyclic > free_memory) {
>  				MSG("Specified buffer size is larger than free memory.\n");
>  				MSG("The buffer size for the cyclic mode will ");
> @@ -8548,6 +8550,9 @@ calculate_cyclic_buffer_size(void) {
>  	 */
>  	free_size = get_free_memory_size() * 0.4;
>  	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
> +	/* if --split was specified cyclic buffer allocated per dump file */
> +	if (info->num_dumpfile > 1)
> +		needed_size /= info->num_dumpfile;
>  
>  	info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;
>  
> -- 
> 1.7.9.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

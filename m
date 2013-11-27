Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vlgm6-0006Yu-D3
 for kexec@lists.infradead.org; Wed, 27 Nov 2013 15:11:34 +0000
Date: Wed, 27 Nov 2013 10:10:56 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v7 2/2] Documentation, x86, apic, kexec: Add
 disable_cpu_apicid kernel parameter
Message-ID: <20131127151056.GJ18706@redhat.com>
References: <20131127020006.1493.86091.stgit@localhost6.localdomain6>
 <20131127020053.1493.54092.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127020053.1493.54092.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: fengguang.wu@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

On Wed, Nov 27, 2013 at 11:00:53AM +0900, HATAYAMA Daisuke wrote:
> Add disable_cpu_apicid kernel parameter to disable the CPU with the
> specified number of initial APIC ID, mostly used for the kdump 2nd
> kernel to disable BSP to wake up multiple CPUs without causing system
> reset or hang due to sending INIT from AP to BSP.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>

I guess you don't require a separate patch for documentation. Just merge
it with previous patch. So this becomes a single patch fix and not a 
series.

Thanks
Vivek
> ---
>  Documentation/kernel-parameters.txt |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 50680a5..dd77bec 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -774,6 +774,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  	disable=	[IPV6]
>  			See Documentation/networking/ipv6.txt.
>  
> +	disable_cpu_apicid= [X86,APIC,KEXEC,SMP]
> +			Format: <int>
> +			The number of initial APIC ID for the
> +			corresponding CPU to be disabled at boot,
> +			mostly used for the kdump 2nd kernel to
> +			disable BSP to wake up multiple CPUs without
> +			causing system reset or hang due to sending
> +			INIT from AP to BSP.
> +
>  	disable_ddw     [PPC/PSERIES]
>  			Disable Dynamic DMA Window support. Use this if
>  			to workaround buggy firmware.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 25 Sep 2019 14:04:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 01/17] kexec: quiet down kexec reboot
Message-ID: <20190925060445.GA30921@dhcp-128-65.nay.redhat.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
 <20190923203427.294286-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190923203427.294286-2-pasha.tatashin@soleen.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, james.morse@arm.com, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

On 09/23/19 at 04:34pm, Pavel Tatashin wrote:
> Here is a regular kexec command sequence and output:
> =====
> $ kexec --reuse-cmdline -i --load Image
> $ kexec -e
> [  161.342002] kexec_core: Starting new kernel
> 
> Welcome to Buildroot
> buildroot login:
> =====
> 
> Even when "quiet" kernel parameter is specified, "kexec_core: Starting
> new kernel" is printed.
> 
> This message has  KERN_EMERG level, but there is no emergency, it is a
> normal kexec operation, so quiet it down to appropriate KERN_NOTICE.
> 
> Machines that have slow console baud rate benefit from less output.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Simon Horman <horms@verge.net.au>
> ---
>  kernel/kexec_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d5870723b8ad..2c5b72863b7b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1169,7 +1169,7 @@ int kernel_kexec(void)
>  		 * CPU hotplug again; so re-enable it here.
>  		 */
>  		cpu_hotplug_enable();
> -		pr_emerg("Starting new kernel\n");
> +		pr_notice("Starting new kernel\n");
>  		machine_shutdown();
>  	}
>  

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

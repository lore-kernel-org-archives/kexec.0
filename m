Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6UvP-0004I9-Sv
 for kexec@lists.infradead.org; Wed, 09 Dec 2015 02:56:16 +0000
Date: Wed, 9 Dec 2015 10:55:39 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 06/14] crashdump/cris: Add
 print_crashkernel_region_size() function
Message-ID: <20151209025539.GD14426@dhcp-128-65.nay.redhat.com>
References: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
 <1449611867-15672-7-git-send-email-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1449611867-15672-7-git-send-email-daniel.kiper@oracle.com>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: keir@xen.org, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, david.vrabel@citrix.com, xen-devel@lists.xenproject.org

On 12/08/15 at 10:57pm, Daniel Kiper wrote:
> Provide just print_crashkernel_region_size() stub. This way
> we can properly build kexec utility on cris arch even
> if the functionality is not available on it.
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  kexec/arch/cris/kexec-cris.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
> index 4ac2f89..8c62191 100644
> --- a/kexec/arch/cris/kexec-cris.c
> +++ b/kexec/arch/cris/kexec-cris.c
> @@ -77,6 +77,11 @@ int is_crashkernel_mem_reserved(void)
>  	return 0;
>  }
>  
> +void print_crashkernel_region_size(void)
> +{
> +	printf("-1\n");

"-1" is meaningless to end user, how about instead telling that there's no
such functionality for the arch.


> +}
> +
>  unsigned long virt_to_phys(unsigned long addr)
>  {
>  	return (addr) & 0x7fffffff;
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

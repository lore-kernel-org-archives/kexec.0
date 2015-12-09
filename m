Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6UsA-0002LI-O8
 for kexec@lists.infradead.org; Wed, 09 Dec 2015 02:52:55 +0000
Date: Wed, 9 Dec 2015 10:52:19 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 11/14] crashdump/ppc64: Add
 print_crashkernel_region_size() function
Message-ID: <20151209025219.GC14426@dhcp-128-65.nay.redhat.com>
References: <1449611867-15672-1-git-send-email-daniel.kiper@oracle.com>
 <1449611867-15672-12-git-send-email-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1449611867-15672-12-git-send-email-daniel.kiper@oracle.com>
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
> we can properly build kexec utility on ppc64 arch even
> if the functionality is not available on it.

Ditto as ppc, you can read procfs file to get the values..

> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> ---
>  kexec/arch/ppc64/crashdump-ppc64.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
> index b3c8928..49af7a6 100644
> --- a/kexec/arch/ppc64/crashdump-ppc64.c
> +++ b/kexec/arch/ppc64/crashdump-ppc64.c
> @@ -527,6 +527,11 @@ int is_crashkernel_mem_reserved(void)
>  	return 1;
>  }
>  
> +void print_crashkernel_region_size(void)
> +{
> +	printf("-1\n");
> +}
> +
>  #if 0
>  static int sort_regions(mem_rgns_t *rgn)
>  {
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

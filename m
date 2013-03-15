Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGX0k-0004Yv-AI
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 15:57:39 +0000
Date: Fri, 15 Mar 2013 16:57:33 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/s390: Replace clgfi with cghi
Message-ID: <20130315155732.GF16561@verge.net.au>
References: <20130315134632.1177a239@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130315134632.1177a239@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Fri, Mar 15, 2013 at 01:46:32PM +0100, Michael Holzheu wrote:
> The clgfi instruction needs at least z9 machine level. To allow kexec-tools
> compiled also with z900, this patch replaces clgfi with the older cghi
> instruction.

Hi,

could you update the changelog to include a brief description of the
difference between the two instructions - I assume they work the same
way in the context of this change.

> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  purgatory/arch/s390/setup-s390.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: kexec-tools-2.0.3/purgatory/arch/s390/setup-s390.S
> ===================================================================
> --- kexec-tools-2.0.3.orig/purgatory/arch/s390/setup-s390.S
> +++ kexec-tools-2.0.3/purgatory/arch/s390/setup-s390.S
> @@ -16,7 +16,7 @@ purgatory_start:
>  	larl	%r15,lstack_end
>  	aghi	%r15,-160
>  
> -	clgfi	%r2,0
> +	cghi	%r2,0
>  	je	verify_checksums
>  
>  	brasl	%r14,purgatory
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

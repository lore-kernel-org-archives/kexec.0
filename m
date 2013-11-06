Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fldsmtpe02.verizon.com ([140.108.26.141])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ve8Ei-0000Yq-N4
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 18:53:53 +0000
From: Don Slutz <dslutz@verizon.com>
Message-ID: <527A8F62.4040105@terremark.com>
Date: Wed, 6 Nov 2013 13:50:10 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 9/9] MAINTAINERS: Add KEXEC maintainer
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <1383749386-11891-10-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1383749386-11891-10-git-send-email-david.vrabel@citrix.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>

Looks good.

Reviewed-by: Don Slutz <dslutz@verizon.com>

    -Don Slutz

On 11/06/13 09:49, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> ---
>   MAINTAINERS |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index adacac2..4aac28c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -197,6 +197,14 @@ X:	xen/drivers/passthrough/amd/
>   X:	xen/drivers/passthrough/vtd/
>   F:	xen/include/xen/iommu.h
>   
> +KEXEC
> +M:      David Vrabel <david.vrabel@citrix.com>
> +S:      Supported
> +F:      xen/common/{kexec,kimage}.c
> +F:      xen/include/{kexec,kimage}.h
> +F:      xen/arch/x86/machine_kexec.c
> +F:      xen/arch/x86/x86_64/kexec_reloc.S
> +
>   LINUX (PV_OPS)
>   M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>   S:	Supported


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

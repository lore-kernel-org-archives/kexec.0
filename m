Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fldsmtpe03.verizon.com ([140.108.26.142])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ve8F2-0000Zp-B1
 for kexec@lists.infradead.org; Wed, 06 Nov 2013 18:54:12 +0000
From: Don Slutz <dslutz@verizon.com>
Message-ID: <527A8F9D.3030501@terremark.com>
Date: Wed, 6 Nov 2013 13:51:09 -0500
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 8/9] x86: check kexec relocation code fits
 in a page
References: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
 <1383749386-11891-9-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1383749386-11891-9-git-send-email-david.vrabel@citrix.com>
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

Also

Reviewed-by: Don Slutz <dslutz@verizon.com>

    -Don Slutz

On 11/06/13 09:49, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> The kexec relocation (control) code must fit in a single page so add a
> link time check for this.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
>   xen/arch/x86/xen.lds.S |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/xen/arch/x86/xen.lds.S b/xen/arch/x86/xen.lds.S
> index 9600cdf..17db361 100644
> --- a/xen/arch/x86/xen.lds.S
> +++ b/xen/arch/x86/xen.lds.S
> @@ -198,3 +198,5 @@ SECTIONS
>     .stab.indexstr 0 : { *(.stab.indexstr) }
>     .comment 0 : { *(.comment) }
>   }
> +
> +ASSERT(kexec_reloc_size - kexec_reloc <= PAGE_SIZE, "kexec_reloc is too large")


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

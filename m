Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLY1O-0002tC-O3
 for kexec@lists.infradead.org; Mon, 16 Sep 2013 12:35:20 +0000
Date: Mon, 16 Sep 2013 14:34:34 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 8/9] x86: check kexec relocation code fits in a page
Message-ID: <20130916123434.GA14630@debian70-amd64.local.net-space.pl>
References: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
 <1379015347-21653-9-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379015347-21653-9-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, Keir Fraser <keir@xen.org>, Jan Beulich <jbeulich@suse.com>, xen-devel@lists.xen.org

On Thu, Sep 12, 2013 at 08:49:06PM +0100, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
>
> The kexec relocation (control) code must fit in a single page so add a
> link time check for this.
>
> Signed-off-by: David Vrabel <david.vrabel@citrix.com>
> ---
>  xen/arch/x86/xen.lds.S |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/xen/arch/x86/xen.lds.S b/xen/arch/x86/xen.lds.S
> index 9600cdf..078bac6 100644
> --- a/xen/arch/x86/xen.lds.S
> +++ b/xen/arch/x86/xen.lds.S
> @@ -198,3 +198,5 @@ SECTIONS
>    .stab.indexstr 0 : { *(.stab.indexstr) }
>    .comment 0 : { *(.comment) }
>  }
> +
> +ASSERT(__kexec_reloc_size <= PAGE_SIZE, "kexec control code is too large")

ASSERT(kexec_reloc_size - kexec_reloc <= PAGE_SIZE, "kexec control code is too large")

This way you could remove this crazy __kexec_reloc_size variable.
Last time I sent broken solution for that issue. This one works.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

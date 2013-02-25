Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1UA3of-0001Nn-0p
 for kexec@lists.infradead.org; Mon, 25 Feb 2013 19:34:26 +0000
Message-ID: <512BBCBC.8050404@citrix.com>
Date: Mon, 25 Feb 2013 19:34:20 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 0/4] kexec-tools: add support for Xen 4.3
References: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
 <512BAEB3.4010708@CloudSwitch.Com>
In-Reply-To: <512BAEB3.4010708@CloudSwitch.Com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Don Slutz <Don@CloudSwitch.Com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On 25/02/13 18:34, Don Slutz wrote:
> 
> I did not find a fix/change to get_xen_vmcoreinfo() to call on 
> xc_kexec_get_range(xc, KEXEC_RANGE_MA_VMCOREINFO, ...
> 
> I found the following to work.
>     -Don Slutz
> 
>  From 2cabc018d7613b0d2ac487cbf2a2e9438a441a8d Mon Sep 17 00:00:00 2001
> From: Don Slutz <Don@CloudSwitch.com>
> Date: Fri, 22 Feb 2013 22:27:03 -0500
> Subject: [PATCH 1/2] Switch to use xc_kexec_get_range for 
> get_xen_vmcoreinfo.

Thanks.  I'll add this to my series.

David

> Signed-off-by: Don Slutz <Don@CloudSwitch.com>
> ---
>   kexec/crashdump-xen.c |   20 ++++++++++++++++++++
>   kexec/crashdump.c     |    2 ++
>   2 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
> index 56b0653..8179b72 100644
> --- a/kexec/crashdump-xen.c
> +++ b/kexec/crashdump-xen.c
> @@ -161,6 +161,26 @@ unsigned long xen_architecture(struct 
> crash_elf_info *elf_info)
>   }
> 
>   #ifdef HAVE_LIBXENCTRL
> +int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
> +{
> +       xc_interface *xc;
> +        int ret = 0;
> +
> +       xc = xc_interface_open(NULL, NULL, 0);
> +       if ( !xc ) {
> +               fprintf(stderr, "failed to open xen control interface.\n");
> +               return -1;
> +       }
> +
> +        ret = xc_kexec_get_range(xc, KEXEC_RANGE_MA_VMCOREINFO, 0, len, 
> addr);
> +
> +       xc_interface_close(xc);
> +
> +        if (ret < 0)
> +            return -1;
> +        return 0;
> +}
> +
>   int xen_get_nr_phys_cpus(void)
>   {
>          xc_interface *xc;
> diff --git a/kexec/crashdump.c b/kexec/crashdump.c
> index 847d080..3d2c1b9 100644
> --- a/kexec/crashdump.c
> +++ b/kexec/crashdump.c
> @@ -142,7 +142,9 @@ int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
>          return get_vmcoreinfo("/sys/kernel/vmcoreinfo", addr, len);
>   }
> 
> +#ifndef HAVE_LIBXENCTRL
>   int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
>   {
>          return get_vmcoreinfo("/sys/hypervisor/vmcoreinfo", addr, len);
>   }
> +#endif


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

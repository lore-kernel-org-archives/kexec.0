Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDQtb-0008Lo-An
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 02:49:28 +0000
Message-ID: <1362624402.8941.106.camel@hastur.hellion.org.uk>
Subject: Re: [Xen-devel] [PATCH 8/8] libxc: add API for kexec hypercall
From: Ian Campbell <ian.campbell@citrix.com>
Date: Thu, 7 Mar 2013 02:46:42 +0000
In-Reply-To: <1361468894-18655-9-git-send-email-david.vrabel@citrix.com>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-9-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Thu, 2013-02-21 at 17:48 +0000, David Vrabel wrote:
> From: David Vrabel <david.vrabel@citrix.com>
> 
> Add xc_kexec_exec(), xc_kexec_get_ranges(), xc_kexec_load(), and
> xc_kexec_unload().  The load and unload calls require the v2 load and
> unload ops.

Looks good, few nits below, but

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> +/*
> + * Find the machine address and size of certain memory areas.
> + *
> + *   KEXEC_RANGE_MA_CRASH       crash area
> + *   KEXEC_RANGE_MA_XEN         Xen itself
> + *   KEXEC_RANGE_MA_CPU         CPU note for CPU number 'nr'
> + *   KEXEC_RANGE_MA_XENHEAP     xenheap
> + *   KEXEC_RANGE_MA_EFI_MEMMAP  EFI Memory Map
> + *   KEXEC_RANGE_MA_VMCOREINFO  vmcoreinfo

I expect there is a canonical list of these somewhere, can we get a
pointer to it here?

> + *
> + * Fails with:
> + *   EINVAL if the range or CPU number isn't valid.
> + */
> +int xc_kexec_get_range(xc_interface *xch, int range,  int nr,
> +                       uint64_t *size, uint64_t *start);
> +
> +/*
> + * Load a kexec image into memory.
> + *
> + * The image may be of type KEXEC_TYPE_DEFAULT (executed on request)
> + * or KEXEC_TYPE_CRASH (executed on a crash).
> + *
> + * The image architecture may be a 32-bit variant of the hypervisor
> + * architecture (e.g, EM_386 on a x86-64 hypervisor).

arch is an ELF arch? Worth mentioning explicitly I think.

Ian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wi0-x231.google.com ([2a00:1450:400c:c05::231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vfv98-0007Iu-0g
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 17:19:31 +0000
Received: by mail-wi0-f177.google.com with SMTP id hq4so2086333wib.16
 for <kexec@lists.infradead.org>; Mon, 11 Nov 2013 09:19:05 -0800 (PST)
Date: Mon, 11 Nov 2013 17:18:57 +0000
Subject: Re: [Xen-devel] [PATCHv10 0/9] Xen: extend kexec hypercall for use
 with pv-ops kernels
From: Keir Fraser <keir.xen@gmail.com>
Message-ID: <CEA6C201.3E08B%keir.xen@gmail.com>
In-Reply-To: <1383749386-11891-1-git-send-email-david.vrabel@citrix.com>
Mime-version: 1.0
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
To: David Vrabel <david.vrabel@citrix.com>, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Jan Beulich <jbeulich@suse.com>

On 06/11/2013 14:49, "David Vrabel" <david.vrabel@citrix.com> wrote:

> The series (for Xen 4.4) improves the kexec hypercall by making Xen
> responsible for loading and relocating the image.  This allows kexec
> to be usable by pv-ops kernels and should allow kexec to be usable
> from a HVM or PVH privileged domain.

Acked-by: Keir Fraser <keir@xen.org>

> I have now tested this with a Linux kernel image using the VGA console
> which was what was causing problems in v9 (this turned out to be a
> kexec-tools bug).
> 
> The required patch series for kexec-tools will be posted shortly and
> are available from the xen-v7 branch of:
> 
> http://xenbits.xen.org/gitweb/?p=people/dvrabel/kexec-tools.git;a=summary
> 
> Changes in v10:
> 
> - Document host state on exec.
> - Fix kimage_alloc() error path (double free, crash on zero kimage->head).
> - Check for segment before expanding it in load_v1.
> - Move kexec_lock define into kexec_swap_images().
> 
> Changes in v9:
> 
> - Update comments to correctly say 4.4.
> - Minor updates the kexec_reloc assembly to improve maintainability a
>   bit.
> 
> Changes in v8:
> 
> - Use #defines for compat ABI structures.
> - Tweak link time check for kexec_reloc.
> 
> Changes in v7:
> 
> - No longer use GUEST_HANDLE_64(), get a uniform ABI by using unions
>   and explicit padding.
> - Only map the segments and not all of RAM.
> - Add a mechanism to create mappings for use by the exec'd image (a
>   segment with a NULL buf handle).
> - Fix a bug where a crash image's code page would by placed at machine
>   address 0 (instead of inside the crash region).
> 
> Changes in v6:
> 
> - Fix double free in KEXEC_load_v1 failure path.
> - Only copy the relocation code and not the whole page.
> - Add myself as the kexec maintainer.
> 
> Changes in v5 (not posted to the list):
> 
> - _rsvd -> _pad in one of the public ABI structures.
> - Fix bug where trailing pages were not zeroed. This fixes loading a
>   64-bit Linux kernel using a more recent version of kexec-tools.
> - Check the relocation code fits into a page at link time.
> 
> Changes in v4:
> 
> - Use paddr_t and page_to_maddr() etc. for portability.
> - Add explicit padding to hypercall structures where required.
> - Minor cleanup of the kexec_reloc assembly.
> - Print a message before exec'ing a crash image.
> - Style fixes (tabs, trailing whitespace) and typos.
> - Fix a bug where using the V1 interface and unloading a image may crash.
> 
> Changes in v3:
> 
> - Provide old struct xen_kexec_load if __XEN_INTERFACE_VERSION__ < 4.3
> - Adjust new struct xen_kexec_load to avoid unnecessary padding.
> - Use domheap pages for the image and control pages.
> - Remove the DBG() macros from the reloc code.
> 
> David
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

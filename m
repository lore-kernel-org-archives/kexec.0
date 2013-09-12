Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKCtb-0004rt-O7
 for kexec@lists.infradead.org; Thu, 12 Sep 2013 19:49:45 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCHv7 0/9] Xen: extend kexec hypercall for use with pv-ops kernels
Date: Thu, 12 Sep 2013 20:48:58 +0100
Message-ID: <1379015347-21653-1-git-send-email-david.vrabel@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: kexec@lists.infradead.org, Daniel Kiper <daniel.kiper@oracle.com>, Keir Fraser <keir@xen.org>, David Vrabel <david.vrabel@citrix.com>, Jan Beulich <jbeulich@suse.com>

The series (for Xen 4.4) improves the kexec hypercall by making Xen
responsible for loading and relocating the image.  This allows kexec
to be usable by pv-ops kernels and should allow kexec to be usable
from a HVM or PVH privileged domain.

The first patch is a simple clean-up.

Patch 2 introduces the new ABI.

Patch 3 and 4 nearly completely reimplement the kexec load, unload and
exec sub-ops.  The old load_v1 sub-op is then implemented on top of
the new code.

Patch 5 calls the kexec image when dom0 crashes.  This avoids having
to alter dom0 kernels to do a exec sub-op call on crash -- a
SHUTDOWN_crash by dom0 will trigger the kexec.

Patches 6 and 7 add the libxc API for the kexec calls.  These have
been acked-by Ian Campbell already.

Patch 8 adds a link time check for the size of the relocate code.

Patch 9 adds myself as the maintainer for kexec in Xen.

The required patch series for kexec-tools will be posted shortly and
are available from the xen-v4 branch of:

http://xenbits.xen.org/gitweb/?p=people/dvrabel/kexec-tools.git;a=summary

Changes since v6:

- No longer use GUEST_HANDLE_64(), get a uniform ABI by using unions
  and explicit padding.
- Only map the segments and not all of RAM.
- Add a mechanism to create mappings for use by the exec'd image (a
  segment with a NULL buf handle).
- Fix a bug where a crash image's code page would by placed at machine
  address 0 (instead of inside the crash region).

Changes since v5:

- Fix double free in KEXEC_load_v1 failure path.
- Only copy the relocation code and not the whole page.
- Add myself as the kexec maintainer.

Changes since v4 (v5 was not posted to the list):

- _rsvd -> _pad in one of the public ABI structures.
- Fix bug where trailing pages were not zeroed. This fixes loading a
  64-bit Linux kernel using a more recent version of kexec-tools.
- Check the relocation code fits into a page at link time.

Changes since v3:

- Use paddr_t and page_to_maddr() etc. for portability.
- Add explicit padding to hypercall structures where required.
- Minor cleanup of the kexec_reloc assembly.
- Print a message before exec'ing a crash image.
- Style fixes (tabs, trailing whitespace) and typos.
- Fix a bug where using the V1 interface and unloading a image may crash.

Changes since v2: 

- Provide old struct xen_kexec_load if __XEN_INTERFACE_VERSION__ < 4.3
- Adjust new struct xen_kexec_load to avoid unnecessary padding.
- Use domheap pages for the image and control pages.
- Remove the DBG() macros from the reloc code.

David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

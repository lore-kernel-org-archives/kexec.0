Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPHIW-000719-Nt
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 19:00:10 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCHv3 0/8] kexec: extend kexec hypercall for use with pv-ops
 kernels
Date: Mon, 8 Apr 2013 19:59:45 +0100
Message-ID: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
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
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Ian Campbell <Ian.Campbell@citrix.com>

The series improves the kexec hypercall by making Xen responsible for
loading and relocating the image.  This allows kexec to be usable by
pv-ops kernels and should allow kexec to be usable from a HVM or PVH
privileged domain.

The first patch is a simple clean-up.

The second patch allows hypercall structures to be ABI compatible
between 32- and 64-bit guests (by reusing stuff present for domctls
and sysctls).  This seems better than having to keep adding compat
handling for new hypercalls etc.

Patch 3 introduces the new ABI.

Patch 4 and 5 nearly completely reimplement the kexec load, unload and
exec sub-ops.  The old load_v1 sub-op is then implemented on top of
the new code.

Patch 6 calls the kexec image when dom0 crashes.  This avoids having
to alter dom0 kernels to do a exec sub-op call on crash -- a
SHUTDOWN_crash by dom0 will trigger the kexec.

Patches 7 and 8 add the libxc API for the kexec calls.  These have
been acked-by Ian Campbell already.

The required patch series for kexec-tools will be posted shortly.

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

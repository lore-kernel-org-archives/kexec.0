Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8ev4-0007wA-Oe
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 22:47:15 +0000
Date: Thu, 21 Feb 2013 23:47:04 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 0/8] kexec: extended kexec hypercall for use with pv-ops
 kernels
Message-ID: <20130221224704.GC18464@host-192-168-1-59.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: kexec@lists.infradead.org, xen-devel@lists.xen.org

On Thu, Feb 21, 2013 at 05:48:06PM +0000, David Vrabel wrote:
> The series improves the kexec hypercall by making Xen responsible for
> loading and relocating the image.  This allows kexec to be usable by
> pv-ops kernels and should allow kexec to be usable from a HVM or PVH
> privileged domain.
>
> The first patch is a simple clean-up.
>
> The second patch allows hypercall structures to be ABI compatible
> between 32- and 64-bit guests (by reusing stuff present for domctls
> and sysctls).  This seems better than having to keep adding compat
> handling for new hypercalls etc.
>
> Patch 3 introduces the new ABI.
>
> Patch 4 and 5 nearly completely reimplement the kexec load, unload and
> exec sub-ops.  The old load_v1 sub-op is then implemented on top of
> the new code.
>
> Patch 6 calls the kexec image when dom0 crashes.  This avoids having
> to alter dom0 kernels to do a exec sub-op call on crash -- an existing
> SHUTDOWN_crash.
>
> Patches 7 and 8 add the libxc API for the kexec calls.
>
> The required patch series for kexec-tools will be posted shortly.

On first sight both patch series looks quite good for me.
Give me a week or two to do some tests.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

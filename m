Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from nat28.tlf.novell.com ([130.57.49.28])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8nnv-0005nD-OH
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 08:16:28 +0000
Message-Id: <512737A302000078000C038F@nat28.tlf.novell.com>
Date: Fri, 22 Feb 2013 08:17:23 +0000
From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 0/8] kexec: extended kexec hypercall
 for use with pv-ops kernels
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
Mime-Version: 1.0
Content-Disposition: inline
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

>>> On 21.02.13 at 18:48, David Vrabel <david.vrabel@citrix.com> wrote:
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

Am I right in understanding that at this point no kexec support is
necessary in the Dom0 kernel at all anymore? If so, that's a very
nice move - thanks for doing that!

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

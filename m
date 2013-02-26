Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hub021-nj-6.exch021.serverdata.net ([206.225.164.222])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1UAL3F-0005b6-T7
 for kexec@lists.infradead.org; Tue, 26 Feb 2013 13:58:38 +0000
Message-ID: <512CBF8B.2090008@CloudSwitch.com>
Date: Tue, 26 Feb 2013 08:58:35 -0500
From: Don Slutz <Don@CloudSwitch.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 0/8] kexec: extended kexec hypercall for use
 with pv-ops kernels
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On 02/21/13 12:48, David Vrabel wrote:
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
>
> David
>
>
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
I have tested this patch set on a Fedora 17 dom0 with kernels:

3.7.3-101.fc17.x86_64
3.6.5-1.fc17.x86_64

So:

Tested-by: Don Slutz <Don@CloudSwitch.com>

    -Don Slutz

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USRZp-0003dj-Jm
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 12:35:08 +0000
Date: Wed, 17 Apr 2013 14:34:37 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCHv4 0/8] kexec: extend kexec hypercall for use with pv-ops
 kernels
Message-ID: <20130417123437.GA906@debian70-amd64.local.net-space.pl>
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
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
Cc: kexec@lists.infradead.org, Keir Fraser <keir@xen.org>, xen-devel@lists.xen.org

On Tue, Apr 16, 2013 at 06:13:02PM +0100, David Vrabel wrote:
> The series improves the kexec hypercall by making Xen responsible for
> loading and relocating the image.  This allows kexec to be usable by
> pv-ops kernels and should allow kexec to be usable from a HVM or PVH
> privileged domain.
>
> This has now missed the code freeze deadline but could it be
> considered for 4.3 anyway?  kexec isn't a core piece of functionality
> and I see minimal risk of introducing regressions to Xen as a whole
> with this series.
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
> to alter dom0 kernels to do a exec sub-op call on crash -- a
> SHUTDOWN_crash by dom0 will trigger the kexec.
>
> Patches 7 and 8 add the libxc API for the kexec calls.  These have
> been acked-by Ian Campbell already.
>
> The required patch series for kexec-tools have previously been posted
> and this series has been rebased on the latest kexec-tools and is
> available from the xen-v3 branch of:
>
> http://xenbits.xen.org/gitweb/?p=people/dvrabel/kexec-tools.git;a=summary

kexec -e still does not work. I see in my console:

I'm in purgatory
sha256 digests do not match :(
...

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

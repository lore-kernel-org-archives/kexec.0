Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cb6yb-0001kt-OP
 for kexec@lists.infradead.org; Tue, 07 Feb 2017 14:42:43 +0000
Date: Tue, 7 Feb 2017 15:42:06 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 00/12] crashdump: Add print_crashkernel_region_size()
 function
Message-ID: <20170207144206.GB13477@olila.local.net-space.pl>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
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
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: andrew.cooper3@citrix.com, dyoung@redhat.com, horms@verge.net.au, kexec@lists.infradead.org, konrad.wilk@oracle.com

On Mon, Feb 06, 2017 at 01:42:12PM -0600, Eric DeVolder wrote:
> Crash kernel region size is available via sysfs on Linux running on
> bare metal. However, this does not work when Linux runs as Xen dom0.
> In this case Xen crash kernel region size should be established using
> __HYPERVISOR_kexec_op hypercall (Linux kernel kexec functionality does
> not make a lot of sense in Xen dom0). Sadly hypercalls are not easily
> accessible using shell scripts or something like that. Potentially we
> can check "xl dmesg" output for crashkernel option but this is not nice.
> So, let's add this functionality, for Linux running on bare metal and
> as Xen dom0, to kexec-tools. This way kdump scripts may establish crash
> kernel region size in one way regardless of platform. All burden of
> platform detection lies on kexec-tools.
>
> Figure (and unit) displayed by this new kexec-tools functionality is
> the same as one taken from /sys/kernel/kexec_crash_size.
>
> This patch just adds print_crashkernel_region_size() function, which
> prints crash kernel region size, for x86 arch. Next patches will add
> same named function for other archs supported by kexec-tools. Last patch
> of this series will export this functionality to the userspace via
> separate kexec utility option.
>
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

This does not need to have SOB.

> ---
> v0: Interal version.
> v1: Posted to kexec-tools mailing list
> v2: Incorporated feedback:
>     - utilize the is_crashkernel_mem_reserved() function common in all archs
>     - for ppc and ppc64, utilize device-tree values to print size
>     - for unsupported architectures, print appropriate message

Next time please provide a list of patches (numbers are OK) changed in
comparison to earlier version. Results of "git diff --stat master.." and
"git shortlog master.." (I assume that you based patches on master) are
also nice to have at the bottom of patch #00.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

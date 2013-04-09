Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPftz-0005EW-LJ
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 21:16:28 +0000
Date: Tue, 9 Apr 2013 23:16:16 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCHv2 0/4] kexec-tools: add support for Xen 4.3
Message-ID: <20130409211616.GD31533@debian70-amd64.local.net-space.pl>
References: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Mon, Apr 08, 2013 at 08:06:49PM +0100, David Vrabel wrote:
> The series adds support for the new hypercall ABI which should be
> provided by Xen 4.3.  Images are loaded into Xen directly with no
> kernel involvement.
>
> Do not apply until the hypervisor side patches are applied to Xen.
>
> Patch 1 is unrelated but kexec wouldn't work for me without it. Not
> sure why I had problems, perhaps a toolstack specific issue?
>
> Patch 2 makes libxc 4.3 mandatory for Xen support.
>
> Patch 3-4 removes a use of /proc/iomem in favour of libxc.
>
> Patch 5 adds the support for loading, unloading, and exec'ing an image
> in Xen.
>
> This series explicitly drops support for older version of libxc/Xen as
> supporting kexec on these hypervisors requires kernel support that
> will never be available upstream.
>
> Changes since v1:
> - Patch from Don Sultz: use libxc for vmcoreinfo.
> - Use xc_get_max_cpus() to get number of PCPUs.
> - Enable unload and exec of images.

I could not test new kexec implementation because this patch
series does not cleanly apply to latest kexec-tools tree.
Please fix that and repost.

Xen patches applies to latest Xen unstable tree with some warnings.
I think it is worth update those patches too.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

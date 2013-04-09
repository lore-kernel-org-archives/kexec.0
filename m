Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPOd7-0006ho-Pl
 for kexec@lists.infradead.org; Tue, 09 Apr 2013 02:49:54 +0000
Date: Tue, 9 Apr 2013 11:49:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCHv2 0/4] kexec-tools: add support for Xen 4.3
Message-ID: <20130409024950.GC11444@verge.net.au>
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
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

Hi David,

On Mon, Apr 08, 2013 at 08:06:49PM +0100, David Vrabel wrote:
> The series adds support for the new hypercall ABI which should be
> provided by Xen 4.3.  Images are loaded into Xen directly with no
> kernel involvement.
> 
> Do not apply until the hypervisor side patches are applied to Xen.

Please let me know when you are ready for these to be applied
by reposting them.

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
> 
> David
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

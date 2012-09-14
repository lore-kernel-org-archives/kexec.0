Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TCMcu-0000sb-VG
 for kexec@lists.infradead.org; Fri, 14 Sep 2012 03:31:33 +0000
Date: Fri, 14 Sep 2012 12:30:59 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7] kdump: Xen fixes
Message-ID: <20120914033059.GF17943@verge.net.au>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, andrew.cooper3@citrix.com, ptesarik@suse.cz, jbeulich@suse.com, kexec@lists.infradead.org

On Mon, Sep 10, 2012 at 01:57:44PM +0200, Daniel Kiper wrote:
> Hi,
> 
> Here I am sending Xen kdump fixes.

Hi Daniel,

do these relate to the changes that you were discussing
with Petr Tesarik in July?


> Daniel Kiper (7):
>       kexec: Define some constants and structures conditionally
>       xen: Rename e820_to_kexec_type() to xen_e820_to_kexec_type() and export it
>       kexec: Move crash kernel area placement and size detection to is_crashkernel_mem_reserved()
>       kexec: Add segregate_lowmem_region()
>       kexec: Get backup area start address and size directly from mem_range
>       kexec: Move crash memory ranges logging
>       xen: Fix Xen kdump support
> 
>  include/x86/x86-linux.h            |    7 +-
>  kexec/arch/i386/crashdump-x86.c    |  322 +++++++++++++++++++++++++++--------
>  kexec/arch/i386/kexec-x86-common.c |    6 +-
>  kexec/arch/i386/kexec-x86.h        |    2 +
>  4 files changed, 259 insertions(+), 78 deletions(-)
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

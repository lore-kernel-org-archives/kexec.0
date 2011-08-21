Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QvGnx-0006S3-Oz
	for kexec@lists.infradead.org; Sun, 21 Aug 2011 22:47:46 +0000
Date: Mon, 22 Aug 2011 07:47:38 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] kexec-tools: Xen fixes and cleanups
Message-ID: <20110821224737.GF2300@verge.net.au>
References: <20110821135029.GA17323@router-fw-old.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110821135029.GA17323@router-fw-old.local.net-space.pl>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Kiper <dkiper@net-space.pl>
Cc: olaf@aepfle.de, xen-devel@lists.xensource.com, ian.campbell@citrix.com, konrad.wilk@oracle.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Sun, Aug 21, 2011 at 03:50:29PM +0200, Daniel Kiper wrote:
> Hi,
> 
> I am sending some Xen specific fixes and cleanups for kexec-tools.
> These patches applies to current kexec-tools git tree.
> 
> Full list of fixes and cleanups:
>   - xen: Take into account Xen control interface changes since Xen Ver. 4.1,
>   - kexec: Export compare_ranges() function from firmware_memmap.c module,
>   - kexec/arch/i386: Rename fixup_memory_ranges_sysfs() to fixup_memory_ranges(),
>   - kexec/arch/i386: Add get_memory_ranges_xen() function.

Thanks Daniel,

all applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

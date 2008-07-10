Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KH5Zs-0001jj-0Y
	for kexec@lists.infradead.org; Thu, 10 Jul 2008 23:29:32 +0000
Date: Fri, 11 Jul 2008 09:29:30 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/3] Parse /sys/firmware/memmap.
Message-ID: <20080710232929.GH11227@verge.net.au>
References: <20080709004138.GD13710@verge.net.au>
	<1215601862-21748-2-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1215601862-21748-2-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Wed, Jul 09, 2008 at 01:11:00PM +0200, Bernhard Walle wrote:
> After the patch that provides /sys/firmware/memmap has been merged in the 'tip'
> tree by Ingo Molnar, kexec should use that interface.
> 
> This patch implements architecture-independent parsing in a new file called
> firmware_memmap.c. The x86 part is ported to use that memory map for
> kexec. We don't use that memory map for building the ELF core headers,
> that was the intention for that new interface.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thanks, applied. Ditto for the following two patches.

[PATCH 2/3] Remove redundancy between get_memory_ranges_proc_iomem()
        and get_memory_ranges_sysfs()
[PATCH 3/3] Use get_memory_ranges() on x86-64.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

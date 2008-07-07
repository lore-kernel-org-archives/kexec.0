Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KFkno-0000BF-Dr
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 07:06:25 +0000
Date: Mon, 7 Jul 2008 17:06:22 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/5] Parse /sys/firmware/memmap.
Message-ID: <20080707070621.GD788@verge.net.au>
References: <1215385571-11844-1-git-send-email-bwalle@suse.de>
	<1215385571-11844-4-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1215385571-11844-4-git-send-email-bwalle@suse.de>
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
Cc: Bernhard Walle <bernhard.walle@gmx.de>, kexec@lists.infradead.org, vgoyal@redhat.com

On Mon, Jul 07, 2008 at 01:06:09AM +0200, Bernhard Walle wrote:
> From: Bernhard Walle <bernhard.walle@gmx.de>
> 
> After the patch that provides /sys/firmware/memmap has been merged in the 'tip'
> tree by Ingo Molnar, kexec should use that interface.
> 
> This patch implements architecture-independent parsing in a new file called
> firmware_memmap.c. The x86 part is ported to use that memory map for
> kexec. We don't use that memory map for building the ELF core headers,
> that was the intention for that new interface.

Hi Bernhard,

I am seeing a build problem when compiling for i386

exec/firmware_memmap.c: In function `parse_numeric_sysfs':
kexec/firmware_memmap.c:55: error: `ULLONG_MAX' undeclared (first use in
this function)
kexec/firmware_memmap.c:55: error: (Each undeclared identifier is
reported only once
kexec/firmware_memmap.c:55: error: for each function it appears in.)
kexec/firmware_memmap.c: In function `parse_memmap_entry':
kexec/firmware_memmap.c:117: error: `ULLONG_MAX' undeclared (first use
in this function)

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

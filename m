Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JyhZe-0007MS-7r
	for kexec@lists.infradead.org; Wed, 21 May 2008 06:13:18 +0000
Date: Wed, 21 May 2008 16:13:11 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Implement EDD support for 32 bit boot
Message-ID: <20080521061310.GH3714@verge.net.au>
References: <20080509164904.GA18218@suse.de>
	<20080513151703.07a31891@strauss.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080513151703.07a31891@strauss.suse.de>
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

On Tue, May 13, 2008 at 03:17:03PM +0200, Bernhard Walle wrote:
> Update: Use the length field of the EDD header. Some BIOSe don't use
> the full EDD_DEVICE_PARAM_SIZE bytes, depending on the EDD version.
> 
> 
> From: Bernhard Walle <bwalle@suse.de>
> Subject: [PATCH] Implement EDD support for 32 bit boot
> To: kexec@lists.infradead.org
> 
> This patch implements EDD support. The information is read from
> /sys/firmware/edd (the edd driver must be loaded for this) and is written into
> the zero page of the 32 bit boot protocol.
> 
> I successfully tested the patch on a x86_64 machine with the x86_64 kernel.
> 
> This fixes a hardware detection problem, discovered in
> https://bugzilla.novell.com/show_bug.cgi?id=383210.
> 
> The last patch that updates the E820MAX constant is required to use that patch.

Thanks Bernhard, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

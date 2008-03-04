Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JWOlK-000823-OA
	for kexec@lists.infradead.org; Tue, 04 Mar 2008 04:28:23 +0000
Date: Tue, 4 Mar 2008 13:28:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] reduce alignment constraint on ia64 elf core header
Message-ID: <20080304042815.GA9469@verge.net.au>
References: <20080303143026.GA15484@hmsreliant.think-freely.org>
	<20080303155644.GB30167@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080303155644.GB30167@suse.de>
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
To: kexec@lists.infradead.org
Cc: Neil Horman <nhorman@tuxdriver.com>

On Mon, Mar 03, 2008 at 04:56:44PM +0100, Bernhard Walle wrote:
> * Neil Horman <nhorman@tuxdriver.com> [2008-03-03 15:30]:
> > Hey all-
> > 	Patch to reduce the alignment constraints on ia64 elf core headers.
> > >From what I can see there is no need to align the elf core header structure to
> > the EFI_PAGE_SIZE (given that the EFI will never read this data, only the kernel
> > will when booting a kdump kernel).  And since this is going into our reserved
> > memory, it saves us 3K (4K vs 1K alignment).  Tested successfully by myself on
> > several ia64 boxes.
> 
> This is wrong. Please read this thead:
> 
> https://lists.linux-foundation.org/pipermail/fastboot/2007-February/012882.html

Hi Neil, Hi Bernhard,

I can confirm that with Neil's patch I end up with a zero
byte long /proc/vmcore

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

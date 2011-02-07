Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PmOp9-000755-Hr
	for kexec@lists.infradead.org; Mon, 07 Feb 2011 11:00:04 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1PmOp2-0006Y0-Be
	for kexec@lists.infradead.org; Mon, 07 Feb 2011 11:59:56 +0100
Received: from 60.247.97.102 ([60.247.97.102])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Mon, 07 Feb 2011 11:59:56 +0100
Received: from xiyou.wangcong by 60.247.97.102 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Mon, 07 Feb 2011 11:59:56 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH -next] Documentation: Improve crashkernel= description
Date: Mon, 7 Feb 2011 10:59:40 +0000 (UTC)
Message-ID: <iiojar$cvf$1@dough.gmane.org>
References: <20110206154108.GA16542@laptop>
	<20110206215733.GB26233@verge.net.au> <4D4F5810.3070300@parallels.com>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Sun, 06 Feb 2011 20:25:20 -0600, Rob Landley wrote:

> 
> Suitable offset as in parses a known image type (ELF, bzImage, etc) to
> find the start address?  Or just assumes the entry point and load
> address are the same?


No, that is the start physical address of crashkernel, which should be
your system RAM not reserved by your BIOS etc..

The beginning of the physical memory is often fragmented, thus specifying 
a fixed offset may not work on a specific machine.

> 
> Is this the size for just the kernel image, or also for the physical
> memory it uses so it won't overwrite the existing kernel's stuff on the
> way up?  (If a compressed kernel wants to decompress itself or extract
> an initramfs for itself, what happens?)
> 

The size means the whole physical memory size available to the second
kernel (i.e. crash kernel), which includes the memory occupied by 
vmlinuz, initrd, *and* the memory which will be used by the programs
inside initrd (e.g. /sbin/init). If this memory is not sufficient,
you will get OOM.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

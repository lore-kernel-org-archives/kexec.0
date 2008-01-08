Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3] helo=e28esmtp03.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JC7DX-0006eT-V1
	for kexec@lists.infradead.org; Tue, 08 Jan 2008 05:41:49 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m085fUFd004640
	for <kexec@lists.infradead.org>; Tue, 8 Jan 2008 11:11:30 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m085fUZa1122446
	for <kexec@lists.infradead.org>; Tue, 8 Jan 2008 11:11:30 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id m085fTGo016781
	for <kexec@lists.infradead.org>; Tue, 8 Jan 2008 05:41:30 GMT
Date: Tue, 8 Jan 2008 11:11:05 +0530
From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: [PATCH] i386: handle an initrd in highmem (version 2)
Message-ID: <20080108054105.GC5393@linux.vnet.ibm.com>
References: <200801080502.m0852rhW017142@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200801080502.m0852rhW017142@tazenda.hos.anvin.org>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, hbabu@us.ibm.com, Ingo Molnar <mingo@redhat.com>, Thomas Gleixer <tglx@linutronix.de>, vgoyal@redhat.com

On Mon, Jan 07, 2008 at 09:02:53PM -0800, H. Peter Anvin wrote:
> The boot protocol has until now required that the initrd be located in
> lowmem, which makes the lowmem/highmem boundary visible to the boot
> loader.  This was exported to the bootloader via a compile-time
> field.  Unfortunately, the vmalloc= command-line option breaks this
> part of the protocol; instead of adding yet another hack that affects
> the bootloader, have the kernel relocate the initrd down below the
> lowmem boundary inside the kernel itself.
> 
> Note that this does not rely on HIGHMEM being enabled in the kernel.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> ---
> Fix crash on NUMA reported by Dhaval Giani (reported as being a kexec issue.)
> 

Yep, it does that. Just tested that on top of the x86 git tree (the mm
queue). It boots.

Tested-by: Dhaval Giani <dhaval@linux.vnet.ibm.com>

-- 
regards,
Dhaval

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

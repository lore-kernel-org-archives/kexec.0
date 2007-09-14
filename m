Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.ocgnet.org ([64.20.243.3])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IW1sr-0002PI-FS
	for kexec@lists.infradead.org; Thu, 13 Sep 2007 23:30:25 -0400
Date: Fri, 14 Sep 2007 12:30:05 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 6/7] Use extended crashkernel command line on sh
Message-ID: <20070914033005.GA3445@linux-sh.org>
References: <20070913161428.343951643@strauss.suse.de>
	<20070913161430.416849478@strauss.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070913161430.416849478@strauss.suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net

On Thu, Sep 13, 2007 at 06:14:34PM +0200, Bernhard Walle wrote:
> This patch removes the crashkernel parsing from arch/sh/kernel/machine_kexec.c
> and calls the generic function, introduced in the generic patch, in
> setup_bootmem_allocator().
> 
> This is necessary because the amount of System RAM must be known in this
> function now because of the new syntax.
> 
> NOTE: Due to the lack of a SH processor, this patch is untested (and
> uncompiled). Because the code in that area is quite similar as i386/x86_64
> (contrary to PPC and IA64), it should compile and work. However, if someone of
> the SH people could test for me and provide feedback, that would be very nice.
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
Works fine on SH.

Acked-by: Paul Mundt <lethal@linux-sh.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

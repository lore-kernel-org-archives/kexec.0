Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K5h5K-0004rP-6d
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 13:06:55 +0000
Date: Mon, 9 Jun 2008 09:06:46 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/3] [x86] Fix crashkernel reservation on NUMA machines
Message-ID: <20080609130646.GB3542@redhat.com>
References: <20080608134628.757299158@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080608134628.757299158@halley.suse.de>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de

On Sun, Jun 08, 2008 at 03:46:28PM +0200, Bernhard Walle wrote:
> This patch series fixes the crashkernel reservation on NUMA machine. The
> regression was discovered by Dave Anderson <anderson@redhat.com>.
> 
> The background is that on NUMA machines, reserve_bootmem_generic() is required
> instead of reserve_bootmem(). To achieve that, it's necessary to make a few
> API changes.
> 
> The patches are against latest linux-2.6 git. They should still go into 2.6.26
> since it's only bug fixing. For 2.6.27, we should unify crashkernel reservation
> for i386 and x86-64.
> 
> Tested on both i386 and x86-64. Compilation was tested with both kexec disabled
> and enabled. The change is x86 only, so no need to test on other architectures.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Yes we should be using reserve_bootmem_generic() for reserving memory
on NUMA machines. Recently myself and Dave A. ran into crash while 
reserving memory using resreve_bootmem() on a NUMA machine. 

Reason for crash? reserve_bootmem() always assumes node id to be zero, and
that was not the case.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

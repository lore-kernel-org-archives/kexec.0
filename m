Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J1r9q-0005EO-AC
	for kexec@lists.infradead.org; Mon, 10 Dec 2007 22:31:32 +0000
Date: Mon, 10 Dec 2007 17:31:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/4 -mm] kexec based hibernation -v7 : kexec jump
Message-ID: <20071210223117.GC27124@redhat.com>
References: <1197042810.24045.61.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1197042810.24045.61.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Fri, Dec 07, 2007 at 03:53:30PM +0000, Huang, Ying wrote:
> This patch implements the functionality of jumping between the kexeced
> kernel and the original kernel.
> 
> To support jumping between two kernels, before jumping to (executing)
> the new kernel and jumping back to the original kernel, the devices
> are put into quiescent state, and the state of devices and CPU is
> saved. After jumping back from kexeced kernel and jumping to the new
> kernel, the state of devices and CPU are restored accordingly. The
> devices/CPU state save/restore code of software suspend is called to
> implement corresponding function.
> 
> To support jumping without reserving memory. One shadow backup page
> (source page) is allocated for each page used by new (kexeced) kernel
> (destination page). When do kexec_load, the image of new kernel is
> loaded into source pages, and before executing, the destination pages
> and the source pages are swapped, so the contents of destination pages
> are backupped. Before jumping to the new (kexeced) kernel and after
> jumping back to the original kernel, the destination pages and the
> source pages are swapped too.
> 
> A jump back protocol for kexec is defined and documented. It is an
> extension to ordinary function calling protocol. So, the facility
> provided by this patch can be used to call ordinary C function in real
> mode.
> 
> A set of flags for sys_kexec_load are added to control which state are
> saved/restored before/after real mode code executing. For example, you
> can specify the device state and FPU state are saved/restored
> before/after real mode code executing.
> 
> The states (exclude CPU state) save/restore code can be overridden
> based on the "command" parameter of kexec jump. Because more states
> need to be saved/restored by hibernating/resuming.
> 


[..]
>  
> -#define KEXEC_ON_CRASH  0x00000001
> -#define KEXEC_ARCH_MASK 0xffff0000
> +#define KEXEC_ON_CRASH		0x00000001
> +#define KEXEC_PRESERVE_CPU	0x00000002
> +#define KEXEC_PRESERVE_CPU_EXT	0x00000004
> +#define KEXEC_SINGLE_CPU	0x00000008
> +#define KEXEC_PRESERVE_DEVICE	0x00000010
> +#define KEXEC_PRESERVE_CONSOLE	0x00000020

Hi,

Why do we need so many different flags for preserving different types
of state (CPU, CPU_EXT, Device, console) ? To keep things simple,
can't we can create just one flag KEXEC_PRESERVE_CONTEXT, which will
indicate any special action required for preserving the previous kernel's
context so that one can swith back to old kernel?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

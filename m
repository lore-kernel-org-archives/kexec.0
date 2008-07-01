Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bobafett.staff.proxad.net ([213.228.1.121])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KDgRm-00086O-NP
	for kexec@lists.infradead.org; Tue, 01 Jul 2008 14:03:07 +0000
From: Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH] MIPS: kernel kexec crashdump, 64-bit support, SMP etc.
Date: Tue, 1 Jul 2008 16:03:04 +0200
References: <48624ACE.4050403@ru.mvista.com>
In-Reply-To: <48624ACE.4050403@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807011603.04654.nschichan@freebox.fr>
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
Cc: msyrchin <msyrchin@ru.mvista.com>


Hi,


On Wednesday 25 June 2008 15:40:30 msyrchin wrote:
> This patch updates kernel part of kexec for MIPS platform to support
> kdump, 64-bit, SMP and simplify code adaptation to new boards. It does
> the following:
>
> - hooks for machine-specific actions are introduced
> (_machine_kexec_prepare,
>   _machine_kexec_shutdown, _machine_crash_shutdown);
> - kexec reboot on SMP machine is implemented;
> - add boot parameters passing to new kernel (array kexec_args[] is
> copied to
>   registers a0-a3 on reboot );
> - crash dump functionality is added (boot kernel with non-default physical
>   start, parse "crashkernel=..." command line parameter, copy_oldmem_page()
>   is implemeted to read memory dump after reboot-on-crashi,
> crash_setup_regs()
>   is updated to correctly store registers on crash);
>
> kexec/kdump funtionality was tested on several Cavium Octeon boards
> (mips64 SMP). The way we do it was the following:
> - _machine_kexec_prepare was find kexec segment with command line and
> save it's pointed into internal bootloader structure.
> - _machine_kexec_shutdown was used to stop boards IO and make all non-boot
> CPUs spin in function relocated_kexec_smp_wait()
> - _machine_crash_shutdown just calls default_machine_crash_shutdown()
> We tested 1) 'common' kexec reboot (by 'kexec -e'), 2) kexec-on-panic
> ('kexec -p ...') and 3) access to/proc/vmcore (with gdb).

Nice  :)   could  you   also  send  this   patch  to   the  linux-mips
mailing-list ?

Apprently all tabs in the patch have been converted to spaces and some
lines seem to have been wrapped by your mailer.

Regards,

-- 
Nicolas Schichan




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

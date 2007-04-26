Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HgtA3-0005Ck-5h
	for kexec@lists.infradead.org; Wed, 25 Apr 2007 21:52:45 -0400
Date: Thu, 26 Apr 2007 10:52:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec/kdump: Use generic elf code on ia64
Message-ID: <20070426015233.GB13085@verge.net.au>
References: <20070425090903.GA26412@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070425090903.GA26412@verge.net.au>
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
To: fastboot@lists.osdl.org, kexec@lists.infradead.org, linux-ia64@vger.kernel.org
Cc: Nanhai Zou <nanhai.zou@intel.com>, Vivek Goyal <vgoyal@in.ibm.com>, Tony Luck <tony.luck@intel.com>

On Wed, Apr 25, 2007 at 06:09:05PM +0900, Simon Horman wrote:
> Make use of the generic implementation of crash_save_cpu().
> 
> On ia64 the registers are saved by a kdump-specific function
> ia64_dump_cpu_regs() rather than elf_core_copy_regs() which
> is used by other architectures via crash_save_cpu(). It seems
> that ia64_dump_cpu_regs() and elf_core_copy_regs() are indeed
> quite different
> 
> In order to facilitate this kdump_elf_core_copy_regs()
> has been created, and it is called by crash_save_cpu().
> By default kdump_elf_core_copy_regs() is just defined to be
> elf_core_copy_regs() and ia64 defines its own implementation,
> which calls ia64_dump_cpu_regs().  The ia64 version also sets
> register 47 in accordance with the code that it replaces.
> 
> crash_save_cpu() has also been modifued to use a pre-alocated,
> per-cpu variable for saving the cpu registers, as per the
> IA64 specific code that this patch removes. This is
> in order to reduce possible stack contention at crash-time.

There are a couple of areas of the kexec code that allocate
per-cpu variables either staticly or at boot time. I wonder
if a more lazy approach of initialising them when they are first
accessed would be better. I am thinking of cases such as this one
where the first access will occur at kexec load time, so there
shouldn't be any chance of contention occuring at the time when
kexec executes the new kernel, or in the case of kdump, crash-time.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

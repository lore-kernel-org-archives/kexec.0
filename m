Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fx2GW-0007K0-AM
 for kexec@lists.infradead.org; Tue, 04 Sep 2018 03:44:33 +0000
Date: Tue, 4 Sep 2018 11:44:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] x86/boot: Add bit fields into xloadflags for 5-level
 kernel checking
Message-ID: <20180904034414.GI1740@192.168.1.3>
References: <20180829141624.13985-1-bhe@redhat.com>
 <20180829141624.13985-2-bhe@redhat.com>
 <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ea94875-ae07-6220-eb3e-d3f830cdac03@zytor.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, kirill.shutemov@linux.intel.com

Hi hpa,

Thanks for looking into this. 

On 09/03/18 at 07:41pm, H. Peter Anvin wrote:
> I don't understand why there is any reason not to always enter the target
> kernel in 4-level mode.  There certainly is no point whatsoever in having two
> xloadflags: the only thing that could possibly matter is whether or not the
> kernel in question *can* be entered in 5-level mode should that ever be necessary.

This patchset is only used to fix kexec/kdump issues. We never stop
kernel booting in 4-level mode from firmware as 1st kernel. However,
there are issues when jump from the 1st kernel which is in 5-level mode
to 2nd kernel. The reason is:

1) in arch/x86/kernel/relocate_kernel_64.S, we set X86_CR4_LA57 into cr4
if the 1st kernel is in 5-level mode. Then in
arch/x86/boot/compressed/head_64.S, paging_prepare() is called to decide
if 5-level mode will be enabled, and prepare the trampoline. If
kexec/kdump kernel is expected to be in 4-level, e.g with 'nolv5'
specified, it still can handle well. But for the old kernel w/o these
 5-level codes, it will ignore the fact that X86_CR4_LA57 has been set
in CR4 and proceed anyway, then #GP is triggered. That's why XLF_5LEVEL
is used to mark. 

2) For kexec_load interface, we put kernel/initrd at top of system RAM
in kexec_tools utility. If the 1st kernel is in 5-level mode, the
kexec-ed kernel has "CONFIG_X86_5LEVEL=n", we have to detect this and
limit the kernel to be loaded under 64TB, since kexec-ed kernel will
definitely run in 4-level mode. Putting kernel above 64TB will fail
kexec-ed kernel booting. That's why *XLF_5LEVEL_ENABLED* is needed.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

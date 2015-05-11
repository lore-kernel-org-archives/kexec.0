Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 11 May 2015 16:39:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [v2 4/5] arm64: add kdump support
Message-ID: <20150511083930.GB15884@dhcp-128-124.nay.redhat.com>
References: <1429861989-8417-1-git-send-email-takahiro.akashi@linaro.org>
 <1429861989-8417-5-git-send-email-takahiro.akashi@linaro.org>
 <20150508121921.GA18400@localhost.localdomain>
 <20150511074728.GA15884@dhcp-128-124.nay.redhat.com>
 <5550613A.3070506@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5550613A.3070506@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: panand@redhat.com, hbabus@us.ibm.com, linaro-kernel@lists.linaro.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, vgoyal@redhat.com, linux-arm-kernel@lists.infradead.org

On 05/11/15 at 04:58pm, AKASHI Takahiro wrote:
> Dave,
> 
> On 05/11/2015 04:47 PM, Dave Young wrote:
> >On 05/08/15 at 08:19pm, Dave Young wrote:
> >>Hi,
> >>
> >>On 04/24/15 at 04:53pm, AKASHI Takahiro wrote:
> >>>Please read the following commits for arm64-specific constraints:
> >>>     arm64: kdump: reserve memory for crash dump kernel
> >>>     arm64: kdump: do not go into EL2 before starting a crash dump kernel
> >>>
> >>>Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>>---
> >>>  Documentation/kdump/kdump.txt |   31 ++++++++++++++++++++++++++++++-
> >>>  arch/arm64/Kconfig            |   12 ++++++++++++
> >>>  2 files changed, 42 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> >>>index bc4bd5a..f9cf6f5 100644
> >>>--- a/Documentation/kdump/kdump.txt
> >>>+++ b/Documentation/kdump/kdump.txt
> >>>@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
> >>>  a remote system.
> >>>
> >>>  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> >>>-s390x and arm architectures.
> >>>+s390x, arm and arm64 architectures.
> >>>
> >>>  When the system kernel boots, it reserves a small section of memory for
> >>>  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> >>>@@ -249,6 +249,29 @@ Dump-capture kernel config options (Arch Dependent, arm)
> >>>
> >>>      AUTO_ZRELADDR=y
> >>>
> >>>+Dump-capture kernel config options (Arch Dependent, arm64)
> >>>+----------------------------------------------------------
> >>>+
> >>>+1) Disable symmetric multi-processing support under "Processor type and
> >>>+   features":
> >>>+
> >>>+   CONFIG_SMP=n
> >>>+
> >>>+   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
> >>>+   when loading the dump-capture kernel, see section "Load the Dump-capture
> >>>+   Kernel".)
> >>>+
> >>>+2) Under uefi, the maximum memory size on the dump-capture kernel must be
> >>>+   limited by specifying:
> >>>+
> >>>+   mem=X[MG]
> >>>+
> >>>+   where X should be less than or equal to the size in "crashkernel="
> >>>+   boot parameter. Kexec-tools will automatically add this.
> >>
> >>I noticed you are passing mem=X in kexec-tools, Pratyush found a problem
> >>that vmcore is corrupted because kdump kernel is using the crash notes memory.
> >>
> >>How does kdump kernel know the system ram range especially the mem_start?
> >>Only with the size from mem=? parammeter?
> >>
> >>In X86 because it use E820 so kexec-tools can pass the memory range to kdump
> >>kernel even for UEFI booting. But in arm64 may need find other way to
> >>communicate with 2nd kernel like memmap=exactmap in X86..
> >
> >Discussed with Pratyush in irc, he mentioned that start address is get from
> >kernel->entry which was passed by kexec-tools.
> >
> >So sorry for the noise, it will works fine with the UEFI mem= limitation
> >fix from Mark Salter
> 
> No, not at all.
> As you know, in another thread (with Mark), we're discussing this.
> If we conclude that we should go for "memmap=" approach, I will update my patch.

Ok, good to know. I did not notice the thread, will take a look.

There's another problem for memmap= approach though. In x86 we have problems when
we need pass reserved memory ranges as well because of some pci mmconfig issue.
In that case kernel command line buffer is too small and there's too many memory
ranges for reserved ranges. Thus later we switched to pass e820 in x86 boot params
directly.

If there's same potential problems we may consider to use memmap= only for system
ram, and for any other reserved types we can still get from same dtb in 1st kernel.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

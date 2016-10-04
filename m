Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 4 Oct 2016 11:18:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v26 0/7] arm64: add kdump support
Message-ID: <20161004101833.GB18083@leverpostej>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <8a57223d-000d-536e-6885-d427ee81508c@caviumnetworks.com>
 <20161003110424.GD14025@linaro.org>
 <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ae717d6-b2aa-105b-4f47-d879882ca5d3@caviumnetworks.com>
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
To: Manish Jaggi <mjaggi@caviumnetworks.com>
Cc: geoff@infradead.org, kexec@lists.infradead.org, will.deacon@arm.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, catalin.marinas@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Mon, Oct 03, 2016 at 06:11:40PM +0530, Manish Jaggi wrote:
> On 10/03/2016 04:34 PM, AKASHI Takahiro wrote:
> > On Mon, Oct 03, 2016 at 01:24:34PM +0530, Manish Jaggi wrote:
> >> Observations:
> >> 1.1. Dump capture kernel shows different memory map.
> >> ---------------------------------------------------
> >> In dump capture kernel /proc/meminfo and /proc/iomem differ
> >>
> >> root@arm64:/home/ubuntu/CODE/crash#
> >> MemTotal:       65882432 kB
> >> MemFree:        65507136 kB
> >> MemAvailable:   60373632 kB
> >> Buffers:           29248 kB
> >> Cached:            46720 kB
> >> SwapCached:            0 kB
> >> Active:            63872 kB
> >> Inactive:          19776 kB
> >> Active(anon):       8256 kB
> >> Inactive(anon):     7616 kB
> >>
> >> First kernel is booted with mem=2G crashkernel=1G command line option.
> >> While the system has 64G memory.
> >>
> >> root@arm64:/home/ubuntu/CODE/crash# cat /proc/iomem
> >> 41400000-fffeffff : System RAM
> >>   41480000-420cffff : Kernel code
> >>   42490000-4278ffff : Kernel data
> >> ffff0000-ffffffff : reserved
> >> 100000000-ffaa7ffff : System RAM
> >> ffaa80000-ffaabffff : reserved
> >> ffaac0000-fffa6ffff : System RAM
> >> fffa70000-fffacffff : reserved
> >> fffad0000-fffffffff : System RAM
> > 
> > Are you saying that "mem=..." doesn't have any effect?
> What I am saying it that If the first kernel is booted using mem= option and crashkernel= option
> the memory for second kernel has to be withing the crashkernel size.

Please don't try to use mem= to limit the kernel to a specific range of
memory. It's really only there as a tool to test handling of low-memory
situations. 

While it guarantees that at most, the amount requested will be used
(modulo a number of edge cases with reserved memory ranges), it does not
guarantee *which* memory will be used. It is *very* fragile.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

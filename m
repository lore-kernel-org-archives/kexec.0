Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 29 Nov 2016 11:05:02 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v28 0/9] arm64: add kdump support
Message-ID: <20161129110502.GE30283@arm.com>
References: <20161124095523.6972-1-takahiro.akashi@linaro.org>
 <20161125162039.GB22099@e104818-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161125162039.GB22099@e104818-lin.cambridge.arm.com>
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On Fri, Nov 25, 2016 at 04:20:40PM +0000, Catalin Marinas wrote:
> On Thu, Nov 24, 2016 at 06:55:23PM +0900, AKASHI Takahiro wrote:
> > AKASHI Takahiro (8):
> >   arm64: kdump: reserve memory for crash dump kernel
> >   memblock: add memblock_cap_memory_range()
> >   arm64: limit memory regions based on DT property, usable-memory-range
> >   arm64: kdump: implement machine_crash_shutdown()
> >   arm64: kdump: add kdump support
> >   arm64: kdump: add VMCOREINFO's for user-space coredump tools
> >   arm64: kdump: enable kdump in the arm64 defconfig
> >   arm64: kdump: update a kernel doc
> 
> Given that it's nearly -rc7, holiday in the US and more acks needed, we
> should defer merging this series to 4.11. In the meantime, since Will is
> going to handle the 4.11 merging window, I'm acking the whole series:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Okey doke. I'll keep my eyes peeled for a new version in the new year.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 23 Jul 2018 14:35:35 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
Message-ID: <20180723133527.GA9450@arm.com>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com>
 <20180713003434.GZ28220@linaro.org>
 <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
 <20180717051222.GA11258@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180717051222.GA11258@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Jul 17, 2018 at 02:12:23PM +0900, AKASHI Takahiro wrote:
> On Fri, Jul 13, 2018 at 07:49:45AM +0200, Ard Biesheuvel wrote:
> > On 13 July 2018 at 02:34, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > > On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
> > >> Hi Akashi,
> > >>
> > >> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
> > >> > This patch series is a set of bug fixes to address kexec/kdump
> > >> > failures which are sometimes observed on ACPI-only system and reported
> > >> > in LAK-ML before.
> > >>
> > >> I tried picking this up, along with Ard's fixup, but I'm seeing a build
> > >> failure for allmodconfig:
> > >>
> > >> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
> > >> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
> > >>
> > >> I didn't investigate further. Please can you fix this?
> > >
> > > Because CONFIG_ACPI is on and CONFIG_EFI is off.
> > >
> > > This can happen in allmodconfig as CONFIG_EFI depends on
> > > !CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.
> > >
> > 
> > Allowing both CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN to be configured
> > makes no sense at all. Things will surely break if you start using BE
> > memory accesses while parsing ACPI tables.
> > 
> > Allowing CONFIG_ACPI without CONFIG_EFI makes no sense either, since
> > on arm64, the only way to find the ACPI tables is through a UEFI
> > configuration table.
> 
> 
> Do you agree to this?

Yes; please post a new series which resolves these dependencies and includes
Ard's fixup from before.

Thanks,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 9 Oct 2014 11:21:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
Message-ID: <20141009032130.GB2690@darkstar.nay.redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
 <20141007134006.GC27464@redhat.com>
 <20141008094258.GG27216@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141008094258.GG27216@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: ard.biesheuvel@linaro.org, Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, leif.lindholm@linaro.org, roy.franz@linaro.org, Marc Zyngier <Marc.Zyngier@arm.com>, Vivek Goyal <vgoyal@redhat.com>, msalter@redhat.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 10/08/14 at 10:42am, Mark Rutland wrote:
> [Cc'ing the arm efi guys]
> 
> On Tue, Oct 07, 2014 at 02:40:06PM +0100, Vivek Goyal wrote:
> > On Fri, Oct 03, 2014 at 02:16:11PM -0700, Geoff Levand wrote:
> > > Hi,
> > > 
> > > On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
> > > > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
> > > > > Hi All,
> > > > > 
> > > > > This series adds the core support for kexec re-boots on arm64.  I have tested
> > > > > with the ARM VE fast model using various kernel config options for both the
> > > > > first and second stage kernels.
> > > > 
> > > > Does this patch series work with kexec on UEFI machines?
> > > 
> > > I have not done much more than some simple re-boot tests using the
> > > base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
> > > but yes, it should work.
> > 
> > [CC Dave Young ]
> > 
> > I have not looked at the user space patches but are you preparing efi
> > setup data and passing all the runtime map information to second kernel.
> > 
> > I am hoping on arm64 we have the CONFIG_EFI_RUNTIME_MAP=y and it works
> > well.
> 
> From a quick look at mainline that config option just gates exposing
> that info under sysfs, and we never call efi_runtime_map_setup on arm64.
> I gues the x86 kexec tool parses that and sets up some data structure?
> 
> For arm64 we have runtime map information in the initial DTB, and this
> should have been copied into the DTB we pass to the second kernel. See
> Documentation/arm/uefi.txt and drivers/firmware/efi/libstub/fdt.c.
> 
> Is that sufficient?

That will be sufficient for runtime maps, but several phys addresses need to be
saved: /sys/firmware/efi/{fw_vendor,runtime,config_table}

From uefi spec these addresses are updated to virtual addresses after entering
virtual mode.

Though it should work without the runtime map exporting to sysfs, It's not bad
to export them, it's good to have for debugging purpose and it will be consistant
across different arches.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

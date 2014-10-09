Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XcApV-0008L0-1l
 for kexec@lists.infradead.org; Thu, 09 Oct 2014 10:20:18 +0000
Received: by mail-lb0-f170.google.com with SMTP id u10so831903lbd.15
 for <kexec@lists.infradead.org>; Thu, 09 Oct 2014 03:19:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20141009100919.GF3869@leverpostej>
References: <cover.1411604443.git.geoff@infradead.org>
 <20141001151947.GB14991@redhat.com>
 <1412370971.32313.30.camel@smoke>
 <20141007134006.GC27464@redhat.com>
 <20141008094258.GG27216@leverpostej>
 <20141009032130.GB2690@darkstar.nay.redhat.com>
 <20141009100919.GF3869@leverpostej>
Date: Thu, 9 Oct 2014 12:19:54 +0200
Message-ID: <CAKv+Gu_-Cx7Byy_HwtN2OxHy1W_UxTwmkJYzyEm7eW6UE6iLNQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64 kexec kernel patches V3
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
Cc: Geoff Levand <geoff@infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "leif.lindholm@linaro.org" <leif.lindholm@linaro.org>, "roy.franz@linaro.org" <roy.franz@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msalter@redhat.com" <msalter@redhat.com>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

On 9 October 2014 12:09, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Oct 09, 2014 at 04:21:30AM +0100, Dave Young wrote:
>> On 10/08/14 at 10:42am, Mark Rutland wrote:
>> > [Cc'ing the arm efi guys]
>> >
>> > On Tue, Oct 07, 2014 at 02:40:06PM +0100, Vivek Goyal wrote:
>> > > On Fri, Oct 03, 2014 at 02:16:11PM -0700, Geoff Levand wrote:
>> > > > Hi,
>> > > >
>> > > > On Wed, 2014-10-01 at 11:19 -0400, Vivek Goyal wrote:
>> > > > > On Thu, Sep 25, 2014 at 12:23:26AM +0000, Geoff Levand wrote:
>> > > > > > Hi All,
>> > > > > >
>> > > > > > This series adds the core support for kexec re-boots on arm64.  I have tested
>> > > > > > with the ARM VE fast model using various kernel config options for both the
>> > > > > > first and second stage kernels.
>> > > > >
>> > > > > Does this patch series work with kexec on UEFI machines?
>> > > >
>> > > > I have not done much more than some simple re-boot tests using the
>> > > > base model (FVP_Base_AEMv8A-AEMv8A) and the Linaro 14.08 efi build,
>> > > > but yes, it should work.
>> > >
>> > > [CC Dave Young ]
>> > >
>> > > I have not looked at the user space patches but are you preparing efi
>> > > setup data and passing all the runtime map information to second kernel.
>> > >
>> > > I am hoping on arm64 we have the CONFIG_EFI_RUNTIME_MAP=y and it works
>> > > well.
>> >
>> > From a quick look at mainline that config option just gates exposing
>> > that info under sysfs, and we never call efi_runtime_map_setup on arm64.
>> > I gues the x86 kexec tool parses that and sets up some data structure?
>> >
>> > For arm64 we have runtime map information in the initial DTB, and this
>> > should have been copied into the DTB we pass to the second kernel. See
>> > Documentation/arm/uefi.txt and drivers/firmware/efi/libstub/fdt.c.
>> >
>> > Is that sufficient?
>>
>> That will be sufficient for runtime maps, but several phys addresses need to be
>> saved: /sys/firmware/efi/{fw_vendor,runtime,config_table}
>>
>> From uefi spec these addresses are updated to virtual addresses after entering
>> virtual mode.
>
> Ouch. That sounds painful.
>
> I'd prefer to not have to duplicate these in the DTB if we can. Given we
> should have the memmmap with the virtual<->physical mappings, could we
> not do a lookup there before early dereferences if we happen to already
> be in virtual mode?
>

According to the UEFI spec, only code and data regions used for UEFI
Runtime Services are supposed to be virtually remapped. The firmware
must not request virtual mappings for configuration tables that are
installed at boot time. (UEFI spec 2.3.6)

This means that the only spec compliant way to access this data is to
take its physical address (whose value remains accessible after
installing the virtual memory map) and ioremap() it. Anything else
violates the spec, even if it works currently on x86

>> Though it should work without the runtime map exporting to sysfs, It's not bad
>> to export them, it's good to have for debugging purpose and it will be consistant
>> across different arches.
>
> Exporting the sysfs entries makes sense for debug, but I'd very much
> prefer that it were not our default solution for passing the maps to the
> next kernel.
>

Agreed

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

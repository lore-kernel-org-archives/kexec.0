Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbpAU-0005Bz-Bk
 for kexec@lists.infradead.org; Thu, 21 May 2020 17:39:44 +0000
Date: Thu, 21 May 2020 20:39:41 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20200521173941.GP1634618@smile.fi.intel.com>
References: <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
 <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
 <20200120121927.GJ32742@smile.fi.intel.com>
 <87a76i9ksr.fsf@x220.int.ebiederm.org>
 <CAHp75VdjwWfqHtJ3n-UK_n5nzpgcpERbM+_9-Z3FrjJx7nHQzQ@mail.gmail.com>
 <CAKv+Gu-sVSWNYHEjzjOfbEryOR_XruwH=qQphq4uTXMLPK18tw@mail.gmail.com>
 <20200121153730.GZ32742@smile.fi.intel.com>
 <87h80o4tls.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87h80o4tls.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Matt Fleming <matt@codeblueprint.co.uk>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>, Jean Delvare <jdelvare@suse.de>

On Tue, Jan 21, 2020 at 11:17:19AM -0600, Eric W. Biederman wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > On Tue, Jan 21, 2020 at 12:18:03AM +0100, Ard Biesheuvel wrote:
> >> On Mon, 20 Jan 2020 at 23:31, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >> > On Mon, Jan 20, 2020 at 9:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> > > > On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:

...

> >> > > > Can we apply these patches for now until you will find better
> >> > > > solution?
> >> > >
> >> > > Not a chance.  The patches don't apply to any kernel in the git history.
> >> > >
> >> > > Which may be part of your problem.  You are or at least were running
> >> > > with code that has not been merged upstream.
> >> >
> >> > It's done against linux-next.
> >> > Applied clearly. (Not the version in this more than yearly old series
> >> > of course, that's why I told I can resend)
> >> >
> >> > > > P.S. I may resend them rebased on recent vanilla.
> >> > >
> >> > > Second.  I looked at your test results and they don't directly make
> >> > > sense.  dmidecode bypasses the kernel completely or it did last time
> >> > > I looked so I don't know why you would be using that to test if
> >> > > something in the kernel is working.
> >> > >
> >> > > However dmidecode failing suggests that the actual problem is something
> >> > > in the first kernel is stomping the dmi tables.
> >> >
> >> > See below.
> >> >
> >> > > Adding a command line option won't fix stomped tables.
> >> >
> >> > It provides a mechanism, which seems to be absent, to the second
> >> > kernel to know where to look for SMBIOS tables.
> >> >
> >> > > So what I would suggest is:
> >> > > a) Verify that dmidecode works before kexec.
> >> >
> >> > Yes, it does.
> >> >
> >> > > b) Test to see if dmidecode works after kexec.
> >> >
> >> > No, it doesn't.
> >> >
> >> > > c) Once (a) shows that dmidecode works and (b) shows that dmidecode
> >> > >    fails figure out what is stomping your dmi tables during or before
> >> > >    kexec and that is what should get fixed.
> >> >
> >> > The problem here as I can see it that EFI and kexec protocols are not
> >> > friendly to each other.
> >> > I'm not an expert in either. That's why I'm asking for possible
> >> > solutions. And this needs to be done in kernel to allow drivers to
> >> > work.
> >> >
> >> > Does the
> >> >
> >> > commit 4996c02306a25def1d352ec8e8f48895bbc7dea9
> >> > Author: Takao Indoh <indou.takao@jp.fujitsu.com>
> >> > Date:   Thu Jul 14 18:05:21 2011 -0400
> >> >
> >> >     ACPI: introduce "acpi_rsdp=" parameter for kdump
> >> >
> >> > description shed a light on this?
> >> >
> >> > > Now using a non-efi method of dmi detection relies on the
> >> > > tables being between 0xF0000 and 0x10000. AKA the last 64K
> >> > > of the first 1MiB of memory.  You might check to see if your
> >> > > dmi tables are in that address range.
> >> >
> >> > # dmidecode --no-sysfs
> >> > # dmidecode 3.2
> >> > Scanning /dev/mem for entry point.
> >> > # No SMBIOS nor DMI entry point found, sorry.
> >> >
> >> > === with patch applied ===
> >> > # dmidecode
> >> > ...
> >> >         Release Date: 03/10/2015
> >> > ...
> >> >
> >> > >
> >> > > Otherwise I suspect the good solution is to give efi it's own page
> >> > > tables in the kernel and switch to it whenever efi functions are called.
> >> > >
> >> >
> >> > > But on 32bit the Linux kernel has historically been just fine directly
> >> > > accessing the hardware, and ignoring efi and all of the other BIOS's.
> >> >
> >> > It seems not only for 32-bit Linux kernel anymore. MS Surface 3 runs
> >> > 64-bit code.
> >> >
> >> > > So if that doesn't work on Intel Galileo that is probably a firmware
> >> > > problem.
> >> >
> >> > It's not only about Galileo anymore.
> >> >
> >> 
> >> Looking at the x86 kexec EFI code, it seems that it has special
> >> handling for the legacy SMBIOS table address, but not for the SMBIOS3
> >> table address, which was introduced to accommodate SMBIOS tables
> >> living in memory that is not 32-bit addressable.
> >> 
> >> Could anyone check whether these systems provide SMBIOS 3.0 tables,
> >> and whether their address gets virtually remapped at ExitBootServices?
> >
> > On Microsoft Surface 3 tablet:
> >
> > === First kernel ===
> >
> > # uname -a
> >
> > (Previously reported issue on)
> > Linux buildroot 4.13.0+ #39 SMP Tue Sep 5 14:58:23 EEST 2017 x86_64 GNU/Linux
> >
> > (Updated today to)
> > Linux buildroot 5.4.0+ #2 SMP Tue Nov 26 15:36:31 EET 2019 x86_64 GNU/Linux
> >
> > # ls -l /sys/firmware/dmi/tables/
> > total 0
> > -r--------    1 root     root           825 Jan 21 15:41 DMI
> > -r--------    1 root     root            31 Jan 21 15:41 smbios_entry_point
> >
> > # od -Ax -tx1 /sys/firmware/dmi/tables/smbios_entry_point
> > 000000 5f 53 4d 5f 0f 1f 02 08 6a 00 00 00 00 00 00 00
> > 000010 5f 44 4d 49 5f e0 39 03 00 40 5b 7b 0f 00 27
> > 00001f
> >
> > # dmesg | grep -i dmi
> > [    0.000000] DMI: Microsoft Corporation Surface 3/Surface 3, BIOS 1.50410.78 03/10/2015
> > [    0.403058] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> >
> > # dmesg | grep -i smb
> > [    0.000000] efi:  ESRT=0x7b7c6c98  ACPI=0x7ad5a000  ACPI 2.0=0x7ad5a000  SMBIOS=0x7b5f7d18
> > [    0.000000] SMBIOS 2.8 present.
> >
> > === kexec'ed kernel ===
> > # uname -a
> > (in both cases, see above `uname -a`, the same version)
> > Linux buildroot 5.5.0-rc7+ #161 SMP Tue Jan 21 15:50:02 EET 2020 x86_64 GNU/Linux
> >
> > # dmidecode
> > # dmidecode 3.2
> > 	Scanning /dev/mem for entry point.
> > # No SMBIOS nor DMI entry point found, sorry.
> >
> > # dmidecode --no-sysfs
> > # dmidecode 3.2
> > 	Scanning /dev/mem for entry point.
> > # No SMBIOS nor DMI entry point found, sorry.
> 
> This sounds like at least something of a different issue, with similar
> symptoms.
> 
> I don't think it is fundamentally wrong to pass the location of the dmi
> tables in a command line option.  If you can build that command line
> option independent of kexec and it takes practically no maintenance then
> it does not harm, and can be used as a debug option by others.
> 
> My primary concern with your original patch is because it did not
> apply to any version of the kernel in Linus's git tree that it had not
> been tested on any code.

As I have told couple of times there is no issue for me to rebase on any
subsytem tree. Do you want EFI one as a base?

> That said let me lay some background on kexec and efi so we can
> have a productive conversation about how to maintain their cooperation
> in the long term.  I am going to do this from memory so please forgive
> me where I get my details slightly off.

Thank you for that, but as far as I'm concerned those calls are not significant
in the second kernel for my test purposes. Basically the issue is to supply DMI
information, which is static, to the second kernel.

...

> ExitBootSerives is similarly challenging as it can only be called once,
> and there are systems that get it wrong if you call it at all.  Even if
> ExitBootServices works you can't depend on any of the boot services for
> the second kernel.

And I do not need. At least I haven't (yet?) found an issue with that.

...

> There are two primary uses for kexec.  To use the first kernel as a boot
> loader in which case it is desiable for everything to work after kexec
> is called.  To use the second kernel as something to capture a crash
> dump in which case simply a best effor is needed and failing cleanly
> if something won't work properly.

> You are running interactive commands so I presume you are wanting to use
> kexec as a bootloader.

We are using kexec to run kernel over network. That's how our (local) lab
infrastructure looks like. Basically what we need is to be able to test
drivers on SUT as a primary concern here.

...

> By the same token I don't understand the problem with DMI not working.
> As I recall all the linux kernel really uses DMI for is to decide which
> quirks to apply.

Yes, that's usual (historical) way for quirks on x86.

> It might be better just to pass a board name string
> on the kernel command line, and use that string for quirk selection
> instead.  A simple string seems like an easy to implement and use
> debug command line option, that has uses outside of kexec.  AKA testing
> to see if quirks do what you expect them too.

Huh?! No way, we have a (1st) kernel platform agnostic. This will make it board
dependent. Moreover, second kernel needs to be *heavily* patched for this.
It's way to nowhere.

> Which brings us to the question of quirks.  Why are quirks important?
> If they are that suggests something else is wrong.  Maybe that something
> else should be fixed.

> Why do those boards need the DMI information in the first place?

I didn't get a sarcasm in above few paragraphs, but we are living in ideal
world, you know...

So, I will rebase and submit a new version of the series with extended commit
message. Problem is there and should be addressed.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

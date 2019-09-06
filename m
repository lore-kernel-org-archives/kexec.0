Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga18.intel.com ([134.134.136.126])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6JVN-0005cq-Hs
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 19:02:46 +0000
Date: Fri, 6 Sep 2019 22:00:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20190906190040.GA16211@smile.fi.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion>
 <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
 <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161217105721.GB6922@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, ard.biesheuvel@linaro.org, matt@codeblueprint.co.uk, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>

On Sat, Dec 17, 2016 at 06:57:21PM +0800, Dave Young wrote:
> On 12/16/16 at 02:33pm, Jean Delvare wrote:
> > On Fri, 16 Dec 2016 14:18:58 +0200, Andy Shevchenko wrote:
> > > On Fri, 2016-12-16 at 10:32 +0800, Dave Young wrote:
> > > > On 12/15/16 at 12:28pm, Jean Delvare wrote:
> > > > > I am no kexec expert but this confuses me. Shouldn't the second
> > > > > kernel have access to the EFI systab as the first kernel does? It
> > > > > includes many more pointers than just ACPI and DMI tables, and it
> > > > > would seem inconvenient to have to pass all these addresses
> > > > > individually explicitly.
> > > > 
> > > > Yes, in modern linux kernel, kexec has the support for EFI, I think it
> > > > should work naturally at least in x86_64.
> > > 
> > > Thanks for this good news!
> > > 
> > > Unfortunately Intel Galileo is 32-bit platform.
> > 
> > If it was done for X86_64 then maybe it can be generalized to X86?
> 
> For X86_64, we have a new way for efi runtime memmory mapping, in i386
> code it still use old ioremap way. It is impossible to use same way as
> the X86_64 since the virtual address space is limited.
> 
> But maybe for 32bit, kexec kernel can run in physical mode, but I'm not
> sure, I would suggest Andy to do a test first with efi=noruntime for
> kexec 2nd kernel.

Sorry for a delay.
Eventually I found time to check this.

Unfortunately the efi=noruntime didn't help:

# uname -a
Linux buildroot 5.3.0-rc7+ #17 Thu Sep 5 16:08:22 EEST 2019 i586 GNU/Linux
# dmidecode
# dmidecode 4.2
Scanning /dev/mem for entry point.
# No SMBIOS nor DMI entry point found, sorry.
#
# cat /proc/cmdline
... ignore_loglevel efi=noruntime earlycon=efifb acpi_rsdp=0xf01e014

So, I am all ears to anything else to try.

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

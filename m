Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqItz-004ks9-EL
 for kexec@lists.infradead.org; Mon, 07 Jun 2021 17:19:04 +0000
Date: Mon, 7 Jun 2021 20:18:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
Message-ID: <YL5U/zSb50SnbLgW@smile.fi.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <YLdEZoSWI41fcTB1@smile.fi.intel.com>
 <YLdG91qspr19heDS@smile.fi.intel.com>
 <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com>
 <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
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
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Javier =?iso-8859-1?B?VGnh?= <javier.tia@gmail.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-efi <linux-efi@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, Ard Biesheuvel <ardb@kernel.org>

On Mon, Jun 07, 2021 at 07:22:21PM +0300, Andy Shevchenko wrote:
> On Sat, Jun 05, 2021 at 03:51:05PM +0800, Dave Young wrote:
> > On 06/02/21 at 11:53am, Andy Shevchenko wrote:
> > > On Wed, Jun 02, 2021 at 11:42:14AM +0300, Andy Shevchenko wrote:
> > > > On Fri, Dec 02, 2016 at 09:54:14PM +0200, Andy Shevchenko wrote:
> > > > > Until now DMI information is lost when kexec'ing. Fix this in the same way as
> > > > > it has been done for ACPI RSDP.
> > > > > 
> > > > > Series has been tested on Galileo Gen2 where DMI is used by drivers, in
> > > > > particular the default I2C host speed is choosen based on DMI system
> > > > > information and now gets it correct.
> > > > 
> > > > Still nothing happens for a while and problem still exists.
> > > > Can we do something about it, please?
> > 
> > Seems I totally missed this thread. Old emails lost.
> 
> You can always access to it via lore :-)
> https://lore.kernel.org/linux-efi/20161217105721.GB6922@dhcp-128-65.nay.redhat.com/T/#u
> 
> (Okay, it's not full, but contains main parts anyway)
> 
> 
> > The question Ard asked is to confirm if the firmware converted the
> > SMBIOS3 addr to a virtual address after exit boot service. I do not
> > remember some easy way to check it due to lost the context of the code.
> > But you can try to check it via dmesg|grep SMBIOS both in normal boot
> > and kexeced boot log.  And then compare if those addresses are
> > identical.
> > 
> > If the SMBIOS3 addr in kexec kernel is different then it should have
> > been modified by firmware. Then we need patch kernel and kexec-tools to
> > support it.
> > 
> > You can try below patch to see if it works:
> 
> So, AFAIU I have to apply patch to kexec tools for the fist kernel + userspace
> and apply kernel patch for the second kernel? Or it's all for the first one?
> 
> > apply a kexec-tools patch to kexec-tools if you do not use kexec -s
> > (kexec_file_load):
> 
> Here is how we are using it:
> https://github.com/andy-shev/buildroot/blob/intel/board/intel/common/netboot/udhcpc-script.sh#L54

Okay, thanks for the patches. I have applied them to both kernels, so the first
one and second one are the same and kexec tools have a patch provided in the
user space of the both kernels (only first one in use though).

Before applying your patch, I have reverted my hacks (as per this series).

Result is:

# uname -a
Linux buildroot 5.13.0-rc5+ #1 SMP Mon Jun 7 19:49:40 EEST 2021 i586 GNU/Linux
# dmidecode
# dmidecode 3.3
Scanning /dev/mem for entry point.
# No SMBIOS nor DMI entry point found, sorry.

I.o.w. it does NOT fix the issue. My patches do (with a hint from user space).

-- 
With Best Regards,
Andy Shevchenko



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

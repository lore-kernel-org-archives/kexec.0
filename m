Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cICaP-0002DW-E6
 for kexec@lists.infradead.org; Sat, 17 Dec 2016 10:51:30 +0000
Date: Sat, 17 Dec 2016 18:50:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20161217105059.GA6922@dhcp-128-65.nay.redhat.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion>
 <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1481890738.9552.70.camel@linux.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org

On 12/16/16 at 02:18pm, Andy Shevchenko wrote:
> On Fri, 2016-12-16 at 10:32 +0800, Dave Young wrote:
> > On 12/15/16 at 12:28pm, Jean Delvare wrote:
> > > Hi Andy,
> > > =

> > > On Fri,=A0=A02 Dec 2016 21:54:16 +0200, Andy Shevchenko wrote:
> > > > Until now kexec'ed kernel has no clue where to look for DMI entry
> > > > point.
> > > > =

> > > > Pass it via kernel command line parameter in the same way as it's
> > > > done for ACPI
> > > > RSDP.
> > > =

> > > I am no kexec expert but this confuses me. Shouldn't the second
> > > kernel
> > > have access to the EFI systab as the first kernel does? It includes
> > > many more pointers than just ACPI and DMI tables, and it would seem
> > > inconvenient to have to pass all these addresses individually
> > > explicitly.
> > =

> > Yes, in modern linux kernel, kexec has the support for EFI, I think it
> > should work naturally at least in x86_64.
> =

> Thanks for this good news!
> =

> Unfortunately Intel Galileo is 32-bit platform.

Maybe you can try use efi=3Dnoruntime kernel parameter in kexec/kdump
kernel, see if it works or not.

> =

> -- =

> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHseD-0005vK-Mz
 for kexec@lists.infradead.org; Fri, 16 Dec 2016 13:34:06 +0000
Date: Fri, 16 Dec 2016 14:33:30 +0100
From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
Message-ID: <20161216143330.69e9c8ee@endymion>
In-Reply-To: <1481890738.9552.70.camel@linux.intel.com>
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion>
 <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com>
MIME-Version: 1.0
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, 16 Dec 2016 14:18:58 +0200, Andy Shevchenko wrote:
> On Fri, 2016-12-16 at 10:32 +0800, Dave Young wrote:
> > On 12/15/16 at 12:28pm, Jean Delvare wrote:
> > > I am no kexec expert but this confuses me. Shouldn't the second
> > > kernel have access to the EFI systab as the first kernel does? It
> > > includes many more pointers than just ACPI and DMI tables, and it
> > > would seem inconvenient to have to pass all these addresses
> > > individually explicitly.
> > 
> > Yes, in modern linux kernel, kexec has the support for EFI, I think it
> > should work naturally at least in x86_64.
> 
> Thanks for this good news!
> 
> Unfortunately Intel Galileo is 32-bit platform.

If it was done for X86_64 then maybe it can be generalized to X86?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

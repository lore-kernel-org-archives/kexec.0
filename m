Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZRiQN-0008Pt-7y
 for kexec@lists.infradead.org; Tue, 18 Aug 2015 15:03:39 +0000
Message-ID: <1439910078.24434.106.camel@hp.com>
Subject: Re: kexec, x86: Need a new e820 type support for kexec
From: Toshi Kani <toshi.kani@hp.com>
Date: Tue, 18 Aug 2015 09:01:18 -0600
In-Reply-To: <20150818085330.GB15480@dhcp-128-28.nay.redhat.com>
References: <1437697592.3214.373.camel@hp.com>
 <20150806081231.GA16699@dhcp-128-28.nay.redhat.com>
 <1438910038.3109.116.camel@hp.com>
 <20150818085330.GB15480@dhcp-128-28.nay.redhat.com>
Mime-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: linux-nvdimm@ml01.01.org, dan.j.williams@intel.com, kexec@lists.infradead.org, hch@lst.de, linux-kernel@vger.kernel.org

On Tue, 2015-08-18 at 16:53 +0800, Baoquan He wrote:
> On 08/06/15 at 07:13pm, Toshi Kani wrote:
> > On Thu, 2015-08-06 at 16:12 +0800, Baoquan He wrote:
> > E820_PMEM cannot be emulated by the "memmap=" option.  Do you have to 
> > use the "memmap=" options to pass the ranges for kdump kernel?  If so, 
> > I'd rather ignore E820_PMEM and let it be passed as E820_RESERVED.  The
> > kdump kernel can still obtain the info from NFIT if necessary.
> > 
> > As for the code change...
> > 
> > > @@ -640,6 +644,8 @@ static void cmdline_add_memmap_internal(char 
> > > *cmdline, 
> > > unsigned long startk,
> > >  		strcat (str_mmap, "K$");
> > >  	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
> > >  		strcat (str_mmap, "K#");
> > > +	else if (type == RANGE_PMEM || type == RANGE_PRAM)
> > > +		strcat (str_mmap, "K!");
> > 
> > It should only check with RANGE_PRAM, but I do not think this change 
> > matters much unless you also modify the caller cmdline_add_memmap(), 
> > which has the following check to skip other types.  I do not think we 
> > will use legacy NVDIMM device as a dump device, so you may ignore 
> > RANGE_PRAM and let it be passed as RESERVED as well (which is likely the 
> > case I tested with).
> 
> Rethink it again, maybe it's better to pass PMEM as PRAM to kdump
> kernel if user really want to use memmap way by specifying
> --pass-memmap-cmdline. Then I need add the PMEM and PRAM checking here
> you pointed out. Will repost with them.

No, you should not report PMEM as PRAM.  They are different things.  The
kdump kernel does not need to support memmap cmdline for PMEM, as the
regular kernel does not -- memmap cmdline cannot emulate PMEM.

Thanks,
-Toshi


> 
> 
> > 
> >                 /* Only adding memory regions of RAM and ACPI */
> >                 if (type != RANGE_RAM &&
> >                     type != RANGE_ACPI &&
> >                     type != RANGE_ACPI_NVS)
> >                         continue;
> > 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

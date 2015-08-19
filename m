Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZS0sA-00034P-MK
 for kexec@lists.infradead.org; Wed, 19 Aug 2015 10:45:35 +0000
Date: Wed, 19 Aug 2015 18:45:09 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v3] Add persistent memory support
Message-ID: <20150819104509.GG19950@dhcp-128-28.nay.redhat.com>
References: <1439975029-25611-1-git-send-email-bhe@redhat.com>
 <20150819092815.GB6130@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150819092815.GB6130@localhost.localdomain>
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
Cc: toshi.kani@hp.com, horms@verge.net.au, kexec@lists.infradead.org

On 08/19/15 at 05:28pm, Dave Young wrote:
> Hi,
> 
> On 08/19/15 at 05:03pm, Baoquan He wrote:
  
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 82bf239..598a78f 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -301,6 +301,10 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> >  			type = RANGE_ACPI;
> >  		} else if(memcmp(str,"ACPI Non-volatile Storage\n",26) == 0 ) {
> >  			type = RANGE_ACPI_NVS;
> > +		} else if(memcmp(str,"Persistent Memory (legacy)\n",27) == 0 ) {
> > +			type = RANGE_PRAM;
> > +		} else if(memcmp(str,"Persistent Memory\n",18) == 0 ) {
> > +			type = RANGE_PMEM;
> >  		} else if(memcmp(str,"reserved\n",9) == 0 ) {
> >  			type = RANGE_RESERVED;
> >  		} else if (memcmp(str, "GART\n", 5) == 0) {
> > @@ -640,6 +644,8 @@ static void cmdline_add_memmap_internal(char *cmdline, unsigned long startk,
> >  		strcat (str_mmap, "K$");
> >  	else if (type == RANGE_ACPI || type == RANGE_ACPI_NVS)
> >  		strcat (str_mmap, "K#");
> > +	else if (type == RANGE_PRAM)
> > +		strcat (str_mmap, "K!");
> 
> Since we have switched to use e820 it is not necessary to supporting new things
> in legacy memmap interface?

Well, I am not sure about this. Kexec-tools provides memmap method to
pass the memory ranges, then either we continue supporting it or we
delete it. Now is this OK we just keep legacy memmap code there and
ignore it? If people check the man page and find --pass-memmap-cmdline
and intend to try, then kexec/kdump fail, then how do we go with it?

Thanks
Baoquan

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

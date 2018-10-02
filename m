Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g7JVq-0003TE-MY
 for kexec@lists.infradead.org; Tue, 02 Oct 2018 12:11:20 +0000
Date: Tue, 2 Oct 2018 20:10:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2] kdump: fix an error that can not parse the e820
 reserved region
Message-ID: <20181002121033.GA10450@dhcp-128-65.nay.redhat.com>
References: <20180906055618.3210-1-lijiang@redhat.com>
 <20180907010550.GA30391@dhcp-128-65.nay.redhat.com>
 <20181002120250.jlkvvau2oqcfffxb@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181002120250.jlkvvau2oqcfffxb@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Lianbo Jiang <lijiang@redhat.com>

On 10/02/18 at 02:02pm, Simon Horman wrote:
> On Fri, Sep 07, 2018 at 09:05:50AM +0800, Dave Young wrote:
> > On 09/06/18 at 01:56pm, Lianbo Jiang wrote:
> > > When kexec-tools load the kernel and initramfs for kdump, kexec-tools will
> > > read /proc/iomem and recreate the e820 ranges for kdump kernel. But it fails
> > > to parse the e820 reserved region, because the memcmp() is case sensitive
> > > when comparing the string. In fact, it may be "Reserved" or "reserved" in
> > > the /proc/iomem, so we have to fix these cases.
> > > 
> > > Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> > > ---
> > >  kexec/arch/i386/crashdump-x86.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > > index 437e8a8..140f45b 100644
> > > --- a/kexec/arch/i386/crashdump-x86.c
> > > +++ b/kexec/arch/i386/crashdump-x86.c
> > > @@ -289,6 +289,8 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
> > >  			type = RANGE_PMEM;
> > >  		} else if(memcmp(str,"reserved\n",9) == 0 ) {
> > >  			type = RANGE_RESERVED;
> > > +		} else if (memcmp(str, "Reserved\n", 9) == 0) {
> > > +			type = RANGE_RESERVED;
> > >  		} else if (memcmp(str, "GART\n", 5) == 0) {
> > >  			gart_start = start;
> > >  			gart_end = end;
> > > -- 
> > > 2.17.1
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > Reviewed-by: Dave Young <dyoung@redhat.com>
> 
> Sorry for letting this slip through the cracks.
> I've applied this now.

Simon, thank you!

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

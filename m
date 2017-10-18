Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1e4gik-00067D-Rp
 for kexec@lists.infradead.org; Wed, 18 Oct 2017 05:16:49 +0000
Date: Wed, 18 Oct 2017 07:16:03 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] kexec-tools: mips: Merge adjacent memory ranges.
Message-ID: <20171018051603.f7o2lgr7tiux5r6b@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-2-david.daney@cavium.com>
 <20171016065313.g5va4jel5si2udbm@verge.net.au>
 <8a440fe8-0633-32e1-d142-44765b41c47b@caviumnetworks.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a440fe8-0633-32e1-d142-44765b41c47b@caviumnetworks.com>
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
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-mips@linux-mips.org, kexec@lists.infradead.org, David Daney <david.daney@cavium.com>

On Mon, Oct 16, 2017 at 09:13:30AM -0700, David Daney wrote:
> On 10/15/2017 11:53 PM, Simon Horman wrote:
> > On Thu, Oct 12, 2017 at 02:02:25PM -0700, David Daney wrote:
> > > Some kernel versions running on MIPS split the System RAM memory
> > > regions reported in /proc/iomem.  This may cause loading of the kexec
> > > kernel to fail if it crosses one of the splits.
> > > 
> > > Fix by merging adjacent memory ranges that have the same type.
> > > 
> > > Signed-off-by: David Daney <david.daney@cavium.com>
> > > ---
> > >   kexec/arch/mips/kexec-mips.c | 14 ++++++++++----
> > >   1 file changed, 10 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
> > > index 2e5b700..415c2ed 100644
> > > --- a/kexec/arch/mips/kexec-mips.c
> > > +++ b/kexec/arch/mips/kexec-mips.c
> > > @@ -60,10 +60,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
> > >   		} else {
> > >   			continue;
> > >   		}
> > > -		memory_range[memory_ranges].start = start;
> > > -		memory_range[memory_ranges].end = end;
> > > -		memory_range[memory_ranges].type = type;
> > > -		memory_ranges++;
> > > +		if (memory_ranges > 0 &&
> > 
> > It seems that this will never merge the first memory range
> > with subsequent ones. Is that intentional?
> 
> 
> With the first range (index 0), no other range yet exists to merge with.  We
> can only test for merging with the second and subsequent ranges (indices 1
> and above).  To do otherwise would cause us to read things from *before* the
> beginning of the array ...

Yes, of course. I see that now.

I've applied this patch.

> > 
> > 
> > > +		    memory_range[memory_ranges - 1].end == start &&
> 
> ... here.
> 
> > > +		    memory_range[memory_ranges - 1].type == type) {
> > > +			memory_range[memory_ranges - 1].end = end;
> > > +		} else {
> > > +			memory_range[memory_ranges].start = start;
> > > +			memory_range[memory_ranges].end = end;
> > > +			memory_range[memory_ranges].type = type;
> > > +			memory_ranges++;
> > > +		}
> > >   	}
> > >   	fclose(fp);
> > >   	*range = memory_range;
> > > -- 
> > > 2.9.5
> > > 
> > > 
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > > 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

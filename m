Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WTUX9-00011h-TA
 for kexec@lists.infradead.org; Fri, 28 Mar 2014 11:01:12 +0000
Date: Fri, 28 Mar 2014 12:00:47 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140328120047.24a056ea@hananiah.suse.cz>
In-Reply-To: <20140327145441.4c956989@holzheu>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
 <20140326185426.5e2e5fc4@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FA0EC@BPXM01GP.gisp.nec.co.jp>
 <20140327145441.4c956989@holzheu>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

On Thu, 27 Mar 2014 14:54:41 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> On Thu, 27 Mar 2014 05:19:06 +0000
> Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> 
> > Hello Michael,
> > 
> > >On Wed, 26 Mar 2014 10:55:07 +0100 (a/T)
> > >HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> > >
> > >> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > >> Subject: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
> > >> Date: Tue, 25 Mar 2014 17:14:20 +0100
> > >
> > >[snip]
> > >
> > >> > With this patch makedumpfile gets the maximum page frame number from
> > >> > the mem_map array and adjusts info->max_mapnr if this value is smaller
> > >> > than the value calculated from the ELF header.
> > >> >
> > >> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > >> > ---
> > >> >  makedumpfile.c |   14 +++++++++++++-
> > >> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >> >
> > >> > --- a/makedumpfile.c
> > >> > +++ b/makedumpfile.c
> > >> > @@ -2829,7 +2829,8 @@ get_mem_map_without_mm(void)
> > >> >  int
> > >> >  get_mem_map(void)
> > >> >  {
> > >> > -	int ret;
> > >> > +	unsigned long max_pfn = 0;
> > >> > +	int ret, i;
> > >>
> > >> Please define max_pfn as unsigned long long.
> > >
> > >Ok done.
> > >
> > >>
> > >> And for i,
> > >>
> > >> >
> > >> >  	switch (get_mem_type()) {
> > >> >  	case SPARSEMEM:
> > >> > @@ -2861,6 +2862,17 @@ get_mem_map(void)
> > >> >  		ret = FALSE;
> > >> >  		break;
> > >> >  	}
> > >> > +	/*
> > >> > +	 * Adjust "max_mapnr" for the case that Linux uses less memory
> > >> > +	 * than is dumped. For example when "mem=" has been used for the
> > >> > +	 * dumped system.
> > >> > +	 */
> > >> > +	for (i = 0; i < info->num_mem_map; i++) {
> > >>
> > >> info->num_mem_map is defined as unsigned int. I guess some warning
> > >> about comparison with different signedness occurs.
> > >
> > >Ah ok...
> > >
> > >With the default CFLAGS for makedumpfile-1.5.5 tarball I do not get
> > >any warning. When I add "-W" to CFLAGS, I get lots of warnings
> > >including the one you mentioned.
> > >
> > >Here the fixed patch:
> > 
> > Thanks, I'll merge the fixed version into v1.5.6.
> 
> Great!

I'm sorry to spoil the party, but this patch broke Xen dumps for me.
I'm getting an long series of these messages:

set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
...

In fact, it most likely broke all non-cyclic dumps.

That's because the bitmap length is calculated in prepare_bitmap_buffer
using info->max_mapnr, but create_1st_bitmap() still loops over all
PT_LOAD segments, calling set_bit_on_1st_bitmap() for each PFN. The
offset may easily fall beyond the bitmap size.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

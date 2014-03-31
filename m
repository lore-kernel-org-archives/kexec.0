Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WUZRr-0003v5-Q5
 for kexec@lists.infradead.org; Mon, 31 Mar 2014 10:28:12 +0000
Date: Mon, 31 Mar 2014 12:27:45 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140331122745.65643833@hananiah.suse.cz>
In-Reply-To: <20140328174622.2896296e@holzheu>
References: <20140325171420.6b558576@holzheu>
 <20140326.105507.429853525.d.hatayama@jp.fujitsu.com>
 <20140326185426.5e2e5fc4@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE971FA0EC@BPXM01GP.gisp.nec.co.jp>
 <20140327145441.4c956989@holzheu>
 <20140328120047.24a056ea@hananiah.suse.cz>
 <20140328174622.2896296e@holzheu>
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

On Fri, 28 Mar 2014 17:46:22 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> On Fri, 28 Mar 2014 12:00:47 +0100
> Petr Tesarik <ptesarik@suse.cz> wrote:
> 
> > On Thu, 27 Mar 2014 14:54:41 +0100
> > Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 
> [snip]
> 
> > > > >Here the fixed patch:
> > > > 
> > > > Thanks, I'll merge the fixed version into v1.5.6.
> > > 
> > > Great!
> > 
> > I'm sorry to spoil the party, but this patch broke Xen dumps for me.
> > I'm getting an long series of these messages:
> > 
> > set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
> > set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
> > set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap91pbsO). Invalid argument
> > ...
> > 
> > In fact, it most likely broke all non-cyclic dumps.
> > 
> > That's because the bitmap length is calculated in prepare_bitmap_buffer
> > using info->max_mapnr, but create_1st_bitmap() still loops over all
> > PT_LOAD segments, calling set_bit_on_1st_bitmap() for each PFN. The
> > offset may easily fall beyond the bitmap size.
> 
> What about the following patch. It works for me when I specify
> the "--non-cyclic" option.

I'm still getting a bunch of these:

set_bitmap: Can't read the bitmap(/tmp/kdump_bitmap7lSPrl). Invalid
argument

This time they come in like this:

create_2nd_bitmap
-> exclude_free_page
   -> _exclude_free_page
      -> reset_bitmap_of_free_pages
         -> clear_bit_on_2nd_bitmap_for_kernel
            (here, physical PFN is translated to machine PFN)
            -> clear_bit_on_2nd_bitmap

The resulting machine PFN is beyond the bitmap extents.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

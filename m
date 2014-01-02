Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VynVp-0002Kp-Kg
 for kexec@lists.infradead.org; Thu, 02 Jan 2014 19:00:59 +0000
Date: Thu, 2 Jan 2014 14:00:34 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <821191738.23743294.1388689234324.JavaMail.root@redhat.com>
In-Reply-To: <20140102182430.GA23662@sgi.com>
References: <mailman.18142.1388532985.1059.kexec@lists.infradead.org>
 <1324606289.23678103.1388681414693.JavaMail.root@redhat.com>
 <20140102182430.GA23662@sgi.com>
Subject: Re: [PATCH 2/2] makedumpfile: exclude unused vmemmap pages > (Cliff
 Wickman)
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> On Thu, Jan 02, 2014 at 11:50:14AM -0500, Dave Anderson wrote:
> > 
> > 
> > ----- Original Message -----
> > > Date: Tue, 31 Dec 2013 17:36:02 -0600
> > > From: Cliff Wickman <cpw@sgi.com>
> > > To: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com,
> > > 	kumagai-atsushi@mxc.nes.nec.co.jp
> > > Subject: [PATCH 2/2] makedumpfile: exclude unused vmemmap pages
> > > Message-ID: <20131231233602.GB18522@sgi.com>
> > > Content-Type: text/plain; charset=us-ascii
> > > 
> > > On Tue, Dec 31, 2013 at 05:30:01PM -0600, cpw wrote:
> > > 
> > > Exclude kernel pages that contain nothing but page structures for pages
> > > that are not being included in the dump.
> > > These can amount to 3.67 million pages per terabyte of system memory!
> > > 
> > > The kernel's page table, starting at virtual address 0xffffea0000000000,
> > > is
> > > searched to find the actual pages containing the vmemmap page structures.
> > > 
> > > Bitmap1 is a map of dumpable (i.e existing) pages. Bitmap2 is a map
> > > of pages not to be excluded.
> > > To speed the search of bitmaps only whole 64-bit words of 1's in
> > > bitmap1 and 0's in bitmap2 are tested to see if they are vmemmap pages.
> > > 
> > > The list of vmemmap pfn's to be excluded is written to a small file in
> > > order
> > > to conserve crash kernel memory.
> > > 
> > > In practice, this whole procedure only takes about 10 seconds on a
> > > 16TB machine.
> > > 
> > > The effect of omitting unused page structures from the dump has only
> > > one, minimal side effect that I can find: the crash command "kmem -f"
> > > will
> > > fail when attempting to walk through free pages. This seems to me to be
> > > a trivial negative when weighed against the enabling and acceleration
> > > of dumps on large systems.
> > > 
> > > This patch includes -e and -N options to exclude or include unneeded
> > > vmemmap pages regardless of system size (see flag_includevm and
> > > flag_excludvm).  By default the exclusion of such pages is only
> > > done on a system of a terabyte or more.
> > 
> > Hi Cliff,
> > 
> > I understand the reason behind this, but the default exclusion
> > (even @ 1TB) makes me a little nervous.
> > 
> > Although I'm sure you tested this, I find it amazing that
> > only the "kmem -[fF]" option is the only command option
> > that is affected?
> 
> Hi Dave,
> 
> Maybe I missed some kmem options that walk free page lists.
> If a crash command is walking a page freelist it would use the
> list_head named 'lru' would it not?  I only find lru references
> in crash's memory.c unwind.c gdb-7.6/sim/frv/cache.c gdb-7.6/bfd/cache.c
> I didn't do extensive tests of crash, but the kmem command was
> all I found.

Right, but look at all of the other page struct offsets in addition to
page.lru that are used.  The page.flags usage comes to mind, and for
example, what would "kmem -p" display for the missing pages?
Or "kmem <address>"?  And would "kmem -i" display invalid data?
I'm just speculating off the top of my head, but the page structure is
such a fundamental data structure with several of its fields being used,
just enter "help -o page_" to see all of its potential member usages.

> > 
> > If I'm not mistaken, this would be the first time that legitimate
> > kernel data would be excluded from the dump, and the user would
> > have no obvious way of knowing that it had been done, correct?
> > If it were encoded in the in the header somewhere, at least a
> > warning message could be printed during crash initialization.
> 
> Agreed, it is legitimate kernel data.  But it is data that represents
> memory that we are not capturing.  So it would seem to me to be of
> little use.  And on the other hand if we do capture that data the time
> to take the dump would be so long as to make the whole notion of doing
> a dump prohibitive.
> (Even with this patch it took 40 minutes to dump a system of 16TB.
>  Without the patch that might be 5 hours.  And soon there will be
>  64TB systems.)
> 
> When kmem -f fails it does say that a needed page has been excluded
> from the dump.
> But an up-front message would be reasonable.

Perhaps the disk_dump_header.status field could be used?  Currently only
the 3 DUMP_DH_COMPRESSED_xxx bits are used. 

> > 
> > In any case, given that this can change traditional behavior,
> > I would prefer that the full set of pages be copied by default,
> > and only be excluded if the user configures it to do so.
> 
> That could be easily done.  It's not unreasonable to make the very large
> system require the special option.  I just thought that the check of system
> size would be doing the system administrator a favor.

Yeah, I understand, but we don't do any other kind of restrictions without
purposefully specifying them with the -d arguments.  IMHO it just seems to be 
heading down a slippery slope that presumes makedumpfile "knows better"
than the administrator.

Dave




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

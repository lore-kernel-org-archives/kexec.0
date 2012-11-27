Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TdFfP-00059w-Kj
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 07:33:17 +0000
Date: Tue, 27 Nov 2012 16:30:08 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 08/10] Add page_is_buddy for PG_buddy
Message-Id: <20121127163008.00c899202ae52536f544dd45@mxc.nes.nec.co.jp>
In-Reply-To: <20121127150048.f84d125d86e404c5b177cd58@mxc.nes.nec.co.jp>
References: <20121116050108.8280.14861.stgit@localhost6.localdomain6>
 <20121116050213.8280.73020.stgit@localhost6.localdomain6>
 <20121127150048.f84d125d86e404c5b177cd58@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

On Tue, 27 Nov 2012 15:00:48 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello HATAYAMA-san,
> 
> On Fri, 16 Nov 2012 14:02:13 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> > On kernels from v2.6.18 to v2.6.37, buddy page is marked by the
> > PG_buddy flag.
> > 
> >   kernel version     | PG_buddy
> >   ------------------ +---------------------------------
> >   v2.6.17 to v2.6.26 | 19
> >   v2.6.27 to v2.6.37 | 19 if CONFIG_PAGEFLAGS_EXTEND=y
> >                      | 18 otherwise

Additionally, PG_private_2 was introduced in v2.6.30 with the commit
below:

  commit 266cf658efcf6ac33541a46740f74f50c79d2b6b
  Author: David Howells <dhowells@redhat.com>
  Date:   Fri Apr 3 16:42:36 2009 +0100

      FS-Cache: Recruit a page flags for cache management

      Recruit a page flag to aid in cache management.  The following extra flag is
      defined:

       (1) PG_fscache (PG_private_2)


Therefore, PG_buddy varies as below:

  kernel version     | PG_buddy
  ------------------ +---------------------------------
  v2.6.27 to v2.6.29 | 18 if CONFIG_PAGEFLAGS_EXTEND=y
                     | 17 otherwise
  v2.6.30 to v2.6.37 | 19 if CONFIG_PAGEFLAGS_EXTEND=y
                     | 18 otherwise


Thanks
Atsushi Kumagai

> > We don't need to care about CONFIG_PAGEFLAGS_EXTEND because the
> > architectures specifying this as y are um and xtensa only. They are
> > not included in the supported architectures of makedumpfile.
> 
> Sorry for too late point out.
> 
> I did regression test for v1.5.1 on x86_64 machine in the last weekend
> and found the issue that page_is_buddy_v2() can't exclude free pages
> correctly for kernel 2.6.30 to 2.6.37. 
> I checked the configuration of these kernels, I made sure that
> CONFIG_PAGEFLAGS_EXTENDED was set as y, so PG_buddy=18 is invalid for them.
> 
> According to this fact, PG_buddy is variable for the supported architectures
> of makedumpfile, too.
> So, how did you confirm that CONFIG_PAGEFLAGS_EXTENDED is only related with
> um and xtensa ?
> 
> And why did you test with PG_buddy=19 for 2.6.32 when you posted this patch set?
> 
> >  - 2.6.32
> >  NUMBER(PG_slab)=7
> >  NUMBER(PG_buddy)=19
> >  OFFSET(page._mapcount)=12
> >  OFFSET(page.private)=16
> >  SIZE(pageflags)=4
> 
> 
> Thanks
> Atsushi Kumagai
>  
> > Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> > ---
> > 
> >  makedumpfile.c |   24 ++++++++++++++++++++----
> >  1 files changed, 20 insertions(+), 4 deletions(-)
> > 
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 7b13dca..4e5d4d3 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -3669,6 +3669,19 @@ exclude_free_page(void)
> >  }
> >  
> >  /*
> > + * For the kernel versions from v2.6.17 to v2.6.37.
> > + */
> > +static int
> > +page_is_buddy_v2(unsigned long flags, unsigned int _mapcount,
> > +			unsigned long private, unsigned int _count)
> > +{
> > +	if (flags & (1UL << NUMBER(PG_buddy)))
> > +		return TRUE;
> > +
> > +	return FALSE;
> > +}
> > +
> > +/*
> >   * For v2.6.38 and later kernel versions.
> >   */
> >  static int
> > @@ -3690,10 +3703,13 @@ setup_page_is_buddy(void)
> >  	if (OFFSET(page.private) == NOT_FOUND_STRUCTURE)
> >  		goto out;
> >  
> > -	if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
> > -		if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
> > -			info->page_is_buddy = page_is_buddy_v3;
> > -	}
> > +	if (NUMBER(PG_buddy) == NOT_FOUND_NUMBER) {
> > +		if (NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE) != NOT_FOUND_NUMBER) {
> > +			if (OFFSET(page._mapcount) != NOT_FOUND_STRUCTURE)
> > +				info->page_is_buddy = page_is_buddy_v3;
> > +		}
> > +	} else
> > +		info->page_is_buddy = page_is_buddy_v2;
> >  
> >  out:
> >  	if (!info->page_is_buddy)
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

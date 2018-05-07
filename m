Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFao8-0004h3-Vp
 for kexec@lists.infradead.org; Mon, 07 May 2018 07:43:44 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH 2/2] Check PG_swapbacked for swap cache pages
Date: Mon, 7 May 2018 07:42:23 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE011A770D@BPXM01GP.gisp.nec.co.jp>
References: <5e0004648d2a597417542b483a0c3aed114bf03f.1523636414.git.ptesarik@suse.com>
 <2efa8f466177a492abbe0cb64046ec8cd8b8afdf.1523636414.git.ptesarik@suse.com>
 <20180424124325.2ef00cd0@ezekiel.suse.cz>
 <61D4E5D821F1674CB87C99F080A210BE0119C16E@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <61D4E5D821F1674CB87C99F080A210BE0119C16E@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec-ml <kexec@lists.infradead.org>, Keiichi Nakamura <kei-nakamura@vt.jp.nec.com>

Hi Petr,

Sorry for the late reply.
Your patches look good.
Thank you.


Thanks
Tachibana


> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Masaki Tachibana
> Sent: Wednesday, April 25, 2018 1:12 PM
> To: Petr Tesarik <ptesarik@suse.cz>
> Cc: kexec-ml <kexec@lists.infradead.org>; Nakamura Keiichi() <kei-nakamura@vt.jp.nec.com>
> Subject: RE: [PATCH 2/2] Check PG_swapbacked for swap cache pages
> 
> Hi Petr,
> 
> Sorry. I can't take time enough for makedumpfile recently.
> I would like to reply by May 11th.
> Please wait some weeks.
> 
> Thanks
> Tachibana
> 
> > -----Original Message-----
> > From: Petr Tesarik [mailto:ptesarik@suse.cz]
> > Sent: Tuesday, April 24, 2018 7:43 PM
> > To: Tachibana Masaki() <mas-tachibana@vf.jp.nec.com>; Nakayama Takuya() <tak-nakayama@tg.jp.nec.com>;
> > kexec-ml <kexec@lists.infradead.org>
> > Subject: Re: [PATCH 2/2] Check PG_swapbacked for swap cache pages
> >
> > Hi Masaki-san,
> >
> > what is the status of this patch? Do you have any concerns?
> >
> > TIA,
> > Petr T
> >
> > On Fri, 13 Apr 2018 18:29:59 +0200
> > Petr Tesarik <ptesarik@suse.cz> wrote:
> >
> > > When page cache is filtered out (dump level bitmap includes 2 or 4),
> > > makedumpfile checks the PG_swapcache bit, but since kernel commit
> > > 6326fec1122cde256bd2a8c63f2606e08e44ce1d (v4.10-rc1~7) this bit is
> > > an alias for PG_owner_priv_1, which is also used by filesystem
> > > code (PG_checked) and Xen (PG_pinned and PG_foreign).
> > >
> > > With these kernels, the PG_swapcache flag is valid only if
> > > PG_swapbacked is set. A Linux kernel patch has already been
> > > submitted to export the value of PG_swapbacked in VMCOREINFO.
> > >
> > > Since there are released kernels in the wild which do not export the
> > > value, a fallback is implemented. I considered these three situations:
> > >
> > >   1. Kernels before v2.6.28-rc1~244:
> > >      PG_swapbacked does not exist, so it must not be checked.
> > >      Instead, check PG_swapcache, which is never overloaded for
> > >      another purpose.
> > >
> > >   2. Kernels between v2.6.28-rc1~244 and v4.10-rc1~7:
> > >      It is sufficient to check only PG_swapcache, but PG_swapbacked
> > >      may also be checked (it is always set if PG_swapcache is set).
> > >
> > >   3. Kernels since v4.10-rc1~7:
> > >      PG_swapbacked must be checked.
> > >
> > > If PG_swapbacked value is known (exported or read from debuginfo),
> > > it is always safe to use it (case 2 or 3). If PG_swapbacked is not
> > > known, it is safe to ignore it for cases 1 and 2, but not 3.
> > > Thankfully, the new value of PG_swapcache (since v4.10-rc1~7) is
> > > less than PG_private (which is known), whereas the old value had
> > > always been greater than PG_private. Moreover, the flags between
> > > PG_private and PG_swapbacked haven't changed since v4.10-rc1~7, so
> > > PG_swapbacked can fall back to PG_private + 6 if unknown.
> > >
> > > Without this patch, all Xen dumps are unusable, because PG_pinned is
> > > set for all page table pages.
> > >
> > > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > > ---
> > >  makedumpfile.c | 19 ++++++++++++++++++-
> > >  makedumpfile.h |  2 ++
> > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/makedumpfile.c b/makedumpfile.c
> > > index 175ba68..ec04a88 100644
> > > --- a/makedumpfile.c
> > > +++ b/makedumpfile.c
> > > @@ -252,7 +252,18 @@ isHugetlb(unsigned long dtor)
> > >  static int
> > >  is_cache_page(unsigned long flags)
> > >  {
> > > -	return isLRU(flags) || isSwapCache(flags);
> > > +	if (isLRU(flags))
> > > +		return TRUE;
> > > +
> > > +	/* PG_swapcache is valid only if:
> > > +	 *   a. PG_swapbacked bit is set, or
> > > +	 *   b. PG_swapbacked did not exist (kernels before 4.10-rc1).
> > > +	 */
> > > +	if ((NUMBER(PG_swapbacked) == NOT_FOUND_NUMBER || isSwapBacked(flags))
> > > +	    && isSwapCache(flags))
> > > +		return TRUE;
> > > +
> > > +	return FALSE;
> > >  }
> > >
> > >  static inline unsigned long
> > > @@ -1735,6 +1746,7 @@ get_structure_info(void)
> > >  	ENUM_NUMBER_INIT(PG_lru, "PG_lru");
> > >  	ENUM_NUMBER_INIT(PG_private, "PG_private");
> > >  	ENUM_NUMBER_INIT(PG_swapcache, "PG_swapcache");
> > > +	ENUM_NUMBER_INIT(PG_swapbacked, "PG_swapbacked");
> > >  	ENUM_NUMBER_INIT(PG_buddy, "PG_buddy");
> > >  	ENUM_NUMBER_INIT(PG_slab, "PG_slab");
> > >  	ENUM_NUMBER_INIT(PG_hwpoison, "PG_hwpoison");
> > > @@ -1988,6 +2000,9 @@ get_value_for_old_linux(void)
> > >  		NUMBER(PG_private) = PG_private_ORIGINAL;
> > >  	if (NUMBER(PG_swapcache) == NOT_FOUND_NUMBER)
> > >  		NUMBER(PG_swapcache) = PG_swapcache_ORIGINAL;
> > > +	if (NUMBER(PG_swapbacked) == NOT_FOUND_NUMBER
> > > +	    && NUMBER(PG_swapcache) < NUMBER(PG_private))
> > > +		NUMBER(PG_swapbacked) = NUMBER(PG_private) + 6;
> > >  	if (NUMBER(PG_slab) == NOT_FOUND_NUMBER)
> > >  		NUMBER(PG_slab) = PG_slab_ORIGINAL;
> > >  	if (NUMBER(PG_head_mask) == NOT_FOUND_NUMBER)
> > > @@ -2264,6 +2279,7 @@ write_vmcoreinfo_data(void)
> > >  	WRITE_NUMBER("PG_private", PG_private);
> > >  	WRITE_NUMBER("PG_head_mask", PG_head_mask);
> > >  	WRITE_NUMBER("PG_swapcache", PG_swapcache);
> > > +	WRITE_NUMBER("PG_swapbacked", PG_swapbacked);
> > >  	WRITE_NUMBER("PG_buddy", PG_buddy);
> > >  	WRITE_NUMBER("PG_slab", PG_slab);
> > >  	WRITE_NUMBER("PG_hwpoison", PG_hwpoison);
> > > @@ -2658,6 +2674,7 @@ read_vmcoreinfo(void)
> > >  	READ_NUMBER("PG_private", PG_private);
> > >  	READ_NUMBER("PG_head_mask", PG_head_mask);
> > >  	READ_NUMBER("PG_swapcache", PG_swapcache);
> > > +	READ_NUMBER("PG_swapbacked", PG_swapbacked);
> > >  	READ_NUMBER("PG_slab", PG_slab);
> > >  	READ_NUMBER("PG_buddy", PG_buddy);
> > >  	READ_NUMBER("PG_hwpoison", PG_hwpoison);
> > > diff --git a/makedumpfile.h b/makedumpfile.h
> > > index 6205ef3..fe306bb 100644
> > > --- a/makedumpfile.h
> > > +++ b/makedumpfile.h
> > > @@ -155,6 +155,7 @@ test_bit(int nr, unsigned long addr)
> > >  #define isPrivate(flags)	test_bit(NUMBER(PG_private), flags)
> > >  #define isCompoundHead(flags)   (!!((flags) & NUMBER(PG_head_mask)))
> > >  #define isSwapCache(flags)	test_bit(NUMBER(PG_swapcache), flags)
> > > +#define isSwapBacked(flags)	test_bit(NUMBER(PG_swapbacked), flags)
> > >  #define isHWPOISON(flags)	(test_bit(NUMBER(PG_hwpoison), flags) \
> > >  				&& (NUMBER(PG_hwpoison) != NOT_FOUND_NUMBER))
> > >
> > > @@ -1881,6 +1882,7 @@ struct number_table {
> > >  	long	PG_head;
> > >  	long	PG_head_mask;
> > >  	long	PG_swapcache;
> > > +	long	PG_swapbacked;
> > >  	long	PG_buddy;
> > >  	long	PG_slab;
> > >  	long    PG_hwpoison;
> >
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

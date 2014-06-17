Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwmbC-0005y9-Rm
 for kexec@lists.infradead.org; Tue, 17 Jun 2014 06:10:30 +0000
Date: Tue, 17 Jun 2014 08:10:01 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: kexec-save-pg_head_mask-in-vmcoreinfo.patch
Message-ID: <20140617081001.3e0e1ac9@hananiah.suse.cz>
In-Reply-To: <20140612170436.51e6338d@hananiah.suse.cz>
References: <20140609153153.9766367624fcc723eaac7a15@linux-foundation.org>
 <20140610153554.GC17337@redhat.com>
 <20140611132042.1621a230@hananiah.suse.cz>
 <20140611172422.GG10723@redhat.com>
 <20140612170436.51e6338d@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

On Thu, 12 Jun 2014 17:04:36 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Wed, 11 Jun 2014 13:24:22 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Wed, Jun 11, 2014 at 01:20:42PM +0200, Petr Tesarik wrote:
> > > On Tue, 10 Jun 2014 11:35:54 -0400
> > > Vivek Goyal <vgoyal@redhat.com> wrote:
> > > 
> > > > On Mon, Jun 09, 2014 at 03:31:53PM -0700, Andrew Morton wrote:
> > > > > 
> > > > > 
> > > > > Guys, could you please review this one?
> > > > > 
> > > > > Thanks.
> > > > > 
> > > > > 
> > > > > From: Petr Tesarik <ptesarik@suse.cz>
> > > > > Subject: kexec: save PG_head_mask in VMCOREINFO
> > > > > 
> > > > > To allow filtering of huge pages, makedumpfile must be able to identify
> > > > > them in the dump.  This can be done by checking the appropriate page flag,
> > > > > so communicate its value to makedumpfile through the VMCOREINFO interface.
> > > > > 
> > > > > There's only one small catch.  Depending on how many page flags are
> > > > > available on a given architecture, this bit can be called PG_head or
> > > > > PG_compound.
> > > > > 
> > > > > I sent a similar patch back in 2012, but Eric Biederman did not like using
> > > > > an #ifdef.  So, this time I'm adding a common symbol (PG_head_mask)
> > > > > instead.
> > > > > 
> > > > > See https://lkml.org/lkml/2012/11/28/91 for the previous version.
> > > > > 
> > > > 
> > > > Hi Petr,
> > > > 
> > > > I went through previous conversation and personally I like that patch
> > > > better.
> > > > 
> > > > We already have so many exports in vmcoreinfo which are conditional
> > > > based on config options. Adding one more should be just fine. And as
> > > > you said that it should not bitrot as it will most likely lead
> > > > to complication failures if things shift around.
> > > > 
> > > > Does this patch compile with !CONFIG_PAGEFLAGS_EXTENDED. I did not see
> > > > a definition of PG_head_mask in that case.
> > > 
> > > With !CONFIG_PAGEFLAGS_EXTENDED, the definition of PG_head_mask is
> > > already there (and has been for quite some time).
> > 
> > Oh.., I had not noticed that. Thanks.
> > 
> > > 
> > > > So I would say post your patch again, I will ack it. CC Eric and hopefully
> > > > he does not have any objections to it.

Oh, it seems you're still waiting for Eric's opinion, but I didn't
notice that he wasn't in Cc yet.

> > > Er, I'm not sure which patch you mean. The original one (with
> > > conditional PG_head/PG_compound), or the new one (with PG_head_mask)?
> > 
> > Given PG_head_mask is already defined for !CONFIG_PAGEFLAGS_EXTENDED, I
> > am fine with this version too. 
> > 
> > So bottom line, I am fine with either version. Given that Andrew 
> > already seems to have this one queued, I will ack this one.
> > 
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>

Eric, based on Vivek's feedback, do you have any objections to the
following patch:

http://ozlabs.org/~akpm/mmotm/broken-out/kexec-save-pg_head_mask-in-vmcoreinfo.patch

Thanks,
Petr Tesarik

> Thank you!
> 
> As a side note, I personally like this new version better, because it
> does not propagate the differences between CONFIG_PAGEFLAGS_EXTENDED
> and !CONFIG_PAGEFLAGS_EXTENDED to VMCOREINFO (and consequently to all
> tools that want to use it).
> 
> Petr Tesarik
> 
> > > > > Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> > > > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > > > Cc: Paul Mackerras <paulus@samba.org>
> > > > > Cc: Fengguang Wu <fengguang.wu@intel.com>
> > > > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > > > Cc: Shaohua Li <shli@kernel.org>
> > > > > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > Cc: Sasha Levin <sasha.levin@oracle.com>
> > > > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > > > ---
> > > > > 
> > > > >  include/linux/page-flags.h |    3 +++
> > > > >  kernel/kexec.c             |    1 +
> > > > >  2 files changed, 4 insertions(+)
> > > > > 
> > > > > diff -puN include/linux/page-flags.h~kexec-save-pg_head_mask-in-vmcoreinfo include/linux/page-flags.h
> > > > > --- a/include/linux/page-flags.h~kexec-save-pg_head_mask-in-vmcoreinfo
> > > > > +++ a/include/linux/page-flags.h
> > > > > @@ -350,6 +350,9 @@ static inline void ClearPageCompound(str
> > > > >  	ClearPageHead(page);
> > > > >  }
> > > > >  #endif
> > > > > +
> > > > > +#define PG_head_mask ((1L << PG_head))
> > > > > +
> > > > >  #else
> > > > >  /*
> > > > >   * Reduce page flag use as much as possible by overlapping
> > > > > diff -puN kernel/kexec.c~kexec-save-pg_head_mask-in-vmcoreinfo kernel/kexec.c
> > > > > --- a/kernel/kexec.c~kexec-save-pg_head_mask-in-vmcoreinfo
> > > > > +++ a/kernel/kexec.c
> > > > > @@ -1617,6 +1617,7 @@ static int __init crash_save_vmcoreinfo_
> > > > >  #ifdef CONFIG_MEMORY_FAILURE
> > > > >  	VMCOREINFO_NUMBER(PG_hwpoison);
> > > > >  #endif
> > > > > +	VMCOREINFO_NUMBER(PG_head_mask);
> > > > >  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
> > > > >  
> > > > >  	arch_crash_save_vmcoreinfo();
> > > > > _
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

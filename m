Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKv9P-0007KI-TU
 for kexec@lists.infradead.org; Wed, 23 Sep 2020 03:09:00 +0000
Date: Wed, 23 Sep 2020 11:08:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3] MIPS: Crash kernel should be able to see old memories
Message-ID: <20200923030847.GM25604@MiWiFi-R3L-srv>
References: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
 <20200923024548.GL25604@MiWiFi-R3L-srv>
 <CAAhV-H66O77hK7kB8cCcM6XUOc-TFEg_TJG+GrCSEdD89Qxb7g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAhV-H66O77hK7kB8cCcM6XUOc-TFEg_TJG+GrCSEdD89Qxb7g@mail.gmail.com>
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
To: Huacai Chen <chenhc@lemote.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kexec@lists.infradead.org, "open list:MIPS" <linux-mips@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Biederman <ebiederm@xmission.com>, Fuxin Zhang <zhangfx@lemote.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 09/23/20 at 10:58am, Huacai Chen wrote:
> Hi, Baoquan,
> 
> On Wed, Sep 23, 2020 at 10:46 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/23/20 at 10:30am, Huacai Chen wrote:
> > > Kexec-tools use mem=X@Y to pass usable memories to crash kernel, but in
> > > commit a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map") all
> > > BIOS passed memories are removed by early_parse_mem(). I think this is
> > > reasonable for a normal kernel but not for a crash kernel, because a
> > > crash kernel should be able to see all old memories, even though it is
> > > not supposed to use them.
> >
> > I am not familiar with MIPS code, but we analyze and fill memmap= to
> > pass usable memory to crashkenrel in kexec-tools, do you mean you are
> > specifying memmap= or mem= by hand?
> Not by hand, but by code of kexec-tools via the "mem=" parameter.

OK, please ignore my comments.

> 
> As I know, kexec-tools of MIPS only use "mem=" to pass "usable"
> memory, but not "visible" memory. "Visible" memory of the crash kernel
> is still passed by BIOS (strictly, by the old kernel who duplicates
> information from BIOS). If memblock_remove() executed here, it would
> remove all "visible" memory and make "visible" memory the same as
> "usable" memory, and I think this is not correct.
> 
> >
> > And we don't have mem=X@Y, only mem=nn[KMG].
> The relocatable kernel of MIPS is still unusable now, so MIPS should
> use mem=X@Y, and the crash kernel is always different from normal
> kernel.

Interesting. Seems MIPS does support mem=X@Y, even though the document
of 'mem=' says it's used to specify amount of memory, but not memory
region. Anyway, leave this to mips reviewers, thanks for replying.

~~~~~~~~~~~~~~~~~~~
        mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
                        Amount of memory to be used in cases as follows:

> 
> >
> > >
> > > Fixes: a94e4f24ec836c8984f83959 ("MIPS: init: Drop boot_mem_map")
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > ---
> > >  arch/mips/kernel/setup.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> > > index 4c04a86..e2804a2 100644
> > > --- a/arch/mips/kernel/setup.c
> > > +++ b/arch/mips/kernel/setup.c
> > > @@ -392,8 +392,10 @@ static int __init early_parse_mem(char *p)
> > >        */
> > >       if (usermem == 0) {
> > >               usermem = 1;
> > > +#ifndef CONFIG_CRASH_DUMP
> > >               memblock_remove(memblock_start_of_DRAM(),
> > >                       memblock_end_of_DRAM() - memblock_start_of_DRAM());
> > > +#endif
> > >       }
> > >       start = 0;
> > >       size = memparse(p, &p);
> > > --
> > > 2.7.0
> > >
> >
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

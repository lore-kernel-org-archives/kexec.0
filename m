Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPnGP-0003nT-IE
 for kexec@lists.infradead.org; Wed, 10 Apr 2013 05:08:07 +0000
Date: Wed, 10 Apr 2013 13:46:55 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/4] Add support for vmap_area_list.
Message-Id: <20130410134655.a7bb6d6b5cf67ae220161f6c@mxc.nes.nec.co.jp>
In-Reply-To: <20130409115440.GA13835@verge.net.au>
References: <20130409172706.d6eda15764b0ef2700588e74@mxc.nes.nec.co.jp>
 <20130409115440.GA13835@verge.net.au>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

On Tue, 9 Apr 2013 20:54:40 +0900
Simon Horman <horms@verge.net.au> wrote:

> On Tue, Apr 09, 2013 at 05:27:06PM +0900, Atsushi Kumagai wrote:
> > Hello,
> > 
> > This patchset is to work with "remove vm_struct list management":
> > 
> >   https://lkml.org/lkml/2013/3/13/40
> > 
> > I tested this on i386/x86_64, but I can't do it on other 
> > architectures. So, please let me know if you find any problems.
> 
> Perhaps CCing linuxppc-dev@lists.ozlabs.org would be a good idea.

Thanks for your advice, I'll repost this with CCing linuxppc-dev.


Atsushi Kumagai

> 
> > ---
> > 
> > Atsushi Kumagai (4):
> >       Introduce new symbols to look at the first vmap_area.
> >       Use vmap_area_list to get vmalloc_start for i386.
> >       Use vmap_area_list to get vmalloc_start for ppc32.
> >       Use vmap_area_list to get vmalloc_start for ppc64.
> > 
> >  arch/ppc.c     | 46 ++++++++++++++++++++++++++++++++--------------
> >  arch/ppc64.c   | 46 ++++++++++++++++++++++++++++++++--------------
> >  arch/x86.c     | 46 ++++++++++++++++++++++++++++++++--------------
> >  makedumpfile.c |  9 +++++++++
> >  makedumpfile.h |  5 +++++
> >  5 files changed, 110 insertions(+), 42 deletions(-)
> > 
> > 
> > Thanks
> > Atsushi Kumagai
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

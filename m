Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWcdW-000630-GF
 for kexec@lists.infradead.org; Thu, 17 Oct 2013 01:44:27 +0000
Date: Thu, 17 Oct 2013 10:44:01 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/fs2dt: fix endianess conversion
Message-ID: <20131017014401.GM21728@verge.net.au>
References: <20131015170528.10192.71185.stgit@nimbus>
 <20131016072826.GC29696@verge.net.au>
 <525E5D77.8090109@linux.vnet.ibm.com>
 <20131017014253.GL21728@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131017014253.GL21728@verge.net.au>
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org

On Thu, Oct 17, 2013 at 10:42:53AM +0900, Simon Horman wrote:
> On Wed, Oct 16, 2013 at 11:33:43AM +0200, Laurent Dufour wrote:
> > On 16/10/2013 09:28, Simon Horman wrote:
> > > On Tue, Oct 15, 2013 at 07:05:28PM +0200, Laurent Dufour wrote:
> > >> While reviewing fs2dt.c in the common kexec directory, in order to use it to
> > >> support little endian ppc64 architecture, I found some endianess
> > >> conversion's issues.
> > >>
> > >> In dt_reserve, dt_base is a pointer and thus should not be converted.
> > >>
> > >> In checkprop, values read from the device tree are big endian encoded and
> > >> should be converted if CPU is running in little endian mode.
> > >>
> > >> In add_dyn_reconf_usable_mem_property__, fix extraneous endianess conversion
> > >> of rlen which should be natively used to increase the dt pointer.
> > > 
> > > These changes seem logical to me.
> > > 
> > > However, I'm unsure how the code might have worked as-is.
> > > In particular I'm pretty sure ARM was running in little endian
> > > mode when I worked on DT support for it. Perhaps these code
> > > paths were not executed. Or the errors cancelled themselves out somehow?
> > 
> > I've to admit that I don't know how this has worked for ARM.
> > I run this patch with a set of change I'm working on to support PPC64
> > little endian architecture. My tests were done with kexec-tools built in
> > little endian mode, using this fs2dt.c file and I need this fix to build
> > a valid device tree.
> > 
> > The fix is dt_reserve is hit unless the device tree is large enough. I
> > had to reduce INIT_TREE_WORDS to hit it.
> > 
> > I think the ones in checkprop, add_dyn_reconf_usable_mem_property__  are
> > Power specific since RTAS and 'ibm,dynamic-memory' are required to hit them.
> > 
> > This may explain why this issue are not seen in ARM mode.
> 
> Perhaps, its a bit of a mystery.
> I think that I will apply your change as it does seem to be correct.

And I have. It should appear on kernel.org shortly.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

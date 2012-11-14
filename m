Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TYh9Q-0004Oc-Id
 for kexec@lists.infradead.org; Wed, 14 Nov 2012 17:53:25 +0000
Date: Wed, 14 Nov 2012 12:53:04 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121114175304.GK20215@redhat.com>
References: <20121108133554.28410.99763.stgit@aravinda>
 <20121114145445.GC20215@redhat.com>
 <50A3CFAD.6090008@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50A3CFAD.6090008@linux.vnet.ibm.com>
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
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, LChouinard@s2sys.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, buendgen@de.ibm.com

On Wed, Nov 14, 2012 at 10:36:53PM +0530, Aravinda Prasad wrote:
> Hi Vivek,
> 
> On 2012-11-14 20:24, Vivek Goyal wrote:
> 
> > On Thu, Nov 08, 2012 at 07:07:52PM +0530, Aravinda Prasad wrote:
> >> makedumpfile security key filtering enhancement - Add Eppic language
> >> support (formerly known as SIAL) to specify rules to scrub data in a
> >> dumpfile. Eppic was previously part of crash source code repository.
> >>
> >> The following series of patches enhance the makedumpfile to provide
> >> a more powerful way to specify rules and commands to traverse and
> >> erase complex data structures in a dump file by integrating Embeddable
> >> Pre-Processor and Interpreter for C (eppic).
> > 
> > Hi Aravinda,
> > 
> > Had few questions.
> > 
> > - Which file will contain all the rules?
> 
> 
> As of now rule files will not be provided by makedumpfile. However,
> writing a rule file is very easy - it is a C program.

Can you give some details about how does it work and what's the
correlation with makedumpfile.

> 
> > 
> > - What's the memory footprint of libeppic.a? Looks like this will be
> >   linked statically with makedumpfile, and how much is the size bloat of
> >   makedumpfile.
> 
> 
> Memory footprint of libeppic.a is around 1MB. Yes, this will be
> statically linked to makedumpfile. Users should specify EPPIC=on while
> building the makedumpfile and hence linking libeppic.a is optional

How would distributions handle it. Will we continue to build makedumpfile
without EPPIC=on. Any increase in initramfs size increase is frowned upon
in general.

> 
> > 
> > - Is this supposed to work from kdump initramfs or it is supposed to be
> >   used on already saved dump (later during post processing).
> 
> 
> For the time being, it is only during post processing.

Again, how distributions will handle it. If it is being integrated
makedumpfile, as opposed to an stand alone utility, that means it
makedumpfile needs to link against this library so that somebody can
later filter out the symbols. And that means initramfs size bloat too?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

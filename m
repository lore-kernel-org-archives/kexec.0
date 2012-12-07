Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Th5xO-0007lh-4P
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 21:59:43 +0000
Date: Fri, 7 Dec 2012 16:59:31 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Message-ID: <20121207215930.GE4928@redhat.com>
References: <1350981766.43974385.1354807618743.JavaMail.root@redhat.com>
 <50C18718.40902@linux.vnet.ibm.com>
 <C14DE2E60140984C9CEB63D47F21D9D40499579E@s2exchange2.hq.s2sys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <C14DE2E60140984C9CEB63D47F21D9D40499579E@s2exchange2.hq.s2sys.com>
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
To: Luc Chouinard <LChouinard@s2sys.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, Dave Anderson <anderson@redhat.com>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, buendgen@de.ibm.com

On Fri, Dec 07, 2012 at 08:46:33AM -0500, Luc Chouinard wrote:

[..]
> > This is what I am planning.
> > 
> > A new extension_eppic.c file will be created under makedumpfile source
> > directory. This file is equivalent to applications/crash/eppic.c in
> upstream eppic
> > repository. A new target will be added to the Makefile of makedumpfile
> to build
> > the shared library and to build this shared library libeppic.a would
> be required.
> > The makedumpfile specific shared library will be named different - say
> > eppic_mkdumpfile.so to avoid conflict with crash specific libeppic.so.
> > 
> > The reason for including extension_eppic.c under makedumpfile source
> is
> > because it will be dependent on other functions in makedumpfile code
> like dwarf
> > related calls etc. People modifying those functions should be aware of
> the
> > callers in extension_eppic.c and if this is included in upstream eppic
> code, it will
> > be easily overlooked (or may not be aware of its existence).
> 
> The same reasons exists for applications/crash/eppic.c. It only ended up
> on eppic's git for two reasons. To provide for a complete example of
> integration into a tool and, because I originally wrote it,  I could
> support it from there without having to send a patch Dave's way.
>  
> I expect other applications to own their glue/integration file(s) and
> only grab libeppic from the git. These applications, will comply to
> libeppic's APIs and only fixes or new functions will be added to
> libeppic to support these applications and valid new requirements they
> may have. Like we did for mkdumpfile.
> 
> Same libeppic.so and same libeppic Makefile for all.

I am lost here. Can somebody explain this thing in layman's terms with
simple example. (We have a function foo() in libeppic which makeudmpfile
wants to call. Now what?)

Few questions come to my mind.

- What is glue logic and why do we need application specific glue
  logic to use this library.

- Assuming we need glue logic and assuming it is small enough, will
  it make sense to build statically build glue logic in application
  and build actual libeppic as shared object and do dlopen() on it.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

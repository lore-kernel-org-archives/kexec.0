Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from s2exchange2.hq.s2sys.com ([23.25.203.146])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TgyGX-0007Rj-1C
 for kexec@lists.infradead.org; Fri, 07 Dec 2012 13:46:58 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH v2 0/7] makedumpfile security key filtering with eppic
Date: Fri, 7 Dec 2012 08:46:33 -0500
Message-ID: <C14DE2E60140984C9CEB63D47F21D9D40499579E@s2exchange2.hq.s2sys.com>
In-Reply-To: <50C18718.40902@linux.vnet.ibm.com>
References: <1350981766.43974385.1354807618743.JavaMail.root@redhat.com>
 <50C18718.40902@linux.vnet.ibm.com>
From: "Luc Chouinard" <LChouinard@s2sys.com>
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
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Dave Anderson <anderson@redhat.com>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Vivek Goyal <vgoyal@redhat.com>, buendgen@de.ibm.com



> -----Original Message-----
> From: Aravinda Prasad [mailto:aravinda@linux.vnet.ibm.com]
> Sent: Friday, December 07, 2012 1:05 AM
> To: Dave Anderson
> Cc: ananth@in.ibm.com; mahesh@linux.vnet.ibm.com;
> kexec@lists.infradead.org; Luc Chouinard; tachibana@mxm.nes.nec.co.jp;
> Atsushi Kumagai; Vivek Goyal; buendgen@de.ibm.com
> Subject: Re: [PATCH v2 0/7] makedumpfile security key filtering with
eppic
> 
> 
> 
> On 2012-12-06 20:56, Dave Anderson wrote:
> 
> >
> >
> > ----- Original Message -----
> >
> >>
> >> Another approach is to dynamically load libeppic library - similar
> >> way how crash does it. No major changes will be done to
makedumpfile
> >> code, except the addition of --eppic flag. Upon specifying --eppic
> >> flag makedumpfile will dlopen libeppic.so, which will have
> >> functionality to scrub the specified data. This will prevent
> >> makedumpfile bloat and will not affect the size of initramfs as
> >> --eppic is only specified during post processing. The distribution
> >> should build and ship libeppic.so and the procedure for building
.so
> >> will be similar to what we have in crash.
> >
> > OK, so based upon the most recent discussion here:
> >
> >  Re: [PATCH v2 0/7] makedumpfile security key filtering with eppic
> > http://lists.infradead.org/pipermail/kexec/2012-December/007452.html
> >
> > Aravinda states that he will be posting an update for makedumpfile
> > that will dlopen() a new "libeppic.so" shared object that is built
> > with the libeppic.a library.
> >
> > The upstream eppic git tree contains an "applications/crash"
> > subdirectory that contains the code that creates a
crash-utility-specific
> "eppic.so" file.
> >
> > Accordingly, this new proposal will also require new source file(s)
> > and a build process to create this new makedumpfile-specific
"libeppic.so"
> > shared object.
> >
> > Arvinda -- will you be proposing an additional
"applications/makedumpfile"
> > subdirectory for the upstream eppic git tree that can be used to
> > create the makedumpfile-specific libeppic.so file?
> 
> 
> This is what I am planning.
> 
> A new extension_eppic.c file will be created under makedumpfile source
> directory. This file is equivalent to applications/crash/eppic.c in
upstream eppic
> repository. A new target will be added to the Makefile of makedumpfile
to build
> the shared library and to build this shared library libeppic.a would
be required.
> The makedumpfile specific shared library will be named different - say
> eppic_mkdumpfile.so to avoid conflict with crash specific libeppic.so.
> 
> The reason for including extension_eppic.c under makedumpfile source
is
> because it will be dependent on other functions in makedumpfile code
like dwarf
> related calls etc. People modifying those functions should be aware of
the
> callers in extension_eppic.c and if this is included in upstream eppic
code, it will
> be easily overlooked (or may not be aware of its existence).

The same reasons exists for applications/crash/eppic.c. It only ended up
on eppic's git for two reasons. To provide for a complete example of
integration into a tool and, because I originally wrote it,  I could
support it from there without having to send a patch Dave's way.
 
I expect other applications to own their glue/integration file(s) and
only grab libeppic from the git. These applications, will comply to
libeppic's APIs and only fixes or new functions will be added to
libeppic to support these applications and valid new requirements they
may have. Like we did for mkdumpfile.

Same libeppic.so and same libeppic Makefile for all.

> 
> A flag --eppic will be added to makedumpfile which will dlopen the
shared
> library. Few additional helper functions will be added to dwarf_info.c
and
> erase_info.c - the same functions which are in v2 of the patchset.
> 
> 
> >
> > Dave
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> 
> 
> --
> Regards,
> Aravinda


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

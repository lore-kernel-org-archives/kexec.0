Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk4Pn-00035I-1v
 for kexec@lists.infradead.org; Thu, 17 Jan 2019 09:56:50 +0000
Date: Thu, 17 Jan 2019 10:56:40 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC v1] kexec: Prototype for signature verification within Xen
Message-ID: <20190117095640.z7vvon2db3bdqtlh@verge.net.au>
References: <1547495527-30191-1-git-send-email-eric.devolder@oracle.com>
 <20190115141528.jxjvnihe6p5rmvvs@verge.net.au>
 <20190115154119.4b3uyns4mitic6u6@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190115154119.4b3uyns4mitic6u6@tomti.i.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: boris.ostrovsky@oracle.com, Eric DeVolder <eric.devolder@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Tue, Jan 15, 2019 at 04:41:19PM +0100, Daniel Kiper wrote:
> On Tue, Jan 15, 2019 at 03:15:28PM +0100, Simon Horman wrote:
> > On Mon, Jan 14, 2019 at 01:52:07PM -0600, Eric DeVolder wrote:
> > > These changes work in conjunction with the signature
> > > verification support for Xen I published recently.
> > >
> > > Prior to this change, kexec supported the following
> > > three modes of operation:
> > >
> > > kexec_load:
> > > - unverified loading of kernel into Linux (original mode)
> > > - unverified loading of kernel into Xen
> > > kexec_file_load (the -s option to kexec):
> > > - verified loading of kernel into Linux
> > >
> > > With the verified loading of a kernel into Linux, the scope
> > > of kexec changed drastically as the kernel performs most of
> > > the work that kexec previously did; the kernel does so so as
> > > to reduce the risk of compromise.
> > >
> > > For example, the unverified loading of a kernel into Linux
> > > involves locating memory within the system to load the
> > > various pieces of data (kernel, initramdisk, command line)
> > > as well as reserving additional memory such as the first 1MB
> > > on x86 for legacy reasons as well as something known as
> > > 'purgatory', a trampoline that checks the integrity of the
> > > contents of loaded pieces of data, before invoking that
> > > loaded kernel. The management of purgatory involves
> > > manipulating an embedded ELF purgatory object file to insert
> > > a memory hash value, and rewrite a few run-time switches
> > > based on kexec command line parameters.
> > >
> > > By contrast, the verified loading essentially just passes
> > > file handles for the kernel, initramdisk, and command line
> > > pointer, and the kernel takes care of the rest, by
> > > performing all the work that the unverified kexec load would
> > > do, but inside the kernel using trusted kernel code.
> > >
> > > This changeset adds a fourth mode to kexec:
> > >
> > > - verified loading of kernel into Xen
> > >
> > > In general, Xen performs the signature verification on the
> > > loaded kernel, much as Linux does, but that is where the
> > > similarities end.  In the current Xen implementation, no
> > > infrastructure is present to support reading from [Linux
> > > dom0] file handles, or for manipulating ELF objects. As
> > > such, without Xen support for these actions, Xen relies upon
> > > kexec to provide these services, which is what this mode
> > > does.
> > >
> > > To achieve this, this mode of operation essentially vectors
> > > the verified load for Xen through the non-verified path,
> > > which performs all the needed actions for kexec to work, but
> > > then makes an adjustment to pass the entire kernel file, not
> > > just the loadable portion of the kernel file, to Xen in
> > > order to provide the proper image for signature
> > > verification.
> > >
> > > The loading of kexec images for signature verification for
> > > Xen is indicated with the -s switch, just like for Linux.
> > >
> > > Changes to configure.ac are for detecting whether or not the
> > > Xen version supports this kexec_file_load hypercall op.
> > >
> > > Changes to kexec-bzImage64.c are for recording what the
> > > change to the kernel image entry needs to be (the entire
> > > kernel file, not just the loadable portion), as well as
> > > vectoring kexec_file_load through kexec_load for Xen.
> > >
> > > Changes to kexec-xen.c are to invoke the new Xen
> > > kexec_file_load hypercall op, from kexec_load.
> > >
> > > Changes to kexec.c are to vector kexec_file_load for Xen
> > > throgh kexec_load for Xen, as well as make the correction
> > > for passing the complete kernel file to Xen.
> > >
> > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> >
> > Thanks Eric,
> >
> > this looks good to me, aside from one nit below.
> 
> Please do not apply this patch. This is an RFC.
> 
> Eric, thank you for doing this work.

Thanks Daniel, noted.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6wSZ-0002F4-FR
	for kexec@lists.infradead.org; Thu, 12 Jun 2008 23:44:04 +0000
Date: Fri, 13 Jun 2008 08:41:55 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: [Xen-devel] [PATCH 0/2] extract vmcoreinfo from /proc/vmcore for
	Xen
In-Reply-To: <C476F301.21F9F%keir.fraser@eu.citrix.com>
References: <20080612165246.16CC.ODA@valinux.co.jp>
	<C476F301.21F9F%keir.fraser@eu.citrix.com>
Message-Id: <20080613075723.16DF.ODA@valinux.co.jp>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Keir Fraser <keir.fraser@eu.citrix.com>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org

Hi,

The aim of "vmcoreinfo in vmcore" is to run makedumpfile
without xen-syms.

The basic form of the xen extraction:
# makedumpfile -X --xen-syms xen-syms /proc/vmcore output-file
It selects pages owned by the hypervisor and the domain 0 and
makes a size reduced vmcore image.
The page selection is done as follows:
- scan alloc_bitmap and frametable
  - select if alloc_bitmap on &&
    - xen heap
    or
    - owned by dom0/dom-xen/dom-io
The necessary infomation such as the symbol address of alloc_bitmap,
the size of page_info, the offset of _domain in page_info, and so on
are extracted in the xen-syms.

The vmcoreinfo is a note section in a vmcore which is packed the
infomation neccessary for page selection. If a vmcoreinfo exists
in a vmcore, xen-syms is not necessary to run makedumpfile:
# makedumpfile -X /proc/vmcore output-file
does the same thing as mentioned above.

Thanks.
Itsuro Oda

On Thu, 12 Jun 2008 15:36:33 +0100
Keir Fraser <keir.fraser@eu.citrix.com> wrote:

> I'm a bit confused as to what this is for. If you know where Xen is located
> in physical or virtual address space, and you have access to Xen symbols,
> why would you need the few symbol addresses provided by vmcoreinfo? I can
> hardly see what symbols dom_xen and dom_io would be particularly useful for.
> Similarly, why would you record structure sizes when this is statically
> determinable given the Xen sources?
> 
>  -- Keir
> 
> On 12/6/08 09:22, "Itsuro ODA" <oda@valinux.co.jp> wrote:
> 
> > Hi,
> > 
> > The following patchset is to support extracting vmcoreinfo from
> > /proc/vmcore for Xen.
> > 
> > This is the up-port of the patchset I made for 3.2.0 and posted
> > the end of March.
> > 
> > [PATCH 1/2] patch for xen hypervisor (xen-unstable.hg)
> > [PATCH 2/2] patch for linux (linux-2.6.18-xen.hg)
> > 
> > --- background ----------------------------------------------------
> > * what the makedumpfile is:
> >   To shorten the size of the dumpfile and the time of creating the
> >   dumpfile, makedumpfile copies only the necessary pages for analysis
> >   to the dumpfile from /proc/vmcore. You can specify the kind of
> >   unnecessary pages with dump_level. If you want to shorten the size
> >   further, enable the compression of the page data.
> > * Xen extraction 
> >   makedumpfile also has a feature that extracting the part of
> >   xen hypervisor and domain-0 from /proc/vmcore taken under xen
> >   environment. In most cases under xen environment, it is enough to
> >   analyze a cause of system crash.
> > * extract vmcoreinfo from /proc/vmcore
> >   makedumpfile 1.2.0 supports to extract the vmcoreinfo data from
> >   /proc/vmcore and uses it for dump filtering. (for a vmcore taken
> >   under the native environment.)
> > ------------------------------------------------------------------
> > 
> > Thanks.
> 
> 

-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

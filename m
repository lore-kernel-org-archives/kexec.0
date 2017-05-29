Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dFJ0c-0001Y6-4M
 for kexec@lists.infradead.org; Mon, 29 May 2017 11:38:52 +0000
Date: Mon, 29 May 2017 13:38:19 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Crash-utility] [PATCH] xen: Add support for domU with Linux
 kernel 3.19 and newer
Message-ID: <20170529113819.GL30364@olila.local.net-space.pl>
References: <1495609985-5328-1-git-send-email-honglei.wang@oracle.com>
 <2121155069.18928570.1495641388085.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2121155069.18928570.1495641388085.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: jgross@suse.com, Honglei Wang <honglei.wang@oracle.com>, konrad wilk <konrad.wilk@oracle.com>, ptesarik@suse.cz, kexec@lists.infradead.org, xen-devel@lists.xenproject.org, eric devolder <eric.devolder@oracle.com>, crash-utility@redhat.com

On Wed, May 24, 2017 at 11:56:28AM -0400, Dave Anderson wrote:
> ----- Original Message -----
> > crash patch c3413456599161cabc4e910a0ae91dfe5eec3c21 (xen: Add support for
> > dom0 with Linux kernel 3.19 and newer) from Daniel made crash utility
> > support xen dom0 vmcores after linux kernel commit
> > 054954eb051f35e74b75a566a96fe756015352c8 (xen: switch to linear virtual
> > mapped sparse p2m list).
> >
> > This patch can be deemed as a subsequent and make this utility support Xen
> > PV domU dumpfiles again.
> >
> > Basically speaking, readmem() can't be used to read xen_p2m_addr associate
> > memory directly during m2p translation. It introduces infinite recursion.
> > Following call sequence shows the scenario, it comes from a section of
> > backtrace with only kvaddr, machine addr and mfn left as parameter:
> >
> > module_init()
> >
> > /* The first readmem() from module_init(). */
> > readmem(addr=0xffffffffa02fe4a0)
> >
> > /* readmem() needs physical address, so calls kvtop(). */
> > kvtop(kvaddr=0xffffffffa02fe4a0)
> > x86_64_kvtop(kvaddr=ffffffffa02fe4a0)
> >
> > /* Calculate physical address by traversing page tables. */
> > x86_64_kvtop_xen_wpt(kvaddr=0xffffffffa02fe4a0)
> >
> > /*
> >  * x86_64_kvtop_xen_wpt() is going to traverse the page table to
> >  * get the physical address for 0xffffffffa02fe4a0. So, at first it
> >  * is needed to translate the pgd from machine address to physical
> >  * address. So invoke xen_m2p() here to do the translation. 0x58687f000
> >  * is the pgd machine address in x86_64_kvtop_xen_wpt() and is needed
> >  * to be translated to its physical address.
> >  */
> > xen_m2p(machine=0x58687f000)
> > __xen_m2p(machine=0x58687f000, mfn=0x58687f)
> >
> > /*
> >  * __xen_m2p() is going to search mfn 0x58687f in p2m VMA which starts
> >  * at VMA 0xffffc900001cf000. It compares every mfn stored in it with
> >  * 0x58687f. Once it's proved 0x58687f is one mfn in the p2m, its offset
> >  * will be used to calculate the pfn.
> >  *
> >  * readmem() is invoked by __xen_m2p() to read the page from VMA
> >  * 0xffffc900001cf000 here.
> >  */
> > readmem(addr=0xffffc900001cf000)
> >
> > /*
> >  * readmem() needs physical address of 0xffffc900001cf000 to make the
> >  * reading done. So it invokes kvtop() to get the physical address.
> >  */
> > kvtop(kvaddr=0xffffc900001cf000)
> > x86_64_kvtop(kvaddr=0xffffc900001cf000)
> >
> > /* It needs to calculate physical address by traversing page tables. */
> > x86_64_kvtop_xen_wpt(kvaddr=0xffffc900001cf000)
> >
> > /*
> >  * 0x581b7e000 is the machine address of pgd need to be translated here.
> >  * The mfn is calculated in this way at x86_64_kvtop_xen_wpt():
> >  *
> >  * pml4 = ((ulong *)machdep->machspec->pml4) + pml4_index(kvaddr);
> >  * pgd_paddr = (*pml4) & PHYSICAL_PAGE_MASK;
> >  *
> >  * The kvaddr 0xffffc900001cf000 here is quite different from the one
> >  * above, so the machine address of pgd is not the same one. And this
> >  * pgd is the one we use to access the VMA of p2m table.
> >  */
> > xen_m2p(machine=0x581b7e000)
> > __xen_m2p(machine=0x581b7e000, mfn=0x581b7e)
> >
> > /*
> >  * Looking for mfn 0x581b7e in the range of p2m page which starts at
> >  * VMA 0xffffc900001f5000.
> >  */
> > readmem(addr=0xffffc900001f5000)
> >
> > /* Need physical address of VMA 0xffffc900001f5000 as same reason above. */
> > kvtop(kvaddr=0xffffc900001f5000)
> > x86_64_kvtop(kvaddr=0xffffc900001f5000)
> >
> > /* Need to traverse page tables to calculate physical address for it. */
> > x86_64_kvtop_xen_wpt(kvaddr=0xffffc900001f5000)
> >
> > /*
> >  * Unfortunately, machine address 0x581b7e000 have to be translated again.
> >  * Endless loop starts from here.
> >  */
> > xen_m2p(machine=0x581b7e000)
> > __xen_m2p(machine=0x581b7e000, mfn=0x581b7e)
> > readmem(addr=0xffffc900001f5000)
> >
> > Fortunately, PV domU p2m mapping is also stored at xd->xfd + xch_index_offset
> > and organized as struct xen_dumpcore_p2m. We have a chance to read the p2m
> > stuff directly from there, and then we avoid the loop above.
> >
> > So, this patch implements a special reading function read_xc_p2m() to extract
> > the mfns from xd->xfd + xch_index_offset. This function does not need to read
> > mfns from p2m VMA like readmem() does, so, we avoid the endless loop introduced
> > by the address translation.
> >
> > Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
> > Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
>
> Queued for crash-7.2.0:
>
>   https://github.com/crash-utility/crash/commit/5c52842a58a2602dba81de71831af98b2b53c6e0

Wow, Dave, you are fast! Thanks a lot!

Honglei, congrats! Thanks for doing the work!

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

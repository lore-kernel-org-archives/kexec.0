Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JyJj5-0005BL-1e
	for kexec@lists.infradead.org; Tue, 20 May 2008 04:45:27 +0000
Date: Tue, 20 May 2008 14:45:18 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: handle x86_64 xen code/data relocation
Message-ID: <20080520044517.GA308@verge.net.au>
References: <20080422154506.BDB1.ODA@valinux.co.jp>
	<20080520035837.GA29290@verge.net.au>
	<20080520131910.308D.ODA@valinux.co.jp>
MIME-Version: 1.0
In-Reply-To: <20080520131910.308D.ODA@valinux.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1386346993=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Itsuro ODA <oda@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, crash-utility@redhat.com

--===============1386346993==
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline

On Tue, May 20, 2008 at 01:39:26PM +0900, Itsuro ODA wrote:
> Hi all,
> 
> On Tue, 20 May 2008 13:58:39 +1000
> Simon Horman <horms@verge.net.au> wrote:
> 
> > On Tue, Apr 22, 2008 at 05:32:03PM +0900, Itsuro ODA wrote:
> > > Hi all,
> > > 
> > > Recent version of xen (ex. RHEL5.2, 3.2.0) on the x86_64
> > > moves the physical(machine) address of xen code/data area after 
> > > the system started up. The start address of this is stored in
> > > 'xen_phys_start'. Thus to get a machine address of a xen text symbol
> > > from its virtual address, calculate 
> > > "va - __XEN_VIRT_START +  xen_phys_start".
> > > 
> > > crash and makedumpfile command need the value of xen_phys_start.
> > > They know the virtual address of 'xen_phys_start' symbol but
> > > no way to extract the value of xen_phys_start.
> > > 
> > > I think adding the xen_phys_start value to the CRASHINFO ElfNote
> > > section at first. (Plan A: patch for xen hypervisor code attaced)
> > > It is smallest modification necessary over all.
> > > 
> > > On the other hand there is a opinion that it is better to upgrade
> > > a user-package than a hypervisor or kernel package.
> > > The xen_phys_start value can be got from /proc/iomem.
> > >     -------------------------------------------------------
> > >     # cat /proc/iomem
> > >     ...
> > >       7e600000-7f5fffff : Hypervisor code and data  *** this line
> > >     ...
> > >     -------------------------------------------------------
> > > So the kexec-tools can handle it theoretically.
> > > 
> > > The Plan B is that kexec-tools adds another ElfNote section which
> > > holds the xen_phys_start value. The attached patch works well
> > > though I am concern about it is a bit tricky.
> > > 
> > > Which plan is better ?  Or more good implementation ?
> > > Please comment.
> > > 
> > > (note that crash and makedumpfile modification is same degree
> > > for both plan.)
> > 
> > Hi Oda-san,
> > 
> > I think that in terms of simplicity plan A is a clear
> > winner. That is assuming tha the changes to crash
> > and makedumpfile are more or less the same for both
> > plan A and plan B.
> 
> The changes to crash and makedumpfile is almost same
> for both plan A and plan B.
> 
> Yes, Plan A is simple.
> The point under discussion is that the already released 
> versions of xen need to apply the fix, and from the view point
> of the users for such versions they may prefer to update 
> the kexec-tools rather than the hypervisor.
> 
> > However, if there is a reason that it makes sense to include
> > the change in kexec-tools and make a fresh release, I'm happy to do so.
> 
> Thanks.
> 
> I am concerned about the changes of the Plan B is little tricky. 
> So I will think that the changes become simpler or more reasonable.

Yes, i am concerned about that too.

-- 
宝曼 西門 (ホウマン・サイモン) | Simon Horman (Horms)


--===============1386346993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1386346993==--

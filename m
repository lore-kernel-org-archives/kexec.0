Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYWtD-0004uB-8L
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 09:05:03 +0000
Date: Mon, 29 Sep 2014 17:04:32 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: Add "--mem-usage" support for s390x
Message-ID: <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140926133441.5e58303c@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On 09/26/14 at 01:34pm, Michael Holzheu wrote:
> On Fri, 26 Sep 2014 16:55:46 +0800
 
> > > Isn't this a chicken-and-egg problem? In order to determine vmalloc start
> > > I have to be able to read memory. But in order to read memory I have
> > > to call get_kcore_dump_loads() first.
> > > 
> > > What about using /proc/iomem to find out if an address is a real address?
> > 
> > Well, that's good it works for s390. Anyway in get_kcore_dump_loads() it
> > just gets the physical ram region, and filter out the unwanted region,
> > so your method is good. In x86_64, the is_vmalloc_addr_x86_64 is not
> > only filtering the vmalloc, but vmmemmap and modules_vaadr region. For
> > simplicity it's only named as is_vmalloc_addr.
> 
> Not sure if I understood, why ths is_real_addr() function does not
> work for x86_64.
> 
> Also for x86 all three areas, vmalloc, vmemmap, and modules_vaddr, are
> virtual memory regions with addresses outside of the the memory ranges
> where /proc/iommem reports physical memory, right?
> 
> So the new is_real_addr() function should return false for that areas.

is_real_addr() should work for x86_64, this almost does the way
kexec-tools is doing. Originally I just consider this for x86_64,
skipped other ARCHs. From x86_64 point of view, processing kcore only
need to pick up the program segments we want. If it's hard to handle it,
I am fine with it that you use the is_real_addr to do it. But please
don't use this name, it could be is_phy_addr() or somthing like that.
Please post your patch and test x86_64 too and we can review it.

In fact the other way is wrapping your is_real_addr() to
is_vmalloc_addr_s390(), and make it work for s390. If later other ARCH
also has this requirements, raise it to be common function. Anyway it's
fine to me if it can work.

Thanks
Baoquan


> 
> Michael
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

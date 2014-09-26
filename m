Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XXTnq-0002kk-0U
 for kexec@lists.infradead.org; Fri, 26 Sep 2014 11:35:10 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 26 Sep 2014 12:34:46 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA55017D8059
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 12:36:51 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8QBYhYP45875438
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 11:34:43 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8QBYhZr012197
 for <kexec@lists.infradead.org>; Fri, 26 Sep 2014 07:34:43 -0400
Date: Fri, 26 Sep 2014 13:34:41 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: Add "--mem-usage" support for s390x
Message-ID: <20140926133441.5e58303c@holzheu>
In-Reply-To: <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On Fri, 26 Sep 2014 16:55:46 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 09/26/14 at 10:10am, Michael Holzheu wrote:
> > On Thu, 25 Sep 2014 17:44:12 +0800
> > Baoquan He <bhe@redhat.com> wrote:
> > 
> > > On 09/24/14 at 05:19pm, Michael Holzheu wrote:
> > > > On Tue, 23 Sep 2014 10:40:58 +0800
> > > > Baoquan He <bhe@redhat.com> wrote:
> > 
> > [snip]
> > 
> 
> > > > For s390x this is not so easy because vmalloc_start is dependent
> > > > on the memory size of the system (see setup_memory_end()
> > > > in arch/s390/kernel/setup.c). Unfortunately "info->max_mapnr"
> > > > is not set at that time.
> > > 
> > > I am not aware of s390 arch and memory layout. But I can explain what
> > > those versiondep_info are used for, hope they can help. In fact in
> > > x86_64, page_offset is got for set_kcore_vmcoreinfo(), there the
> > > vmcoreinfo_addr need be converted to kvaddr. Since vmcoreinfo_addr is a
> > > physical addr, we can't use it directly. And
> > > VMALLOC_START/VMEMMAP_START/MODULES_VADDR are all used to filter this
> > > virtual addr space region since our vmcore only care about the physical
> > > ram addr region.
> > > 
> > > If you need get these before they are used for s390 arch. If necessary
> > > you can build a different code flow if you can achive the goal. All
> > > these are all used to get dumpable load segments from kcore.
> > 
> > Isn't this a chicken-and-egg problem? In order to determine vmalloc start
> > I have to be able to read memory. But in order to read memory I have
> > to call get_kcore_dump_loads() first.
> > 
> > What about using /proc/iomem to find out if an address is a real address?
> 
> Well, that's good it works for s390. Anyway in get_kcore_dump_loads() it
> just gets the physical ram region, and filter out the unwanted region,
> so your method is good. In x86_64, the is_vmalloc_addr_x86_64 is not
> only filtering the vmalloc, but vmmemmap and modules_vaadr region. For
> simplicity it's only named as is_vmalloc_addr.

Not sure if I understood, why ths is_real_addr() function does not
work for x86_64.

Also for x86 all three areas, vmalloc, vmemmap, and modules_vaddr, are
virtual memory regions with addresses outside of the the memory ranges
where /proc/iommem reports physical memory, right?

So the new is_real_addr() function should return false for that areas.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XYakp-0003WI-U6
 for kexec@lists.infradead.org; Mon, 29 Sep 2014 13:12:40 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 29 Sep 2014 14:12:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 80A7B1B0805F
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 14:13:26 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8TDCEYD51773574
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 13:12:14 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8TDCEG8027389
 for <kexec@lists.infradead.org>; Mon, 29 Sep 2014 07:12:14 -0600
Date: Mon, 29 Sep 2014 15:12:12 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: Add "--mem-usage" support for s390x
Message-ID: <20140929151212.4e81820f@holzheu>
In-Reply-To: <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
 <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
 <20140926101057.14549a12@holzheu>
 <20140926085546.GA30346@dhcp-16-116.nay.redhat.com>
 <20140926133441.5e58303c@holzheu>
 <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On Mon, 29 Sep 2014 17:04:32 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 09/26/14 at 01:34pm, Michael Holzheu wrote:
> > On Fri, 26 Sep 2014 16:55:46 +0800
> 
> > > > Isn't this a chicken-and-egg problem? In order to determine vmalloc start
> > > > I have to be able to read memory. But in order to read memory I have
> > > > to call get_kcore_dump_loads() first.
> > > > 
> > > > What about using /proc/iomem to find out if an address is a real address?
> > > 
> > > Well, that's good it works for s390. Anyway in get_kcore_dump_loads() it
> > > just gets the physical ram region, and filter out the unwanted region,
> > > so your method is good. In x86_64, the is_vmalloc_addr_x86_64 is not
> > > only filtering the vmalloc, but vmmemmap and modules_vaadr region. For
> > > simplicity it's only named as is_vmalloc_addr.
> > 
> > Not sure if I understood, why ths is_real_addr() function does not
> > work for x86_64.
> > 
> > Also for x86 all three areas, vmalloc, vmemmap, and modules_vaddr, are
> > virtual memory regions with addresses outside of the the memory ranges
> > where /proc/iommem reports physical memory, right?
> > 
> > So the new is_real_addr() function should return false for that areas.
> 
> is_real_addr() should work for x86_64, this almost does the way
> kexec-tools is doing. Originally I just consider this for x86_64,
> skipped other ARCHs. From x86_64 point of view, processing kcore only
> need to pick up the program segments we want. If it's hard to handle it,
> I am fine with it that you use the is_real_addr to do it. But please
> don't use this name, it could be is_phy_addr() or somthing like that.
> Please post your patch and test x86_64 too and we can review it.
> 
> In fact the other way is wrapping your is_real_addr() to
> is_vmalloc_addr_s390(), and make it work for s390. If later other ARCH
> also has this requirements, raise it to be common function. Anyway it's
> fine to me if it can work.

Hi Baoquan,

Because I don't have the possibility to test on x86_64 I decided to
make a s390x only patch. I will send it with the next note.

Thanks for your help!
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

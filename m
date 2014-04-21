Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcFwC-0001pK-Tx
 for kexec@lists.infradead.org; Mon, 21 Apr 2014 15:15:17 +0000
Date: Mon, 21 Apr 2014 23:16:21 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 9/9] x86: Pass memory range via E820 for kdump
Message-ID: <20140421151621.GA2489@darkstar.redhat.com>
References: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
 <1397487341-17287-10-git-send-email-chaowang@redhat.com>
 <20140417052913.GB4889@dhcp-16-126.nay.redhat.com>
 <20140417054854.GA1940@dhcp-17-89.nay.redhat.com>
 <20140417055817.GE4889@dhcp-16-126.nay.redhat.com>
 <20140421000103.GC32087@verge.net.au>
 <20140421024935.GA4564@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140421024935.GA4564@dhcp-17-89.nay.redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, linn@hp.com, hpa@zytor.com, trenn@suse.de, vgoyal@redhat.com, ebiederm@xmission.com

[snip]

> > > > I prefer to first get this patch in if there's no problem in it and then
> > > > look back and think about how we can clean up the code block which have
> > > > been there for historical reason.
> > > 
> > > I think the cleanup is worth, but if you want to do it later I'm fine.
> > > So should better leave the patch 5/9 to later cleanup as well.
> > > 
> > > Thus except for 5/9, for other patches:
> > > Acked-by: Dave Young <dyoung@redhat.com>
> 
> Hi, Simon
> 
> Later, after a discussion with Dave Young, he is ok with 5/9. Here's his
> ACK for the whole patch series:
> 
> http://lists.infradead.org/pipermail/kexec/2014-April/011615.html
> 
> I'll explain why 5/9 is necessary below.

Yes, it's fine to me for the whole series after more discussion as Chao
mentioned below. In the future if kexec and kdump cases can use just one
array then this macro can be removed that time. 


> Patch 5/9 increased memmap_p from a small array to a large one. That
> patch is necessary.
> 
> Originally memmap_p was used to store the RANGE_RAM only for 2nd kernel
> and that was fine for memmap_p to be small, since we only have several
> memory range of RANGE_RAM to be passed to 2nd kernel.
> 
> However now memmap_p will be used to store all types of memory ranges to
> pass to 2nd kernel, which means not only RANGE_RAM but also RANGE_ACPI
> and RANGE_ACPI_NVS (probably RANGE_RESERVED in the future). That small
> memmap_p is not likely to be enough to contain all the memory ranges. So
> that's why we should increase CRASH_MAX_MEMMAP_NR to about 1024 to adapt
> the change of memmap_p will contains all type of memory ranges.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

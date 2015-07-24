Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZIdxr-0002GJ-Pl
 for kexec@lists.infradead.org; Fri, 24 Jul 2015 14:28:44 +0000
Message-ID: <1437748031.3214.374.camel@hp.com>
Subject: Re: kexec, x86: Need a new e820 type support for kexec
From: Toshi Kani <toshi.kani@hp.com>
Date: Fri, 24 Jul 2015 08:27:11 -0600
In-Reply-To: <20150724055053.GB19975@dhcp-128-28.nay.redhat.com>
References: <1437697592.3214.373.camel@hp.com>
 <20150724053145.GA19975@dhcp-128-28.nay.redhat.com>
 <20150724055053.GB19975@dhcp-128-28.nay.redhat.com>
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
Cc: linux-nvdimm@ml01.01.org, kexec@lists.infradead.org

On Fri, 2015-07-24 at 13:50 +0800, Baoquan He wrote:
> On 07/24/15 at 01:31pm, Baoquan He wrote:
> > On 07/23/15 at 06:26pm, Toshi Kani wrote:
> > > Hello,
> > > 
> > > ACPI 6.0 defines a new type in e820, AddressRangePersistentMemory 
> > > (7), for
> > > NVDIMM.  On a system with NVDIMM, kexec displays the following error
> > > message and sets it to RANGE_RESERVED as the fallback type.
> > > 
> > > Unknown type (Persistent Memory) while parsing
> > > /sys/firmware/memmap/34/type. Please report this as bug. Using
> > > RANGE_RESERVED now.
> > > 
> > > This new type is defined in "arch/x86/include/uapi/asm/e820.h" in 4.2
> > > -rc1
> > > as follows. 
> > > 
> > >   #define E820_PMEM       7
> 
> Let me check this and try to make a patch, it may need your help to test
> it.

Great!  Yes, I'd be glad to help testing your changes.

Thanks,
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

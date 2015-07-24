Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZIVac-0000Po-2D
 for kexec@lists.infradead.org; Fri, 24 Jul 2015 05:32:10 +0000
Date: Fri, 24 Jul 2015 13:31:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec, x86: Need a new e820 type support for kexec
Message-ID: <20150724053145.GA19975@dhcp-128-28.nay.redhat.com>
References: <1437697592.3214.373.camel@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1437697592.3214.373.camel@hp.com>
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
To: Toshi Kani <toshi.kani@hp.com>
Cc: linux-nvdimm@ml01.01.org, kexec@lists.infradead.org

On 07/23/15 at 06:26pm, Toshi Kani wrote:
> Hello,
> 
> ACPI 6.0 defines a new type in e820, AddressRangePersistentMemory (7), for
> NVDIMM.  On a system with NVDIMM, kexec displays the following error
> message and sets it to RANGE_RESERVED as the fallback type.
> 
> Unknown type (Persistent Memory) while parsing
> /sys/firmware/memmap/34/type. Please report this as bug. Using
> RANGE_RESERVED now.
> 
> This new type is defined in "arch/x86/include/uapi/asm/e820.h" in 4.2-rc1
> as follows. 
> 
>   #define E820_PMEM       7

It need be added in struct e820entry:include/x86/x86-linux.h and
memory_range:kexec/kexec.h and their related handling. Could you give
more details about this memory type? I downloaded a ACPI 6.0 spec but
am not familiar with this.

> 
> kexec needs to know this new type, but I think its build env includes
> "/usr/include/asm/e820.h", which is provided by a distribution.  On Fedora
> 22, kernel-headers-4.0.6-300.fc22.x86_64 is the latest kernel header
> package and it will take a while for 4.2 headers.
> 
> How do we handle such kernel header dependency in the kexec build env?
> 
> Thanks,
> -Toshi
> 
> 
> 
> 
> 
> 
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

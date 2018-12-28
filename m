Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcj0F-0006Ch-Lv
 for kexec@lists.infradead.org; Fri, 28 Dec 2018 03:40:05 +0000
Date: Fri, 28 Dec 2018 11:39:40 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCHv3 0/2] mm/memblock: reuse memblock bottom-up allocation
 style
Message-ID: <20181228033940.GB1990@MiWiFi-R3L-srv>
References: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
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
To: Pingfan Liu <kernelfans@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Mathieu Malaterre <malat@debian.org>, kexec@lists.infradead.org, Daniel Vacek <neelx@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Tatashin <pasha.tatashin@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, Tang Chen <tangchen@cn.fujitsu.com>, linux-acpi@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org, Stefan Agner <stefan@agner.ch>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, vgoyal@redhat.com, Len Brown <lenb@kernel.org>

On 12/28/18 at 11:00am, Pingfan Liu wrote:
> The bottom-up allocation style is introduced to cope with movable_node,
> where the limit inferior of allocation starts from kernel's end, due to
> lack of knowledge of memory hotplug info at this early time.
> Beside this original aim, 'kexec -c' prefers to reuse this style to alloc mem

Wondering what is 'kexec -c'.

> at lower address, since if the reserved region is beyond 4G, then it requires
> extra mem (default is 16M) for swiotlb. But at this time hotplug info has been

The default is 256M, not sure if we are talking about the same thing.

low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);

> got, the limit inferior can be extend to 0, which is done by this series
> 
> Cc: Tang Chen <tangchen@cn.fujitsu.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Daniel Vacek <neelx@redhat.com>
> Cc: Mathieu Malaterre <malat@debian.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: yinghai@kernel.org,
> Cc: vgoyal@redhat.com
> Cc: linux-kernel@vger.kernel.org
> 
> Pingfan Liu (2):
>   mm/memblock: extend the limit inferior of bottom-up after parsing
>     hotplug attr
>   x86/kdump: bugfix, make the behavior of crashkernel=X consistent with
>     kaslr
> 
>  arch/x86/kernel/setup.c  |  9 +++++---
>  drivers/acpi/numa.c      |  4 ++++
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 58 +++++++++++++++++++++++++++++-------------------
>  4 files changed, 46 insertions(+), 26 deletions(-)
> 
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

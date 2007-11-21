Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Iufeh-0002yY-FM
	for kexec@lists.infradead.org; Tue, 20 Nov 2007 21:49:42 -0500
Message-Id: <47439CDB.4080004@mxs.nes.nec.co.jp>
Date: Wed, 21 Nov 2007 11:50:03 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] Fix the configuration dependencies
References: <473CFE14.3010400@mxs.nes.nec.co.jp>	<473D0170.1060304@mxs.nes.nec.co.jp>
	<20071116162511.GB2658@verge.net.au>
In-Reply-To: <20071116162511.GB2658@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0170600201=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>

--===============0170600201==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Simon,

Thank you for reviewing and your "Acked-by" signs.

Simon Horman wrote:
> On Fri, Nov 16, 2007 at 11:33:20AM +0900, Ken'ichi Ohmichi wrote:
>> This patch fixes the configuration dependencies in the vmcoreinfo data.
>>
>> i386's "node_data" is defined in arch/x86/mm/discontig_32.c,
>> and x86_64's one is defined in arch/x86/mm/numa_64.c.
>> They depend on CONFIG_NUMA:
>>   arch/x86/mm/Makefile_32:7
>>     obj-$(CONFIG_NUMA) += discontig_32.o
>>   arch/x86/mm/Makefile_64:7
>>     obj-$(CONFIG_NUMA) += numa_64.o
>>
>> ia64's "pgdat_list" is defined in arch/ia64/mm/discontig.c,
>> and it depends on CONFIG_DISCONTIGMEM and CONFIG_SPARSEMEM:
>>   arch/ia64/mm/Makefile:9-10
>>     obj-$(CONFIG_DISCONTIGMEM) += discontig.o
>>     obj-$(CONFIG_SPARSEMEM)    += discontig.o
>>
>> ia64's "node_memblk" is defined in arch/ia64/mm/numa.c,
>> and it depends on CONFIG_NUMA:
>>   arch/ia64/mm/Makefile:8
>>     obj-$(CONFIG_NUMA)         += numa.o
>>
>> Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
> 
> This appears correct to me, checking through the symbols and the
> location of their deffinitions, though I have not had a chance to run
> many build checks.
> 
> I also note that CONFIG_ARCH_DISCONTIGMEM_ENABLE does not even
> appear to exist on i386, so it looks that without this change
> the code in question whould never be enabled.

If you enable "Numa Memory Allocation and Scheduler Support" in i386's
menuconfig, CONFIG_ARCH_DISCONTIGMEM_ENABLE is enabled.


Thanks
Ken'ichi Ohmichi 



--===============0170600201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0170600201==--

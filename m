Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WL4Vk-00033B-Ui
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 05:36:57 +0000
Date: Wed, 5 Mar 2014 13:36:17 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
Message-ID: <20140305053617.GE26240@dhcp-17-89.nay.redhat.com>
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Muli Ben-Yehuda <muli@cs.technion.ac.il>, "Jon D. Mason" <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Yinghai Lu <yinghai@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: discuss@x86-64.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

[ Add Muli, I find his new email in git log]

Hi, Muli

saved_max_pfn is becoming a setback for kexec-tools. Ideally calgary
could get rid of saved_max_pfn at all. But If this can't work, how about
exporting a calgary tce table size to user space, so that kexec-tools
can simply pass calgary=xxx cmdline to 2nd kernel.

What do you think of this problem?

BTW MAINTAINERS file still uses your old email, please update
accordingly.

Thanks
WANG Chao

On 02/19/14 at 02:18pm, WANG Chao wrote:
> Hi, All
> 
> arch/x86/kernel/pci-calgary.c is the only user of saved_max_pfn today:
> 
> int __init detect_calgary(void)
> {
> 	[..]
> 	specified_table_size = determine_tce_table_size((is_kdump_kernel() ?
> 					saved_max_pfn : max_pfn) * PAGE_SIZE);
> 	[..]
> }
> 
> saved_max_pfn is the real mem size and is calculated by 1st kernel E820
> memmap which is passed in by 2nd kernel's boot_params (done by kexec):
> 
> 	saved_max_pfn = e820_end_of_ram_pfn();
> 
> After saved_max_pfn has been set, memmap=exactmap will reset the E820
> provided by boot_params and use the user defined E820 instead.
> 
> Now we want to get rid of memmap=exactmap and directly pass the E820
> memmap by boot_params for some reason (eg. exactmap may exceed the cmdline
> size and also isn't compatible with kaslr).
> 
> However saved_max_pfn becomes the obstacle for obsoleting exactmap.
> Because it needs two conditions: first kernel's E820 map and
> memmap=exactmap cmdline.
> 
> So I'm wondering if it's possible to get rid of saved_max_pfn totally in
> calgary code. Or we can get saved_max_pfn using a different way, for
> example calculated in 1st kernel and passed in to 2nd kernel by cmdline.
> 
> Thanks
> WANG Chao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WGH8B-0004kb-RH
 for kexec@lists.infradead.org; Thu, 20 Feb 2014 00:04:48 +0000
Received: by mail-wg0-f44.google.com with SMTP id k14so910762wgh.11
 for <kexec@lists.infradead.org>; Wed, 19 Feb 2014 16:04:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
References: <20140219061824.GA29703@dhcp-17-89.nay.redhat.com>
Date: Wed, 19 Feb 2014 17:04:22 -0700
Message-ID: <CAPoiz9yuLg4exX58bh5=XumgAmYNq-9kPjc+f1wa8kMU3-dBbg@mail.gmail.com>
Subject: Re: How could we get rid of saved_max_pfn for calgary iommu?
From: Jon Mason <jdmason@kudzu.us>
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
To: WANG Chao <chaowang@redhat.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, discuss@x86-64.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Feb 18, 2014 at 11:18 PM, WANG Chao <chaowang@redhat.com> wrote:
> Hi, All
>
> arch/x86/kernel/pci-calgary.c is the only user of saved_max_pfn today:
>
> int __init detect_calgary(void)
> {
>         [..]
>         specified_table_size = determine_tce_table_size((is_kdump_kernel() ?
>                                         saved_max_pfn : max_pfn) * PAGE_SIZE);
>         [..]
> }

IIUC, the purpose of this code is to reuse the TCE table from the
previous kernel.  Thus, it needs to be of the same size as the
pre-kdump kernel.  It is using the max_pfn to determine the TCE table
size in the non-kdump case.  If there is another way to determine the
size it used before, then I am fine making the change to use that way.

Thanks,
Jon

> saved_max_pfn is the real mem size and is calculated by 1st kernel E820
> memmap which is passed in by 2nd kernel's boot_params (done by kexec):
>
>         saved_max_pfn = e820_end_of_ram_pfn();
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

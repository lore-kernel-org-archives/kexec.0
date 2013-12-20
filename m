Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vu0pl-0004eB-6S
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 14:13:45 +0000
Date: Fri, 20 Dec 2013 09:13:21 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
Message-ID: <20131220141321.GA27063@redhat.com>
References: <20131218133402.GA23617@dhcp-17-89.nay.redhat.com>
 <52B39878.3030403@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52B39878.3030403@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>

On Fri, Dec 20, 2013 at 10:08:08AM +0900, HATAYAMA Daisuke wrote:

[..]
> 
> >cat /proc/iomem:
> >00000000-00000fff : reserved
> >00001000-0009ffff : System RAM
> >000a0000-000bffff : PCI Bus 0000:00
> >000f0000-000fffff : System ROM
> >00100000-3d162017 : System RAM
> >   01000000-015cab9b : Kernel code
> >   015cab9c-019beb3f : Kernel data
> >   01b4f000-01da9fff : Kernel bss
> >   30000000-37ffffff : Crash kernel
> >3d162018-3d171e57 : System RAM
> >3d171e58-3d172017 : System RAM
> >3d172018-3d17ae57 : System RAM
> >3d17ae58-3dc10fff : System RAM
> 
> this part is consecutive but somehow is divided into 4 entries.
> You called your environment as ``EFI virtual machine'', could you tell
> me precisely what it mean? qemu/KVM or VMware guest system? I do want
> to understand how this kind of memory map was created. I think this
> kind of memory mapping is odd and I guess this is caused by the fact
> that the system is a virtual environment.
> 
> And for Vivek, this case is a concrete example of multiple RAM entries
> appearing in a single page I suspected in the mmap failure patch,
> although these entries are consecutive in physical address and can be
> represented by a single entry by merging them in a single entry. But
> then it seems to me that there could be more odd case that multiple
> RAM entries but not consecutive. I again think this should be addressed
> in the patch for the mmap failure issue. How do you think?

Hi Hatayama,

This indeed looks very odd. See if a very small number of systems have it,
the only thing we will do is allocate extra page in second kernel for
a memory range. It will not make mmap() fail. So it is just a matter of
optimization.

Given the fact I have not seen many systems with this anomaly, I am not
too worried about it even if you don't this optimization in your patch
series. We can always take care of it later if need be.

At the same time, if you feel strongly about it and want to fix it in
same patch series, I don't mind.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

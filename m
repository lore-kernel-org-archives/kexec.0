Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vtpf8-00041b-E6
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 02:18:04 +0000
Date: Fri, 20 Dec 2013 10:17:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] makedumpfile: memset() in cyclic bitmap initialization
 introduce segment fault
Message-ID: <20131220021750.GA7962@dhcp-16-126.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, WANG Chao <chaowang@redhat.com>

> Also, I'm interested in the memory map passed to from EFI in that
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

This is not specific to EFI machine, it's the reserved setup_data regions
They happened to be continous but they do not have to be continuous.

> 
> And for Vivek, this case is a concrete example of multiple RAM entries
> appearing in a single page I suspected in the mmap failure patch,
> although these entries are consecutive in physical address and can be
> represented by a single entry by merging them in a single entry. But
> then it seems to me that there could be more odd case that multiple
> RAM entries but not consecutive. I again think this should be addressed
> in the patch for the mmap failure issue. How do you think?

They are different problems, the previous mmap bug is for cross page regions
with different page flags.

> 
> >3dc11000-3dc18fff : reserved
> >3dc19000-3dc41fff : System RAM
> >3dc42000-3ddcefff : reserved
> >3ddcf000-3f7fefff : System RAM
> >3f7ff000-3f856fff : reserved
> >[..]
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

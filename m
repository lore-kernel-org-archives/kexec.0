Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eBdhV-0007FK-3h
 for kexec@lists.infradead.org; Mon, 06 Nov 2017 09:28:16 +0000
Date: Mon, 6 Nov 2017 17:27:29 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171106092729.GB3669@x1>
References: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
 <20171106024143.GA3669@x1>
 <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
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
To: Jiri Bohac <jbohac@suse.cz>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi Jiri,

Thanks for providing these information.

On 11/06/17 at 10:01am, Jiri Bohac wrote:
> Hi Baoquan,
> 
> 	[    0.000000] memblock_reserve: [0x00000000b8000000-0x00000000bbffffff] gart_iommu_hole_init+0x396/0x4b6
> 	[    0.000000] AGP: Mapping aperture over RAM [mem 0xb8000000-0xbbffffff] (65536KB)
> ^^^^^

> /proc/iomem:
> 	00000000-00000fff : Reserved
> 	00001000-0009d7ff : System RAM
> 	0009d800-0009ffff : Reserved
> 	000a0000-000bffff : PCI Bus 0000:00
> 	000c0000-000cafff : PCI Bus 0000:00
> 	  000c0000-000cafff : Video ROM
> 	000cb000-000ccfff : Adapter ROM
> 	000ce000-000fffff : Reserved
> 	  000f0000-000fffff : System ROM
> 	00100000-c7e7ffff : System RAM
> 	  0b000000-0b792eb5 : Kernel code
> 	  0b792eb6-0bd5d47f : Kernel data
> 	  0c274000-0c3c8fff : Kernel bss
> 	  b7000000-c6ffffff : Crash kernel

It's weird, gart aperture located in crashkernel region? Or we need
reserve the low crashkernel memory for gart aperture usage, Just like
swiotlb?

Sorry, I am not familiar with gart.

Thanks
Baoquan


> 	c7e80000-c7e8afff : ACPI Tables
> 	c7e8b000-c7e8cfff : ACPI Non-volatile Storage
> 	c7e8d000-c7ffffff : Reserved
> 	c8000000-ce0fffff : PCI Bus 0000:00
> 	  c8000000-c80003ff : IOAPIC 1
> 	  c8014000-c80143ff : 0000:00:11.0
> 	    c8014000-c80143ff : ahci
> 	  c8014400-c80144ff : 0000:00:12.2
> 	    c8014400-c80144ff : ehci_hcd
 
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

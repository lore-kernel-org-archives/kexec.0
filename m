Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eBe9M-0008An-Ni
 for kexec@lists.infradead.org; Mon, 06 Nov 2017 09:57:02 +0000
Date: Mon, 6 Nov 2017 10:56:38 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171106095638.7iwlyjmlom3tqelt@dwarf.suse.cz>
References: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
 <20171106024143.GA3669@x1>
 <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
 <20171106092729.GB3669@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171106092729.GB3669@x1>
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
To: Baoquan He <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, Nov 06, 2017 at 05:27:29PM +0800, Baoquan He wrote:
> > 	00100000-c7e7ffff : System RAM
> > 	  0b000000-0b792eb5 : Kernel code
> > 	  0b792eb6-0bd5d47f : Kernel data
> > 	  0c274000-0c3c8fff : Kernel bss
> > 	  b7000000-c6ffffff : Crash kernel
> 
> It's weird, gart aperture located in crashkernel region? 

Ooops! I sent you a /proc/iomem from a different boot than the
dmesg, whith different crashkernel= commandline. Sorry, this is
the correct /proc/iomem:


	00000000-00000fff : Reserved
	00001000-0009d7ff : System RAM
	0009d800-0009ffff : Reserved
	000a0000-000bffff : PCI Bus 0000:00
	000c0000-000cafff : PCI Bus 0000:00
	  000c0000-000cafff : Video ROM
	000cb000-000ccfff : Adapter ROM
	000ce000-000fffff : Reserved
	  000f0000-000fffff : System ROM
	00100000-c7e7ffff : System RAM
	  c3000000-c77fffff : Crash kernel
	c7e80000-c7e8afff : ACPI Tables
	c7e8b000-c7e8cfff : ACPI Non-volatile Storage
	c7e8d000-c7ffffff : Reserved
	c8000000-ce0fffff : PCI Bus 0000:00
	  c8000000-c80003ff : IOAPIC 1
	  c8014000-c80143ff : 0000:00:11.0
	    c8014000-c80143ff : ahci
	  c8014400-c80144ff : 0000:00:12.2
	    c8014400-c80144ff : ehci_hcd
	  c8014800-c80148ff : 0000:00:13.2
	    c8014800-c80148ff : ehci_hcd
	  c8015000-c8015fff : 0000:00:12.0
	    c8015000-c8015fff : ohci_hcd
	  c8016000-c8016fff : 0000:00:12.1
	    c8016000-c8016fff : ohci_hcd
	  c8017000-c8017fff : 0000:00:13.0
	    c8017000-c8017fff : ohci_hcd
	  c8018000-c8018fff : 0000:00:13.1
	    c8018000-c8018fff : ohci_hcd
	  c8019000-c8019fff : 0000:00:14.5
	    c8019000-c8019fff : ohci_hcd
	  ca000000-cdffffff : PCI Bus 0000:01
	    ca000000-cbffffff : 0000:01:00.0
	      ca000000-cbffffff : bnx2
	    cc000000-cdffffff : 0000:01:00.1
	      cc000000-cdffffff : bnx2
	  ce000000-ce0fffff : PCI Bus 0000:02
	    ce000000-ce00ffff : 0000:02:06.0
	d0000000-d7ffffff : PCI Bus 0000:00
	  d0000000-d7ffffff : PCI Bus 0000:02
	    d0000000-d7ffffff : 0000:02:06.0
	e0000000-efffffff : Reserved
	  e0000000-efffffff : pnp 00:00
	    e0000000-e02fffff : PCI MMCONFIG 0000 [bus 00-02]
	fec00000-fec0ffff : Reserved
	  fec00000-fec003ff : IOAPIC 0
	fec10000-fec1001f : pnp 00:05
	fed00000-fed003ff : HPET 2
	  fed00000-fed003ff : PNP0103:00
	fed40000-fed45000 : PCI Bus 0000:00
	fee00000-fee00fff : Local APIC
	  fee00000-fee00fff : Reserved
	    fee00000-fee00fff : pnp 00:00
	fff00000-ffffffff : Reserved
	  fff00000-ffffffff : pnp 00:05
	100000000-837ffffff : System RAM
	  4df000000-4df792eb5 : Kernel code
	  4df792eb6-4dfd5d47f : Kernel data
	  4e0274000-4e03c8fff : Kernel bss
	  831000000-8374fffff : Crash kernel

Sorry for the confusion!

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

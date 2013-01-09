Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TslU7-0002XP-1p
 for kexec@lists.infradead.org; Wed, 09 Jan 2013 02:33:45 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
 with iommu
Date: Wed, 09 Jan 2013 03:32:50 +0100
Message-ID: <3564889.4S6qWWRR6X@hammer82.arch.suse.de>
In-Reply-To: <CAE9FiQXUCtfeKuZVb1=13SL-UUu5hkNE3Q3K8MTZA2ap1qDCAg@mail.gmail.com>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <201301081750.07296.trenn@suse.de>
 <CAE9FiQXUCtfeKuZVb1=13SL-UUu5hkNE3Q3K8MTZA2ap1qDCAg@mail.gmail.com>
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Tuesday, January 08, 2013 09:27:55 AM Yinghai Lu wrote:
> On Tue, Jan 8, 2013 at 8:50 AM, Thomas Renninger <trenn@suse.de> wrote:
> > megaraid_sas
> 
> can you check if your initrd for kdump kernel has that driver and
> module that it depends on like
> scsi sas transport etc ?

Removing the 5 patches and the disk works and the
dump is written.

I can look a bit further at the memmap=exactmap issue tomorrow.
I can also double check above then, but I am rather sure about it
already:
I tried plain vanilla -> worked, dumping started
I tried with only these 5 patches added -> no disk.


Some questions:

You try to initialize the PCI subsystem in a way the BIOS typically has
to do it in kexec case?

Reacting and trying to handle error condtitions more gracefully
at the place where they are caught could be another approach which
imo makes sense to implement in parallel.

In my case for example I see:
"Present field in the IRTE entry is clear"
DMAR errors. I expect this comes from a device which still throws
interrupts, but irq vector got not set-up or registered in the kexec'ed 
kernel.

I could imagine this is the same error which happens when an irq is
wrongly configured and spurious interrupts happen (but in irq remapped case).
In my case it's not sever as I only see this message once, but according
to another report, they see about 80 of such DMAR error messages per
second. This seem to result in endless DMAR error interrupts and finally
a dead system.

I wonder whether the DMAR error handler could already invoke a PCIe
reset.
I found:
int pci_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
which unfortunatly is only implemented for PPC, but would it make sense to
implement this one and trigger function level reset if several specific DMAR
errors are seen (or other PCI(e) error handlers get active?)?

If this does not help the next step could be to stop DMAR error interrupt
handling or other iommu commands to keep the machine alive, even if one
device keeps firing interrupts to an unconfigured irq vector (or whatever other
things could happen).

Just some ideas...
Comments appreciated.

   Thomas

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HgGfB-0007N3-Ua
	for kexec@lists.infradead.org; Tue, 24 Apr 2007 04:46:20 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3O8jqEt022924
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 04:45:52 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3O8jqdN149072
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 02:45:52 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3O8jp7o010741
	for <kexec@lists.infradead.org>; Tue, 24 Apr 2007 02:45:52 -0600
Date: Tue, 24 Apr 2007 14:14:44 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] aacraid: fails to initialize after a  kexec operation
Message-ID: <20070424084444.GC22742@in.ibm.com>
References: <20070423161203.GA2129@in.ibm.com>
	<AE4F746F2AECFC4DA4AADD66A1DFEF0188AE58@otce2k301.adaptec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AE4F746F2AECFC4DA4AADD66A1DFEF0188AE58@otce2k301.adaptec.com>
Reply-To: vgoyal@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kexec Mailing List <kexec@lists.infradead.org>, Judith Lebzelter <judith@linux-foundation.org>, linux-scsi@vger.kernel.org

On Mon, Apr 23, 2007 at 01:20:32PM -0400, Salyzyn, Mark wrote:
> That is a failure to route the interrupts and is possibly an issue with
> the kernel and the hardware, and not the driver directly (since there is
> an expectation that request_irq will connect the interrupt to the
> interrupt service routine). Judith reported success in the past with
> this patch on her hardware, perhaps the motherboard on your system has
> some odd BIOS setup of the hardware that is giving acpi or the apic some
> headaches? Can you check out success or failure on other motherboards?
> Please try the suggestions from the driver (safe flags)?
> 
> Sincerely -- Mark Salyzyn
> 

Hi Mark,

We don't even go through BIOS in kexec and kdump. So BIOS should not be an
issue.

Looks like you sent some message to controller and then waiting for an
interrupt from the controller as an indication of completion of command. In
this case you never seem to get an interrupt hence timeout.

To bypass this problem, I am now booting my second kernel with "irqpoll"
command line option. This will make sure that aacraid interrupt handler
gets invoked even if there is an interrupt routing issue.

This option does help in progressing the things but it ends up corrupting
something or other on the disk. In three attempts I get three types of
errors.

In first attempt I get continuous stream of following messages once
root file system has been mounted.

=============================================
sda1: rw=0, want=9261304112, limit=41945652
attempt to access beyond end of device
sda1: rw=0, want=9261304112, limit=41945652
attempt to access beyond end of device
sda1: rw=0, want=9261304112, limit=41945652
attempt to access beyond end of device
sda1: rw=0, want=9261304112, limit=41945652
attempt to access beyond end of device
sda1: rw=0, want=9261304112, limit=41945652
attempt to access beyond end of device
============================================

In second attempt, it mounted the file system but it found some issue
with "resize" inode and asked me to run fsck manually. Which in turn 
deleted whole lot of inodes.

In third attemt it panics later when it finds ext3 to be corrupted.

=========================================
Creating block device nodes.
Trying to resume from LABEL=SWAP-sda3
No suspend signature on swap, not resuming.
Creating root device.
Mounting root filesystem.
EXT3-fs: Magic mismatch, very weird !
mount: error mouKernel panic - not syncing: Attempted to kill init!
nting /dev/root
=================================================== 

Following are relevant aacraid initiliazation messages on serial console.

===================================================================
Adaptec aacraid driver (1.1-5[2437]-mh4)
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 25
AAC0: kernel 5.2-0[11835] Jan  9 2007
AAC0: monitor 5.2-0[11835]
AAC0: bios 5.2-0[11835]
AAC0: serial 1625d1
AAC0: 64bit support enabled.
AAC0: 64 Bit DAC enabled
scsi0 : ServeRAID
scsi 0:0:0:0: Direct-Access     IBM      x366             V1.0 PQ: 0 ANSI: 2
scsi 0:1:0:0: Direct-Access     IBM-ESXS ST973401SS       B519 PQ: 0 ANSI: 5
scsi 0:1:1:0: Direct-Access     IBM-ESXS ST973401SS       B519 PQ: 0 ANSI: 5
scsi 0:1:2:0: Direct-Access     IBM-ESXS ST973401SS       B519 PQ: 0 ANSI: 5
scsi 0:3:0:0: Enclosure         IBM      SAS SES-2 DEVICE 0.09 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 429459456 512-byte hardware sectors (219883 MB)
sd 0:0:0:0: [sda] Assuming Write Enabled
sd 0:0:0:0: [sda] Assuming drive cache: write through
sd 0:0:0:0: [sda] 429459456 512-byte hardware sectors (219883 MB)
sd 0:0:0:0: [sda] Assuming Write Enabled
sd 0:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 0:0:0:0: [sda] Attached SCSI removable disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 0:1:0:0: Attached scsi generic sg1 type 0
scsi 0:1:1:0: Attached scsi generic sg2 type 0
scsi 0:1:2:0: Attached scsi generic sg3 type 0
scsi 0:3:0:0: Attached scsi generic sg4 type 13
================================================

I am not sure why this reset leaves file system in corrupted state and
is there a better way to handle this? Link syncing the existing commands
before restarting it.

Should one keep a dedicated partition on the disk and not mount it in first
kernel. Mount this partition only in second kernel to save the dump. I shall
have to test such configuration.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

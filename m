Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YF0k7-0007pN-Rt
 for kexec@lists.infradead.org; Sat, 24 Jan 2015 13:27:16 +0000
Date: Sat, 24 Jan 2015 21:26:37 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [RFD] efi assisted kdump
Message-ID: <20150124132637.GB2139@darkstar.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: linux-efi@vger.kernel.org
Cc: matt.fleming@intel.com, kexec@lists.infradead.org, vgoyal@redhat.com

Hi,

Kdump has several limitations currently such as kdump kernel reboot will bypass
device shutdown path so device drivers should reset during initialization.

* One of such problem we encounter now is the iommu
issue, 1st kernel's on fly DMA requests cause 2nd kernel hang. There's some effort
on this area, Zhenhua Li posted patches to resolve the intel iommu issue which is
under review. But that is just one case there's other possible problems in the future.

* There's no serial console on most machines in the market especially for desktop
machines and laptops. kms enabled kernel need drm layer driver for framebuffer
console, after kernel crashing we need a console to see the 2nd kernel output
ideally a serial console because we can not switch back to VGA mode.

ppc64 has a feature "firmware assisted kdump", see below documentation:
Documentation/powerpc/firmware-assisted-dump.txt

In case UEFI machines I wonder if we can do similar things, basic idea is doing
minimum thing based on original kdump process.

kernel reserve crashkernel memory during early boot
 -> user (kdump service) save necessary informations in some way so that second
    kernel boot can access ie. efi runtime variables or in reserved memory
    * crashkernel memory ranges infomation
    * collect infomations and save elf notes for 2nd kernel vmcore initialization
    -> crashing
       * call efi warm reboot
       -> 2nd kernel boot
          -> efi stub checking if this is a warm reboot and if this is a crashed boot
             -> if this is not a crashed boot then
                    do nothing more than original logic
                else
                    boot kernel with limited memory which was reserved in previous kernel
                    -> 2nd kernel boot
                       vmcore intializing

There's several things I need to ask for help from EFI gurus to see if it is doable:

* Make sure in case EFI warm reboot the memory of previous kernel can be retained.

* How to determine if kernel is boot with EFI warm reboot in stub

* What is the right way to pass informations from 1st kernel to 2nd kernel.
  Is it ok for saving something with efi variables? 

* Other possible problems what I missed

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjNxk-0001ym-Er
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 06:42:06 +0000
Message-Id: <20131121064043.969000753@dhcp-16-126.nay.redhat.com>
Date: Thu, 21 Nov 2013 14:40:43 +0800
From: dyoung@redhat.com
Subject: [patch 0/4 v3] kexec-tools: efi runtime support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

Hi,

This is the v3 patchset for adding efi runtime support on kexec kernel
kernel patches was sent a while ago, not yet updated in archive. 

in kexec-tools, this patchset will do below:
1. retrieve efi_info from sysfs boot_params, and fill the
x86 setup header. If kernel does not export sysfs boot_params,
still try to find them in debugfs.

2. collect data efi runtime needed:
/sys/firmware/efi/systab: smbios
/sys/firmware/efi/fw_vendor
/sys/firmware/efi/runtime
/sys/firmware/efi/config_table

/sys/firmware/efi/runtime-map/*, the phys-virt mappings in 1st kernel

3. assemble setup_data based on data get in 2) then pass it to 2nd kernel

Tested on OVMF, dell laptop, lenovo laptop and HP workstation

TODO: add functions for easily adding setup_data, arrange them as link list
because we probably will add e820 memory ranges as setup_data as well.
I do not prefer to bloat this patchset anymore, so I'd likt to address this
issue after the efi runtime issue finished unless people request.

V2 changelog:
Address comments from
Simon:
  coding style, fixed a mem leak
HPA:
  use type uint64_t instead of __uint64_t
mjg:
  do not cause regression for loading old kernel
  use xloadflags to check the bzImage support for efi.
  in case old kernel, do not pass efi_info and setup_data
  for new kernel, do not pass acpi_rsdp
Vivek:
  suggest to export a value in bzImage probe for efi support
  so it can be used to check if we should pass acpi_rsdp.

V3 changelog:
01/04: new patch of a building fix
try sysfs firstly for boot params
add checking of efi memory range description version, bail out if it's not 1
error handling improvement and some cleanups

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

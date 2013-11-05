Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdcAs-0002bz-Jn
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 08:39:47 +0000
Message-Id: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
Date: Tue, 05 Nov 2013 16:29:47 +0800
From: dyoung@redhat.com
Subject: [patch 0/3 v2] kexec-tools: efi runtime support
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

This patchset is for adding efi runtime support on kexec kernel
kernel patches see below thread:
http://thread.gmane.org/gmane.linux.kernel.efi/2491

in kexec-tools, this patchset will do below:
1. retrieve efi_info from debugfs boot_params, and fill the
x86 setup header

2. collect data efi runtime needed:
/sys/firmware/efi/systab: fw_vendor, runtime, config_tables and smbios
/sys/firmware/efi/efi-runtime-map/*, the phys-virt mappings in 1st kernel

3. assemble setup_data based on data get in 2) then pass it to 2nd kernel

Tested on OVMF, dell laptop, lenovo laptop and HP workstation

Please help to review

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

--
Thanks
dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

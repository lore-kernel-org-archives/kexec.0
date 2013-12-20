Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VtwyE-0005cd-MD
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 10:06:15 +0000
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 0/4] kexec-tools: efi runtime support on kexec kernel
Date: Fri, 20 Dec 2013 18:05:43 +0800
Message-Id: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
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

changelog v3->v4:
update efi_info memmap to the saved runtime map instead of use 1st kernel
untouched memmap.

Tested on OVMF, dell laptop, lenovo laptop and HP workstation

Dave Young (4):
  build fix: include x86-linux.h in x86-linux-setup.h
  Add function get_bootparam
  Add efi_info in x86 setup header
  Passing efi related data via setup_data

 include/x86/x86-linux.h             |   3 +-
 kexec/arch/i386/crashdump-x86.c     |   4 +-
 kexec/arch/i386/x86-linux-setup.c   | 246 ++++++++++++++++++++++++++++++++++--
 kexec/arch/i386/x86-linux-setup.h   |   2 +
 kexec/arch/x86_64/kexec-bzImage64.c |   6 +
 5 files changed, 248 insertions(+), 13 deletions(-)

-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

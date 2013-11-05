Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdcAM-0002Yv-Cp
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 08:39:14 +0000
Message-Id: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
Date: Tue, 05 Nov 2013 16:20:07 +0800
From: dyoung@redhat.com
Subject: [patch 0/7 v2] kexec kernel efi runtime support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2330930287306889092=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

--===============2330930287306889092==
Content-Type: text/plain

Hi,

Here is the V2 for supporting kexec kernel efi runtime.
Per pervious discussion I pass the 1st kernel efi runtime mapping
via setup_data to 2nd kernel. Besides of the runtime mapping
info I also pass the fw_vendor, runtime, config table, smbios
physical address in setup_data. EFI spec mentioned fw_vendor,
runtime, config table addresses will be converted to virt address
after entering virtual mode, but we will use it as physical address
in efi_init. For smbios EFI spec did not mention about the address
updating, but during my test on a HP workstation, the bios will
convert it to Virt addr, thus pass it in setup_data as well.

For fw_vendor, runtime, config table, I export them in /sys/firmware/
efi/systab, smbios is already in that file.

For efi runtime mapping I add a new directory /sys/firmware/efi/
efi-runtime-map/ like below
[dave@darkstar ~]$ tree /sys/firmware/efi/efi-runtime-map/
/sys/firmware/efi/efi-runtime-map/
��������� 0
������� ��������� attribute
������� ��������� num_pages
������� ��������� phys_addr
������� ��������� type
������� ��������� virt_addr
��������� 1
������� ��������� attribute
������� ��������� num_pages
������� ��������� phys_addr
������� ��������� type
������� ��������� virt_addr
[snip]
 
kexec-tools will assemble them as setup_data and pass to 2nd kernel.
I will send userspace patches as well.

Limitation is I only write support for x86_64, test on below machines:
Lenovo thinkpad t420
Dell inspiron 14 - 3421
HP Z420 workstation
Qemu + OVMF

Please help to review the patches.

The patches are based on matt's efi master tree

Changes from v1:
add one flag in xloadflags, so kexec-tools can safely load old kernel
without efi support.
coding style fixes
function name for map phys_addr to fixed virt_addr
Add ABI documentation for sysfs files
--
Thanks
Dave


--===============2330930287306889092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2330930287306889092==--

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaHWL-0001o9-LS
 for kexec@lists.infradead.org; Sun, 27 Oct 2013 04:00:10 +0000
Message-Id: <20131027034713.481920209@dhcp-16-126.nay.redhat.com>
Date: Sun, 27 Oct 2013 11:47:13 +0800
From: dyoung@redhat.com
Subject: [patch 0/6] kexec kernel efi runtime support 
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7661022321987958582=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

--===============7661022321987958582==
Content-Type: text/plain

Hi,

Here is the 1st version for supporting kexec kernel efi runtime.
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

The patches are based on linus tree (3.12.0-rc6+) + matt's next tree + bp's efi mapping patches
Boris's last patch can not directly apply, need a little line shifting.
--
Thanks
Dave


--===============7661022321987958582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7661022321987958582==--

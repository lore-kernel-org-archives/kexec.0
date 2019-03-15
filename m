Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h4k8R-0005Tr-UA
 for kexec@lists.infradead.org; Fri, 15 Mar 2019 10:32:20 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/3] Add kdump support for the SEV enabled guest
Date: Fri, 15 Mar 2019 18:32:00 +0800
Message-Id: <20190315103203.13128-1-lijiang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

For the AMD SEV machines, add kdump support when the SEV is enabled.

Test tools:
makedumpfile[v1.6.5]:
git://git.code.sf.net/p/makedumpfile/code
commit <d222b01e516b> ("Add support for AMD Secure Memory Encryption")
Note: This patch was merged into the devel branch.

crash-7.2.5: https://github.com/crash-utility/crash.git

kexec-tools-2.0.19:
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
commit <942d813cda35> ("Fix for the kmem '-i' option on Linux 5.0")
http://lists.infradead.org/pipermail/kexec/2019-March/022576.html
Note: The second kernel cann't boot without this patch. 

kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit <f261c4e529da> ("Merge branch 'akpm' (patches from Andrew)")

Test steps:
[1] load the vmlinux and initrd for kdump
# kexec -p /boot/vmlinuz-5.0.0+ --initrd=/boot/initramfs-5.0.0+kdump.img --command-line="BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.0.0+ ro resume=UUID=126c5e95-fc8b-48d6-a23b-28409198a52e console=ttyS0,115200 earlyprintk=serial irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"

[2] trigger panic
# echo 1 > /proc/sys/kernel/sysrq
# echo c > /proc/sysrq-trigger

[3] check and parse the vmcore
# crash vmlinux /var/crash/127.0.0.1-2019-03-15-05\:03\:42/vmcore

Lianbo Jiang (3):
  kexec: Do not map the kexec area as decrypted when SEV is active
  kexec: Set the C-bit in the identity map page table when SEV is active
  kdump,proc/vmcore: Enable kdumping encrypted memory when SEV was
    active

 arch/x86/kernel/machine_kexec_64.c | 20 +++++++++++++++++---
 fs/proc/vmcore.c                   |  6 +++---
 2 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

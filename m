Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leiXt-006HMt-4V
 for kexec@lists.infradead.org; Thu, 06 May 2021 18:16:22 +0000
From: Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Subject: BUG REPORT: makedumpfile can't get the kernel version for Linux
 5.10.30-e8d03e3 on ARMv7 Processor rev 5 (v7l)
Message-ID: <08dc647e-7841-4a0d-d133-d871551a4a6f@linux.vnet.ibm.com>
Date: Thu, 6 May 2021 11:16:15 -0700
MIME-Version: 1.0
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: k-hagio-ab@nec.com, kexec@lists.infradead.org

With commit a8250642a4ff50a2559446f4e915a1f59ac7adf7 (HEAD -> master, 
origin/master, origin/HEAD)

This is on OpenBMC which builds on OpenEmbedded and Yocto.

sh-5.1# makedumpfile -d 31 /proc/vmcore /mnt/dumpfile
The kernel version is not supported.
The makedumpfile operation may be incomplete.
check_release: Can't get the kernel version.

makedumpfile Failed.


sh-5.1# makedumpfile -v
makedumpfile: version 1.6.8++ (released on 16 Nov 2020)
lzo     disabled
snappy  disabled


sh-5.1# uname -a
Linux p10bmc 5.10.30-e8d03e3 #1 SMP Thu May 6 15:55:30 UTC 2021 armv7l 
GNU/Linux


sh-5.1# cat /etc/os-release
ID=openbmc-openpower
NAME="Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro)"
VERSION="2.10.0-dev"
VERSION_ID=2.10.0-dev-1109-g322868a61-dirty
PRETTY_NAME="Phosphor OpenBMC (Phosphor OpenBMC Project Reference 
Distro) 2.10.0-dev"
BUILD_ID="2.10.0-dev"
OPENBMC_TARGET_MACHINE="p10bmc"


sh-5.1# cat /proc/cpuinfo
processor       : 0
model name      : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 2400.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 
idiva idivt vfpd32 lpae evtstrm
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xc07
CPU revision    : 5

Hardware        : Generic DT based system
Revision        : 0000
Serial          : 0000000000000000



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

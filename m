Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410049.outbound.protection.outlook.com
 ([40.107.141.49] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lh0C4-00AxMp-LY
 for kexec@lists.infradead.org; Thu, 13 May 2021 01:31:19 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: BUG REPORT: makedumpfile can't get the kernel version for Linux
 5.10.30-e8d03e3 on ARMv7 Processor rev 5 (v7l)
Date: Thu, 13 May 2021 01:31:12 +0000
Message-ID: <OSBPR01MB1991D61F019E4785C81971FFDD519@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <08dc647e-7841-4a0d-d133-d871551a4a6f@linux.vnet.ibm.com>
In-Reply-To: <08dc647e-7841-4a0d-d133-d871551a4a6f@linux.vnet.ibm.com>
Content-Language: ja-JP
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> 
> With commit a8250642a4ff50a2559446f4e915a1f59ac7adf7 (HEAD -> master,
> origin/master, origin/HEAD)
> 
> This is on OpenBMC which builds on OpenEmbedded and Yocto.
> 
> sh-5.1# makedumpfile -d 31 /proc/vmcore /mnt/dumpfile
> The kernel version is not supported.
> The makedumpfile operation may be incomplete.
> check_release: Can't get the kernel version.
> 
> makedumpfile Failed.
> 

Thanks for the report.

Could I have the output with -D option?  That debugging output would not be
enough to understand the issue fully but helpful to know your kernel more
with vmcoreinfo.  (I suspect that vtop conversion might go wrong.)

Thanks,
Kazu

> 
> sh-5.1# makedumpfile -v
> makedumpfile: version 1.6.8++ (released on 16 Nov 2020)
> lzo     disabled
> snappy  disabled
> 
> 
> sh-5.1# uname -a
> Linux p10bmc 5.10.30-e8d03e3 #1 SMP Thu May 6 15:55:30 UTC 2021 armv7l
> GNU/Linux
> 
> 
> sh-5.1# cat /etc/os-release
> ID=openbmc-openpower
> NAME="Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro)"
> VERSION="2.10.0-dev"
> VERSION_ID=2.10.0-dev-1109-g322868a61-dirty
> PRETTY_NAME="Phosphor OpenBMC (Phosphor OpenBMC Project Reference
> Distro) 2.10.0-dev"
> BUILD_ID="2.10.0-dev"
> OPENBMC_TARGET_MACHINE="p10bmc"
> 
> 
> sh-5.1# cat /proc/cpuinfo
> processor       : 0
> model name      : ARMv7 Processor rev 5 (v7l)
> BogoMIPS        : 2400.00
> Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4
> idiva idivt vfpd32 lpae evtstrm
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x0
> CPU part        : 0xc07
> CPU revision    : 5
> 
> Hardware        : Generic DT based system
> Revision        : 0000
> Serial          : 0000000000000000
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

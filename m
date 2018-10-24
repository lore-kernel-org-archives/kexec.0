Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam05on0601.outbound.protection.outlook.com
 ([2a01:111:f400:fe51::601]
 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFIen-00029O-On
 for kexec@lists.infradead.org; Wed, 24 Oct 2018 12:53:07 +0000
From: "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>
Subject: [BUG] vmcore-dmesg cant' read dmesg log from /proc/vmcore if log_buf
 is reallocated due to large number of CPUs
Date: Wed, 24 Oct 2018 12:52:49 +0000
Message-ID: <MWHPR07MB3007D9D79825933D958943EC8AF60@MWHPR07MB3007.namprd07.prod.outlook.com>
Content-Language: en-US
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>

Hi all,

Following issue has been found for vmcore-dmesg app with latest release (94159bc3c264fa26395e56302072276a139d18af 2.0.18-rc1) of kexec-tools at CentOS 7.5 distro:

While having systems with large number of CPUs (e.g. Cavium ThunderX2 has 224) the log_buf gets reallocated by memblock_virt_alloc() at the setup_log_buf routine (https://elixir.bootlin.com/linux/v4.16.18/source/kernel/printk/printk.c#L1108).

Then while dumping vmcore the vmcore-dmesg can't find dmesg log at /proc/vmcore file and exits with following message:
  Failed to read log text of size 0 bytes: Bad address

However it (vmcore-dmesg app) reads properly the log_buf symbol, it's address and eventually it's value from /proc/vmcore but fails to find dmesg data then.

In the same time the makedumpfile is able to find and extract dmesg buffer from /proc/vmcore.
The makedumpfile comes with kexec-tools-2.0.15-13.el7_5.2.aarch64 package.

The issue is not reproduced for systems with small number of CPUs and log_buf not reallocated to memblock section.

WBR,
Vadim
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mexforward.lss.emc.com ([128.222.32.20])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SSZir-0002IL-4g
 for kexec@lists.infradead.org; Thu, 10 May 2012 20:12:25 +0000
Received: from hop04-l1d11-si04.isus.emc.com (HOP04-L1D11-SI04.isus.emc.com
 [10.254.111.24])
 by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
 q4AKCMaX009910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Thu, 10 May 2012 16:12:23 -0400
Received: from mailhub.lss.emc.com (mailhubhoprd04.lss.emc.com
 [10.254.222.226]) by hop04-l1d11-si04.isus.emc.com (RSA Interceptor) for
 <kexec@lists.infradead.org>; Thu, 10 May 2012 16:12:13 -0400
Received: from mxhub07.corp.emc.com (mxhub07.corp.emc.com [128.222.70.204])
 by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id
 q4AKCDqI018145
 for <kexec@lists.infradead.org>; Thu, 10 May 2012 16:12:13 -0400
From: <Ivan.Novick@emc.com>
Date: Thu, 10 May 2012 16:12:11 -0400
Subject: kexec from live image failing periodically
Message-ID: <CBD16F2B.4661%ivan.novick@emc.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hello,

I am trying to run kexec into the RHEL62 kickstart installer from a RHEL62
LiveCD.

It works most of the time, but sometimes it fails with a kernel crash
stack.

The last message before the crash is always:

"Trying to unpack rootfs image as initramfs...."


Below is a sample stack from the crash.

Does any one have any clues on tracking down this issue?

Cheers,
Ivan


BUG: soft lockup - CPU#0 stuck for 67s! [swapper:1]
Modules linked in:
CPU 0 
Modules linked in:

Pid: 1, comm: swapper Not tainted 2.6.32-220.el6.x86_64 #1 EMC
S2600GZ/S2600GZ
RIP: 0010:[<ffffffff81c4c8d8>]  [<ffffffff81c4c8d8>] rc_get_bit+0x6/0x79
RSP: 0018:ffff88102ceadce8  EFLAGS: 00000246
RAX: 0000000000000007 RBX: ffff88102ceadcf0 RCX: 0000000000000000
RDX: ffff88102ceaddfc RSI: ffffc90016e47686 RDI: ffff88102ceaddb0
RBP: ffffffff8100bc0e R08: ffffc90016e47678 R09: 0000000000000003
R10: 0000000000000003 R11: 0000000000000000 R12: 0000000004000605
R13: 000000000acff908 R14: ffffc90016e47644 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff880044600000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00007f42971e7730 CR3: 0000000001a85000 CR4: 00000000000406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper (pid: 1, threadinfo ffff88102ceac000, task
ffff88082c9554c0)
Stack:
 0000000000000000 ffff88102ceade30 ffffffff81c4d449 ffff881000000003
<0> ffffc90016e47678 ffffffff00000000 ffffffff81dd32b8 0000000000000000
<0> ffff88007e3b7000 ffff88007e3b7000 0000000000000003 0000000000000051
Call Trace:
 [<ffffffff81c4d449>] ? unlzma+0xa73/0xd21
 [<ffffffff8115e832>] ? fallback_alloc+0x12/0x270
 [<ffffffff81c21b25>] ? flush_buffer+0x0/0xa3
 [<ffffffff8126aa30>] ? nofill+0x0/0x10
 [<ffffffff81c228d2>] ? unpack_to_rootfs+0x1d9/0x2ec
 [<ffffffff81c21995>] ? error+0x0/0x17
 [<ffffffff81c4e381>] ? pci_apply_final_quirks+0x0/0x35
 [<ffffffff81c22a88>] ? populate_rootfs+0x0/0xd3
 [<ffffffff81c22ae3>] ? populate_rootfs+0x5b/0xd3
 [<ffffffff8100204c>] ? do_one_initcall+0x3c/0x1d0
 [<ffffffff81c1f8cb>] ? kernel_init+0x29d/0x2f9
 [<ffffffff8100c14a>] ? child_rip+0xa/0x20
 [<ffffffff81c1f62e>] ? kernel_init+0x0/0x2f9
 [<ffffffff8100c140>] ? child_rip+0x0/0x20
Code: 08 09 d0 89 43 24 0f b7 06 8b 53 28 c1 ea 0b 0f af c2 39 43 24 89 43
2c 0f 92 c0 48 83 c4 18 0f b6 c0 5b c9 c3 55 48 89 e5 41 55 <49> 89 d5 41
54 49 89 f4 53 48 89 fb 48 83 ec 08 e8 7c ff ff ff
Call Trace:
 [<ffffffff81c4d449>] ? unlzma+0xa73/0xd21
 [<ffffffff8115e832>] ? fallback_alloc+0x12/0x270
 [<ffffffff81c21b25>] ? flush_buffer+0x0/0xa3
 [<ffffffff8126aa30>] ? nofill+0x0/0x10
 [<ffffffff81c228d2>] ? unpack_to_rootfs+0x1d9/0x2ec
 [<ffffffff81c21995>] ? error+0x0/0x17
 [<ffffffff81c4e381>] ? pci_apply_final_quirks+0x0/0x35
 [<ffffffff81c22a88>] ? populate_rootfs+0x0/0xd3
 [<ffffffff81c22ae3>] ? populate_rootfs+0x5b/0xd3
 [<ffffffff8100204c>] ? do_one_initcall+0x3c/0x1d0
 [<ffffffff81c1f8cb>] ? kernel_init+0x29d/0x2f9
 [<ffffffff8100c14a>] ? child_rip+0xa/0x20
 [<ffffffff81c1f62e>] ? kernel_init+0x0/0x2f9
 [<ffffffff8100c140>] ? child_rip+0x0/0x20


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

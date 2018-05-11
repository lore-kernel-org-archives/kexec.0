Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [223.203.96.7] (helo=barracuda.hxt-semitech.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fH175-0007tU-Mo
 for kexec@lists.infradead.org; Fri, 11 May 2018 06:01:12 +0000
From: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Subject: [PATCH] How to validate this patch
Date: Fri, 11 May 2018 14:00:26 +0800
Message-ID: <1526018427-8710-1-git-send-email-yanjiang.jin@hxt-semitech.com>
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
To: kexec@lists.infradead.org
Cc: yanjiang.jin@hxt-semitech.com, jinyanjiang@gmail.com, horms@verge.net.au

I have a arm64 system, I can find the virtural memory layout during booting:

Virtual kernel memory layout:
.............................
    memory  : 0xffff800000200000 - 0xffff801800000000   ( 98302 MB)

Then I can read the elf_info in vmcore:

readelf -l vmcore

Program Headers:
Type Offset             VirtAddr           PhysAddr            FileSize
...............................................................................

LOAD 0x0000000076d40000 0xffff80017fe00000 0x0000000180000000 0x0000001680000000

The end of vmcore's VirtAddr is

(0xffff80017fe00000 + 0x0000001680000000) = 0xFFFF8017FFE00000

The end of vmlinux's VirtAddr is

0xffff801800000000

They have 0x20000 offset.

If we use vmcore-dmesg to read the log_buf from vmcore, we would get
the below error:

vmcore-dmesg vmcore

"No program header covering vaddr 0xffff8017ffe90000 found kexec bug?"

Since on my system, log_buf is in 0xffff8017ffe90000, it exceeds the end
of vmcore VirtAddr.

With my patch, vmcore-dmesg can read all dmesg info happily.

Yanjiang Jin (1):
  arm64: update PHYS_OFFSET to conform to kernel

 kexec/arch/arm64/kexec-arm64.c | 100 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

--
1.8.3.1




This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

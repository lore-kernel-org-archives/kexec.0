Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h2vKD-0007Nu-VS
 for kexec@lists.infradead.org; Sun, 10 Mar 2019 10:05:00 +0000
Received: by mail-pf1-f195.google.com with SMTP id g6so1470201pfh.13
 for <kexec@lists.infradead.org>; Sun, 10 Mar 2019 03:04:57 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 1/2] arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
Date: Sun, 10 Mar 2019 15:34:01 +0530
Message-Id: <1552212242-9479-2-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, kexec@lists.infradead.org, bhsharma@redhat.com, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

With ARMv8.2-LVA architecture extension availability, arm64 hardware
which supports this extension can support a virtual address-space upto
52-bits.

Since at the moment we enable the support of this extension in kernel
via CONFIG flags, e.g.
 - User-space 52-bit LVA via CONFIG_ARM64_USER_VA_BITS_52

so, there is no clear mechanism in the user-space right now to
determine these CONFIG flag values and hence determine the maximum
virtual address space supported by the underlying kernel.

User-space tools like 'makedumpfile' therefore are broken currently
as they have no proper method to calculate the 'PTRS_PER_PGD' value
which is required to perform a page table walk to determine the
physical address of a corresponding virtual address found in
kcore/vmcoreinfo.

If one appends 'PTRS_PER_PGD' number to vmcoreinfo for arm64,
it can be used in user-space to determine the maximum virtual address
supported by underlying kernel.

A reference 'makedumpfile' implementation which uses this approach to
determining the maximum physical address is available in [0].

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-va-support-via-vmcore-upstream-v3/arch/arm64.c#L459

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Steve Capper <Steve.Capper@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/kernel/crash_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index ca4c3e12d8c5..123a42c56b8e 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -10,6 +10,7 @@
 void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(VA_BITS);
+	VMCOREINFO_NUMBER(PTRS_PER_PGD);
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
 	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
 						kimage_voffset);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

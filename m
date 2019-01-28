Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goDym-00024o-VZ
 for kexec@lists.infradead.org; Mon, 28 Jan 2019 20:58:07 +0000
Received: by mail-pf1-f193.google.com with SMTP id c73so8541570pfe.13
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2019 12:58:04 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 0/2] arm64: Expose physical and virtual address capabilities
 to user-space
Date: Tue, 29 Jan 2019 02:27:54 +0530
Message-Id: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, steve.capper@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, ard.biesheuvel@linaro.org, will.deacon@arm.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org, suzuki.poulose@arm.com

With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
supports these extensions can support upto 52-bit virtual and 52-bit
physical addresses respectively.

Since at the moment we enable the support of these extensions via CONFIG
flags, e.g.
 - LPA via CONFIG_ARM64_PA_BITS_52
   
there are no clear mechanisms in user-space right now to
deteremine these CONFIG flag values and also determine the PARange and
VARange address values.

This patchset proposes two mechanisms to provide a user/user-space
application more information on the same:

1. For a non-expert user, getting an idea about the virtual/physical
   address capabilities on an arm64 hardware via executing:
   $ cat /proc/cpuinfo

   can be quite useful as it provides a similar mechanism as available
   already on x86_64.

   PATCH 1/2 implements the same.

2. For a more involved user/user-space application, the Appendix I:
   Example in 'Documentation/arm64/cpu-feature-registers.txt' is pretty
   useful.

   If we can expose the PARange and VARange values via the MRS register
   reads to user-space, we can use them in user-space programs as a
   standard ABI.

   I already have a 'makedumpfile' user-space example that uses the same
   to determine ARMv8.2-LPA support. See [0].
   
   PATCH 2/2 implements the same.

[0]. https://github.com/bhupesh-sharma/makedumpfile/blob/9d7da4aad3efe79b448f48cc3454fcae46a316d6/arch/arm64.c#L499

Bhupesh Sharma (2):
  arm64: Expose address bits (physical/virtual) via cpuinfo
  arm64: Expose PARange via ID_AA64MMFR0_EL1 and VARange via
    ID_AA64MMFR2_EL1

 arch/arm64/include/asm/cpufeature.h | 59 ++++++++++++++++++++++++-------------
 arch/arm64/include/asm/sysreg.h     | 19 ++++++++++++
 arch/arm64/kernel/cpufeature.c      |  4 +--
 arch/arm64/kernel/cpuinfo.c         |  4 ++-
 4 files changed, 63 insertions(+), 23 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iT08R-0004OB-NP
 for kexec@lists.infradead.org; Fri, 08 Nov 2019 09:00:53 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/3 v9] x86/kdump: Fix 'kmem -s' reported an invalid
 freepointer when SME was active
Date: Fri,  8 Nov 2019 17:00:24 +0800
Message-Id: <20191108090027.11082-1-lijiang@redhat.com>
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
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

In purgatory(), the main things are as below:

[1] verify sha256 hashes for various segments.
    Lets keep these codes, and do not touch the logic.

[2] copy the first 640k content to a backup region.
    Lets safely remove it and clean all code related to backup region.

This patch series will remove the backup region, because the current
handling of copying the first 640k runs into problems when SME is
active(https://bugzilla.kernel.org/show_bug.cgi?id=204793).

The low 1M region will always be reserved when the crashkernel kernel
command line option is specified. And this way makes it unnecessary to
do anything with the low 1M region, because the memory allocated later
won't fall into the low 1M area.

This series includes three patches:
[1] x86/kdump: always reserve the low 1M when the crashkernel option
    is specified
    The low 1M region will always be reserved when the crashkernel
    kernel command line option is specified, which ensures that the
    memory allocated later won't fall into the low 1M area.

[2] x86/kdump: clean up all the code related to the backup region
    Remove the backup region and clean up.

[3] kexec: Fix i386 build warnings that missed declaration of struct
    kimage

Changes since v1:
[1] Add extra checking condition: when the crashkernel option is
    specified, reserve the low 640k area.

Changes since v2:
[1] Reserve the low 1M region when the crashkernel option is only
    specified.(Suggested by Eric)

[2] Remove the unused crash_copy_backup_region()

[3] Remove the backup region and clean up

[4] Split them into three patches

Changes since v3:
[1] Improve the first patch's log

[2] Improve the third patch based on Eric's suggestions

Changes since v4:
[1] Correct some typos, and also improve the first patch's log

[2] Add a new function kexec_reserve_low_1MiB() in kernel/kexec_core.c
    and which is called by reserve_real_mode(). (Suggested by Boris)

Changes since v5:
[1] Call the cmdline_find_option() instead of strstr() to check the
    crashkernel option. (Suggested by Hatayama)

[2] Add a weak function kexec_reserve_low_1MiB() in kernel/kexec_core.c,
    and implement the kexec_reserve_low_1MiB() in arch/x86/kernel/
    machine_kexec_64.c so that it does not cause the compile error
    on non-x86 kernel, and also ensures that it can work well on x86
    kernel.

Changes since v6:
[1] Move the kexec_reserve_low_1MiB() to arch/x86/kernel/crash.c and
    also move its declaration function to arch/x86/include/asm/crash.h
    (Suggested by Dave Young)

[2] Adjust the corresponding header files.

Changes since v7:
[1] Change the function name from kexec_reserve_low_1MiB() to
    crash_reserve_low_1M().

[2] Fix some warnings reported by kduild.

Changes since v8:
[1] Fix some build warnings reported by kbuild and make it as a separate
    patch.

Lianbo Jiang (3):
  x86/kdump: always reserve the low 1M when the crashkernel option is
    specified
  x86/kdump: clean up all the code related to the backup region
  kexec: Fix i386 build warnings that missed declaration of struct
    kimage

 arch/x86/include/asm/crash.h       |   8 +++
 arch/x86/include/asm/kexec.h       |  10 ---
 arch/x86/include/asm/purgatory.h   |  10 ---
 arch/x86/kernel/crash.c            | 102 ++++++++---------------------
 arch/x86/kernel/machine_kexec_64.c |  47 -------------
 arch/x86/purgatory/purgatory.c     |  19 ------
 arch/x86/realmode/init.c           |   2 +
 7 files changed, 36 insertions(+), 162 deletions(-)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

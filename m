Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eybuf-0003J2-S7
 for kexec@lists.infradead.org; Wed, 21 Mar 2018 11:28:37 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LBRUW7025019
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:00 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gumf0ngs3-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:00 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 11:27:57 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH v2 00/11] kexec_file: Clean up purgatory load
Date: Wed, 21 Mar 2018 12:27:40 +0100
MIME-Version: 1.0
Message-Id: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hi everybody

here is the updated patch set including Dave's comments.

Changes v1 -> v2:
	* Fix missing memcpy and memset definition in x86 purgatory
	introduced by moving the sha256 implementation to common code.
	* Update subject of patches #7-9 to be more precise.
	* Add missing semicolon in patch #7 found by kbuild bot.
	* Fix compile warnings found by kbuild bot by moving all kexec_file
	specific function declarations into a 'ifdef CONFIG_KEXEC_FILE'
	block (patch #5 and #10).

Thanks
Philipp

---

Hi everybody

following the discussion with Dave and AKASHI, here are the common code
patches extracted from my recent patch set (Add kexec_file_load support to
s390) [1]. The patches were extracted to allow upstream integration together
with AKASHI's common code patches before the arch code gets adjusted to the
new base.

The reason for this series is to prepare common code for adding
kexec_file_load to s390 as well as cleaning up the mis-use of the sh_offset
field during purgatory load. In detail this series contains:

Patch #1&2: Minor cleanups/fixes.

Patch #3-9: Clean up the purgatory load/relocation code. Especially remove
the mis-use of the purgatory_info->sechdrs->sh_offset field, currently
holding a pointer into either kexec_purgatory (ro) or purgatory_buf (rw)
depending on the section. With these patches the section address will be
calculated verbosely and sh_offset will contain the offset of the section
in the stripped purgatory binary (purgatory_buf).

Patch #10: Allows architectures to set the purgatory load address. This
patch is important for s390 as the kernel and purgatory have to be loaded
to fixed addresses. In current code this is impossible as the purgatory
load is opaque to the architecture.

Patch #11: Moves x86 purgatories sha implementation to common lib/
directory to allow reuse in other architectures.

The patches apply to v4.16-rc3. There are no changes compared to [1] (all
requested changes only affected s390 code). Please note that I had to touch
arch code for x86 and power a little. In theory this should not change the
behavior but I don't have a way to test it. Cross-compiling with
defconfig [2] works fine for both.

Thanks
Philipp

[1] http://lists.infradead.org/pipermail/kexec/2018-February/019926.html
[2] On x86 with the orc unwinder and stack validation turned off. objtool
    SEGFAULTs on s390...

Philipp Rudo (11):
  kexec_file: Silence compile warnings
  kexec_file: Remove checks in kexec_purgatory_load
  kexec_file: Make purgatory_info->ehdr const
  kexec_file: Search symbols in read-only kexec_purgatory
  kexec_file: Use read-only sections in arch_kexec_apply_relocations*
  kexec_file: Split up __kexec_load_puragory
  kexec_file: Remove unneeded for-loop in kexec_purgatory_setup_sechdrs
  kexec_file: Remove unneeded variables in kexec_purgatory_setup_sechdrs
  kexec_file: Remove mis-use of sh_offset field during purgatory load
  kexec_file: Allow archs to set purgatory load address
  kexec_file: Move purgatories sha256 to common code

 arch/powerpc/kernel/kexec_elf_64.c             |   9 +-
 arch/x86/kernel/kexec-bzimage64.c              |   8 +-
 arch/x86/kernel/machine_kexec_64.c             |  66 ++---
 arch/x86/purgatory/Makefile                    |   3 +
 arch/x86/purgatory/purgatory.c                 |   2 +-
 arch/x86/purgatory/string.c                    |  12 +
 include/linux/kexec.h                          |  49 ++--
 {arch/x86/purgatory => include/linux}/sha256.h |  11 +-
 kernel/kexec_file.c                            | 379 ++++++++++++-------------
 {arch/x86/purgatory => lib}/sha256.c           |   4 +-
 10 files changed, 267 insertions(+), 276 deletions(-)
 rename {arch/x86/purgatory => include/linux}/sha256.h (62%)
 rename {arch/x86/purgatory => lib}/sha256.c (99%)

-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Ji4-0005vW-UZ
 for kexec@lists.infradead.org; Fri, 29 Jan 2021 02:40:33 +0000
Received: by mail-pg1-x533.google.com with SMTP id z21so5647879pgj.4
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2021 18:40:31 -0800 (PST)
From: kazuhito.hagio@gmail.com
Subject: [PATCH 0/3] makedumpfile/arm64: support flipped VA and 52-bit kernel
 VA
Date: Fri, 29 Jan 2021 11:40:22 +0900
Message-Id: <1611888025-29321-1-git-send-email-kazuhito.hagio@gmail.com>
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
To: bhupesh.linux@gmail.com, piliu@redhat.com, kexec@lists.infradead.org

Pingfan, Bhupesh and arm64 folks,

Here is a modified series for arm64 5.4+ kernels.
I would like to proceed with this if no big issue, i.e. a regression.

changes from the RFC series:
- remove get_elf_loads() no longer used
- remove unnecessary 3/4 patch
- add get_kvbase_arm64() change
- add commit messages

Kazuhito Hagio (3):
  Use vmcoreinfo note in /proc/kcore for --mem-usage option
  arm64: Make use of NUMBER(VA_BITS) in vmcoreinfo
  arm64: support flipped VA and 52-bit kernel VA

 arch/arm64.c   | 159 +++++++++++++++++++++++++++++++++++++++++++++------------
 elf_info.c     |  49 ------------------
 elf_info.h     |   1 -
 makedumpfile.c |  28 ++++++++--
 makedumpfile.h |   1 +
 5 files changed, 149 insertions(+), 89 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

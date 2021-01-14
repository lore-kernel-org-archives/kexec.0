Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzxwU-0006wb-3p
 for kexec@lists.infradead.org; Thu, 14 Jan 2021 08:25:19 +0000
Received: by mail-pj1-x1035.google.com with SMTP id w1so4303669pjc.0
 for <kexec@lists.infradead.org>; Thu, 14 Jan 2021 00:25:15 -0800 (PST)
From: kazuhito.hagio@gmail.com
Subject: [RFC PATCH 0/4] makedumpfile/arm64: support flipped VA and 52-bit
 kernel VA
Date: Thu, 14 Jan 2021 17:25:05 +0900
Message-Id: <1610612709-18887-1-git-send-email-kazuhito.hagio@gmail.com>
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
To: bhsharma@redhat.com, bhupesh.linux@gmail.com, alexander.kamensky42@gmail.com, piliu@redhat.com, kexec@lists.infradead.org
Cc: aadiga@qti.qualcomm.com, ioanna-maria.alifieraki@canonical.com

Hi Bhupesh, Alexander, Pingfan and arm64 guys,

I've rewritten Bhupesh's v5 patch [1] in order to avoid some limitations and
now this patchset
- can be built on some old arm64 environments hopefully,
- can be built on x86_64 machines with TARGET=aarch64,
- can process vmcores on different version of kernel from captured version.

Could you test this?  The patchset is also on GitHub [2] and the commit
messages are to be written later.

However the following conditions are probably not supported:
- 5.11-rc is not taken into account
- 5.4 <= kernels <= 5.8 (*1)
  * if PA_BITS=52 && VA_BITS!=52
  * with -x option if vabits_actual=52
- kernels < 5.4 with CONFIG_ARM64_USER_VA_BITS_52=y (e.g. RHEL8 kernels)

(*1) supported with kernel commit bbdbc11804ff and 1d50e5d0c5052.

I think especially MAX_PHYSMEM_BITS cannot be guessed correctly only with
the entries in vmcoreinfo (even with Bhupesh's original patch), so basically
I would like distributions that uses 5.4 to 5.8 to backport Bhupesh's kernel
patches above if the patchset does not work well.

[1] http://lists.infradead.org/pipermail/kexec/2020-September/021336.html
[2] https://github.com/k-hagio/makedumpfile/commits/arm64.kh.test2

Kazuhito Hagio (4):
  Use ELF vmcoreinfo note for --mem-usage option
  arm64: use NUMBER(VA_BITS) in vmcoreinfo
  Get kernel version from OSRELEASE in vmcoreinfo
  arm64: support flipped VA and 52-bit kernel VA

 arch/arm64.c   | 155 ++++++++++++++++++++++++++++++++++++++++++++-------------
 makedumpfile.c |  32 ++++++++++--
 makedumpfile.h |   1 +
 3 files changed, 149 insertions(+), 39 deletions(-)

-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

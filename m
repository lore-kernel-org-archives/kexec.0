Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4zBl-00081t-UI
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 16:23:42 +0000
Received: by vws3 with SMTP id 3so1969792vws.36
	for <kexec@lists.infradead.org>; Thu, 22 Apr 2010 09:23:39 -0700 (PDT)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: [PATCH 0/5] Add second memory region for crash kernel
Date: Thu, 22 Apr 2010 18:23:07 +0200
Message-Id: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Patch applies to 2.6.34-rc5

On x86 platform, even if hardware is 64-bit capable, kernel starts
execution in 32-bit mode. When system is kdump-enabled, crashed kernel
switches to 32 bit mode and jumps into new kernel. This automatically
limits location of dump-capture kernel image and it's initrd by first
4Gb of memory. Switching to 32 bit mode is performed by purgatory
code, which has relocations of type R_X86_64_32S (32-bit signed), and
this cuts "good" address space for crash kernel down to 2 Gb. I/O
regions may cut down this space further.

When system has a lot of memory (hundreds of gigabytes), dump-capture
kernel also needs relatively a lot of memory to account old kernel's
pages. It may be impossible to reserve enough memory below 2 or even 4
Gb. Simplest solution is it break dump-capture kernel's reserved
memory region into two pieces: first (small) region for kernel and
initrd images may be easily placed in "good" address space in the
beginning of physical memory, and second region may be located
anywhere.

This serie of patches realizes this approach. It requires also changes
in kexec utility to make this feature work, but is
backward-compatible: old versions of kexec will work with new
kernel. I will post patch to kexec-tools upstream separately.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>

 Documentation/kdump/kdump.txt       |   40 ++++++++
 Documentation/kernel-parameters.txt |   19 +++-
 arch/x86/kernel/setup.c             |   56 +++++++----
 include/linux/kexec.h               |    6 +
 kernel/kexec.c                      |  182 ++++++++++++++++++++++++++---------
 5 files changed, 232 insertions(+), 71 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXz1u-000457-P4
 for kexec@lists.infradead.org; Thu, 11 Aug 2016 23:04:51 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BN4HkO106129
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:04:29 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24ru30aht0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 19:04:29 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 20:04:27 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 0/2] extend kexec_file_load system call
Date: Thu, 11 Aug 2016 20:03:56 -0300
Message-Id: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, David Laight <David.Laight@ACULAB.COM>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

This patch series is from AKASHI Takahiro. I will use it in my next
version of the kexec_file_load implementation for powerpc, so I am
rebasing it on top of v4.8-rc1.

I dropped the patch which adds __NR_kexec_file_load to
<asm-generic/unistd.h> for simplicity, since the powerpc patches already
add it to powerpc's <asm/unistd.h>. I don't know which approach is
better.

The first patch in this series is unchanged from v1.

The second patch is the same one I posted on July 26th. It has the
following changes from v1:

- Added the arch_kexec_verify_buffer hook, where each architecture can
  verify if the DTB is safe to load.
- Renamed KEXEC_FILE_TYPE_DTB to KEXEC_FILE_TYPE_PARTIAL_DTB.
- Limited max number of fds to KEXEC_SEGMENT_MAX.
- Changed to use fixed size buffer for fdset instead of allocating it.
- Changed to return -EINVAL if an unknown file type is found in fdset.

I am also posting a new version of the kexec_file_load syscall
implementation for powerpc which uses the arch_kexec_verify_buffer hook
to enforce a whitelist of nodes and properties that userspace can pass to
the next kernel, as suggested by Michael Ellerman.

You can find it in a new patch in the powerpc series called
"powerpc: Allow userspace to set device tree properties in kexec_file_load"

Original cover letter:

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.

This patch extends kexec_file_load system call by adding an extra
argument to this syscall so that an arbitrary number of file descriptors
can be handed out from user space to the kernel.

See the background [1].

Please note that the new interface looks quite similar to the current
system call, but that it won't always mean that it provides the "binary
compatibility."

[1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html

AKASHI Takahiro (1):
  kexec: add dtb info to struct kimage

Thiago Jung Bauermann (1):
  kexec: extend kexec_file_load system call

 include/linux/fs.h         |  1 +
 include/linux/kexec.h      | 10 ++++--
 include/linux/syscalls.h   |  4 ++-
 include/uapi/linux/kexec.h | 22 ++++++++++++
 kernel/kexec_file.c        | 86 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 114 insertions(+), 9 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22f.google.com ([2607:f8b0:400e:c03::22f])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bMmdc-0004fD-8U
 for kexec@lists.infradead.org; Tue, 12 Jul 2016 01:37:28 +0000
Received: by mail-pa0-x22f.google.com with SMTP id ks6so795845pab.0
 for <kexec@lists.infradead.org>; Mon, 11 Jul 2016 18:37:07 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 0/3] extend kexec_file_load system call
Date: Tue, 12 Jul 2016 10:41:58 +0900
Message-Id: <20160712014201.11456-1-takahiro.akashi@linaro.org>
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
To: ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com, bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

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


AKASHI Takahiro (3):
  syscall: add kexec_file_load to generic unistd.h
  kexec: add dtb info to struct kimage
  kexec: extend kexec_file_load system call

 include/linux/fs.h                |  1 +
 include/linux/kexec.h             |  5 +++-
 include/linux/syscalls.h          |  4 ++-
 include/uapi/asm-generic/unistd.h |  8 ++++-
 include/uapi/linux/kexec.h        | 17 +++++++++++
 kernel/kexec_file.c               | 62 ++++++++++++++++++++++++++++++++++-----
 6 files changed, 87 insertions(+), 10 deletions(-)

-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

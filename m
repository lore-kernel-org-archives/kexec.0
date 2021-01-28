Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5D51-0006lg-Uf
 for kexec@lists.infradead.org; Thu, 28 Jan 2021 19:35:49 +0000
Received: by mail-ot1-x32f.google.com with SMTP id i20so6323550otl.7
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2021 11:35:47 -0800 (PST)
MIME-Version: 1.0
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 28 Jan 2021 11:35:35 -0800
Message-ID: <CAP_N_Z8k_TXjbCL-mEF-OY37vB-wo8PVOoz85s3Qp6Q7yzQQVg@mail.gmail.com>
Subject: Makedumpfile compile errors on Debian 10
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
To: kexec <kexec@lists.infradead.org>

Hi there,

I tried to compile version 1.6.7 and master on Debian 10 and got
following error:

root@gitlab-runner-stretch:/home/gitlab-runner/makedumpfile-master# make
cc  -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-D_LARGEFILE64_SOURCE -DVERSION='"1.6.8++"' -DRELEASE_DATE='"16 Nov
2020"' -D__x86_64__   print_info.
o dwarf_info.o elf_info.o erase_info.o sadump_info.o cache.o tools.o
printk.o arch/arm.o arch/arm64.o arch/x86.o arch/x86_64.o arch/ia64.o
arch/ppc64.o arch/s390
x.o arch/ppc.o arch/sparc64.o -rdynamic -o makedumpfile makedumpfile.c
-lpthread -static -ldw -lbz2 -ldl -lelf -lz -llzma  -lebl
/usr/bin/ld: erase_info.o: in function `process_eppic_file':
/home/gitlab-runner/makedumpfile-master/erase_info.c:2202: warning:
Using 'dlopen' in statically linked applications requires at runtime
the shared libraries fro
m the glibc version used for linking
/usr/bin/ld: //usr/local/lib/libdw.a(dwarf_abbrev_hash.o): in function
`Dwarf_Abbrev_Hash_insert':
/home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
undefined reference to `pthread_rwlock_tryrdlock'
/usr/bin/ld: /home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
undefined reference to `pthread_rwlock_tryrdlock'
/usr/bin/ld: /home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
undefined reference to `pthread_rwlock_tryrdlock'
/usr/bin/ld: //usr/local/lib/libdw.a(dwarf_abbrev_hash.o): in function
`Dwarf_Abbrev_Hash_find':
/home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:461:
undefined reference to `pthread_rwlock_tryrdlock'
/usr/bin/ld: //usr/local/lib/libdw.a(dwarf_sig8_hash.o): in function
`Dwarf_Sig8_Hash_insert':
/home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
undefined reference to `pthread_rwlock_tryrdlock'
/usr/bin/ld: //usr/local/lib/libdw.a(dwarf_sig8_hash.o):/home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
more undefined referenc
es to `pthread_rwlock_tryrdlock' follow
collect2: error: ld returned 1 exit status
make: *** [Makefile:100: makedumpfile] Error 1
To fix it, I have to make the following change:
diff --git a/Makefile b/Makefile
index 388faf7..7006f81 100644
--- a/Makefile
+++ b/Makefile
@@ -65,7 +65,7 @@ LIBS := -lsnappy $(LIBS)
 CFLAGS += -DUSESNAPPY
 endif

-LIBS := -lpthread $(LIBS)
+LIBS := $(LIBS) -lpthread

 try-run = $(shell set -e;              \
        TMP=".$$$$.tmp";                \
Not sure if it is an issue of Debian or makedumpfile. If it is the
latter, please fix the Makefile. Thanks.
Also, I tried the master and version 1.6.7 on Linux kernel 5.10 and
got a kernel not supported error. Do we know when 5.10 will be
supported? Thanks.

Regards,

Jiang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

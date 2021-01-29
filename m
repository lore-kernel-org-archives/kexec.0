Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410057.outbound.protection.outlook.com
 ([40.107.141.57] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Lcq-00069i-ST
 for kexec@lists.infradead.org; Fri, 29 Jan 2021 04:43:19 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: Makedumpfile compile errors on Debian 10
Date: Fri, 29 Jan 2021 04:43:10 +0000
Message-ID: <OSBPR01MB1991FCB292F9584678AB01A9DDB99@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <CAP_N_Z8k_TXjbCL-mEF-OY37vB-wo8PVOoz85s3Qp6Q7yzQQVg@mail.gmail.com>
In-Reply-To: <CAP_N_Z8k_TXjbCL-mEF-OY37vB-wo8PVOoz85s3Qp6Q7yzQQVg@mail.gmail.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "Jiang Wang ." <jiang.wang@bytedance.com>, kexec <kexec@lists.infradead.org>

Hi Jiang,

-----Original Message-----
> Hi there,
> 
> I tried to compile version 1.6.7 and master on Debian 10 and got
> following error:
> 
> root@gitlab-runner-stretch:/home/gitlab-runner/makedumpfile-master# make
> cc  -g -O2 -Wall -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -D_LARGEFILE64_SOURCE -DVERSION='"1.6.8++"' -DRELEASE_DATE='"16 Nov
> 2020"' -D__x86_64__   print_info.
> o dwarf_info.o elf_info.o erase_info.o sadump_info.o cache.o tools.o
> printk.o arch/arm.o arch/arm64.o arch/x86.o arch/x86_64.o arch/ia64.o
> arch/ppc64.o arch/s390
> x.o arch/ppc.o arch/sparc64.o -rdynamic -o makedumpfile makedumpfile.c
> -lpthread -static -ldw -lbz2 -ldl -lelf -lz -llzma  -lebl
> /usr/bin/ld: erase_info.o: in function `process_eppic_file':
> /home/gitlab-runner/makedumpfile-master/erase_info.c:2202: warning:
> Using 'dlopen' in statically linked applications requires at runtime
> the shared libraries fro
> m the glibc version used for linking
> /usr/bin/ld: //usr/local/lib/libdw.a(dwarf_abbrev_hash.o): in function
> `Dwarf_Abbrev_Hash_insert':
> /home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
> undefined reference to `pthread_rwlock_tryrdlock'
> /usr/bin/ld: /home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
> undefined reference to `pthread_rwlock_tryrdlock'
> /usr/bin/ld: /home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
> undefined reference to `pthread_rwlock_tryrdlock'
> /usr/bin/ld: //usr/local/lib/libdw.a(dwarf_abbrev_hash.o): in function
> `Dwarf_Abbrev_Hash_find':
> /home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:461:
> undefined reference to `pthread_rwlock_tryrdlock'
> /usr/bin/ld: //usr/local/lib/libdw.a(dwarf_sig8_hash.o): in function
> `Dwarf_Sig8_Hash_insert':
> /home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsizehash_concurrent.c:394:
> undefined reference to `pthread_rwlock_tryrdlock'
> /usr/bin/ld:
> //usr/local/lib/libdw.a(dwarf_sig8_hash.o):/home/gitlab-runner/elfutils-0.182/libdw/../lib/dynamicsize
> hash_concurrent.c:394:
> more undefined referenc
> es to `pthread_rwlock_tryrdlock' follow
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:100: makedumpfile] Error 1
> To fix it, I have to make the following change:
> diff --git a/Makefile b/Makefile
> index 388faf7..7006f81 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -65,7 +65,7 @@ LIBS := -lsnappy $(LIBS)
>  CFLAGS += -DUSESNAPPY
>  endif
> 
> -LIBS := -lpthread $(LIBS)
> +LIBS := $(LIBS) -lpthread
> 
>  try-run = $(shell set -e;              \
>         TMP=".$$$$.tmp";                \
> Not sure if it is an issue of Debian or makedumpfile. If it is the
> latter, please fix the Makefile. Thanks.

Thanks for the report.

I'm not sure why it doesn't occur on my recent Fedora machine with
elfutils-0.182, but seems that -lpthread should be put after -ldw, so
the change looks good to me.

Would you post a formal patch?  or I can fix it with your tag
like Signed-off-by or Reported-by.

> Also, I tried the master and version 1.6.7 on Linux kernel 5.10 and
> got a kernel not supported error. Do we know when 5.10 will be
> supported? Thanks.

The latest is makedumpfile-1.6.8, but it was tested with up to kernel 5.9.
I've tested the current master with kernel 5.10 to 5.11-rc5 on x86_64,
it's ok so far.  The next version will support 5.10 officially and
will be released this spring or summer, but not scheduled yet.

Thanks,
Kazu


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

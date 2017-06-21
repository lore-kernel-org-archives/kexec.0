Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNbVV-0005We-OF
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 09:01:03 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5L8wWds113270
 for <kexec@lists.infradead.org>; Wed, 21 Jun 2017 05:00:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7jxgg4qj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Jun 2017 05:00:40 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 10:00:37 +0100
Date: Wed, 21 Jun 2017 11:00:31 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390/crash: Fix KEXEC_NOTE_BYTES definition
In-Reply-To: <1496974625-10891-1-git-send-email-xlpang@redhat.com>
References: <1496974625-10891-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Message-Id: <20170621110031.76c15516@TP-holzheu>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>, Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Mikhail Zaslonko <zaslonko@linux.vnet.ibm.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

Hi Xunlei,

Sorry for the late reply - I was on vacation up to now.
Give us some time to look into this issue.

Michael

Am Fri,  9 Jun 2017 10:17:05 +0800
schrieb Xunlei Pang <xlpang@redhat.com>:

> S390 KEXEC_NOTE_BYTES is not used by note_buf_t as before, which
> is now defined as follows:
>     typedef u32 note_buf_t[CRASH_CORE_NOTE_BYTES/4];
> It was changed by the CONFIG_CRASH_CORE feature.
> 
> This patch gets rid of all the old KEXEC_NOTE_BYTES stuff, and
> renames KEXEC_NOTE_BYTES to CRASH_CORE_NOTE_BYTES for S390.
> 
> Fixes: 692f66f26a4c ("crash: move crashkernel parsing and vmcore related code under CONFIG_CRASH_CORE")
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Cc: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
>  arch/s390/include/asm/kexec.h |  2 +-
>  include/linux/crash_core.h    |  7 +++++++
>  include/linux/kexec.h         | 11 +----------
>  3 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
> index 2f924bc..352deb8 100644
> --- a/arch/s390/include/asm/kexec.h
> +++ b/arch/s390/include/asm/kexec.h
> @@ -47,7 +47,7 @@
>   * Seven notes plus zero note at the end: prstatus, fpregset, timer,
>   * tod_cmp, tod_reg, control regs, and prefix
>   */
> -#define KEXEC_NOTE_BYTES \
> +#define CRASH_CORE_NOTE_BYTES \
>  	(ALIGN(sizeof(struct elf_note), 4) * 8 + \
>  	 ALIGN(sizeof("CORE"), 4) * 7 + \
>  	 ALIGN(sizeof(struct elf_prstatus), 4) + \
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index e9de6b4..dbc6e5c 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -10,9 +10,16 @@
>  #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
>  #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
> 
> +/*
> + * The per-cpu notes area is a list of notes terminated by a "NULL"
> + * note header.  For kdump, the code in vmcore.c runs in the context
> + * of the second kernel to combine them into one note.
> + */
> +#ifndef CRASH_CORE_NOTE_BYTES
>  #define CRASH_CORE_NOTE_BYTES	   ((CRASH_CORE_NOTE_HEAD_BYTES * 2) +	\
>  				     CRASH_CORE_NOTE_NAME_BYTES +	\
>  				     CRASH_CORE_NOTE_DESC_BYTES)
> +#endif
> 
>  #define VMCOREINFO_BYTES	   PAGE_SIZE
>  #define VMCOREINFO_NOTE_NAME	   "VMCOREINFO"
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 3ea8275..133df03 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -14,7 +14,6 @@
> 
>  #if !defined(__ASSEMBLY__)
> 
> -#include <linux/crash_core.h>
>  #include <asm/io.h>
> 
>  #include <uapi/linux/kexec.h>
> @@ -25,6 +24,7 @@
>  #include <linux/ioport.h>
>  #include <linux/module.h>
>  #include <asm/kexec.h>
> +#include <linux/crash_core.h>
> 
>  /* Verify architecture specific macros are defined */
> 
> @@ -63,15 +63,6 @@
>  #define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
> 
>  /*
> - * The per-cpu notes area is a list of notes terminated by a "NULL"
> - * note header.  For kdump, the code in vmcore.c runs in the context
> - * of the second kernel to combine them into one note.
> - */
> -#ifndef KEXEC_NOTE_BYTES
> -#define KEXEC_NOTE_BYTES	CRASH_CORE_NOTE_BYTES
> -#endif
> -
> -/*
>   * This structure is used to hold the arguments that are used when loading
>   * kernel binaries.
>   */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

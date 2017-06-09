Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dJBIm-0003o8-Lu
 for kexec@lists.infradead.org; Fri, 09 Jun 2017 04:13:38 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5948ljv036381
 for <kexec@lists.infradead.org>; Fri, 9 Jun 2017 00:13:13 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ayksgsrm4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 09 Jun 2017 00:13:13 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 9 Jun 2017 14:13:10 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v594D1nt7471504
 for <kexec@lists.infradead.org>; Fri, 9 Jun 2017 14:13:09 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v594CaI1014551
 for <kexec@lists.infradead.org>; Fri, 9 Jun 2017 14:12:36 +1000
Subject: Re: [PATCH] s390/crash: Fix KEXEC_NOTE_BYTES definition
References: <1496974625-10891-1-git-send-email-xlpang@redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 9 Jun 2017 09:42:10 +0530
MIME-Version: 1.0
In-Reply-To: <1496974625-10891-1-git-send-email-xlpang@redhat.com>
Content-Language: en-US
Message-Id: <945499f7-3639-d803-adfe-8aa473695488@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Xunlei Pang <xlpang@redhat.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>, Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>, Dave Anderson <anderson@redhat.com>, Eric Biederman <ebiederm@xmission.com>, akpm@linux-foundation.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>



On Friday 09 June 2017 07:47 AM, Xunlei Pang wrote:
> S390 KEXEC_NOTE_BYTES is not used by note_buf_t as before, which
> is now defined as follows:
>      typedef u32 note_buf_t[CRASH_CORE_NOTE_BYTES/4];
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
>   arch/s390/include/asm/kexec.h |  2 +-
>   include/linux/crash_core.h    |  7 +++++++
>   include/linux/kexec.h         | 11 +----------
>   3 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
> index 2f924bc..352deb8 100644
> --- a/arch/s390/include/asm/kexec.h
> +++ b/arch/s390/include/asm/kexec.h
> @@ -47,7 +47,7 @@
>    * Seven notes plus zero note at the end: prstatus, fpregset, timer,
>    * tod_cmp, tod_reg, control regs, and prefix
>    */
> -#define KEXEC_NOTE_BYTES \
> +#define CRASH_CORE_NOTE_BYTES \
>   	(ALIGN(sizeof(struct elf_note), 4) * 8 + \
>   	 ALIGN(sizeof("CORE"), 4) * 7 + \
>   	 ALIGN(sizeof(struct elf_prstatus), 4) + \
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index e9de6b4..dbc6e5c 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -10,9 +10,16 @@
>   #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
>   #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
>
> +/*
> + * The per-cpu notes area is a list of notes terminated by a "NULL"
> + * note header.  For kdump, the code in vmcore.c runs in the context
> + * of the second kernel to combine them into one note.
> + */
> +#ifndef CRASH_CORE_NOTE_BYTES
>   #define CRASH_CORE_NOTE_BYTES	   ((CRASH_CORE_NOTE_HEAD_BYTES * 2) +	\
>   				     CRASH_CORE_NOTE_NAME_BYTES +	\
>   				     CRASH_CORE_NOTE_DESC_BYTES)
> +#endif
>
>   #define VMCOREINFO_BYTES	   PAGE_SIZE
>   #define VMCOREINFO_NOTE_NAME	   "VMCOREINFO"
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 3ea8275..133df03 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -14,7 +14,6 @@
>
>   #if !defined(__ASSEMBLY__)
>
> -#include <linux/crash_core.h>
>   #include <asm/io.h>
>
>   #include <uapi/linux/kexec.h>
> @@ -25,6 +24,7 @@
>   #include <linux/ioport.h>
>   #include <linux/module.h>
>   #include <asm/kexec.h>
> +#include <linux/crash_core.h>
>
>   /* Verify architecture specific macros are defined */
>
> @@ -63,15 +63,6 @@
>   #define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
>
>   /*
> - * The per-cpu notes area is a list of notes terminated by a "NULL"
> - * note header.  For kdump, the code in vmcore.c runs in the context
> - * of the second kernel to combine them into one note.
> - */
> -#ifndef KEXEC_NOTE_BYTES
> -#define KEXEC_NOTE_BYTES	CRASH_CORE_NOTE_BYTES
> -#endif
> -
> -/*
>    * This structure is used to hold the arguments that are used when loading
>    * kernel binaries.
>    */

Looks good to me. Thanks for the fix..

- Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

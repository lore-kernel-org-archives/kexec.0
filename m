Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SkQQT-00082I-U3
 for kexec@lists.infradead.org; Fri, 29 Jun 2012 01:55:15 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A74723EE0C0
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 10:55:06 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8BF0845DE51
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 10:55:06 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 63C4745DE56
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 10:55:06 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 576841DB8037
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 10:55:06 +0900 (JST)
Received: from m023.s.css.fujitsu.com (m023.s.css.fujitsu.com [10.0.81.63])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 028201DB803F
 for <kexec@lists.infradead.org>; Fri, 29 Jun 2012 10:55:06 +0900 (JST)
Date: Fri, 29 Jun 2012 10:54:42 +0900 (JST)
Message-Id: <20120629.105442.297827463.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v3 1/5] x86: Add helper variables and functions to hold
 VMCSINFO
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4FEAC9AE.4090001@cn.fujitsu.com>
References: <4FEAC945.50700@cn.fujitsu.com> <4FEAC9AE.4090001@cn.fujitsu.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei@cn.fujitsu.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, avi@redhat.com, gregkh@linuxfoundation.org, ebiederm@xmission.com

From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
Subject: [PATCH v3 1/5] x86: Add helper variables and functions to hold VMCSINFO
Date: Wed, 27 Jun 2012 16:51:58 +0800

> This patch provides a set of variables to hold the VMCSINFO and also
> some helper functions to help fill the VMCSINFO.
> 
> Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/vmcsinfo.h |  219 ++++++++++++++++++++++
>  arch/x86/include/asm/vmx.h      |  158 +----------------
>  arch/x86/kernel/Makefile        |    1 +
>  arch/x86/kernel/vmcsinfo.c      |  381 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 603 insertions(+), 156 deletions(-)
>  create mode 100644 arch/x86/include/asm/vmcsinfo.h
>  create mode 100644 arch/x86/kernel/vmcsinfo.c
> 
> diff --git a/arch/x86/include/asm/vmcsinfo.h b/arch/x86/include/asm/vmcsinfo.h
> new file mode 100644
> index 0000000..4b9f56b
> --- /dev/null
> +++ b/arch/x86/include/asm/vmcsinfo.h
> @@ -0,0 +1,219 @@
> +#ifndef _ASM_X86_VMCSINFO_H
> +#define _ASM_X86_VMCSINFO_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +#include <linux/elf.h>
> +#include <linux/device.h>
> +
> +/* VMCS Encodings */
> +enum vmcs_field {
> +	VIRTUAL_PROCESSOR_ID            = 0x00000000,

<cut>

> +	HOST_RIP                        = 0x00006c16,
> +};
> +
> +/*
> + * vmcs field offsets.
> + */
> +struct vmcsinfo {
> +	u32 vmcs_revision_id;
> +	int filled;
> +	u16 vmcs_field_to_offset_table[HOST_RIP + 1];

HOST_RIP is so large that this array becomes large. Also there are
unused elements in this array because field encoding is not indexed
constantly.

Instead, how about defining the numbr of vmcs fields, 152?, as a
specific constant, indexing each fields using integers and newly
preparing index_to_field_table[]?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

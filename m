Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B843FC00140
	for <kexec@archiver.kernel.org>; Mon,  8 Aug 2022 03:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1kNlORpSD6DJPxudjMXSwJ927lmqBWr9Lwzl0+q2RCw=; b=pbG9zUjDrIlrvF
	WNBs7F2mCY2HPmJhVfxsbsUd9HYnllynMYuR6TWJXAqTIsL/ldPVZoQ6JW76bVPmEQjzKN5hmo6Fj
	akINTtveX16/RFBILbNeSLSHNYtOs9W8RHl5d+iS10MaNhSMU0V/tEkwDgNnjv+iGv4dxMGy024To
	G6eyh05jgsxHVYOR38y4z2xcDQPr2AVJpcEOnk2MtYiqrd2+wiNs0Z1OzOrqUp82SSavJRsimTS/A
	qEu+Hr/Dja21x7jgbrVDV6Ylxvku0aU1XqO6c51KrG7Vb16tBWaY5GOsCaVxijGaFYD9Ip/wUMZpB
	foSnKsGTNdHMVrwENPPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKtPB-008gLt-V9; Mon, 08 Aug 2022 03:26:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKtP6-008gDD-1R
	for kexec@lists.infradead.org; Mon, 08 Aug 2022 03:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659929163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/5BnEPTRt6rS3Pj2Ddzn8CoW9Kgy2sGXbJADgHzxAY=;
	b=ejLGOXcoqtGo/Jj2Fva7CtPynsEx4+wBtsR9f9W76WINDC7ly2ujLrODUCQ7yVyTWIkO8g
	BkEum496BJ5xMvTQobXWTQmwpHLMhp6TGYDda5KTGpaGM4MzgBsVkufVvQiXoBF6ZXhnMQ
	B4L+9zGB57+Gf911HUJ6Bz+0vGXZoxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-eQ--1pkLO5-dLCOb0V4QhQ-1; Sun, 07 Aug 2022 23:25:51 -0400
X-MC-Unique: eQ--1pkLO5-dLCOb0V4QhQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16D2F80A0BF;
	Mon,  8 Aug 2022 03:25:50 +0000 (UTC)
Received: from localhost (ovpn-12-221.pek2.redhat.com [10.72.12.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6610994561;
	Mon,  8 Aug 2022 03:25:48 +0000 (UTC)
Date: Mon, 8 Aug 2022 11:25:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Message-ID: <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220721181747.1640-2-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_202608_200565_69D2BA9C 
X-CRM114-Status: GOOD (  19.06  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Eric,

On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> The use of __weak is being eliminated within kexec sources.
> The technique uses macros mapped onto inline functions in
> order to replace __weak.
> 
> This patchset was using __weak and so in order to replace
> __weak, this patch introduces arch/*/asm/crash.h, patterned
> after how kexec is moving away from __weak and to the macro
> definitions.

Are you going to replace __weak in kexec of arll ARCHes? I don't see
your point why all these empty header files are introduced. Wondering
what's impacted if not adding these empty files?

> 
> No functionality changed, yet.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>  arch/arm/include/asm/crash.h     | 5 +++++
>  arch/arm64/include/asm/crash.h   | 5 +++++
>  arch/ia64/include/asm/crash.h    | 5 +++++
>  arch/m68k/include/asm/crash.h    | 5 +++++
>  arch/mips/include/asm/crash.h    | 5 +++++
>  arch/parisc/include/asm/crash.h  | 5 +++++
>  arch/powerpc/include/asm/crash.h | 5 +++++
>  arch/riscv/include/asm/crash.h   | 5 +++++
>  arch/s390/include/asm/crash.h    | 5 +++++
>  arch/sh/include/asm/crash.h      | 5 +++++
>  include/linux/crash_core.h       | 2 ++
>  11 files changed, 52 insertions(+)
>  create mode 100644 arch/arm/include/asm/crash.h
>  create mode 100644 arch/arm64/include/asm/crash.h
>  create mode 100644 arch/ia64/include/asm/crash.h
>  create mode 100644 arch/m68k/include/asm/crash.h
>  create mode 100644 arch/mips/include/asm/crash.h
>  create mode 100644 arch/parisc/include/asm/crash.h
>  create mode 100644 arch/powerpc/include/asm/crash.h
>  create mode 100644 arch/riscv/include/asm/crash.h
>  create mode 100644 arch/s390/include/asm/crash.h
>  create mode 100644 arch/sh/include/asm/crash.h
> 
> diff --git a/arch/arm/include/asm/crash.h b/arch/arm/include/asm/crash.h
> new file mode 100644
> index 000000000000..385646957d60
> --- /dev/null
> +++ b/arch/arm/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM_CRASH_H
> +#define _ASM_ARM_CRASH_H
> +
> +#endif /* _ASM_ARM_CRASH_H */
> diff --git a/arch/arm64/include/asm/crash.h b/arch/arm64/include/asm/crash.h
> new file mode 100644
> index 000000000000..ec8870c1ea49
> --- /dev/null
> +++ b/arch/arm64/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_CRASH_H
> +#define _ASM_ARM64_CRASH_H
> +
> +#endif /* _ASM_ARM64_CRASH_H */
> diff --git a/arch/ia64/include/asm/crash.h b/arch/ia64/include/asm/crash.h
> new file mode 100644
> index 000000000000..02a457cccda3
> --- /dev/null
> +++ b/arch/ia64/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_IA64_CRASH_H
> +#define _ASM_IA64_CRASH_H
> +
> +#endif /* _ASM_IA64_CRASH_H */
> diff --git a/arch/m68k/include/asm/crash.h b/arch/m68k/include/asm/crash.h
> new file mode 100644
> index 000000000000..ba6e412a1267
> --- /dev/null
> +++ b/arch/m68k/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_M68K_CRASH_H
> +#define _ASM_M68K_CRASH_H
> +
> +#endif /* _ASM_M68K_CRASH_H */
> diff --git a/arch/mips/include/asm/crash.h b/arch/mips/include/asm/crash.h
> new file mode 100644
> index 000000000000..35872522c574
> --- /dev/null
> +++ b/arch/mips/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_MIPS_CRASH_H
> +#define _ASM_MIPS_CRASH_H
> +
> +#endif /* _ASM_MIPS_CRASH_H */
> diff --git a/arch/parisc/include/asm/crash.h b/arch/parisc/include/asm/crash.h
> new file mode 100644
> index 000000000000..96833b727179
> --- /dev/null
> +++ b/arch/parisc/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_PARISC_CRASH_H
> +#define _ASM_PARISC_CRASH_H
> +
> +#endif /* _ASM_PARISC_CRASH_H */
> diff --git a/arch/powerpc/include/asm/crash.h b/arch/powerpc/include/asm/crash.h
> new file mode 100644
> index 000000000000..40ce71e56ac1
> --- /dev/null
> +++ b/arch/powerpc/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_CRASH_H
> +#define _ASM_POWERPC_CRASH_H
> +
> +#endif /* _ASM_POWERPC_CRASH_H */
> diff --git a/arch/riscv/include/asm/crash.h b/arch/riscv/include/asm/crash.h
> new file mode 100644
> index 000000000000..24f3aea99707
> --- /dev/null
> +++ b/arch/riscv/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_CRASH_H
> +#define _ASM_RISCV_CRASH_H
> +
> +#endif /* _ASM_RISCV_CRASH_H */
> diff --git a/arch/s390/include/asm/crash.h b/arch/s390/include/asm/crash.h
> new file mode 100644
> index 000000000000..0db16ad4c75f
> --- /dev/null
> +++ b/arch/s390/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_S390_CRASH_H
> +#define _ASM_S390_CRASH_H
> +
> +#endif /* _ASM_S390_CRASH_H */
> diff --git a/arch/sh/include/asm/crash.h b/arch/sh/include/asm/crash.h
> new file mode 100644
> index 000000000000..f54e12f88cae
> --- /dev/null
> +++ b/arch/sh/include/asm/crash.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_SH_CRASH_H
> +#define _ASM_SH_CRASH_H
> +
> +#endif /* _ASM_SH_CRASH_H */
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..cb0f1916fbf5 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -6,6 +6,8 @@
>  #include <linux/elfcore.h>
>  #include <linux/elf.h>
>  
> +#include <asm/crash.h>
> +
>  #define CRASH_CORE_NOTE_NAME	   "CORE"
>  #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
>  #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25158C02184
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4iRvRLz910hdXyYaCP3vNWFz8TlsaL0KB+8OP0sL8c=; b=LucNVDG5MU/xPyEkMYb1ZmgeYA
	S1qynA7HurcQKreDChyWAXiofL9/LtZWjEDRCNwOf+sxYef15DDhoFsxp//vZn6+4KYAC/v10a4wa
	j+S4m9neeS6bovXySU+1IsXyP6YkMkt0PxAhXzAp8FOzSWU4GkrV1tb34QryLKHas5VQjj0RIbhmQ
	Gwbq5Akbr995cPWk4SgdaTU+iNcm1G4pM1RiahlymFG130qFaal1qBnFdukk12kHb/VvPNJQpoMws
	ni7YgPuDxB37xQFxSC0uXY5R3OCciXA6JoSLbL6nwKc3UQlzQjIXFkNQ8ljgbNqgyIUmPb5qToIQl
	4qc97mtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfx2-00000008NfI-3jbL;
	Tue, 14 Jan 2025 12:23:20 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfx1-00000008Ne2-0VWQ
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 12:23:20 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04C731CC4;
	Tue, 14 Jan 2025 04:23:47 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1183E3F66E;
	Tue, 14 Jan 2025 04:23:15 -0800 (PST)
Date: Tue, 14 Jan 2025 12:23:13 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com
Subject: Re: [PATCH v4 4/6] crash: Use note name macros
Message-ID: <Z4ZXMUn34wS8vxbx@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-4-b3841fa0dcd9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-4-b3841fa0dcd9@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_042319_245472_9C0A62AB 
X-CRM114-Status: GOOD (  15.41  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sat, Jan 11, 2025 at 02:48:47PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  fs/proc/kcore.c             | 12 ++++++------
>  include/linux/vmcore_info.h |  2 +-
>  kernel/crash_core.c         |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index e376f48c4b8b..e5612313b8b4 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -34,8 +34,6 @@
>  #include <asm/sections.h>
>  #include "internal.h"
>  
> -#define CORE_STR "CORE"
> -
>  #ifndef ELF_CORE_EFLAGS
>  #define ELF_CORE_EFLAGS	0
>  #endif
> @@ -119,7 +117,9 @@ static size_t get_kcore_size(int *nphdr, size_t *phdrs_len, size_t *notes_len,
>  
>  	*phdrs_len = *nphdr * sizeof(struct elf_phdr);
>  	*notes_len = (4 * sizeof(struct elf_note) +
> -		      3 * ALIGN(sizeof(CORE_STR), 4) +
> +		      ALIGN(sizeof(NN_PRSTATUS), 4) +
> +		      ALIGN(sizeof(NN_PRPSINFO), 4) +
> +		      ALIGN(sizeof(NN_TASKSTRUCT), 4) +
>  		      VMCOREINFO_NOTE_NAME_BYTES +
>  		      ALIGN(sizeof(struct elf_prstatus), 4) +
>  		      ALIGN(sizeof(struct elf_prpsinfo), 4) +
> @@ -444,11 +444,11 @@ static ssize_t read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
>  			goto out;
>  		}
>  
> -		append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
> +		append_kcore_note(notes, &i, NN_PRSTATUS, NT_PRSTATUS, &prstatus,
>  				  sizeof(prstatus));
> -		append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
> +		append_kcore_note(notes, &i, NN_PRPSINFO, NT_PRPSINFO, &prpsinfo,
>  				  sizeof(prpsinfo));
> -		append_kcore_note(notes, &i, CORE_STR, NT_TASKSTRUCT, current,
> +		append_kcore_note(notes, &i, NN_TASKSTRUCT, NT_TASKSTRUCT, current,
>  				  arch_task_struct_size);
>  		/*
>  		 * vmcoreinfo_size is mostly constant after init time, but it
> diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
> index e1dec1a6a749..1672801fd98c 100644
> --- a/include/linux/vmcore_info.h
> +++ b/include/linux/vmcore_info.h
> @@ -8,7 +8,7 @@
>  
>  #define CRASH_CORE_NOTE_NAME	   "CORE"
>  #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
> -#define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
> +#define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
>  #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
>  
>  /*
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 078fe5bc5a74..335b8425dd4b 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -436,7 +436,7 @@ void crash_save_cpu(struct pt_regs *regs, int cpu)
>  	memset(&prstatus, 0, sizeof(prstatus));
>  	prstatus.common.pr_pid = current->pid;
>  	elf_core_copy_regs(&prstatus.pr_reg, regs);
> -	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
> +	buf = append_elf_note(buf, NN_PRSTATUS, NT_PRSTATUS,
>  			      &prstatus, sizeof(prstatus));
>  	final_note(buf);
>  }
> 
> -- 
> 2.47.1
> 
> 


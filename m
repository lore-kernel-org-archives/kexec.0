Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF163E77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4M9snT9qbDvQ88PdgmNC6RL0sxoR82CuhIh6v4YfX4A=; b=1qqzAl4y/bxZWODeZikEckZ3uV
	+QybE4by4jX5cHbTkSqWrE9H2+aoCxGGM38MzgvsJn1cT6YtYABGuYMPjwNPMHFWXvjFN2yekuvYH
	DVUtrXVCtfygRf53NoidLvGW5xO1UxY80V6UjiIqeYtnPjOxn5mGRoxvJlylKIiYDzv2oBY4B6BLM
	ZJWWSh/SLc+Scx2WyIdbUPtp5h1sy7yc5SmJ/fCVpL4bBYCrgQa+u+ybnz0JYnqMcpgO46wtBEcX8
	p/gBXTlaBhvL8NIyJnOy2GrJ4Nmt14DIM/WwRtWX6UxocGWhdoLLoW6DYK9OVEHGFdwsalk59Rh/F
	7Wl0VwMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfwV-00000008NS1-1jNE;
	Tue, 14 Jan 2025 12:22:47 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfwR-00000008NRf-3Hx5
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 12:22:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E61311FB;
	Tue, 14 Jan 2025 04:23:09 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E5BF3F66E;
	Tue, 14 Jan 2025 04:22:38 -0800 (PST)
Date: Tue, 14 Jan 2025 12:22:31 +0000
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
Subject: Re: [PATCH v4 1/6] elf: Define note name macros
Message-ID: <Z4ZXB2UJaZWOmshN@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-1-b3841fa0dcd9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-1-b3841fa0dcd9@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_042243_922514_3960961A 
X-CRM114-Status: GOOD (  25.25  )
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

Hi,

On Sat, Jan 11, 2025 at 02:48:44PM +0900, Akihiko Odaki wrote:
> elf.h had a comment saying:
> > Notes used in ET_CORE. Architectures export some of the arch register
> > sets using the corresponding note types via the PTRACE_GETREGSET and
> > PTRACE_SETREGSET requests.
> > The note name for these types is "LINUX", except NT_PRFPREG that is
> > named "CORE".
> 
> However, NT_PRSTATUS is also named "CORE". It is also unclear what
> "these types" refers to.
> 
> To fix these problems, define a name for each note type. The added
> definitions are macros so the kernel and userspace can directly refer to
> them.

I guess another motivation is to move towards having elf.h as the
single point of definition for the note names, so that obscure and
duplicate logic for determining note names can be removed.

(Could be worth adding a note on this is the patch is respun, but this
would be overkill otherwise...)


> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cec..343f5c40d03a 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -368,99 +368,179 @@ typedef struct elf64_shdr {
>  #define ELF_OSABI ELFOSABI_NONE
>  #endif
>  
> +/* Note definitions: NN_ defines names. NT_ defines types. */
> +
>  /*
>   * Notes used in ET_CORE. Architectures export some of the arch register sets
>   * using the corresponding note types via the PTRACE_GETREGSET and
>   * PTRACE_SETREGSET requests.
> - * The note name for these types is "LINUX", except NT_PRFPREG that is named
> - * "CORE".
>   */
> +#define NN_PRSTATUS	"CORE"
>  #define NT_PRSTATUS	1
> +#define NN_PRFPREG	"CORE"
>  #define NT_PRFPREG	2
> +#define NN_PRPSINFO	"CORE"
>  #define NT_PRPSINFO	3
> +#define NN_TASKSTRUCT	"CORE"
>  #define NT_TASKSTRUCT	4
> +#define NN_AUXV		"CORE"
>  #define NT_AUXV		6
>  /*
>   * Note to userspace developers: size of NT_SIGINFO note may increase
>   * in the future to accomodate more fields, don't assume it is fixed!
>   */
> +#define NN_SIGINFO      "CORE"
>  #define NT_SIGINFO      0x53494749
> +#define NN_FILE         "CORE"
>  #define NT_FILE         0x46494c45
> +#define NN_PRXFPREG     "LINUX"
>  #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */

[...]

> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
>  #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>  
> -/* Note types with note name "GNU" */
> +/* Note used in other file types. */

For this, it may make sense to be vaguer, e.g.

	/* Other notes */

(We don't dump NT_GNU_PROPERTY_TYPE_0 in coredumps, but I don't think
it would be nonsensical to do so.)

> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
>  #define NT_GNU_PROPERTY_TYPE_0	5

[...]

With or without those changes,

Reviewed-by: Dave Martin <Dave.Martin@arm.com>



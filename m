Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE03C02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQnotGj8O8dtIqdw3qds2F4aUxndTgIwthGYOjx9Xqw=; b=sxXTwA6M0AjG2LkzpTaiISZkZF
	GdWV+ZQmhFg0QSLl+KtdRIVc4TxgsxJmy7hWffAzDV3OjQ23gdpY14ZJjueL6rWt8PcZr81gWGqV8
	ipam8eQ3bEMfjnR6EhAn/D3fk4B/GZcRlsH4VLYquYaRmtGOtLF64W5RzARdPhj+oQnjBY3uaeSVw
	TT/RhvmvNvXX82gpaMOsm0sgi4k90PP2UOn0WYNtbUE208PcRxqzPhsuMdg7orbiuVFlg+VuTFb1E
	5Mz2dHWDd/5ZgZ4+ApTP7/3mWlmHhhCR3/21NOHZOzZ2pIkiWbQMzaDjJGGES2f7iefhO4H6bYC1u
	f1KYgyPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY6vm-0000000CYj4-0VcV;
	Wed, 15 Jan 2025 17:11:50 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY6vj-0000000CYi0-23WZ
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 17:11:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E6611FB;
	Wed, 15 Jan 2025 09:12:12 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A0F63F673;
	Wed, 15 Jan 2025 09:11:42 -0800 (PST)
Date: Wed, 15 Jan 2025 17:11:34 +0000
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
Subject: Re: [PATCH v5 1/6] elf: Define note name macros
Message-ID: <Z4fsRq4D4X5Qb+Dq@e133380.arm.com>
References: <20250115-elf-v5-0-0f9e55bbb2fc@daynix.com>
 <20250115-elf-v5-1-0f9e55bbb2fc@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-elf-v5-1-0f9e55bbb2fc@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_091147_571026_E726CB6D 
X-CRM114-Status: GOOD (  22.05  )
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

On Wed, Jan 15, 2025 at 02:47:58PM +0900, Akihiko Odaki wrote:
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
> them to remove their duplicate definitions of note names.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  include/uapi/linux/elf.h | 89 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cec..592507aa9b3a 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -368,101 +368,180 @@ typedef struct elf64_shdr {
>  #define ELF_OSABI ELFOSABI_NONE
>  #endif
>  
> +/* Note definitions: NN_ defines names. NT_ defines types. */
> +
> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
> +#define NT_GNU_PROPERTY_TYPE_0	5
> +

I guess this also works as a neutral way of saying that
NT_GNU_PROPERTY_TYPE_0 isn't _specifically_ for coredumps.

I would worry that moving this block is going to generate unwanted
context noise with other patches that may be in flight and add new
NT_ definitions.

But (a) changing the comments will cause that anyway, and
(b) if there are any new NT_ definitions in flight, we want people to
notice the conflict and add the accompanying NN_ definition.

So, perhaps context noise is not such a bad thing in this instance.

[...]

> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
>  #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>  
> -/* Note types with note name "GNU" */
> -#define NT_GNU_PROPERTY_TYPE_0	5
> -
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
>    Elf32_Word	n_namesz;	/* Name size */

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Cheers
---Dave


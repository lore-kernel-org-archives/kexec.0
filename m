Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4B1E77198
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 02:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDNMuGdRbtFXOEF4wgeAn1mDrtVJdeBZdGzWjrJ9xwA=; b=dR2BAtG7U/EXWQRCXwX7gnXpId
	CPR5tIF/U2ZIjH/JB9cYdwwaHzw8PuX5NbrF0iwWbFeZUAQd8JoZ2RCPHPke8xeImkFK2PDe7ZKbD
	4znamFmedZs3eLjyGDrxM4xJrSU5FySwPHc8ANjuL86fJWsWPlVdQhs03shGAwrHB0ZiFQpNJd2/b
	WetoS0xXxTLSHN2uefPP+zFtAOQnLjpIEsfq/yVCtZMjwCoWK/tSyD3sHzthDx2oMPBL2YRsIPC0Q
	8FoOmrU7SYDqKr83L/sboBodvJ3hg1BKI2k+s9xrUC7bbaTPq+XNBBU+vfJJrpjoxZTrk5mW7pgX6
	U2FT1Ydg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUckw-000000002GP-49DI;
	Mon, 06 Jan 2025 02:22:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUckr-000000002FY-2smc
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 02:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736130127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDNMuGdRbtFXOEF4wgeAn1mDrtVJdeBZdGzWjrJ9xwA=;
	b=Ctyd3z2sSCcfdarxXzjsemdA4OhEUpYBKBogz4+J2ZEgYIyaRisyy/07RFyQJudRZAJ7Gx
	OM04/zPjWCPPCXtKXgAw1PULHTN08HfOIXhoV4ylJjdscVh1IRGEdODaTwsgA1udZ8pH6G
	LB/PQ9YzVqB1+h/iVTHZA3NkOyc1sps=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-WPXHLyM9NlasFo14ZUzn-g-1; Sun,
 05 Jan 2025 21:22:04 -0500
X-MC-Unique: WPXHLyM9NlasFo14ZUzn-g-1
X-Mimecast-MFC-AGG-ID: WPXHLyM9NlasFo14ZUzn-g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DB7D19560A2;
	Mon,  6 Jan 2025 02:22:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7E113000197;
	Mon,  6 Jan 2025 02:21:57 +0000 (UTC)
Date: Mon, 6 Jan 2025 10:21:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, devel@daynix.com
Subject: Re: [PATCH v2 1/5] elf: Define note name macros
Message-ID: <Z3s+QeMv8AaGbMGs@MiWiFi-R3L-srv>
References: <20250104-elf-v2-0-77dc2e06db4e@daynix.com>
 <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104-elf-v2-1-77dc2e06db4e@daynix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_182209_804342_706E836E 
X-CRM114-Status: GOOD (  23.10  )
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

On 01/04/25 at 11:38pm, Akihiko Odaki wrote:
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
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/uapi/linux/elf.h | 86 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index b44069d29cec..014b705b97d7 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -372,8 +372,6 @@ typedef struct elf64_shdr {
>   * Notes used in ET_CORE. Architectures export some of the arch register sets
>   * using the corresponding note types via the PTRACE_GETREGSET and
>   * PTRACE_SETREGSET requests.
> - * The note name for these types is "LINUX", except NT_PRFPREG that is named
> - * "CORE".
>   */
>  #define NT_PRSTATUS	1
>  #define NT_PRFPREG	2
> @@ -460,9 +458,91 @@ typedef struct elf64_shdr {
>  #define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint registers */
>  #define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint registers */
>  
> -/* Note types with note name "GNU" */
> +/* Note used in ET_EXEC and ET_DYN. */
>  #define NT_GNU_PROPERTY_TYPE_0	5
>  
> +/* Note names */
> +#define NN_PRSTATUS	"CORE"
> +#define NN_PRFPREG	"CORE"
> +#define NN_PRPSINFO	"CORE"
> +#define NN_TASKSTRUCT	"CORE"
> +#define NN_AUXV	"CORE"
> +#define NN_SIGINFO	"CORE"
> +#define NN_FILE	"CORE"
> +#define NN_PRXFPREG	"LINUX"

No objection to make them clearer. Thanks for the effort.

Wondering where below arch specific macros are used. So you just
added all NN_xxx for the corresponding NT_xxx? Not sure if this is
needed if we don't use them at all in the current kernel.

> +#define NN_PPC_VMX	"LINUX"
> +#define NN_PPC_SPE	"LINUX"
> +#define NN_PPC_VSX	"LINUX"
> +#define NN_PPC_TAR	"LINUX"
> +#define NN_PPC_PPR	"LINUX"
> +#define NN_PPC_DSCR	"LINUX"
> +#define NN_PPC_EBB	"LINUX"
> +#define NN_PPC_PMU	"LINUX"
> +#define NN_PPC_TM_CGPR	"LINUX"
> +#define NN_PPC_TM_CFPR	"LINUX"
> +#define NN_PPC_TM_CVMX	"LINUX"
> +#define NN_PPC_TM_CVSX	"LINUX"
> +#define NN_PPC_TM_SPR	"LINUX"
> +#define NN_PPC_TM_CTAR	"LINUX"
> +#define NN_PPC_TM_CPPR	"LINUX"
> +#define NN_PPC_TM_CDSCR	"LINUX"
> +#define NN_PPC_PKEY	"LINUX"
> +#define NN_PPC_DEXCR	"LINUX"
> +#define NN_PPC_HASHKEYR	"LINUX"
> +#define NN_386_TLS	"LINUX"
> +#define NN_386_IOPERM	"LINUX"
> +#define NN_X86_XSTATE	"LINUX"
> +#define NN_X86_SHSTK	"LINUX"
> +#define NN_X86_XSAVE_LAYOUT	"LINUX"
> +#define NN_S390_HIGH_GPRS	"LINUX"
> +#define NN_S390_TIMER	"LINUX"
> +#define NN_S390_TODCMP	"LINUX"
> +#define NN_S390_TODPREG	"LINUX"
> +#define NN_S390_CTRS	"LINUX"
> +#define NN_S390_PREFIX	"LINUX"
> +#define NN_S390_LAST_BREAK	"LINUX"
> +#define NN_S390_SYSTEM_CALL	"LINUX"
> +#define NN_S390_TDB	"LINUX"
> +#define NN_S390_VXRS_LOW	"LINUX"
> +#define NN_S390_VXRS_HIGH	"LINUX"
> +#define NN_S390_GS_CB	"LINUX"
> +#define NN_S390_GS_BC	"LINUX"
> +#define NN_S390_RI_CB	"LINUX"
> +#define NN_S390_PV_CPU_DATA	"LINUX"
> +#define NN_ARM_VFP	"LINUX"
> +#define NN_ARM_TLS	"LINUX"
> +#define NN_ARM_HW_BREAK	"LINUX"
> +#define NN_ARM_HW_WATCH	"LINUX"
> +#define NN_ARM_SYSTEM_CALL	"LINUX"
> +#define NN_ARM_SVE	"LINUX"
> +#define NN_ARM_PAC_MASK	"LINUX"
> +#define NN_ARM_PACA_KEYS	"LINUX"
> +#define NN_ARM_PACG_KEYS	"LINUX"
> +#define NN_ARM_TAGGED_ADDR_CTRL	"LINUX"
> +#define NN_ARM_PAC_ENABLED_KEYS	"LINUX"
> +#define NN_ARM_SSVE	"LINUX"
> +#define NN_ARM_ZA	"LINUX"
> +#define NN_ARM_ZT	"LINUX"
> +#define NN_ARM_FPMR	"LINUX"
> +#define NN_ARM_POE	"LINUX"
> +#define NN_ARM_GCS	"LINUX"
> +#define NN_ARC_V2	"LINUX"
> +#define NN_VMCOREDD	"LINUX"
> +#define NN_MIPS_DSP	"LINUX"
> +#define NN_MIPS_FP_MODE	"LINUX"
> +#define NN_MIPS_MSA	"LINUX"
> +#define NN_RISCV_CSR	"LINUX"
> +#define NN_RISCV_VECTOR	"LINUX"
> +#define NN_RISCV_TAGGED_ADDR_CTRL	"LINUX"
> +#define NN_LOONGARCH_CPUCFG	"LINUX"
> +#define NN_LOONGARCH_CSR	"LINUX"
> +#define NN_LOONGARCH_LSX	"LINUX"
> +#define NN_LOONGARCH_LASX	"LINUX"
> +#define NN_LOONGARCH_LBT	"LINUX"
> +#define NN_LOONGARCH_HW_BREAK	"LINUX"
> +#define NN_LOONGARCH_HW_WATCH	"LINUX"
> +#define NN_GNU_PROPERTY_TYPE_0	"GNU"
> +
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
>    Elf32_Word	n_namesz;	/* Name size */
> 
> -- 
> 2.47.1
> 



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AF3E77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QgRj0BYJSuOYyejBeg4xTNx/mVIDbkxJCUcL08dHvZg=; b=TRpHqwx56TxlnsgxNIGuqNYcIW
	4VDTFhhvaEW55ihyeGzXWJtCwGwVnSqML5hUT42ppHkiWHVppoWQqT0gBdZtB7NL1rfEA09onqZz+
	U5VfMz93iHru1vB1C4ZG5pBsrgf5uz0dcnx/xeclnByTAIi8j/9X7yQws3zBDVQrh1zMPM6ysDFyX
	gtDkwrCnCj4WSKwzj5thCAoGLjgb0AzEc2LW3GakNB26m5bQUB6J18kY74wrZgPMGhfc7JeI5J3k3
	qu08dw32qFu2iCa7YM1SoCQSw5wXDmehqAvQr6ShSdRPd5ImeG6fWRQp5u8tGAo1cUQy1n1dbU2Nf
	ysD42XPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfxQ-00000008Nr3-2pi0;
	Tue, 14 Jan 2025 12:23:44 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfxN-00000008NpJ-3Fyz
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 12:23:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B66F412FC;
	Tue, 14 Jan 2025 04:24:09 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257BF3F66E;
	Tue, 14 Jan 2025 04:23:39 -0800 (PST)
Date: Tue, 14 Jan 2025 12:23:36 +0000
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
Subject: Re: [PATCH v4 6/6] crash: Remove KEXEC_CORE_NOTE_NAME
Message-ID: <Z4ZXSGk2XpE4H6lQ@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-6-b3841fa0dcd9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-6-b3841fa0dcd9@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_042341_857741_59552F6C 
X-CRM114-Status: GOOD (  14.25  )
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

On Sat, Jan 11, 2025 at 02:48:49PM +0900, Akihiko Odaki wrote:
> KEXEC_CORE_NOTE_NAME is no longer used.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> ---
>  include/linux/kexec.h       | 2 --
>  include/linux/vmcore_info.h | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..c840431eadda 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -68,8 +68,6 @@ extern note_buf_t __percpu *crash_notes;
>  #define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
>  #endif
>  
> -#define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
> -
>  /*
>   * This structure is used to hold the arguments that are used when loading
>   * kernel binaries.
> diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
> index 1672801fd98c..37e003ae5262 100644
> --- a/include/linux/vmcore_info.h
> +++ b/include/linux/vmcore_info.h
> @@ -6,7 +6,6 @@
>  #include <linux/elfcore.h>
>  #include <linux/elf.h>
>  
> -#define CRASH_CORE_NOTE_NAME	   "CORE"
>  #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
>  #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(NN_PRSTATUS), 4)
>  #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
> 
> -- 
> 2.47.1
> 
> 


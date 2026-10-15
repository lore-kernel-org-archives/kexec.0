Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B07ECC6B3A
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Noy49yD8e/Ob4wG2MgzxDSK75qjmJvYApwzUtIvu0QU=; b=dWRxqDPDJfI7jQCWX8BCeh/PDV
	f2kbew1K/XIyMRRltiS8SUpJh/ZTA65JIzpqdn5OMdfvD7EqLdrh3gTVtapuhu1Be1zA3rXS6DzC6
	6OCdTngAskZjzkdY8fi0DszSIf2ooWmkIXkNe777eRTdABwsBV99E5hQuDIfLH6pAn1P1XNzDG+1p
	JWt+seCBUSK4o4l4K5GqYyhFtSK6A3nK4hBQ2GGHSq+R9CWdZ6E4xPciQidBFOADmtlcJuFqFBBuy
	3MxdP3VOJB7y1oUIH2+m5MxuquFAZImj/+fBpdf8c1BFbDmq/8OrCQ5/WYvg7LLbFNYD9Bzt/ItCR
	9qHRJqFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHL9K-00000000DEm-3s0h;
	Thu, 15 Oct 2026 13:05:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHL9J-00000000DEd-0I6x;
	Thu, 15 Oct 2026 13:05:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3CA41601EF;
	Thu, 15 Oct 2026 13:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916351F000C4;
	Thu, 15 Oct 2026 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792069532;
	bh=Noy49yD8e/Ob4wG2MgzxDSK75qjmJvYApwzUtIvu0QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=X11q/huxrkAqwJCmxammjG0KJNkKW/HeV7vwW/AZE/pVPt4r02Y8MELs228K0/yCY
	 /+HUXERfLkTuOSjrnt/oZ0WlpjAWRdzH/0AyNkiysGhZWcD+btWG0ZGi3IgB8Y3a1s
	 +S1i6BhGLSMoxQxdZCVvgZ2iwCxrkEk9yxuIKESop73gfhNF9Y0LiK2JkwxnLmx5nm
	 e6NeKBeY8eX4MVKjA912aq4LlTWdCrk3zgICGY5v5V/GbQlkSUvYxVAe/0iq4cy/MR
	 nBu9T2bXCvWVziYbkRCLhinBob0P6L5+NrhuTkinqc1qqIkdjaEqwbttACABcjlvBN
	 w0EuAS2t5oUAw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Logan Odell <loganodell@google.com>
Cc: arnd@arndb.de,  pasha.tatashin@soleen.com,  rppt@kernel.org,
  pratyush@kernel.org,  graf@amazon.com,  akpm@linux-foundation.org,
  pbonzini@redhat.com,  maz@kernel.org,  oupton@kernel.org,
  seanjc@google.com,  bhelgaas@google.com,  alex@shazbot.org,
  jgg@nvidia.com,  kevin.tian@intel.com,  dwmw2@infradead.org,
  baolu.lu@linux.intel.com,  joro@8bytes.org,  will@kernel.org,
  robin.murphy@arm.com,  linux-arch@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  kvm@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  kvmarm@lists.linux.dev,
  linux-pci@vger.kernel.org,  iommu@lists.linux.dev
Subject: Re: [RFC PATCH 2/3] luo: Export feature support to vmlinux section
In-Reply-To: <20260903023452.721732-3-loganodell@google.com> (Logan Odell's
	message of "Wed, 2 Sep 2026 19:34:51 -0700")
References: <20260903023452.721732-1-loganodell@google.com>
	<20260903023452.721732-3-loganodell@google.com>
Date: Thu, 15 Oct 2026 15:05:26 +0200
Message-ID: <2vxzv773glm1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Logan,

On Wed, Sep 02 2026, Logan Odell wrote:

> Create a liveupdate_features section that contains the feature
> information for a given liveupdate component. Add the LUO component
> first. These can be compared between two kernels to determine live
> update compatibility. Features marked as required in the running kernel
> will need to have that feature marked as supported in the next kernel to
> be eligible for compatibility.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Logan Odell <loganodell@google.com>

I was thinking about this a bit more. We don't really ship the vmlinux
directly. On x86 it is a PE/COFF image, on arm64 the Image format strips
ELF information and is a raw binary file.

So this information would not be accessible to the kexec loader/luod. So
perhaps as part of the build we parse the section and output a file with
the versions? And then it can be packaged with the likes of System.map
for example?

> ---
>  include/asm-generic/vmlinux.lds.h | 12 +++++++++++
>  include/linux/kho/abi/luo.h       | 34 +++++++++++++++++++++++++++++++
>  include/linux/liveupdate.h        | 12 +++++++++++
>  kernel/liveupdate/luo_core.c      | 16 +++++++++++++++
>  4 files changed, 74 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5659f4b5a125..aed4e282a78c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -359,6 +359,17 @@
>  #define THERMAL_TABLE(name)
>  #endif
>  
> +#ifdef CONFIG_LIVEUPDATE
> +#define LIVEUPDATE_FEATURES						\
> +	. = ALIGN(8);							\
> +	.liveupdate_features : AT(ADDR(.liveupdate_features) - LOAD_OFFSET) {	\
> +		KEEP(*(.liveupdate_sec_hdr))				\
> +		KEEP(*(.liveupdate_features))				\
> +	}
> +#else
> +#define LIVEUPDATE_FEATURES
> +#endif
> +
>  #define KERNEL_DTB()							\
>  	STRUCT_ALIGN();							\
>  	__dtb_start = .;						\
> @@ -554,6 +565,7 @@
>  	RO_EXCEPTION_TABLE						\
>  	NOTES								\
>  	BTF								\
> +	LIVEUPDATE_FEATURES						\
>  									\
>  	. = ALIGN((align));						\
>  	__end_rodata = .;
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index 0a7662a0cf9a..5b25e1b48cf5 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -230,4 +230,38 @@ struct luo_flb_ser {
>  #define LIVEUPDATE_TEST_FLB_COMPATIBLE(i)	"liveupdate-test-flb-v" #i
>  #endif
>  
> +#define LIVEUPDATE_VER_HDR_MAGIC	0x4c565550 /* 'LVUP' */
> +#define LIVEUPDATE_VER_HDR_VER		1
> +
> +/**
> + * struct liveupdate_ver_hdr - Header of vmlinux section with version lists
> + * @magic:     Magic number ('LVUP').
> + * @version:   Version of the header format.
> + *
> + * This struct is the header for the vmlinux section ".liveupdate_features". The
> + * section contains the list of feature/version entries that the kernel supports.
> + */
> +struct liveupdate_ver_hdr {
> +	u32 magic;
> +	u32 version;

Should we do feature flags along with the version to extend in
backwards-compatible way?

> +} __packed;
> +
> +/**
> + * struct liveupdate_feature_entry - Live update feature/version entry
> + * @name:       Name of the subsystem or feature ("luo" for core).
> + * @feat_bytes: Number of bytes covered by supp, req, and active bitmaps (e.g. 8).
> + * @reserved:   Reserved / padding for alignment.
> + * @supp:       Bitmask of supported features.
> + * @req:        Bitmask of required features.
> + * @active:     Bitmask of active features.
> + */

How should we model FLB dependencies here? And how do we export FLB
capabilities?

> +struct liveupdate_feature_entry {
> +	char name[LIVEUPDATE_HNDL_COMPAT_LENGTH];
> +	u32 feat_bytes;
> +	u32 reserved;
> +	u64 supp;
> +	u64 req;
> +	u64 active;
> +} __packed;
> +
>  #endif /* _LINUX_KHO_ABI_LUO_H */
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 6051abc0612c..e058df23fed1 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -229,6 +229,16 @@ struct liveupdate_flb {
>  
>  #ifdef CONFIG_LIVEUPDATE
>  
> +#define LIVEUPDATE_FEATURE_ENTRY(_id, _name, _supp, _req, _active)	\
> +	static const struct liveupdate_feature_entry __lu_feat_##_id	\
> +	__used __section(".liveupdate_features") __aligned(8) = {	\
> +		.name       = _name,					\
> +		.feat_bytes = sizeof(u64),				\
> +		.supp       = (_supp),					\
> +		.req        = (_req),					\
> +		.active     = (_active),				\
> +	}
> +
>  /* Return true if live update orchestrator is enabled */
>  bool liveupdate_enabled(void);
>  
> @@ -259,6 +269,8 @@ int liveupdate_get_token_outgoing(struct liveupdate_session *s,
>  
>  #else /* CONFIG_LIVEUPDATE */
>  
> +#define LIVEUPDATE_FEATURE_ENTRY(_id, _name, _supp, _req, _active)
> +
>  static inline bool liveupdate_enabled(void)
>  {
>  	return false;
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index 6add1ecc463f..27413f895174 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -64,6 +64,22 @@
>  #include "kexec_handover_internal.h"
>  #include "luo_internal.h"
>  
> +/*
> + * This is the header for the ".liveupdate_features" section in vmlinux.
> + * The linker makes sure that this header precedes the entries.
> + */
> +static const struct liveupdate_ver_hdr ver_hdr
> +	__used __section(".liveupdate_sec_hdr") __aligned(8) = {
> +	.magic   = LIVEUPDATE_VER_HDR_MAGIC,
> +	.version = LIVEUPDATE_VER_HDR_VER,
> +};
> +
> +/* Core LUO features */
> +LIVEUPDATE_FEATURE_ENTRY(luo_core, "luo",
> +			 LUO_CORE_FEATURES_SUPP,
> +			 LUO_CORE_FEATURES_REQ,
> +			 LUO_CORE_FEATURES_ACTIVE);
> +
>  static struct {
>  	bool enabled;
>  	struct luo_ser *luo_ser_out;

-- 
Regards,
Pratyush Yadav


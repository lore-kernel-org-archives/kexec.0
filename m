Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD0FCD6E57
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BfP3m3uDINOt0fM7mrJg3TEw4eDdUgfRDLxACEeD8dU=; b=FHifRjkBE6JI00z72G/dvb+qYi
	Q6D8FzCyJU8k1VRW2yhiJXuMQkAS3WDHYU+GKhU/qSi49Gmh1FKIo9hD7XI1r9PT/DdnsSfKwGuIn
	yuFJ2ubnMp87BVXeCqKcVnGU63cIW0AEnEBg0m+lXbbI/px+G4r9GCzFrO7437lO8MOso+nGO2+Ub
	hLYkt08eBOhcTlvw2a8BSfmx2BDCWz39s3YPJh1LnxWK6YD8QeRYtoYiUW/juwEg++oGQi6v5ZadW
	+pgk3lcGxBGVGS6MfLF+sjmYw5s7P0j6690SIrvy3iTh9XM8hGTJRYZdKPjQorS0thQug6NwAGBqg
	hqz7tmUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU32d-0000000BEhZ-1Zyu;
	Mon, 01 Jun 2026 13:50:55 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU32b-0000000BEh7-0tco
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 13:50:54 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-7ddd3d67084so39538457b3.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780321852; x=1780926652; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfP3m3uDINOt0fM7mrJg3TEw4eDdUgfRDLxACEeD8dU=;
        b=jZidili2ehIPInmmIL4ocmBB4kVFq9BvsXKw9JmFeoMhix5plqbCcqc4kV1aWJZDg5
         VmEBtjH3d8oPKsFYSeUwOi2osdYrSefHQk80MNukKcVDU0prjrL27bxhomuuTz+fffuG
         4wY1AE2iZcROQF1l6fjCH7GFnUxPaH95zZyfuuJpXUmLk5krBwfYV3yfzkQL5h6Y4esZ
         RaoAgkZz6snvGfV2D9zFIHOAGmQ5KrwpDdlWul9bnYsUd8j/nP+0ToqcWBq9WZHDkcch
         CVxzRjOr006F466VGRUOfHI/muH0PUAvdnAGkA1XwM1/H37Ne2RX1j+djoPJs8wEeTxL
         lQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321852; x=1780926652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfP3m3uDINOt0fM7mrJg3TEw4eDdUgfRDLxACEeD8dU=;
        b=Deetha7UyakQP0VgQz/JgH7pPC1zb/SHs+UXNywQyx1W0yMR41TbB+rKCFXvMrVpkc
         UDI4u0zVuam5X1mfAHtPvNoP+A5lld96M4JgL00otnzqg2dHbRfucTlKdQxD8a4DKh+I
         lsQqv+kzxBIUxulAtWzYF0huhasZcBck8YAWbjlxT55CimC/TgF/KApocOTOQEqAL/oq
         kLvmCIyxQA90y7XEWpTs3DBS0vfux7vK2B5AVnJKCRFE/tXaznDy1go0NZhuf9k9JPoH
         74tWaDNnnLS57GbE8tuL2xzi/FA4Ksws7veeU2/91J1RDnKNvGh6bH+2mGuUN4kpwn87
         4s3A==
X-Forwarded-Encrypted: i=1; AFNElJ+4RPiWyojPx2E63ptj/m0M8rB6YmH1Di78fBBlpmLmudSgJMEq36vQzN8jjXVwc9T7+VQMPw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzEwZ+w0VV2ntuOpZau6Y3k1cqGMgGkAL9InCUNgQ5GTHAICN/C
	l+LLnW00vMZObjmFBNHTyipD5BEN6yyYpL6L/78kYsVyyFpZYVvHrv8sFyn6mSSsQdsc/Nw8IkJ
	Ga4Za
X-Gm-Gg: Acq92OFLsj/uYFRKSMtGga7KaEnsNf78JWctDB4nh/COXfxQ+SSDVqason1KhlNFtS9
	kfJRetSvfxM26abqPLAmLF/NqTo+St7qnfDlaWApyhLil7zboZxTBGEQ+VXwAB/aY9jKOcj2gwM
	PRfSLh7v8tiWNOggnDUdP7iKX0qPqCHN7nYGEEGb8cT/Ml8VnFVkm0mfVmK3wpgg8r2U+QQSvti
	az8RyJuO9RM+kfJd2nygm21rKFYuSKC7WoZ+gWEEl96swyvZeX/qQ/c3VPuLGal1jBDtgl8b/b5
	DhL3y7ZoGeMTZtVZmyy8hJkHnqrTHiaJoQc93anh/T3S/hu2XpYDQRVQuLTylKb53b0Eq/GqjBj
	LmF1jsNt2y3gQUst5p4XePRSZ/5V4mwstps5nMEAtNxlLtkOum9gDQ9GCSw5Wr+3Hm+PuE9DRG1
	r4eyuZsnJWQvbk8ocEwLSi6S0Bes1DlOW9x0cbLF5IuPIFzOpdEdYi6jajbPGDlGoPRx86RptHD
	n6BXR+TLhwH6mDHgwlsvwV1V+e/8X0ESgnroiDtuD0=
X-Received: by 2002:a05:690c:6311:b0:7b9:39f:62c8 with SMTP id 00721157ae682-7e05d8ceaeemr99332547b3.27.1780321851614;
        Mon, 01 Jun 2026 06:50:51 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e17be07a17sm39858607b3.34.2026.06.01.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:50:50 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:50:49 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 04/13] liveupdate: register luo_ser as KHO subtree
Message-ID: <ah2IuC1Z1ssIquXZ@google.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-5-pasha.tatashin@soleen.com>
 <2vxzv7c2fn8n.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzv7c2fn8n.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_065053_281699_825B8F49 
X-CRM114-Status: GOOD (  41.32  )
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

On 06-01 14:39, Pratyush Yadav wrote:
> On Sat, May 30 2026, Pasha Tatashin wrote:
> 
> > Entirely remove the LUO FDT wrapper since the FDT only carries the
> > compatible string and the pointer to the centralized struct luo_ser.
> > Instead, register the struct luo_ser via the KHO raw subtree
> > API, placing the compatibility string inside the structure itself.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kho/abi/luo.h  | 57 +++++++++---------------
> >  kernel/liveupdate/luo_core.c | 85 +++++++++++-------------------------
> >  2 files changed, 46 insertions(+), 96 deletions(-)
> >
> > diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> > index 1b2f865a771a..9a4fe491812b 100644
> > --- a/include/linux/kho/abi/luo.h
> > +++ b/include/linux/kho/abi/luo.h
> > @@ -10,11 +10,11 @@
> >   *
> >   * Live Update Orchestrator uses the stable Application Binary Interface
> >   * defined below to pass state from a pre-update kernel to a post-update
> > - * kernel. The ABI is built upon the Kexec HandOver framework and uses a
> > - * Flattened Device Tree to describe the preserved data.
> > + * kernel. The ABI is built upon the Kexec HandOver framework and registers
> > + * the central `struct luo_ser` via the KHO raw subtree API.
> >   *
> > - * This interface is a contract. Any modification to the FDT structure, node
> > - * properties, compatible strings, or the layout of the `__packed` serialization
> > + * This interface is a contract. Any modification to the structure fields,
> > + * compatible strings, or the layout of the `__packed` serialization
> >   * structures defined here constitutes a breaking change. Such changes require
> >   * incrementing the version number in the relevant `_COMPATIBLE` string to
> >   * prevent a new kernel from misinterpreting data from an old kernel.
> > @@ -23,31 +23,15 @@
> >   * however, backward/forward compatibility is only guaranteed for kernels
> >   * supporting the same ABI version.
> >   *
> > - * FDT Structure Overview:
> > + * KHO Structure Overview:
> >   *   The entire LUO state is encapsulated within a single KHO entry named "LUO".
> > - *   This entry contains an FDT with the following layout:
> > - *
> > - *   .. code-block:: none
> > - *
> > - *     / {
> > - *         compatible = "luo-v2";
> > - *         luo-abi-header = <phys_addr_of_luo_ser>;
> > - *     };
> > - *
> > - * Main LUO Node (/):
> > - *
> > - *   - compatible: "luo-v2"
> > - *     Identifies the overall LUO ABI version.
> > - *   - luo-abi-header: u64
> > - *     The physical address of `struct luo_ser`.
> > + *   This entry contains the `struct luo_ser` structure.
> >   *
> >   * Serialization Structures:
> > - *   The FDT properties point to memory regions containing arrays of simple,
> > - *   `__packed` structures. These structures contain the actual preserved state.
> > - *
> >   *   - struct luo_ser:
> >   *     The central ABI structure that contains the overall state of the LUO.
> > - *     It includes the liveupdate-number and pointers to sessions and FLBs.
> > + *     It includes the compatibility string, the liveupdate-number, and pointers
> > + *     to sessions and FLBs.
> >   *
> >   *   - struct luo_session_header_ser:
> >   *     Header for the session array. Contains the total page count of the
> > @@ -78,26 +62,27 @@
> >  #ifndef _LINUX_KHO_ABI_LUO_H
> >  #define _LINUX_KHO_ABI_LUO_H
> >  
> > +#include <linux/align.h>
> >  #include <uapi/linux/liveupdate.h>
> >  
> >  /*
> > - * The LUO FDT hooks all LUO state for sessions, fds, etc.
> > + * The LUO state is registered under this KHO entry name.
> >   */
> > -#define LUO_FDT_SIZE		PAGE_SIZE
> > -#define LUO_FDT_KHO_ENTRY_NAME	"LUO"
> > -#define LUO_FDT_COMPATIBLE	"luo-v2"
> > -#define LUO_FDT_ABI_HEADER	"luo-abi-header"
> > +#define LUO_KHO_ENTRY_NAME	"LUO"
> > +#define LUO_ABI_COMPATIBLE	"luo-v3"
> > +#define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
> 
> The length of the compatible field will change depending on the length
> of the string. While that is technically fine since a new ABI version is
> allowed to change the layout, it feels odd. I think it would be better
> if we define a static size here, say 64 bytes. This way you can avoid
> all the weirdness that can happen when you move from one version to
> another.

This is what I used initially, but we have cases where one LUO/KHO 
subsystem depends on another. For example, the LUO version must change 
when the block version changes, making the static length too 
restrictive. I would prefer to use proper strncmp() everywhere and allow 
the version string to change dynamically between kernels, while still 
allowing something like this (from [PATCH v4 09/13] liveupdate: Remove 
limit on the number of sessions):

#define LUO_COMPAT_BASE		"luo-v3"
#define LUO_ABI_COMPATIBLE	LUO_COMPAT_BASE "-" 
KHO_BLOCK_ABI_COMPATIBLE

In the future, we may extend this further as we add more dependencies, 
such as your preservable xarray, vmalloc, etc. Everything that depends 
on an external version should include that in its compatibility string.

> 
> >  
> >  /**
> >   * struct luo_ser - Centralized LUO ABI header.
> > + * @compatible:     Compatibility string identifying the LUO ABI version.
> >   * @liveupdate_num: A counter tracking the number of successful live updates.
> >   * @sessions_pa:    Physical address of the first session block header.
> >   * @flbs_pa:        Physical address of the FLB header.
> >   *
> > - * This structure is the root of all preserved LUO state. It is pointed to by
> > - * the "luo-abi-header" property in the LUO FDT.
> > + * This structure is the root of all preserved LUO state.
> >   */
> >  struct luo_ser {
> > +	char compatible[LUO_ABI_COMPAT_LEN];
> >  	u64 liveupdate_num;
> >  	u64 sessions_pa;
> >  	u64 flbs_pa;
> [...]
> > @@ -94,40 +91,29 @@ static int __init luo_early_startup(void)
> >  		return 0;
> >  	}
> >  
> > -	/* Retrieve LUO subtree, and verify its format. */
> > -	err = kho_retrieve_subtree(LUO_FDT_KHO_ENTRY_NAME, &fdt_phys, NULL);
> > +	/* Retrieve LUO state from KHO. */
> > +	err = kho_retrieve_subtree(LUO_KHO_ENTRY_NAME, &luo_ser_phys, &len);
> >  	if (err) {
> >  		if (err != -ENOENT) {
> > -			pr_err("failed to retrieve FDT '%s' from KHO: %pe\n",
> > -			       LUO_FDT_KHO_ENTRY_NAME, ERR_PTR(err));
> > +			pr_err("failed to retrieve LUO state '%s' from KHO: %pe\n",
> > +			       LUO_KHO_ENTRY_NAME, ERR_PTR(err));
> >  			return err;
> >  		}
> >  
> >  		return 0;
> >  	}
> >  
> > -	luo_global.fdt_in = phys_to_virt(fdt_phys);
> > -	err = fdt_node_check_compatible(luo_global.fdt_in, 0,
> > -					LUO_FDT_COMPATIBLE);
> > -	if (err) {
> > -		pr_err("FDT '%s' is incompatible with '%s' [%d]\n",
> > -		       LUO_FDT_KHO_ENTRY_NAME, LUO_FDT_COMPATIBLE, err);
> > -
> > +	if (len < sizeof(*luo_ser)) {
> 
> len != sizeof(*luo_ser) here?

I can change this, but it is not necessary. It is common practice to 
verify that a "struct" is not smaller when compatibility is checked, 
allowing for future expansion without breaking compatibility with older 
kernels. I know we do not support forward/backward compatibility in any 
way right now, but I do not think it hurts to put the proper safeguards 
in place.

Pasha

> 
> > +		pr_err("LUO state is too small (%zu < %zu)\n", len, sizeof(*luo_ser));
> >  		return -EINVAL;
> >  	}
> >  
> > -	header_size = 0;
> > -	ptr = fdt_getprop(luo_global.fdt_in, 0, LUO_FDT_ABI_HEADER, &header_size);
> > -	if (!ptr || header_size != sizeof(u64)) {
> > -		pr_err("Unable to get ABI header '%s' [%d]\n",
> > -		       LUO_FDT_ABI_HEADER, header_size);
> > -
> > +	luo_ser = phys_to_virt(luo_ser_phys);
> > +	if (strncmp(luo_ser->compatible, LUO_ABI_COMPATIBLE, LUO_ABI_COMPAT_LEN)) {
> > +		pr_err("LUO state is incompatible with '%s'\n", LUO_ABI_COMPATIBLE);
> >  		return -EINVAL;
> >  	}
> >  
> > -	luo_ser_pa = get_unaligned((u64 *)ptr);
> > -	luo_ser = phys_to_virt(luo_ser_pa);
> > -
> >  	luo_global.liveupdate_num = luo_ser->liveupdate_num;
> >  	pr_info("Retrieved live update data, liveupdate number: %lld\n",
> >  		luo_global.liveupdate_num);
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav


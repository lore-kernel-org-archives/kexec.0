Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBA606A326
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ma6+VuVn;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D3Q4dteT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+4komcI6Fb95Hps7JFHEwewY0Kj5nDX9+u+4ZAxqqJ4=; b=Ma6+VuVnU72LetquJ5kUmg9oHH
	OjaGo9u4xB+HoJiAaRpPGAdR1ggjRjsfVUkmieQTJ37nVEiR3QKSiKWI957M9OC8QXsdCQDxUJfvD
	75COgJleyL6fundSIiQRpPWvpyLh67+yFFB4D4JNUYJicT1yGjeLQMb9MtRzK9ImfcbwccSrG5L/X
	3KVY3SeppfRiN/g8OdFBTFDmOuwzNTXGVHXSJS/tdJcy5b/6elcNU4RcrqiSVeu6DjzZk+kN5BRq8
	H5fjgu35ejM+RFltm2+P+YYGOAzF1v0yIrhTw/psIgpMh+L0qg5N7pLEtCee40omiGhuN1+8guYrs
	PdDpOXpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2hM-00000000lKp-3ldR;
	Tue, 03 Nov 2026 00:48:24 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO2hJ-00000000lKR-1nT9
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 00:48:23 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2e9f6a16aedso21995335ad.2
        for <kexec@lists.infradead.org>; Mon, 02 Nov 2026 16:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793666899; x=1794271699; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4komcI6Fb95Hps7JFHEwewY0Kj5nDX9+u+4ZAxqqJ4=;
        b=D3Q4dteTX3xW9UjjOQPPhBhpCja4c4di9OKGwzK2sbeClZGVEgSkknDoD01l9zrfAo
         DCCNaN1G9UPOkqdCzktwegET8NbpDaKx/rpITjOBq14VCFgMcDOdGA94ZiiklFpO7naF
         Hm+Gk0Vf8pAG4mPDIpf3qbugGKjqS7VMCrYHCeKBjeX30YWd0u644PGQBY0FoRbUJOkm
         2rJ9dNAU92S32jtipcqDi4FMcbX4m+DTrJRzx6cxBA6SW5WPJ1lG0I5oUiD1YLJluZFt
         FO2cBOi7/+LzkcxPdD94JMNAk3WppDtGV0ErftSFViCsH4BQyldzQZPY525cGqlZebBq
         7FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666899; x=1794271699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4komcI6Fb95Hps7JFHEwewY0Kj5nDX9+u+4ZAxqqJ4=;
        b=pHavomtkwjGLjOeWrCp0WQrJ4m45kJ7z0WObH3ETlzoe1V6hlGMvYKYvs9ee0A28JL
         wUII/sHe5yf8XtTXBMzqgtyMbvWtwgPYQsq6yYVj8piBBq17KdHmNQU58y/0DAmoOsRU
         nC9l/0KmWIVlZj3E3xbxyohj9M2xoMTLRtEScxDYOBxMliuE4pcHttf6l1RsWPtmEwG2
         PJaC7+1dOu7xe5RvngTrBTFxzCwkyfrh3pIp+m7OnLqzK+gfIRFpjGkkjImGUwIBrM3y
         aZ4rU8Icd2cuUksnTiEZSYwdIUFCH9FQjNcgmoGLvB+7ayNEMcnJycEf3sVUMUSYTkll
         2D6A==
X-Forwarded-Encrypted: i=1; AKwUvBzSRyxlm8rbhbsQA5MDsuJuHRst7EkqbkQReGnkTICXOIq4dRL/ucuSsfCk75gKX9g6hMPqXg==@lists.infradead.org
X-Gm-Message-State: APuU4Z8D0OWJT7F208MBtW6VUQGdvkFxnNgIU/MRuhDQdMYUU3vOX4Kx
	eNLx7NvHxGuwgWFt3teMv0kMVPvhw1JDuYk6uqwgjffrqMqf3JdJiE2FS2Tqeq0aQg==
X-Gm-Gg: AYBFou24kiO3+x52TQqclFvC+8+EOSglhKrOLpCVG1udneAggm0MjLboUsNndZmPvRo
	Un88e1ITCYDsZ3WlaY6q1QHkpZkHmV6NS9cfJwShsLc3Qj6SMISfbjg5tDMu/KdGyustcbZjD1Y
	tJKDpZJRONh939HVuIgYVZsIPGMJbof0alZ52dHdAfkliKGx+nXhxmMX4Ph7pCDbjGAi69pbP5D
	YIeEPdqz82feIahTLWDlJRaOOh6HpsMMJ+jxYtpBpZI+76pD6cqqQ6iSc6uu5rEdnZSLaZzU/D6
	NtbjiZgoy/ecvfTbMdA03AVQDwRCfzZW8nNPcIWIr7ubM4gIvvu9VeWBg/EeLptZU9+n33REkVu
	7g29SwnmUIC3F8mu754hvNEHonINFmXZaadtvafooShrQPrXYT+3yFZuPufcvyWdd975kv9oBHb
	LBiZTwnnLsa/bsbEVUkWHJ7n0H5pdhMSZHdqUwYCRoXRcitjzoxNSSjWOdv/7Dms1G31akDqBd+
	vpJlfeaHhO9kSzV64TxyAmZrf7Y9LXZM8BHJJnabyL4YKBgtM6OSO7HBn3WV3GoCzZWxtkvs6bJ
	j9Jiux90oBq2LIyuAu7A3H4lOd4ijrx8x1tUEju9RwZkzceG98W1CxUILVZ5yjt9
X-Received: by 2002:a17:90a:e7cd:b0:3a0:8050:2ec9 with SMTP id 98e67ed59e1d1-3ae897ccf9dmr9145000a91.16.1793666898905;
        Mon, 02 Nov 2026 16:48:18 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6b3493sm1454586a91.13.2026.11.02.16.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:48:18 -0800 (PST)
Date: Tue, 3 Nov 2026 00:48:14 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vipin Sharma <vipinsh@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
	ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com,
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com,
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net,
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com,
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com,
	kees@kernel.org, kevin.tian@intel.com, leon@kernel.org,
	leonro@nvidia.com, lukas@wunner.de, mattev@meta.com,
	michal.winiarski@intel.com, parav@nvidia.com,
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org,
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com,
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com,
	schnelle@linux.ibm.com, skhan@linuxfoundation.org,
	skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com,
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 05/27] PCI: liveupdate: Add helpers to preserve struct
 pci_saved_state
Message-ID: <aukvTvnfyAvahb51@google.com>
References: <20261102153656.1431701-6-vipinsh@google.com>
 <20261102230624.GA1038787@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102230624.GA1038787@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_164821_469614_58D611A6 
X-CRM114-Status: GOOD (  24.60  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-02 05:06 PM, Bjorn Helgaas wrote:
> On Mon, Nov 02, 2026 at 07:36:34AM -0800, Vipin Sharma wrote:
> > struct pci_saved_state is private to the PCI core and its in-memory
> > layout is not a stable ABI. Add helpers to serialize it into a
> > caller-provided buffer and rebuild it in the next kernel with a stable
> > struct pci_saved_state_ser ABI. Using caller-provided buffers allows
> > drivers to embed the serialized saved state directly in their own
> > KHO-preserved data with a single allocation and lifetime.
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

We discussed this patch off-list this morning. I'll sharing the context
here since you were not there Bjorn.

The ABI added by this patch is not actually stable across kernel
versions.

struct pci_saved_state_ser is stable, but the contents of each
capability entry are not:

> > +struct pci_cap_saved_data_ser {
> > +	u16 cap_nr;
> > +	u16 extended;
> > +	u32 size;
> > +	u8 data[];
> > +} __packed;

@data is a memcpy() of the per-capability save buffer, and the layout
of that buffer is not defined by the device or the spec. It is whatever
registers that capability's pci_save_*_state() function happens to
read, in whatever order it reads them. 

None of that is described in include/linux/kho/abi/pci.h, so this patch
implicitly turns the private layout of every capability save buffer in
drivers/pci/ into Live Update ABI. Someone changing
pci_save_pcie_state() or pci_save_aer_state() has no way of knowing they
just broke Live Update compatibility.

And these layouts do change. Commit 898585172fa7 ("PCI: save and restore
PCIe 2.0 registers") grew the PCIe buffer from 4 to 7 registers, and the
AER, LTR, L1SS, PTM, TPH and DPC buffers were all added over time.

This is the problem I was trying to solve with:

  https://lore.kernel.org/linux-pci/20260924173501.856380-1-dmatlack@google.com/

That series replaces the per-capability buffers with a single store
indexed by config space offset.

Where a saved value goes is then determined by the device's config
space, not by the kernel that saved it, so the PCI core can change which
registers it saves without changing what the data means. Serializing
that for Live Update should be trivial (a size/flags header plus the
bitmap and the values). The cross-kernel compatibility question also
becomes explicit and per-register ("the previous kernel saved offset X
and this kernel doesn't restore it") instead of a size mismatch on an
opaque blob.

Bjorn, this is also related to your last comment:

> I think it would be helpful if the names of "config_space[]" and
> "caps[]" hinted at the connection between them (both are in config
> space).

With the offset-indexed layout the two are no longer separate. The
header and the capability registers are all just DWORDs in the same
config space map in struct pci_saved_state.

So I'd suggest that we land the saved state series first and then rebase
this patch on top of it.

I can send a v2 of that series this week that addresses Josh's feedback,
rebases on top of the PCI Live Update v10 series, and includes the
serialization helpers. We can use that as the basis for the next version
of this series.

Thanks,
David


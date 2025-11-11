Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66056CCFA18
	for <kexec@archiver.kernel.org>; Tue, 11 Nov 2025 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7cOclis2GVYdgwMgsdoPFMXGyZnQXGFMSjM5y7cA3Jw=; b=mkfSmjTe9G64DrS0xpy1g3l/TK
	F8GfU6G9aph1teobwCxQwRJzsEiBa2B1IkMhue0JEQYq3qUuiT1WM0zeLKz7jlK6Q4Ljbo8o8ixka
	ahwhMmToteazJkA2y6puAYhYZ+VNgAtpCYRhSRFZvyqL76aEOh3iXAA4jmwhX2VqleeM+SeLYzzn1
	qdkRSPWSzs6t0XXtGAyZFxLr1ElM3gA5gJvrLk1KxiTQpFDRMzL79CTTT330Gs2eW9LRx0A6LuT8n
	Kn18c/WYiCWnlfPvgF9nlTXepv0hx8y4ON8hLPeLw0IHPoVHtDaG5oD0JqH2cER6rD4Dhe0vWXNdy
	erJlJiKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoiC-00000007G9A-0fMN;
	Tue, 11 Nov 2025 13:47:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIoi9-00000007G8o-20v8
	for kexec@lists.infradead.org;
	Tue, 11 Nov 2025 13:47:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C9FC542A88;
	Tue, 11 Nov 2025 13:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFC5C4CEF7;
	Tue, 11 Nov 2025 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762868824;
	bh=uYyvgR8Pd8GTIlDkv/HiLzVsfnvZzjlr3C5nrwymTkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiFd24AOPgfolVf6e8SSLse89m6LjnMU+AshjvyDlwHtZoxsC05D+EL45O2u7teoK
	 wGO2TKCgSzcF/1ePq1Vvt5veOztSk5sOBXrtsZRTFTJ8W0BfUHO5wuZiSlJ/mOphWB
	 aqzSYxVMRSHSP+LgQe3w27fMFROyTTP6Uq0oqTR2+itE7skEAFHbnv7T+z0yhIA0Tm
	 GZT7AGsSG15eYspm4hpab4fvXsMM086I0NsXSGdVuumqvId2a45DOc4I25iSSXxbEz
	 LBL7nO6/jrnF+NAtgqJQ2B2ERwQHT9RbIiTxf/Xg8B8PdK3j3R3HPSett2LMr+3QRd
	 XnnEqNdkUib/A==
Date: Tue, 11 Nov 2025 13:47:01 +0000
From: Simon Horman <horms@kernel.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: sourabhjain@linux.ibm.com, kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools 0/4] ppc64: Support kexec with initrd and DTB
 together
Message-ID: <aRM-VWmxjXaqQvDC@horms.kernel.org>
References: <20251022134611.8921-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022134611.8921-1-shivangu@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_054705_542734_8FA92D4A 
X-CRM114-Status: GOOD (  17.50  )
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

On Wed, Oct 22, 2025 at 07:16:05PM +0530, Shivang Upadhyay wrote:
> Currently, on ppc64 systems, kexec cannot directly use a
> user-provided devicetreeblob (dtb) when booting a new
> kernel with an initrd. This limitation exists because the
> dtb must be modified at runtime — for example, to include
> the initrd’s memory location and size, and to add
> /memreserve/ entries based on the current system memory
> layout.
> 
> Previously, kexec handled this by generating a fresh dtb in
> memory from the running system’s /proc/device-tree directory.
> However, this approach prevents users from making
> intentional modifications to the dtb — such as changin boot
> arguments, enabling or disabling devices, or testing kernel
> changes that depend on specific device tree properties.
> 
> Adding support for user-provided dtb (with appropriate
> patching by kexec) allows more control for developers,
> particularly when experimenting with custom kernels or
> hardware configurations.
> 
> This patch series lifts this restriction and ensures that
> the necessary /memreserve/ sections are properly added to
> the new DTB. on ppc64, it is mandatory, for the rebooting
> cpu to be present in the new kernel’s dtb, so additional
> logic has been added to identify and mark one of available
> cpu as reboot cpu on currect system.
> 
> A new architecture-specific function, arch_do_unload(), has
> been introduced to perform the necessary cleanup during
> kexec unload. in ppc64, the reboot CPU changes due to kexec,
> and it gets reset back on kexec unload.
> 
> Shivang Upadhyay (4):
>   ppc64: ensure /memreserve/ sections exist in user-provided FDT
>   ppc64: handle reboot CPU in case of user provided DTB
>   Add arch_do_unload hook for arch-specific cleanup
>   ppc64: life the dtb and initrd restriction

Thanks, applied.

- ppc64: life the dtb and initrd restriction
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=4dc039779675
- Add arch_do_unload hook for arch-specific cleanup
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=bf4aa2a1f365
- ppc64: handle reboot CPU in case of user provided DTB
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=39631c8fd64f
- ppc64: ensure /memreserve/ sections exist in user-provided FDT
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=32f664bfa479



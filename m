Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB47D5B87B
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 00:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NqTbZAD+H4crQV3J0wq/aDyv2BesH6WqnyEdYxszB4c=; b=lCCsHCwNFfNO2XkFbrEBYQHoA7
	8Jc/UkUKmip05HkNrgLJhKXwidOPNpxaxVUIC7Tow4LLq/VUEWHjVKO/cDRmEnM0/ACfmqDKGUyeD
	4O0OvIwHO4Hcx2bwc3A1PHOI82Nby22DiLc+yNN2q9R9M3fZOL7Hsf33eEVEnQQGAbMKZtkHzjJ50
	llb82KfJTVQU4q7RMHBlZdstGCxy8gEmCWw3+RRx4UYw2r09VXlDqLz0192s6SC+hdgGPX9A4FcJx
	Ry4WBkmt3Lu1d/cJl/kMbi5R8o26XOfqP/6CC8gEyHs6ITkthrzL723/2r2HE4NX6fEH1/qSyM91V
	gYTqBtBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIpB-00000004Rmo-106K;
	Tue, 16 Dec 2025 00:21:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVIp9-00000004Rmg-2PlZ
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 00:21:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C26760183;
	Tue, 16 Dec 2025 00:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898EFC4CEF5;
	Tue, 16 Dec 2025 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765844514;
	bh=z7MdUNUaRKCiy4iD/ii8h4a2sO4D40lQOJuu8ZMUmQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uud8KB6Aa9O+kjvVpEhb/RRnDZ1AX3q5MyR0beQMzjcU6yg3C2ZPUijntGDpl4DBX
	 bczgXj3m//LaoOfshv2kGIAS/E3PV+sj+NUnvieTwslTqTZF6fC02v2cQ0QI3YMIsM
	 1OP7fv+6MwXr91COlAR5qHh3CdZxjf9ExeRszHX78BNS+054yM2fcHMLGxHNl31aSN
	 AqF2KEm9f+Drd/oM6g+0X5UGXtTJvVg4dKPJcG2Y9wqHoxX8cMPOUbCZWWjZfFGaGj
	 JfMGJE7SqkAt1AJsjrAlEyl4V+1uYefx7Qr8jLpw1/+R/NCfeKMv47bnzFEgyTiDbz
	 /qkUhaSSuSVLw==
Date: Mon, 15 Dec 2025 16:21:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux.dev,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
	ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 17/28] x86: Add early SHA-1 support for Secure Launch
 early measurements
Message-ID: <20251216002150.GA11579@quark>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-18-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-18-ross.philipson@oracle.com>
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

On Mon, Dec 15, 2025 at 03:33:05PM -0800, Ross Philipson wrote:
> diff --git a/arch/x86/boot/compressed/sha1.c b/arch/x86/boot/compressed/sha1.c
> new file mode 100644
> index 000000000000..dd1b4cf5caf5
> --- /dev/null
> +++ b/arch/x86/boot/compressed/sha1.c
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Apertus Solutions, LLC.
> + */
> +
> +#undef CONFIG_CRYPTO_LIB_SHA1_ARCH
> +#include "../../../../lib/crypto/sha1.c"

CONFIG_* options shouldn't be undefined like this.  It seems that you're
trying to build the SHA-1 code into a pre-boot environment.  This
problem was already solved in the SHA-256 code, by making
lib/crypto/sha256.c aware of __DISABLE_EXPORTS.  The SHA-1 code should
use the same solution.

- Eric


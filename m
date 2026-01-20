Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB9ECA5FA0
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 16:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AP3b1QG+xPI6jPhdm+mXUYSwKq6bcsjkSqEhuIl9PpA=; b=er5BwuYLupR85FJvrXX7y1LI4N
	u8Fkj6iRTkYbYCqCkPnEI3PMMV7YVPtQHdUi43EGJl0Xy7M11x4JFaSthqq0p7hHrot7rP6fsYvDt
	Bjl/7T0Xd39WnRIYbAtMACDhSQuo6PgM566DIydXR3Bwc8wnVVRB3kVGGFKgMZes3iacN6zBecKFA
	fzrLBQq/5QoDrmaVnpv+1Z912b5hdUCpYiq4dv3uV2BSbkDK+13bX+3l7oJRp6djZPI3B/CqaY6dz
	0Cu5WO5Xjddf54U39LoaDq7UG0j3uusHl4qrh046rUBo6I6LFicq32Uj0ZejnBjggJ84IorFtgo8V
	8Ot2ijVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEMp-000000048m8-3zEN;
	Tue, 20 Jan 2026 16:14:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEMn-000000048lI-1l7y
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 16:14:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C041740BC0;
	Tue, 20 Jan 2026 16:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF835C16AAE;
	Tue, 20 Jan 2026 16:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768925644;
	bh=C1IvwOEB2IeBsljjj1U5exHtGWqVJB2lEhayoPqkk5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dV47J2SIEbcMdZkZ9Lifr8FksIvm38/wEBwH1gTlZgjkovIsgQnrHeducibOmFi2u
	 0MXW3RUHb176VYbMK+JyeNcRLKwK0htuCP642Do6W9esCNrZRZeWgKmjratMzZhxJr
	 /Y/U7vCLf/7KDZtCnyqsm9dTVBjlTW7u7n4Y36QbguNVCx+fcoocx9lfyB/wYY22GI
	 YQxLDv4C46PPgDTux/jLnKScOureFjXjQ3T6yun1zCpFJ4Tb4SkyPicZP67prLnJsO
	 81We6TisKb/KfU/+uDFPsfyFCg9wnY9yaM5CIJw6/dHdUdK9aIvJTFBmcf7RmuOPU6
	 LE8IcaGoozNaQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 4/6] kho: Introduce KHO FDT ABI header
In-Reply-To: <20260105165839.285270-5-rppt@kernel.org> (Mike Rapoport's
	message of "Mon, 5 Jan 2026 18:58:37 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-5-rppt@kernel.org>
Date: Tue, 20 Jan 2026 16:14:01 +0000
Message-ID: <2vxz3440dzxy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_081405_478748_B6A6706F 
X-CRM114-Status: GOOD (  10.82  )
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

On Mon, Jan 05 2026, Mike Rapoport wrote:

> From: Jason Miu <jasonmiu@google.com>
>
> Introduce the `include/linux/kho/abi/kexec_handover.h` header file,
> which defines the stable ABI for the KHO mechanism. This header specifies
> how preserved data is passed between kernels using an FDT.
>
> The ABI contract includes the FDT structure, node properties, and the
> "kho-v1" compatible string. By centralizing these definitions, this
> header serves as the foundational agreement for inter-kernel
> communication of preserved states, ensuring forward compatibility and
> preventing misinterpretation of data across kexec transitions.
>
> Since the ABI definitions are now centralized in the header files, the
> YAML files that previously described the FDT interfaces are
> redundant. These redundant files have therefore been removed.
>
> Signed-off-by: Jason Miu <jasonmiu@google.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


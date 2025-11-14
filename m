Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D56CE8D5E
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfCF8pPF5t2v7RxDZ7/y3H6IXB1Y2o+3F6StwNtACpE=; b=zKpotR7qdB0BnLP5QBSgNnRnld
	rwsDevyOXrB/R6qKNuJJdQYOuW6oDG3TXw+ZbXgcQ6N3cvBKUl+USGeGeoqautcIhQTU4N85fb0dU
	fuCIaVfjszzHAOWkVCiazoYoO2hGdN84tq73naz3GP0jvyJCVO4vr0iHGP3er8eu8s2U9VEWXyHA/
	l/3EP1wgFlZ+cU6JJ3FqkUbV+3VQ5O+sJfTAmUcj+UsMyjXsMYSsuqK0O0k26R82i2mWO3sQavoyP
	/I5kylK+ZL6YyT/E7Fi8QHHwREZJQ86tmFrWR1383gsbu6DmJ9ZFNAbRZi1ulCedpCfkqNQQV8qn8
	MwSKT1oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxRX-0000000CpJU-0ORO;
	Fri, 14 Nov 2025 17:18:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxRV-0000000CpJK-2fUx
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:18:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C163360197;
	Fri, 14 Nov 2025 17:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CD8C113D0;
	Fri, 14 Nov 2025 17:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140716;
	bh=gAz8c0U9qtGAsVP9eT4MuLFLegWENzvHUrrbzi6YB7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DDxLfb/KkNzBf01AdwZSzMCwl9oCPhwnWtd+w1+yjiWzwQJtCAL+vxORBRLi8xFre
	 xB+730Li3oDV3fKjjKXHPSzdB82BwnpQiZZJin3jtPS1ePiS75Zv937VzhpshGKyGR
	 QP0/XGz/Eumy45mDMOlTBAmUqYP0m4eR+ZWM1pYQZF5mRb6hLYdJVUKRW9DPwpSl0U
	 8HrAQBajQXlKt1Urh02I6HXS4EhbZ8Xpj8bRRQ8TIoNOiif5nfqUR2+PYPdsmGFF9s
	 Hf3kY8hPotr125tSFrKIepSsSmW9RDjkTofYXhIPRkhjqK7KDNdWVuC4i/opEFM7rc
	 AIhRV8xetghsg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 08/13] kho: Remove abort functionality and support
 state refresh
In-Reply-To: <20251114155358.2884014-9-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:53 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-9-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:18:32 +0100
Message-ID: <mafs0cy5k7ct3.fsf@kernel.org>
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Previously, KHO required a dedicated kho_abort() function to clean up
> state before kho_finalize() could be called again. This was necessary
> to handle complex unwind paths when using notifiers.
>
> With the shift to direct memory preservation, the explicit abort step
> is no longer strictly necessary.
>
> Remove kho_abort() and refactor kho_finalize() to handle re-entry.
> If kho_finalize() is called while KHO is already finalized, it will
> now automatically clean up the previous memory map and state before
> generating a new one. This allows the KHO state to be updated/refreshed
> simply by triggering finalize again.
>
> Update debugfs to return -EINVAL if userspace attempts to write 0 to
> the finalize attribute, as explicit abort is no longer supported.

Documentation/core-api/kho/concepts.rst touches on the concept of
finalization. I suppose that should be updated as well.

Other than this,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


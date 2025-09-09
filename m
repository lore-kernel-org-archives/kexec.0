Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69043CA0FED
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 17:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tt9cZvyCH1e69uk1ra9K12GwG7NHIEkl8OmCsIymvgw=; b=lXkdWP3BrUm7nS+LPH1DKOyPuT
	U40y8tEA0ZNk2SaQepzeDBXe/zEpJwF4vLPKTkXQ+iJwe7JaRYKc/LVZjLlu3JQq7wGkPoeRe0Uin
	FxWOxZjJCXeAMp3rLQNzuCmOinTA8lBxKrcYzUN1opfCkZf3dqkSSp5RdQgLqbIJCtsZMtOxQmfqN
	yTLz9/VM544lv+GGEnLj96hUUF7fEv9ov3eVoSIdnT6sAJQBZblpQlpoi0HkenQxGkMnHeCb9KqaM
	lQ1JHD0I8eYkSm//Cg2o119YuWAF11avmE2OQStkA9uEWYLnLNqP31aO2oQnwQ/LKuCtqmTV8wPim
	vYc2ilIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw1vX-00000008nD1-1Asj;
	Tue, 09 Sep 2025 17:14:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvxEY-00000006zpM-1CB3
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 12:14:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A4A6C6021E;
	Tue,  9 Sep 2025 12:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F938C4CEF4;
	Tue,  9 Sep 2025 12:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757420041;
	bh=tMruF9j+G2L1N4zuR4KW/thijoi3DgRD3fEIsvtunMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CuzrSo2wC8/+3xPSVkuL28/fLvs9z4VJpLDFlrUXZ9QxiUGZDvez1QEhrB8XqYimj
	 fKwvYQVXCm9wRitIRSPiL/qlnuM7XUwUnU4c/0qtwyqJOfv2HKela5PjaLj6vZQ9NO
	 iAFuNP2nZ+O8FTxe3FH2XmZGMJED34JrwSPdAMQDeQ6/Lil+VBaI8Bd9U44Pkysx+A
	 Ib6wrhmrBV1nEtPBDWRL8WlJP18Z4x0QyfHsHTEvgiQgITLatG+f31/iTaMSKMOluJ
	 KF+40oysRCqEyp2iNF1E4WvSlF21xGRkW/L7Rm0ZCdf1+vBw7KShria3xnXpbaPKz+
	 ki1J91Mqyr//w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Alexander Graf <graf@amazon.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  <kexec@lists.infradead.org>,  <linux-mm@kvack.org>,
  <linux-efi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <nh-open-source@amazon.com>
Subject: Re: [PATCH v3 1/2] kexec: introduce is_kho_boot()
In-Reply-To: <7dc6674a76bf6e68cca0222ccff32427699cc02e.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
	<7dc6674a76bf6e68cca0222ccff32427699cc02e.1755721529.git.epetron@amazon.de>
Date: Tue, 09 Sep 2025 14:13:58 +0200
Message-ID: <mafs0wm67lt6h.fsf@kernel.org>
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

On Thu, Aug 21 2025, Evangelos Petrongonas wrote:

> During early initialisation, after a kexec, other components, like EFI
> need to know if a KHO enabled kexec is performed. The `kho_is_enabled`
> function is not enough as in the early stages, it only reflects
> whether the cmdline has KHO enabled, not if an actual KHO FDT exists.
>
> Extend the KHO API with `is_kho_boot()` to provide a way for components
> to check if a KHO enabled kexec is performed.

Neat! I have always found doing if (kho_get_fdt()) a bit awkward.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C15CA5FAA
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zko+Zb4bPzkw+/TAVgPBIZvS5AM/HE7Ar8QGiBe6cM=; b=gpK0ylyMLjBs5/cC/QMT3Vlu7P
	/5yqQoqUwShXL0LpFFIY6+TdKvamN6fWu359syrfJwI5mNvWVpog2Eu62dqVs0nNTjs+GCnlpZ8FC
	ameCGkxPobRHn9wXkg6P3rrzZzn/4Wn6j7tp+0ns7fKKtqktq8jbkpTJQVj+3OdE431z3xVuFnVB8
	jlIRxz5bRoz/7xeEUvwEfB4TkhHRyC785MLIcoeyoeTwhxEdaLSDKmuMNbua9ZdGpPWgEwbxXcPFZ
	LSKg1UJRQ+exKDcMg2sVXinKmN0U/lIbGxDOypCpV7KIYzlsXU8wlCm75SXJgAlE5uiJRL8iEi7Kr
	tmzw50Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEel-00000004ArY-1RTj;
	Tue, 20 Jan 2026 16:32:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viEei-00000004Aqw-38tv
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 16:32:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1934242A4E;
	Tue, 20 Jan 2026 16:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF72C16AAE;
	Tue, 20 Jan 2026 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768926756;
	bh=BkuoYdiOjEdaSxlt18GMMC+iBXjttPiaqaXPWhOTAOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M15qmp5zcgPGZax3J+ZpO3YDXmk7U0i6dtAhX2uoznBFQL6z5+MRRhW9PsqcRm1qP
	 oL33nkA/ilfO744wGvuCqNvPRWbuskm3T9vocCqHZoMXP3wuH19kiHhQJ7AX9YYL5g
	 ANehmWMB5hXgbPWRvRn3jXjgOHfvCWhlFiHmRerz+D52DzvXq6rgdViR5uplteyW3z
	 Q1Nm/DQLL/ois8KKJ2sqoNfliwN0DFQMdwRV0+29Ok0CNq6xiSr73DLWWTl3wvxeku
	 KrBOWFA4RZ3lBbyc2JG+BJ1aF2eB57Uyw2VkRpycAgiOSy2yDKJwTbW0bQFVriPBdu
	 pvNuc20XRJrHQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 0/6] kho: ABI headers and Documentation updates
In-Reply-To: <20260105165839.285270-1-rppt@kernel.org> (Mike Rapoport's
	message of "Mon, 5 Jan 2026 18:58:33 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
Date: Tue, 20 Jan 2026 16:32:32 +0000
Message-ID: <2vxzms28ckin.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_083236_808102_81B05260 
X-CRM114-Status: GOOD (  10.86  )
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

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Hi,
>
> LUO started adding KHO ABI headers to include/linux/kho/abi, but the
> core parts of KHO and memblock are still using the old way for
> descriptions on their ABIs.
>
> Let's consolidate all things KHO in include/linux/kho/abi.
>
> And while on that, make some documentation updates to have more coherent
> KHO docs.

Thanks for working on this! It is nice to have the ABI consolidated and
cleaned.

[...]

-- 
Regards,
Pratyush Yadav


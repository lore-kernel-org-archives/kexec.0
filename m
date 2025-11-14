Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379E6CE8D4D
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMDWDjt/Wz3SOVfdYzXQII4p8Eg1oPHKPYlKP/wq3Og=; b=Uk57TusFxh4s4aQHKxyPYKnrhy
	PHCG8IeirdL/eUclu3Ewl6ZlpP3ehSUv46otXM3QmBseM0ffyiZiKqMEavGMJRonWrbKPhYgaTOOA
	XSFRvyT9gTWSTMo46eVx3eWpmqUpRg1y+YehkwDMtORK2guEmqs0J4gP2v8cgDCP//V0obah0r1BY
	GVqXWckB46bGD7PImCXkbXmtDl0VamUq+i8XFoWwJvZCdSr4q0zCZvg82EXxp0so4TvNQMKVKJH53
	gsWEvcudXBBC0AtPNVX261tEHTg42loZUvHtbGBJISRLRcm7jdfs1Ko/tDmXMK467TMyfVZuDNM0j
	RTtx/BQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwj2-0000000CkJt-1y11;
	Fri, 14 Nov 2025 16:32:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwj0-0000000CkJa-18dr
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:32:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 540BB442E3;
	Fri, 14 Nov 2025 16:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0422BC4CEF8;
	Fri, 14 Nov 2025 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137955;
	bh=VPIlJaSoX5ApbSW0ibgqxOo/U0FezlELx52crz4R/Qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N7e/jaZ+rMWOwEHCWLLgn6TMigcFke3ePmjNIwetydBBTKGd+F39vf5npz3H7ILEq
	 1B4TPnvmHW7mYSeZPzXCqQza7p6mwzOwSj8Pb3VNtz6bW0QAT/sfippM7ZBNKXQM0E
	 SYTCq5iaEJuOJmn3jqeBx9l59iFsODi39WZ1liTj25QMX7P6okhIqHvX8VhY3FH6/U
	 45xztb/IbpZEQDvTL8E2xOIcS822cEatwoJr4O+GRut/NBwbGi5yVPpWW30iakoBQD
	 Os6KkfwnXowUl1q7K/F1hw4shvEth2riUW5WKPyO/yRcK2ZkQZA2IVo/hNwla0nkqE
	 flvpsX0Db+vTQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 02/13] kho: Convert __kho_abort() to return void
In-Reply-To: <20251114155358.2884014-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:47 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-3-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 17:32:31 +0100
Message-ID: <mafs05xbc8ti8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_083238_336041_20CA739B 
X-CRM114-Status: UNSURE (   7.13  )
X-CRM114-Notice: Please train this message.
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

> The internal helper __kho_abort() always returns 0 and has no failure
> paths. Its return value is ignored by __kho_finalize and checked
> needlessly by kho_abort.
>
> Change the return type to void to reflect that this function cannot
> fail, and simplify kho_abort by removing dead error handling code.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


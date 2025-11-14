Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47F1CE8D4F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 16:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=041pjVoVlObxguqJXnDZhxQ3I0o1sLrkCwAqRkPqSsM=; b=SsW8nycyTz20/lwkLNDjkf5B/h
	gmO7bcphgDQk1munHhWmxRW/xTBPkw6fHUQQAV0/67UkRqbmmRjIm3j9mERLtPrJEAYPS6NCpK23c
	BJsXuhxyrA0pZuoV6/0v8hVA0WsKwI4pxj/F3Y2cj68ZdTHmCW7WviWsd47yq5zkxhyEpG/Nams0r
	GDVB8HLjRiK0yNuxqmLWvNnNWbCVqYjjyizLrvkxZNZlKSzDW3Y1nzDNJ7RCi1cOy1n0LLqY61iiT
	dO2mWZjpAM0ipv+1UKL59NaM8q1aP3RvjTIEyY3DpWn4aDl9giqsxLdf1bsTfXLzrP1EqqZsJcKBe
	rNL145yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwiV-0000000CkFc-3t7z;
	Fri, 14 Nov 2025 16:32:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwiT-0000000CkFT-3wP1
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 16:32:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0AFEA60150;
	Fri, 14 Nov 2025 16:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B467C4CEF8;
	Fri, 14 Nov 2025 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763137924;
	bh=tvaWCesSZPV5aZlyiiBehWbeYK80FC2R6bxRgb0JBv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qCIGg/d2HL42aDcB/Jy4naeEgwsC7p8QScxs+SzfBo8xshO5b0sREvxff35GjiixX
	 G4OEItKvJLztO3DAFZBDxm6nSenW1ZsDeVLHeDmKkeY++3qj4Lr6UsH7jrFdyYqoua
	 u91wQUy8WeigCtehOpi8RkYv20uysrmjxDNlBQ8eB2OYJqw1WSCNYIdHV4ZhINprVD
	 kuwwxUsyP3u9Sp3Et/cKunlR1A4e/3rWao+LqVNt4FkFKmJX7Eh850SY9Ys+18ndCq
	 uGVoMv2oJTSEiT1EpT30n9fXoF0iDd2SwTLhHlPOTBp5Kd11lJ4vQpVBv8Hk4ytYii
	 v36JV88qUa68w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 01/13] kho: Fix misleading log message in kho_populate()
In-Reply-To: <20251114155358.2884014-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:46 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-2-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 17:32:01 +0100
Message-ID: <mafs0a50o8tj2.fsf@kernel.org>
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

> The log message in kho_populate() currently states "Will skip init for
> some devices". This implies that Kexec Handover always involves
> skipping device initialization.
>
> However, KHO is a generic mechanism used to preserve kernel memory across
> reboot for various purposes, such as memfd, telemetry, or reserve_mem.
> Skipping device initialization is a specific property of live update
> drivers using KHO, not a property of the mechanism itself.
>
> Remove the misleading suffix to accurately reflect the generic nature of
> KHO discovery.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


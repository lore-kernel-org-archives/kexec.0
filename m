Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED43CD6E5D
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kLN2nxCenCFriMHbgZyJm69uVh8thx2Q/wX1arVTgj4=; b=PkkrXbyUHMLiR99HLAm3lvVwzK
	U2da5Rbp/hJkrla+g21MBYPfHSGnAGDEzmMZ31LN8Sxrkos5vx08McO9Lb7sXRbaxv/QUCDMA4Fgo
	8oVZqaFI9K3RaVAS96JEk7RDfz7abZaXrDHfHaht/pALPHk6y9yCoOAEeHT9Q3rY9LlBrZmXxY9zt
	+BMtVlfexyfWbSEBHQMhCVQdTZv0tzsg1qLHrMx8wn0gUCy0isvyyK8O4eihl//4j5p+nPe7RYAUj
	OvzTB+vBJ3lE8wvJxGVNxgZtBkfUZRGep3dCRK3yrLldQrR2V00CSZIKkKHb0OTTLwfQje2AKMkpA
	sd+dVk6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Rs-0000000B5TJ-1K8y;
	Mon, 01 Jun 2026 12:08:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1Rq-0000000B5QV-2plu
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 12:08:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0D6A4435C0;
	Mon,  1 Jun 2026 12:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D831F00893;
	Mon,  1 Jun 2026 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780315729;
	bh=kLN2nxCenCFriMHbgZyJm69uVh8thx2Q/wX1arVTgj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=etuz+XML6WCHoCiD6XZWDdtBmSvYoflYOOwpy3l0IcSrWBqMMsconlpV2HkKJ2/Du
	 v+/3YyNCA2PIRV+OGXcws3jTDOkhMyoDKYW0nRNyv8RYufZEpwplNpN9lXifvBMOkK
	 SkOldw71OnXelPchHVQWVcYH/O4Tqt58tPSpPDQ5dgH4cFocz1Dqtdk13+O8UHszdD
	 QW1BRMUl1adBZ1kzAH3ZySXT4BfdxDLXpooMf/zqabNi14LAptzE3wcy6PH7aSE+VE
	 NhxpmTPXnNe7o09HePI0qteYo5tk5km3nviSGcTJic/L5YV4nrgZ/70+oxWwPalpRt
	 zSZTfOrsAB+Fg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 01/13] liveupdate: change file_set->count type to u64
 for type safety
In-Reply-To: <20260530221938.115978-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:26 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-2-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 14:08:46 +0200
Message-ID: <2vxz8q8yh38x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_050850_747100_DA8D325A 
X-CRM114-Status: UNSURE (   5.87  )
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> This improves type safety and aligns the in-memory file_set->count with
> the serialized count type. It avoids potential truncation or sign
> conversion mismatch issues.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


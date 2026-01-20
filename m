Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED9ED2ED17
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sedTFGR0UIxMIY6PBuudToOLvbWS3cx6h34dkkTHn1A=; b=3sGDSNOSkntgmLDmtcm0Vn0dbw
	dB5a+Jyffp5wRy9cpHSKbzT25ce+m7FXDirqSSAad3RX5xoYXa6STp3CeK8Qox4yzsUo0YOMBYJRH
	skiUNel+yPe+uavlFlfs0h1c9mBmSNn7nuOX0R29WoYWvSt2+3wI9Sorcx3U51DJkahlft4/ZCw/D
	0PAa4LvJeF+twvUQcXVGBmJqt7nNxApFt3c1xU7p3jnvX0TYlFr2ramAeliuMHJwuFXb7HaaNSeGO
	bP7mwtZbucosUXjfo6oIL0m/K3jewIxrwjXouqNKCusdyDz1NqHH6zIPsEeNT5MigtDiDupY08xfl
	U8lrgndw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDyu-000000046n3-105N;
	Tue, 20 Jan 2026 15:49:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDyr-000000046mG-4AVr
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 15:49:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DF084436E;
	Tue, 20 Jan 2026 15:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645B5C19422;
	Tue, 20 Jan 2026 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924161;
	bh=Y/AbB7KgatkBwFOqIeCh37bW6yqZKTt6YIephjTthpE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZXYUZUghgW6RMboSc06ViBc7jvzZ9CGg4hucUHqCbYExeJE0/Hvu3Tk/xY3EewL8h
	 75PVDNC07Yw5qzGqyTG0NRtfrBvsWL7L7lugWh1Ewg+Rz7ep8WZG+qHc55M+edrcM2
	 5KZd1kW90br4dzAtum9kF3SgS4tDj8zqGQkmhDix3v37vHRymhdgIY8ZI3lJlxxYER
	 HskWglueLRn36V8/lAsy2MJhJxi+WrU8Omo5KHKgXWjfP/a6LxY4Y0CZOSoe2hVgia
	 NIaj3FaQEv8+Z/tZD0P/bLVFMn1AbdKmvvPjukxiJnE4LhckWdiaSc9TXVn0Ng2vU5
	 PWDIltP8LEeqw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 2/6] kho/abi: memfd: make generated documentation more
 coherent
In-Reply-To: <20260105165839.285270-3-rppt@kernel.org> (Mike Rapoport's
	message of "Mon, 5 Jan 2026 18:58:35 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-3-rppt@kernel.org>
Date: Tue, 20 Jan 2026 15:49:18 +0000
Message-ID: <2vxzecnke135.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_074922_047829_C21AB7A1 
X-CRM114-Status: UNSURE (   8.50  )
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

On Mon, Jan 05 2026, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> memfd preservation ABI description starts with "This header defines"
> which is fine in the header but reads weird in the generated html
> documentation.
>
> Update it to make the generated documentation coherent.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


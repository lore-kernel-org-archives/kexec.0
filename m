Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AF4CD5BD1
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ShcL7r50dfVkd1EvhBq+OIaa4ZXVW5H9HttcXDcV92M=; b=lvpmBi3IAHk28v2pcN6UYWEWpk
	+qINwbQ74VWKtmZ7aU391F0Ye4Am1ZTsuKY+YBesq05LcGSWDQH6Nz4noKMq1RpD6muQGbOF62LRy
	vzm0hlyI6wkGS7GSBZ+Nq+iUxAlw9pJeT8xYvXHJcdw3zCVmmVHswESN2Zuw57IgjK3CbqsUDU9OV
	EMHq61BkX0bENEFSEhZoZ9nNsclgC422N55vESuy8d2ZaYvu6/45NojixIw7AumuJbWpcwqJ0U485
	8PydKp4KjZ/qF/Hwu/0Z16BmQIJ4kQ2ln0gQ1uxwc4awwbuutNJy7imSkr8kUgcgTiYtLb0OUpH2l
	iYoBfw1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSVK-0000000DX2N-1PP1;
	Tue, 02 Jun 2026 17:02:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUSVH-0000000DX0u-3gSV
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 17:02:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A9F343D50;
	Tue,  2 Jun 2026 17:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188071F00898;
	Tue,  2 Jun 2026 17:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419731;
	bh=ShcL7r50dfVkd1EvhBq+OIaa4ZXVW5H9HttcXDcV92M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gPdpn2UgiboYZax3m1sudcCd1Bz3IObeQJ8gFwBLw0ARzbS0bi9eNPJOjxEYtg/FT
	 +pTvMg2hqxgWZUEM0Kz7DhvMRGLQXfTXKJbKZJM0QAQRunrgiTYrUfOlMnOannZwSj
	 yIRSczh7SteOl8ldrFzPnskPV5NFZcUtQJO7jXtzVEo1jsPiLGcACshrJdZzoWTnbD
	 p9JiYBo3MYfttrr20G00bzhqRwVrvnCKqoT62F1/0NWk3rEdSWmae1ZNFTlZSP6jC+
	 X7PEVjIoDqoIoV2IDAoEZEeRvpjdav5LJjcOPT2SVuhTtmqN7xGDUBaAiPJ7N8ZoU/
	 3jIo1lx4Jxx3A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v5 04/13] liveupdate: register luo_ser as KHO subtree
In-Reply-To: <20260602031717.197696-5-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Tue, 2 Jun 2026 03:17:08 +0000")
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
	<20260602031717.197696-5-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 19:02:07 +0200
Message-ID: <2vxzzf1cdgfk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_100211_937458_1A1C12EE 
X-CRM114-Status: UNSURE (   6.18  )
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

On Tue, Jun 02 2026, Pasha Tatashin wrote:

> Entirely remove the LUO FDT wrapper since the FDT only carries the
> compatible string and the pointer to the centralized struct luo_ser.
> Instead, register the struct luo_ser via the KHO raw subtree
> API, placing the compatibility string inside the structure itself.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


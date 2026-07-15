Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F90AC44507
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 09:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fv3sqxipnUe86ke8aUv/45G3UAhWXtWb4CNGKP9uyU4=; b=YTCZBLzxuYRmWQn0RW7tohw2Po
	ZSHQqhuqCb9K3mOnJY2LOv4JOW5caGglRqfC+EX3hnUPTUYZX6C8J1uBJHa5IT9qCRc1pozAyg/Le
	inmxAasRcA76DA9dHwuMXd9Yt7K++VZ4UGF+wFfoy5ymoPa8la/lxN9wNAFIx8do3TNfY7G9L4Mlb
	l/+c32kjJmHHgL9FDxi+8MHVAgCaOH8ylFezq40O3g5BhmveBv3JyiUka9Pq7/LuYUI6OCHeA3US+
	ufA9x9zrxUZsqdt0MQYZbWT42Q5GkKVLLWyueEkFQhUl6siasUqioQHrR6gyjAkfFsZo6Q7kQmCzZ
	bZVA11uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1c-0000000EKs7-213J;
	Wed, 15 Jul 2026 09:35:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjw1a-0000000EKrJ-24rY
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 09:35:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E8D7F6001A;
	Wed, 15 Jul 2026 09:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BAE1F00A3A;
	Wed, 15 Jul 2026 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108129;
	bh=Fv3sqxipnUe86ke8aUv/45G3UAhWXtWb4CNGKP9uyU4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=T9i3rX1ySo9Yb4sjdIjBsYkAIP6x0udu4rX2yD3bhzLtZZl9SIC6DmBMnkZQpYb8p
	 jv9KnVKARGG0ZbI/ofW4vrNrrGaeLSjlfN97Cgou2FeEKvPK9b0wRNZzXiTEBQJgYV
	 l682C+3sLvaJkxi9/rA3zMSaekv/INsDL5rofgaXZYU0XTqnXxQNPgrmhr6rmllrq8
	 w17HQnOCjF8rf3xry4h8XB805tfM19KQFc5+gMisv9rWYFSDMQecwjXK+bL2eo02ff
	 UBaDCkZuAXMCvc43h4Peibbw60H58MjJ6CW5q8NU8uM+mtJ8TZt4J2bAr96809Ilg6
	 uW6hJRHBC+Gaw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 04/21] kho: return virtual address of mem_map
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260709173821.429921-5-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
 <20260709173821.429921-5-pratyush@kernel.org>
Date: Wed, 15 Jul 2026 12:35:19 +0300
Message-Id: <178410811938.820181.15709073379301681705.b4-review@b4>
X-Mailer: b4 0.16-dev
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

> kho: return virtual address of mem_map

It's not really clear from where ...

> Currently it is only used by kho_populate(), which doesn't care whether

... and where it is used ;-)

-- 
Sincerely yours,
Mike.



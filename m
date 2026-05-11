Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50CBCD37B5
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KlgXK9fh/c6tJ8MpzfSz/1fsc65vT6RTYi2FsbqUuhk=; b=Sk7sS3Evxe/UiHHcLORgKXQ9ag
	akpq/BTAbtTE5EQktU9vWbQ+UnJKvd6E4q2wKTJJXjFMtHI5T9aGFMZWlk+NQd150fwg1QtO5kTFr
	/spfHFhB8QMGLmeE96ZaiKl6/DChQQPZY97UdxTnvBfRVU6206LTz3kNOqSng95aFuV5L5bGaOh1H
	W+f3mwk6kcIE+iLJIOkktkkbcRljmWMxKF2Ye9BT4ROdUt0btM2N0xCF9zIudgHkzQp31TLgBwjXt
	TCUenHV7fe4WALRgMEEhDfcH4t5P/nPgjUgnYL+Bgc676Jp3aOlaPr/bTNiuOFepxQgaMJM0qeQbp
	DAMucHmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMORz-0000000DDuq-2i3y;
	Mon, 11 May 2026 11:05:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMORy-0000000DDuD-0cYs
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:05:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7257B600CB;
	Mon, 11 May 2026 11:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15789C2BCB0;
	Mon, 11 May 2026 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778497525;
	bh=BztAq8w5VK1b2+D1NkvixBxhvrkj9m6ZLycQeOZt3oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AFb7kFFrakJ+O+jIq9DJ95cMQOTl61XQ/4sHtzYYZqyQCviZDiQzLDqgQt7e27XuY
	 iC+uHAtm/SC2kbJmzJYRtHLEjiTxtZgqKN7wf7rNoS8P6cRmII+qOOe6ZsM+XQ9uTg
	 A//Z5SCKYxT6VT8GnUl/0o5bKJOax0kxZEKZjVHn8W6q672EhOPi/KOCHWElpDSXHs
	 Cg3LvoQ7KrKXB4aJKttls3nJL7CcRSWeo4qhPcQU9hC75d12Ph3VvqG+D3QwcEujum
	 cCTvbypIMDtzDOO/tsg8TjldwDHZOF1M89vfkGRvYtL/RRZD+nqbraI2wrD889SpVK
	 4+AfaswtV6ZqQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jork Loeser <jloeser@linux.microsoft.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Alexander Graf
 <graf@amazon.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  David Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/12] kho: add kho_radix_init_tree()
In-Reply-To: <e5e9c15f-a030-423e-de79-757c20d084e1@linux.microsoft.com> (Jork
	Loeser's message of "Wed, 6 May 2026 03:51:07 -0700 (PDT)")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-9-pratyush@kernel.org>
	<e5e9c15f-a030-423e-de79-757c20d084e1@linux.microsoft.com>
Date: Mon, 11 May 2026 13:05:21 +0200
Message-ID: <2vxzqzniciku.fsf@kernel.org>
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

On Wed, May 06 2026, Jork Loeser wrote:

> On Wed, 29 Apr 2026, Pratyush Yadav wrote:
>
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>
>> Move the initialization logic of the radix tree into
>> kho_radix_init_tree() instead of having users open-code it. Makes the
>> boundaries cleaner and reduces code duplication when a new user of the
>> radix tree will be added in a future commit.
>
> Consider using kho_radix_init_tree() in kho_init() as well. This will also
> remove the kzalloc() one-off use. Similar for kho_radix_destroy_tree().

Good point. Will do.

-- 
Regards,
Pratyush Yadav


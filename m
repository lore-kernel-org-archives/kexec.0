Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B00CE8D7F
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 19:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WyzsCX9cDFqpjYYE4CvxJEvrL1mAh/0NX+qFVB5a7ZI=; b=5C3aZmt/UqhLHaHkfk/tF3T680
	CYEC9zrPciNF4afgPuehaJ/My1HBJnNIVDMAoa4Euj5dwXppl+x4iMVqi0GPVU0hqWCNzVIc0WXrD
	Z1nK4ugoxCaqcxFURC/Fxr2LduCqPq1ZROppvvnzlZZWvbvopjxrLMqe1l6xcd1Ux7o7Qvb6bZY0K
	TUTBQNbN5vWVfA3OdDgVFe1FeHdt5cdq4uVuEke9rcf01/CBYdBQGdeZOTAQbOoOB58YTrn2MyvyY
	AZ/qdvfUrNXQ1+KCyN18747QczW+Lgm9aXbhVVRyIj5QppqVDtkK2GiWhOEy43tR7LtoP8chve0hQ
	ZYlWkrkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJzaQ-0000000D1Zs-16Xu;
	Fri, 14 Nov 2025 19:35:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJzaN-0000000D1ZT-1GS5
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 19:35:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A776540050;
	Fri, 14 Nov 2025 19:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4BCC19421;
	Fri, 14 Nov 2025 19:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763148954;
	bh=Q1O4BIVR1FCS7fU5WDAS+HptHA2cmt8TA5K3Q3jWw3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Dj5HqMWkFNbuohcjbv4dicuiDeZh9VXlrv4Nq8qQeqKJfLexZPY2HiN/CaXHOqLbs
	 xsPClbHS3mTj0znKO+cynJD/nzJ1g3VtC1sRbQ5BZg8keXFC6PTtm07C9PEfRwfgID
	 9eQrI9Lgcfl4RcBrYMTj5Gxf8uCMx2ARWuSmLOp8indblWHrJwTNgBuho0KBn+0PHu
	 +yVFF9a1HKePZGlxXLWtqBRbi5qco9Y3hFVgdIMcgnLFjI38tialKDlHkQ8ynjQMux
	 grCYboOy1/R63jsDHZkcqmVY0m1TeO4Xvov+J/If6GUxuOUgBxayskyv16HXgznSbP
	 Y3uYfZM3JAT2g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2 13/13] kho: Add Kconfig option to enable KHO by default
In-Reply-To: <20251114190002.3311679-14-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 14:00:02 -0500")
References: <20251114190002.3311679-1-pasha.tatashin@soleen.com>
	<20251114190002.3311679-14-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 20:35:51 +0100
Message-ID: <mafs05xbc5rvs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_113555_359355_94A64A75 
X-CRM114-Status: UNSURE (   7.39  )
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

> Currently, Kexec Handover must be explicitly enabled via the kernel
> command line parameter `kho=on`.
>
> For workloads that rely on KHO as a foundational requirement (such as
> the upcoming Live Update Orchestrator), requiring an explicit boot
> parameter adds redundant configuration steps.
>
> Introduce CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT. When selected, KHO
> defaults to enabled. This is equivalent to passing kho=on at boot.
> The behavior can still be disabled at runtime by passing kho=off.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


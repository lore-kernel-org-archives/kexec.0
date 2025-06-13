Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A66C71136
	for <kexec@archiver.kernel.org>; Fri, 13 Jun 2025 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lkG0Mzmw+k38ced8CtNVvfIiN1HEZS4d+axHpnQVJ04=; b=q93jYXs17CD5V1X+v5XRC3yLk6
	vaxbV5Kn23H6ffUrxF+AmtJ92Zj6GTyjaiVNeJ2aHeFjBDIccmb6xnCDse/pp7N3INh0lZp+Lfn2+
	d0EcGi3W3DnQZ3NNo2Yj4cNvI/kpB3jVgiftbQvUhdfXERR9dbwOvCNzCcmw3kvuUsB/ErlqTzHFf
	pq0NWkON726YaFiSYJFYHsk8Sre9XVDx8osn2f9oyxfQyV79gD+88Z6esdtU4a++tMcc3zABR29rU
	I+P0ArCvaNGkGeq3fUDrV8cE2JQDZ8AjoDhLhGcK6II3m/HNgtjtqny6lqc8Q0tIpOCQ6JQ1tBZgs
	q+CSz8Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ9h6-0000000HNXR-25Dc;
	Fri, 13 Jun 2025 19:04:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ83R-0000000H9Zu-2Pyg
	for kexec@lists.infradead.org;
	Fri, 13 Jun 2025 17:19:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8E5355C5BFF;
	Fri, 13 Jun 2025 17:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD23CC4CEE3;
	Fri, 13 Jun 2025 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749835139;
	bh=Abu6EAYhm8bB5S3eWb73lfBo9Fm8nK7/25q7uL0UYuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ABN80kqouHD25CIXTYevWS0hBu8aECbLujppnWnnqQcbR/yYEgX22e+MOzc5rjqfC
	 k6aijIRRtSGZHiVwVXSL929H/r+3+e7WRGUTmFASrbT6oQau6h6fJLUut5r1NUOSYp
	 cUL+flN0HXfdeDiceFbNrL1X39MC5cCcSOxAfUY/F4oAXQgy+KHuBIkDjCcrJM037t
	 M0KdPEpGD6kk7KtujaWHfpCV+czfIcD3ICextA6XtD6jXBh1/Mwz//Sh/aoIITxD6f
	 rCHbItOHywel0YgO0Yu3TqdyzxvkgOjHp9C3ylGwqsFoyVFJlq/nlo3n08LtDJ3XQQ
	 OjQMgVKEik5Ag==
From: SeongJae Park <sj@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <ptyadav@amazon.de>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] MAINTAINERS: add linux-mm@ list to Kexec Handover
Date: Fri, 13 Jun 2025 10:18:57 -0700
Message-Id: <20250613171857.44909-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250613131917.4488-1-pratyush@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_101901_652051_7D26C197 
X-CRM114-Status: UNSURE (   7.63  )
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

On Fri, 13 Jun 2025 15:19:14 +0200 Pratyush Yadav <pratyush@kernel.org> wrote:

> From: Pratyush Yadav <ptyadav@amazon.de>
> 
> Along with kexec, KHO also has parts dealing with memory management,
> like page/folio initialization, memblock, and preserving/unpreserving
> memory for next kernel. Copy linux-mm@ to KHO patches so the right set
> of eyes can look at changes to those parts.
> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]


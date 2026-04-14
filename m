Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7B1F9D0F6
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 23:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d9z2GrTB9XjHImS8vobySB91FdevqsHBKprMoeLVmro=; b=4ZkDeFrpYscX4nGJwZyzEMclQ5
	WQVYyyXpG1NBRBPRiZF+v2VOJF1+z+dqEaNkx77WfM54+TNIAj26ssGZS29Rb/ExvkP1ISOF8drDa
	l2sd7F76uUuE2pVhOlKGXrDbBQYv8mEaJ+XSbK/PwqDmfwXDN/fcIJl1GUrMsKgfemKp5v42pzsTo
	0xPjdAIfWOwNgWTjGS+MxU8aLR8AzDI+As3MXrLoGxRTJFRe/LOomZvjEWCTA5MXhHzdbcELf6FlK
	LszlRQuI/OdsSDl5lNLw54b6byty5FwagVsYodX36M1BdKSHWvtkePBXmxGnkmRC3TznuzGCCiSbF
	xs+6sDrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCn4m-00000000KN9-1cOk;
	Tue, 14 Apr 2026 23:21:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCn4k-00000000KMg-1ifm
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 23:21:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 40F1143CB9;
	Tue, 14 Apr 2026 23:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF9C19425;
	Tue, 14 Apr 2026 23:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776208905;
	bh=yBEF1CTj/r3UoLSD5Bnk3vGkbeG10Wf0bCAiGqbjEX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CzrFWux8nf/PwhKRWNRD7bYnMw6ccJDIwxfGXqKtRW/Z/bspGQcnkHE3Tct7GoUpV
	 pBbWjBkZimd0i1IAgjQw/7qTaWbT5IjwC65rWCxRYPsQFrY/kmVloxPWPeyPgy7ENu
	 CYDDJIC61mABK5uh1unvxRkkj3GldVF9oubkfYMch5Lne2I7sFJIDMt1yAnNYmI4/6
	 hwD54f5WgyvSGj7VLdYjRUOBXcNcGFgkSjYblGF6LK91ZNr635e5a4cAwLVCfch5Gd
	 0Narx0sQbRgsiXaXDCr/oZ6hgM+DKVIoOMH7Xnhs0M4ZBZzFiWJmC6nT3GDvWLWTwq
	 9z4HJ+BMLoWsg==
From: SeongJae Park <sj@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] MAINTAINERS: drop include/linux/kho/abi/ from KHO
Date: Tue, 14 Apr 2026 16:21:36 -0700
Message-ID: <20260414232137.97202-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414121752.1912847-3-pratyush@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_162146_470455_8D9D0B67 
X-CRM114-Status: UNSURE (   4.97  )
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

On Tue, 14 Apr 2026 12:17:19 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The KHO entry already includes include/linux/kho. Listing its
> subdirectory is redundant.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B68CCCF2DD
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gPrnJ5h+JTd5xfQX0msksUXYMd1kTQebAy6gvwTvYy4=; b=Z85GPfv/OZKAgOSMFD6WKNwEA2
	5fQ5XTQMfqLwP1kuRufx/bjks2T0OAb8xtPq2Hpk/pr71JB1MX+ZKNI1D5OADEm4KZuaQq6OgwjcM
	ICwR+UFbefM7GCbRL0Xs2SfH1S5G2gq/5yDq6a3WyrFPD946HOSIsa+MBabIhguCEwu+/QpbKbA//
	clxfWTwPGTZeV7/uw2eK1Rr9h70q6pUlD8UqR7fmJB3VTm376KxCevC9oIfjvjJMxZHI6ng+2Tn52
	PApx1pmfSgSlw0U/p+q1a9PvJ/VQcsEsvwZFYNwGv65wI8HYLMV5cgcfXc+RX2pAFlJH+USDABA2S
	8QuZCvSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDyW-000000046jc-31cw;
	Tue, 20 Jan 2026 15:49:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viDyV-000000046jV-16EH
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 15:48:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 680C9600CB;
	Tue, 20 Jan 2026 15:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B08C16AAE;
	Tue, 20 Jan 2026 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924138;
	bh=Sibm+aZ98LIkL5kbuZa070QHCHMd8TMrKU2FEeENzvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GhkDiB2Vp1VQB8+q+3lgV8ww3kKRKo+NC2AOuTXsRDcK8rLtDeAOOvRR25qyOkbDJ
	 A15QFxATiZSqYrRwpleFYkpRYLHyPxiuJ0ALEULuUJHTcS7GR2Sf0CBPSCCtrVbTPo
	 GnLK5XOXviPq0Sdv++gz07BSE0UjK6kkHVQPh3AWLBoUMa2vtJ05mFEHn7Fttk2hUm
	 0aGYilay/5fTAwUq70c0ukjadN/sh5lIOaHib2CP6gc/G+dEu3I5kzIY+0Pg4kaITt
	 Nt2C9z4eMdxr/n+/INAP0hq5Im5Otbn83ml2ISTrZpUR2hmIW54KqlowRHJdPy9z99
	 YfikI/LkK4b6g==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH 1/6] kho/abi: luo: make generated documentation more
 coherent
In-Reply-To: <20260105165839.285270-2-rppt@kernel.org> (Mike Rapoport's
	message of "Mon, 5 Jan 2026 18:58:34 +0200")
References: <20260105165839.285270-1-rppt@kernel.org>
	<20260105165839.285270-2-rppt@kernel.org>
Date: Tue, 20 Jan 2026 15:48:54 +0000
Message-ID: <2vxzikcwe13t.fsf@kernel.org>
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

On Mon, Jan 05 2026, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> LUO ABI description starts with "This header defines" which is fine in
> the header but reads weird in the generated html documentation.
>
> Update it to make the generated documentation coherent.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


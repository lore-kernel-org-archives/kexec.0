Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACEDCAC5A2
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R9lgwDHev4dU38X0FYweEhf88k8Y+x8k/AuD59Ougps=; b=qtQMK1+heFGX7uVoL/ZtJrmd1Q
	F/5qY0SnTpnqVIBTEIYbiZKTG5tV3rXhD5gw2kasynkXxifG6XwYx02e5CvOigVNO1Iqesh15bsNf
	xlZMcMAU1m3VhfDvntd3kDLb50LJbDIvqJU+0DSxrHDqVSCTI+ul99i9lkU1V/Pe1fs7rR/J44m5F
	RbnAXmXYtDRDi4p+vSZXTLVDsCzyQ9dLGqLTs6hT6Kyv/uI6s80Ybjo85rcSl1P2AfscUeZ+nSyJY
	14pQzLGnTmFQmXPsjDuhL12JicgVbNMBgwqtG6ZvP8pFFPkoL028eBZDgdLq/IXvVybh1mRbIoLUL
	O+wMACKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyX5a-00000008Cbd-2tqE;
	Tue, 16 Sep 2025 14:55:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyX5Z-00000008CbO-3HMI
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 14:55:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 11F01601AD;
	Tue, 16 Sep 2025 14:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12B7C4CEEB;
	Tue, 16 Sep 2025 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034524;
	bh=+h0GgC3LWghF6oM5gQKsTZ5ZQF+Tvm787123O9K2VnI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F8BnDxmdN1uLoWQamCkXCpbCbGajjH+Z+Eg8tkf1UcJKxqTTVmOev//JQa5hWNpwQ
	 i8HcFmF6APK2Li5miaU/G5IkGv+kmRhTGx+ussnfLk7X83mGUzB2bwKyvgUGg8cW/q
	 baII0v+rlbsJ2MwA1IYCgdvx+L6RRPiwlvJHlIts93SEPz8bytiW7lMKzjLSVjDuXW
	 PMWCX2Iv1vzFPsDTHZ+b135cCz/pXlvVTtbp8b1O2yccMTIyYK9VrmtEQ0aRldQv69
	 77xlzKdpRw3QPhyd18JUFu2d1oKDWMhgxpWtzgxjeSQYpXtFFeYOGSYfhjyMjKqLdu
	 50PtUC1KkbM3w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Changyuan Lyu <changyuanl@google.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Jason Gunthorpe <jgg@nvidia.com>,  Chris Li
 <chrisl@kernel.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <aMl2H3BLpH3xFCOw@kernel.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMl2H3BLpH3xFCOw@kernel.org>
Date: Tue, 16 Sep 2025 16:55:21 +0200
Message-ID: <mafs0h5x2h2g6.fsf@kernel.org>
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

On Tue, Sep 16 2025, Mike Rapoport wrote:

> On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
>> When restoring a folio using kho_restore_folio(), no sanity checks are
>> done to make sure the folio actually came from a kexec handover. The
>> caller is trusted to pass in the right address. If the caller has a bug
>> and passes in a wrong address, an in-use folio might be "restored" and
>> returned, causing all sorts of memory corruption.
>> 
>> Harden the folio restore logic by stashing in a magic number in
>> page->private along with the folio order. If the magic number does not
>> match, the folio won't be touched. page->private is an unsigned long.
>> The union kho_page_info splits it into two parts, with one holding the
>> order and the other holding the magic number.
>
> I think the sanity checks belongs to the core kho_restore_page() function
> and kho_restore_folio() should be a thin wrapper for that, at least until
> we'd need to allocate struct folio there.

Hmm, okay. I can do that for the next version.

-- 
Regards,
Pratyush Yadav


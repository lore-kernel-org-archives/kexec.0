Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84557CF8577
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 09:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3p8qOthpWydgOBX1TRi7q4Y/4ZncxHSSHMGH189+eH8=; b=nC7HGOzT2uSR57oFbpcVILgs4L
	mnBn94qR7fp8UC8VgRyJmxyLfMXp1jEc0GPhlRuTWl5W+6JqjiJvjaWWPXuJZFmNFROVOK+PwPcKB
	6Xxi+ZcpUVH7I/VTs9D8sSg2Fd30x6QLaFgnDY0r87EfWS7/ta1jSe+NbBzKOA+aXl74BszVvC7un
	Pi4nFMEyKMUoCSts2z34PgjUR+iJLjC9UBJLT4Atla9LIjjcpVCYvPzTOsKL5CaG4jP1nzV1U3Dbw
	hgN+ZoRW+wHgvSIUMBkifOdbT8IlY4ozmHyvKMps5kx7UnvSrReu9t9Ihw0UPO5fXPGb0tUYDxp0m
	Qot9yRIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM0v9-00000006Pwt-1kMJ;
	Thu, 20 Nov 2025 09:25:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM0v4-00000006PwN-3JFf
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 09:25:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 319CF60149;
	Thu, 20 Nov 2025 09:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109C2C4CEF1;
	Thu, 20 Nov 2025 09:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763630737;
	bh=evjGnIEpXhARTPmoO/cs1I6ssBqa6z251Ea4MgH+LQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FNK9vddXtCXrTVzMyiR2HxiHbuMADQ+WlZBq9mC2fCoJRg4vxHKB00hiwoIdlap7D
	 ncqc3fjzIGcBOTVaFUQrnXwJG24cD9mYLD/RvqVcnaucDRl0dDIPHmv1Rs9C0IwqVw
	 s7+c3N4FOk1KTTX99A9jjZwC3qHcvY5iLBrgEQPOsGxXrk1mtM0jfm/6JDLI5Qi6+z
	 /TZt7Ev5zh9kGnqUhkWRjoBdf1vgO6jiUHQe+HwET90FCgxYwHcvztM1shPH/HhBc+
	 V/XfajD1W9gE/o5+4CzWKlvEzdm98ZirchTgFzeZIbuFPJ86z0jfXVil2Tzx9gkcLq
	 bzCkwzRc9QBYQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Mike
 Rapoport <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
In-Reply-To: <2025111944-bullpen-slinging-dcdc@gregkh> (Greg KH's message of
	"Wed, 19 Nov 2025 17:02:49 +0100")
References: <20251118182416.70660-1-pratyush@kernel.org>
	<2025111944-tracing-unwieldy-1769@gregkh> <mafs0wm3m2f1h.fsf@kernel.org>
	<2025111944-bullpen-slinging-dcdc@gregkh>
Date: Thu, 20 Nov 2025 10:25:34 +0100
Message-ID: <mafs0ms4h2gz5.fsf@kernel.org>
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

On Wed, Nov 19 2025, Greg KH wrote:

> On Wed, Nov 19, 2025 at 04:55:06PM +0100, Pratyush Yadav wrote:
>> On Wed, Nov 19 2025, Greg KH wrote:
>> 
>> > On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
>> >> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
>> >> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
>> >> KHO maintainers can get patches for its test.
>> >> 
>> >> Cc: stable@vger.kernel.org
>> >
>> > Why is this a patch for stable trees?
>> 
>> If someone finds a problem with this test in a stable kernel, they will
>> know who to contact.
>
> Contacting developers/maintainers should always be done on the latest
> kernel release, not on older stable kernels as fixes need to ALWAYS be
> done on Linus's tree first.
>
> Please don't force us to attempt to keep MAINTAINERS changes in sync in
> stable kernel trees, that way lies madness and even more patches that
> you would be forcing me to handle :)

Okay, my bad. Feel free to ignore this patch then. And I will keep that
in mind the next time around.

Andrew, can you please drop the "Cc: stable@vger.kernel.org" when you
apply?

-- 
Regards,
Pratyush Yadav


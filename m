Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C0CAC5A5
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vGy4r9I5hgyJ4PvKF1ULDLS+M/a8IQIyyw5mwU4gZA=; b=Ubg94I20zKEB9vROlIunM1u5gc
	XP8gRjsk9wfQInN9bLyOj+2G6Xm5/U4eQDReV9XEu9QxRhvs8sVK52eB0nuqVqW+6AKgwZEM3WO+J
	RoLQr3zApC9R30Q0OA3NIxwQCA9eG6mOa43G5KUYAIM1KVkLMcap2d45yyCXaODMbLc19TVjrJmG2
	n/Fwz3omglZEirS6V7b8liiZ6MSvlfaD7bLAZU+BzAxbKKa78p2Ud+971tSKhDsaGS+bXPlcacDgP
	vduSj8WTU0HvK+/eFNCbmqippxhqAfciJ4WNn6chhy2EZu1eiNwUHQvCG+/dE4KXJbkkleiWO4P4F
	ab4usKbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1i8d-00000007WYZ-2Pmv;
	Thu, 25 Sep 2025 09:19:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1i8b-00000007WXR-2rmD
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 09:19:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1EB4C6013C;
	Thu, 25 Sep 2025 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96BDC4CEF0;
	Thu, 25 Sep 2025 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758791980;
	bh=AQqMJQUBDrq9kxPLr/qGEjxf9utS86NJR0MoZy6d1v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0RZZ1RbKWAAkwlLtYKHcY7S4z/MVWCM50D//MM7NbnU4x0VQ104OQW68HBeAYRYE
	 Gk60I4tro2JMqe3Qjc8LwqFxAq2mJlq+lKwYDTQWUkX3AkNoBii2ZDZfEvqZN3rEM3
	 A3jYcewOMAlaG7c+WSx11wDrWKMqV5Bcp+7l8t8kM9isRSp+OuRBU+FwhwS9ueFh46
	 0/QAkKl2M040I2KBKOwHwNMlJg2blEiveia9uQcZQJmWSKPe2WfUhlSKJLGTLszk2K
	 Fb5QnhvksFC9LTB8hhqUzWg6e7ye1m3pyxoM4nRn+bZFFpXmDoPpHtCOVBTNV3MagN
	 yOB/K5Ig541Lg==
Date: Thu, 25 Sep 2025 12:19:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Miu <jasonmiu@google.com>
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Petr Mladek <pmladek@suse.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Steven Chen <chenste@linux.microsoft.com>,
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
Message-ID: <aNUJIsElr5L5uxNv@kernel.org>
References: <20250917025019.1585041-1-jasonmiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917025019.1585041-1-jasonmiu@google.com>
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

Hi Jason,

On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
> This series transitions KHO from an xarray-based metadata tracking
> system with serialization to using page table like data structures
> that can be passed directly to the next kernel.
> 
> The key motivations for this change are to:
> - Eliminate the need for data serialization before kexec.
> - Remove the former KHO state machine by deprecating the finalize
>   and abort states.
> - Pass preservation metadata more directly to the next kernel via the FDT.

If we pass the preservation metadata directly between the kernels, it means
that any change to that data structure will break compatibility between the
new and old kernels. With serialization this is less severe because a more
recent kernel can relatively easy have backward compatible deserialization.

I'm all for removing KHO state machine, but that does not necessarily mean
we must remove the serialization of memory persistence metadata?

For example, we can do the serialization at kernel_kexec() time and if we
want to avoid memory allocations there we might preallocate pages for
khoser_mem_chunk's as amount of bitmaps grow.

It also would be interesting to see how much time is saved if we remove the
serialization.

-- 
Sincerely yours,
Mike.


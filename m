Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10374C55164
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w1Mc/92E8p+lO32h+qT72OZ7HfiwW0g4cTUB3qX11Fo=; b=s5XBAOnIJcZBQ3f3h4d9vaD3bN
	HFWwkb9ljgNLj2NqLw5z/oahdASXd97e07+uqrrh3n9bFwwFKz1Metv27fN5g8aKh4TSDAc8XmFxv
	/TLbqhmYG2x7WohohNzd0eTmZ33FeBZkIb8Vy4KMGyjsoe2yUjHyUAKFC1NI9GmVpXzcOLnFNgzCL
	RW8sHBTd7tT281jjZA/8LWMxOJUNhoozNasZ/GHC8lmQJFnkca9DcFMpVhIZ9ZUGjUVhtrjJefKys
	XIvOewgB0h59fqRR0RtGOnQ3kKx4z7b6l+4+s1XcXxudJGz/1IarUpOrv9m16KNs9Lz9MSBZ1LrxU
	37Y7CPxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTSm-0000000AycU-3CMH;
	Thu, 30 Jul 2026 16:18:28 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpTSk-0000000Aybk-1lQV
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 16:18:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w1Mc/92E8p+lO32h+qT72OZ7HfiwW0g4cTUB3qX11Fo=; b=H30XaJZQ7r7auy62y8eZtVmoVV
	G3l/41e0XdTegoohny+WA7lpvZpnLqqWgSSfj3UghOP2rLGuXgaSg+ZyfpuIRwgiktDQpjd+3saSp
	jp3hBS/EkFWKZMM+b7EempEwkf9zqNMhTW4hQU+6Baa8bJgwYrDLEZYX4gJCRbZ8GpS1dA7/dnuMx
	Epr/T7iZlu2URIwpixBO6Gm6IAjbRZdoId/JN8sOFhwmPGkpnOgq6kXOSH9kwwZQSxDLFvpg2Py6D
	ZnGtkfqjo7577UuywvqOr+ppHiYlH6oYRoll8Y8i3Df7bPv6jUn+fzRsJi+adm3g+jQ9bIMfh4mQv
	7+DCfA/Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpTSQ-009MZJ-24;
	Thu, 30 Jul 2026 16:18:06 +0000
Date: Thu, 30 Jul 2026 09:18:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, kernel-team@meta.com, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v2] kexec: keep the next kernel off hardware-poisoned
 pages
Message-ID: <amt4s9gKB7Dfpjjk@gmail.com>
References: <20260730-kexec_posioned-v2-1-f92d18551f64@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-kexec_posioned-v2-1-f92d18551f64@debian.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_091826_460508_3524E041 
X-CRM114-Status: GOOD (  15.21  )
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

On Thu, Jul 30, 2026 at 08:55:50AM -0700, Breno Leitao wrote:
> Memory failures (such as unrecoverable ECCs errors) are getting more and
> more common. The kernel knows how to handle it while running, marking it
> as poisoned (and SIGBUS user tasks).
> 
> Poisoned memory is removed from the buddy allocator, but, not from
> other places. A current problem is that kexec will load new kernel
> on top of a bad/poisoned memory, which is undesirable.
> 
> If the next kernel's image, initrd or purgatory lands on poisoned frame,
> the relocation copy writes to the bad memory and the machine checks
> during the kexec.
> 
> Skip hardware-poisoned frames when placing segments: check them in the
> kexec_file hole finder so it lays the next kernel down on good memory,
> and reject a poisoned destination in sanity_check_segment_list() for
> the kexec_load path, which cannot relocate.
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changes in v2:
 - change from pfn_to_page() to pfn_to_online_page() (Miaohe Lin)
 - Return the poisioned address once we find a hit, to avoid O(n^2)
   chcek. (Sashiko)


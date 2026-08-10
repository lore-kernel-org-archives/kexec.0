Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76731C5AE49
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ShdhYTN7VXanrMxGBiRoKkMNiBC1EYaMKFKCBl48mZA=; b=Ku/Q4F4cDIV4E24BtjB/IyGg1F
	iWFUNc1Butzx8clUHmLNavwc9qJMW2CUB6/80lKUZg1EGZHB+sET6vXW9KYSijq9TR+oquisNlHXX
	Z9K0iQIMam3eW/1OXDgh6gS8Hc+2bzfe3gsFYSfbGGjfoAvZ2RoZlTncutfW68vPNeQI/hsBd8csJ
	fra7ix+qsiZmpZTnzHH6rLbS4rkkLEervzRt5FXkXbfr1VLaYX+dQGEURR/LpAqAG9/IUrelqBh9t
	YH76MJO/ufxwF3BYhfXRd35HnjUG3Te4dAlUI4aYC7kbed4QKUwHyS84lXlZhMxirSCMTS9FRa3Pj
	qr1eaovA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQZW-0000000BwXj-41AS;
	Mon, 10 Aug 2026 14:01:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQZV-0000000BwXH-45j7
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 14:01:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 619F74047E;
	Mon, 10 Aug 2026 14:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359A41F000E9;
	Mon, 10 Aug 2026 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370503;
	bh=ShdhYTN7VXanrMxGBiRoKkMNiBC1EYaMKFKCBl48mZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fv8tCIz6OJ4rivSB8rzYXOymT6D5z8HgevUrzUBgndP114hVoydAIJZ5RiEUQclC5
	 CY/cpoNqYkeImQhm9rV+YKck4OP4+bBqvvZslb666+gYFAKLV0avGdI07hXNFBjPpS
	 T6rqzTqPQ2Xb2v5ojYrrVaEqr1ANgiKwfwZT2kxoUIrJuVsjxiVd5OF088IeYXsvR0
	 l63W9Jqfo6OTSyt6eeJ6E3iXbUZXChNoesClU/DlCqQnyRnnP62/QNpDgRARzk71VD
	 An9kUiw3IwQE5U1JO3Y9+byaVDjG2kHCGF8p0bWVTQsh0oRT+n4abIBXx6SIAmZkb/
	 VDklH4q5w70Zw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <ljs@kernel.org>,  "Liam R. Howlett"
 <liam@infradead.org>,  Vlastimil Babka <vbabka@kernel.org>,  Mike Rapoport
 <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Baoquan He <baoquan.he@linux.dev>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Miaohe Lin <linmiaohe@huawei.com>,  Naoya Horiguchi
 <nao.horiguchi@gmail.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  rmikey@meta.com,  riel@surriel.com,  kernel-team@meta.com,  Kiryl
 Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v5] kexec: keep the next kernel off hardware-poisoned pages
In-Reply-To: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org> (Breno
	Leitao's message of "Mon, 10 Aug 2026 06:32:04 -0700")
References: <20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org>
Date: Mon, 10 Aug 2026 16:01:38 +0200
Message-ID: <2vxz7bly6pml.fsf@kernel.org>
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

On Mon, Aug 10 2026, Breno Leitao wrote:

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
> The two hole finders walk in opposite directions, so each asks for the
> end of the poison it has to clear: the top-down walk for the first
> poisoned page in the window, the bottom-up walk for the last. A poisoned
> hugetlb folio counts in full, as hugetlb keeps the flag on the folio and
> the poisoned subpages on its raw hwpoison list.
>
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


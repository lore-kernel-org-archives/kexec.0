Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0421AC53200
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 10:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4zFAPc+21MITv4dd8ElNkkULP/O/tRrJgt9WcudjgGI=; b=IhLHhDquiftCOKYxIwnJ/5tuhd
	lK4Qi/hijgFkbK3MU5cePtMoHQd7sjv8l1aD/LeDulEhkg3ZS7v5mxn9U8H0P8EeSx8AdrFUQAyK8
	j6MrwagunGqShA923UYTia3fFLLZmoJrIZiLrbTlC0+4Amhrd2bl5FycWd8nMcjNSF6tPkW1XKHcl
	ivopnPU7OPByJxZP+8GycWXDt1+9U/NMr5/b2Con0I9cepev82r72rrPYF9K/NaInw31+vyogE7AR
	nJHFB7+kro6NaB9UYshjNPXnki9nLFwIroJb41iSidalko38Oh3rVVN0U6D1R+04GV6ZXqcAS6Gp4
	hYf8VU4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1MM-00000007WBE-3aZt;
	Wed, 29 Jul 2026 10:17:58 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1MK-00000007WAM-1DOi
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 10:17:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4zFAPc+21MITv4dd8ElNkkULP/O/tRrJgt9WcudjgGI=; b=Z6ePZNkpTROPEHa8pGFfMtqFxK
	eSOION+l8gFyYqMBw9nHA1xm4vq0Cz7xUpPyRa9afGxlLDBnvcsW0GQjTqeYVDHCQkDAjg2xGG6QI
	yfsxRYTyO/DuD9whEFTxX8FgN4ScH4mpD++Y/jcF04k2aiaFLruOO12wCbR1LTBGhcbz+rr8EVO4M
	nt98u9Jlq+cNZlpXqEnOH/I1pK+uutwvoX2VMKyrZ/SbiIEcJiCEaLPkM5k1hINZzIeh6/fw8Fhfz
	7KXask+L9LjalX+pBDnUzV/fg9XX0jG03MsKHPDNu5p9YFCd3yRd7UOlgzEjL2c/cgRB8rtVUjlqp
	ncqY0D0Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp1M1-008NdZ-0X;
	Wed, 29 Jul 2026 10:17:37 +0000
Date: Wed, 29 Jul 2026 03:17:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, rmikey@meta.com, riel@surriel.com, kernel-team@meta.com, 
	Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>
Subject: Re: [PATCH] kexec: keep the next kernel off hardware-poisoned pages
Message-ID: <amnSy6PFh57T0buv@gmail.com>
References: <20260728-kexec_posioned-v1-1-160c81d180fe@debian.org>
 <16c18549-c9a1-ba55-91b8-52d9368ebbc0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c18549-c9a1-ba55-91b8-52d9368ebbc0@huawei.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_031756_329915_01D86213 
X-CRM114-Status: UNSURE (   9.76  )
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

On Wed, Jul 29, 2026 at 05:33:17PM +0800, Miaohe Lin wrote:

> > +		if (pfn_valid(pfn) && PageHWPoison(pfn_to_page(pfn)))
> 
> Should we use pfn_to_online_page here? I doubt we might meet the same problem
> in [1] if pfn_to_page is used here.

Good catch, thanks -- yes.  An offlined but not removed block is still
pfn_valid() while its struct page is uninitialized, so PageHWPoison()
on it hits VM_BUG_ON_PAGE(PagePoisoned(page)), the same failure as
commit d613f53c83ec ("mm/memory-failure: fix
VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory") fixes.

I'll switch to pfn_to_online_page() in v2:

      for (pfn = PHYS_PFN(start); pfn <= end_pfn; pfn++) {
              struct page *page = pfn_to_online_page(pfn);

              if (page && PageHWPoison(page))
                      return true;
      }

Thanks for the review.
--breno


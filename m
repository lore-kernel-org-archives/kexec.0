Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647B9C982DA
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/jmJ7LZZR/1sSBpc7h3MkpctCTbA/0VAY284FY63k8=; b=HOjJzpymzbQUUJb7kYLFSSjyj9
	v9aPwopPyhOxr49ipgfESJ7nyEm0H1etjXlK1MXZiRLBv3KB1F8NyBFphp6K9y2r95eSODVemqsEd
	zIzjVg1UF5m7CMF+TGxPhGh6zPYOZWt7lI98zPqwYZorgtkXEtKoiGDAQEUziHpeaC+rOeCMk9/ON
	xDu1SAJUHNFWExX1kIobtw0azmAuwSosZI4cbkv8yaHnSTbBvs9DTEtNT0dT/pvslwIfJKBbeXue6
	xKG8pQRzGeB02qPNa84Di9RIRo2J4ALsQ/y+ZZs6B9PkhHRVLTiFIprrsjP215CurJk0isSdrt0F0
	IgS+7xXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aVr-0000000EswK-1QJW;
	Fri, 18 Sep 2026 15:28:31 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aVn-0000000Esvg-2BtR
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 15:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N/jmJ7LZZR/1sSBpc7h3MkpctCTbA/0VAY284FY63k8=; b=JTa7w1HAnYJLKRzmXqqM/n26PT
	XVERCbe9w1NQse8+JSAoioonymw9wi5vLK9SsZzoN90WrTjgDiQwU+OaXAp86a5/Ii5tYXQO0izMZ
	WX3CS0Yp/ScF6ORLsZwJdjG0A8aw1LN3XlrQpakTWPsxfB8JhzZju1bTK5R9AUbrp80nVpHrrGN8W
	cO/aaM8VEcxuEkf9hIJ8w5Fw5SYwXC785b4tlNiGKvsPXbFNEfZX+l/g9v18MiAIoQ6lzvR5ExgL9
	wCKQBPI9INQ+fzEGLXsrYkcM/qtQ7d2mMNwXEyD6BVVjQsIoDNuO/UZoL9gq9ZB+qWbNT33nHTli7
	CDjYGqYA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x7aVB-006p7a-0M;
	Fri, 18 Sep 2026 15:27:49 +0000
Date: Fri, 18 Sep 2026 08:27:40 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.or, Borislav Petkov <bp@alien8.de>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Jackman <brendan.jackman@linux.dev>, x86@kernel.org, 
	kas@kernel.org, Suren Baghdasaryan <surenb@google.com>, Zi Yan <ziy@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, shakeel.butt@linux.dev, Johannes Weiner <hannes@cmpxchg.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mike Rapoport <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harry@kernel.org, rmikey@meta.com, kernel-team@meta.com, 
	driver-core@lists.linux.dev, riel@surriel.com
Subject: Re: [PATCH v5 6/9] mm/memory-failure: efi: answer whether a range is
 poisoned
Message-ID: <aq1Xr4b7BXZForCe@gmail.com>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-6-3bc7a57bd503@debian.org>
 <20260915134535.C3FC91F00899@smtp.kernel.org>
 <edafd246-0bd8-4335-9037-77f552968b56@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edafd246-0bd8-4335-9037-77f552968b56@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_082827_579498_317F1DDE 
X-CRM114-Status: GOOD (  11.53  )
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

On Wed, Sep 16, 2026 at 08:44:30AM +0200, David Hildenbrand (Arm) wrote:
> On 9/15/26 15:45, sashiko-bot@kernel.org wrote:
> >> The bitmap an earlier kernel filled in gets in this one through EFI,
> >> but nothing reads it back yet.
> >>
> >> Introduce range_contains_poisoned_memory(), which the page allocator
> >> will use to ask about a block before handing it out.
> >>
> >> Signed-off-by: Breno Leitao <leitao@debian.org>
> >
> > Sashiko has reviewed this patch and found no issues. It looks great!
> >
>
> David has reviewed this mail and it annoyed him.

Breno is curious what annoyed David here.


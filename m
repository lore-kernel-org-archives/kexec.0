Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA71E92FE0
	for <kexec@archiver.kernel.org>; Mon, 29 Dec 2025 21:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+0hKzidYvfWG+s9TtusbziTKi6XLXUnZ4Y1pxbN7Jvc=; b=dRY5QUougy5fXgT66OhKq08FxR
	PbXlPzuZZVbN73fsPdpbNdNn3uOJvYtYCRPOvnq1nr/zBWbgsqpY/MvxpOmQGiDSiT8AIyFfppC1R
	XaII8Tl5EeYRv/4L2gvAmVyRYtKwC2WLRWhIx1CqhbwCtz7FRsB4A4XBvTrrTQhJlzRiCs2nAZmbH
	LzTXvXxXtnqKJr4tK/PZw7QZiRqeVP+ZhFERv6fxHTq+woy8sGCdYLI74h6bsb5SaBXo7WaqyUORz
	BBWen139mkThaT7Ri4HIqk+LzOyqGVWBA+s7dGKo6JlRwiSUKIr8IST+DrDY7o+QbtqidL1fdiMWt
	ZUeAUJ1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKZz-000000044ih-3hBx;
	Mon, 29 Dec 2025 21:15:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKZz-000000044iZ-1S9V
	for kexec@lists.infradead.org;
	Mon, 29 Dec 2025 21:15:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 58F116000A;
	Mon, 29 Dec 2025 21:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E38C4CEF7;
	Mon, 29 Dec 2025 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767042902;
	bh=+0hKzidYvfWG+s9TtusbziTKi6XLXUnZ4Y1pxbN7Jvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jKY9UZlsTOJCp8mrSaW/YOoqI/r+yyNyFf2huGx4VFftVsJRCMpS4UchEWmSNJU2+
	 mmW/SR65hRZs3p/IS7waf1NjQ9aTDSyuxztBD1pNzRqCoQF95mGqFK75bOE8qiOsTh
	 r/34jl6+cJGesKLtTSrG0wiDLX0xjY3kxFF0yDM8QokptRaq8I7jRQ4niRqABeII49
	 A8Rz7bg+1ZrAHDw6vrD56WZ/IhNI7SrXFPMEOUt9GgTg5RArbxf9AqMyAQ0D8X7rC8
	 ZOtaBzMp1jsL14bwuklPgimM0VCDonLAQ3ZKPaY9/XbQn4TXWFX/cGXEO9V0n2jsnv
	 Kjh2IexLkouyA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam
 R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,
  Jonathan Corbet <corbet@lwn.net>,  Thomas Gleixner <tglx@linutronix.de>,
  Ingo Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>,  Dave
 Hansen <dave.hansen@linux.intel.com>,  x86@kernel.org,  "H. Peter Anvin"
 <hpa@zytor.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Alexander Graf <graf@amazon.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Vipin Sharma <vipinsh@google.com>,  Zhu Yanjun <yanjun.zhu@linux.dev>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  kexec@lists.infradead.org
Subject: Re: [RFC PATCH 08/10] mm: hugetlb: disable CMA if liveupdate is
 enabled
In-Reply-To: <CA+CK2bBeJwACBiKsuXLcbzC4m0zLhu0yNg2HDGR=AQGeEVCJjg@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 23 Dec 2025 13:16:57 -0500")
References: <20251206230222.853493-1-pratyush@kernel.org>
	<20251206230222.853493-9-pratyush@kernel.org>
	<CA+CK2bBeJwACBiKsuXLcbzC4m0zLhu0yNg2HDGR=AQGeEVCJjg@mail.gmail.com>
Date: Mon, 29 Dec 2025 22:14:50 +0100
Message-ID: <86v7hp7zxx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 23 2025, Pasha Tatashin wrote:

> On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> Hugetlb live update support does not yet work with CMA. Print a warning
>> and disable CMA if the config for live updating hugetlb is enabled, and
>> liveupdate is enabled at runtime.
>
> Could you please elaborate this commit to explain why it is not
> supported, and what it would take to support CMA.

The main reason is that when HugeTLB CMA is enabled, the huge pages come
from CMA. If we have preserved pages, we would need to "insert" those
pages into the CMA when they are restored.

CMA does support multiple ranges, so I suppose it can be done, but it
needs some plumbing to work properly.

Will add this in the next revision.

--=20
Regards,
Pratyush Yadav


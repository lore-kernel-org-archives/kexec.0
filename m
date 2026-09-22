Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78381C982FA
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 12:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjn6H9bAPusg9K8m56V4G1qk8427IsHI5UeWzmUJBww=; b=CpE8wb0aTtQu5laYeNxMSEUWuc
	Yg5Jn5CEODgLrdzrbPlwnx1wZYjQiDJBqZYZsOGdwIIIFZtO9jBWUtSOUCqUuLtB8QKRK8MPgzrcI
	fAOyWvVdHt2oGDOwBqRlFGx+HV7nOl0yj+pvPb9ZW8r0jz0Ax532J94s6Xdd/HGiPrViNZwSPiJJT
	YyK2VLy/XhWe9kDVrOYqCitEHJTihWdS3c8serEp4id40K5q4byc+Os1x2I7FgD2F8P3GXq8su43g
	QbtEAqU1b8JwK2KdrEgxzHTacNAEgnHoynqbECM3GZULBtR5lHsatc3soGdSRZ1mL/JChXkbBp7+z
	ITv6WWJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zxz-00000005MsJ-20RQ;
	Tue, 22 Sep 2026 12:51:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8zxy-00000005Mry-2j1l
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 12:51:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D9F6160DE9;
	Tue, 22 Sep 2026 12:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3132F1F00893;
	Tue, 22 Sep 2026 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081481;
	bh=bjn6H9bAPusg9K8m56V4G1qk8427IsHI5UeWzmUJBww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZDpmoKnkXHYvgzWDcXnkPtfTAO4v0F1RscKB2fTnyZdqTfqeB8e97fRQ+cvLiJzvi
	 fgtbgN39wAvaTedzLC7nH363xblfKf51JwbGpFsDV5ceVV1tKBHyppmMluDntmarUM
	 U/YPxsFIdvCFV/yM//9wBfgvhnkZE5MCbaPTe4KVxCbC4jDaVy4mmA8r8Z8VLUfYYO
	 GEtV4JdUTWiHgcGUAYxi3Oytv9PRiyzGo78QyLDtIl0wdvqW8jwcRMt4o3CsPNvRBD
	 /GUn4U2YIQnOzBci4AoYgn1zojzErZuH9TO4AcrJsNrQUfE9oJWBMaYoqNPS6u45uQ
	 j4BLCYvl0v8/g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9D4B41980052;
	Tue, 22 Sep 2026 08:51:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 22 Sep 2026 08:51:17 -0400
X-ME-Sender: <xms:v3myaqO1dJPBBp2pNjko1t5k8FQl_hc03Kdfb9AYFnNOuyG4iLR2jA>
    <xme:v3myanvKy0YCF5GpjVA1evG7y3p8XhUh-KR1TqJq1uq7pKQ0IGJf1uU6CQrAhySyT
    K19JLBuqm3DMdxinXVb2J7xaGy17Zil4GTrpqJJnoQw-9z-HCxljWU>
X-ME-Received: <xmr:v3myajdxZgA5ab59yvkNNapjP2aGmt6aEtXJu7dPZxiT_mpeRjIJGn400Wg>
X-ME-Proxy-Cause: dmFkZTGJsDyAcE8QiCZz6dfbgOk9P/ImhfvjdTgEGi1dyPDTortTmKMOuYz4ch97JTuIJY
    fCTeb/jUDs7RR8+EO82LYzphUG3CyOtSymtz/L464Wc9DfgUawrMcTy2lA/clKyJoAksX0
    ZH839lnzNd/xvI9x9FHSP0kzB6tqsirVPUdHuDCIJ/wWCTBeNdhCrHmzdo6sUbJdKR/2O/
    sWo9+A4BnuafPVatN035tZ09J6Fj99W4S+sDDcIwrbw5dyhaeZ44nnTKKearwgnnRyhT8p
    2DheY2M4Nvuau7iuiAq3/CO0Qk8O5FLAWWU3996mTM//yGu/EY0oyjBeIKfGh7ymLgF2dO
    XupXwF/czUZ2NpcRi/n/HbJd73UF6MopxxDLQXZZTZVEIq8jwxTtntgz1Fudldxc+duznM
    zyN0Jj4dGAXH3J5iS2JrkGwjaln77bkaPrm/ycPIVoKlFDoDCRdxpscdTHnPCICqfqS73s
    hy2SSZD3R9IdvfMM3cVc0eArLzOPt7zot16Rvzjau0S0mryVCZR9cKZJPrITNaxC2WJwRz
    fnTwgIn7q07MgFSsf9rXprcLoqngdr9uLOAXpUXXoVfYM4O+/VQT2vrRpXrrKl6q73ti/q
    doU1LkDyfW1eee9VOUfwBk/tMFKY1IzwPGNO8VK00HRjFLNHKhCBI+4vXJKw
X-ME-Proxy: <xmx:v3myavMzzUcCooHWAjag_NsuwtOzP4qcAfrSEqhzqAEebaztzsxEWA>
    <xmx:v3myamsaWir7lZYy4jpF5EYv1OuaZf2fvO0h0ncnscgZm28WUYCh8g>
    <xmx:v3myao3hUXsCT3LxEmOAAr2Uf60p7xl8XEP1QkfNUvC2ST3uj26bFw>
    <xmx:v3myam9xe1K-RT_7T98Kg09Zq9aohOe4xyGMtGQQZuaj89gdtRJ_2Q>
    <xmx:v3myaukgoi2czh2NEkzuD_dpAYttVrftyzu5kkVWaZA2uWmvyAeQA0st>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 08:51:09 -0400 (EDT)
Date: Tue, 22 Sep 2026 13:51:08 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Ard Biesheuvel <ardb@kernel.org>,
 	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 	Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, 	kexec@lists.infradead.org,
 Lorenzo Stoakes <ljs@kernel.org>,
 	"Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, 	Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, 	Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@kernel.org>, 	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 	Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 	Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 	"Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, hannes@cmpxchg.or,
 	shakeel.butt@linux.dev, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-mm@kvack.org, rmikey@meta.com,
 riel@surriel.com, harry@kernel.org, 	linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v5 7/9] drivers/base/memory: count inherited poisoned
 frames into the block
Message-ID: <arJ5I9QHHBvuGH_F@thinkstation>
References: <20260915-hwpoison-kho-v5-7-3bc7a57bd503@debian.org>
 <de41b78a-8471-4832-be0c-35d410a4499a@kernel.org>
 <aqpczrtIwSG948iv@gmail.com>
 <b8ad366a-a019-4462-9dce-f687f60ee7f2@kernel.org>
 <aqvHHHuWJ-y4WRJZ@gmail.com>
 <caac2cb9-8faa-49bc-ae8a-47c5fd7b7e58@kernel.org>
 <aq1RaH0eE0hZfNpr@gmail.com>
 <fb2237be-f7bc-4ad6-bcb0-7c3ef53136ef@kernel.org>
 <arE3UjqPsxctWckg@gmail.com>
 <ad2ed3ed-959a-4af3-a2f5-4c21e5af62d6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2ed3ed-959a-4af3-a2f5-4c21e5af62d6@kernel.org>
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

On Tue, Sep 22, 2026 at 01:33:51PM +0200, David Hildenbrand (Arm) wrote:
> On 9/21/26 16:31, Breno Leitao wrote:
> > On Fri, Sep 18, 2026 at 10:16:25PM +0200, David Hildenbrand (Arm) wrote:
> >> On 9/18/26 17:22, Breno Leitao wrote:
> >>>
> >>> Right, we have two source for poisoned page information, today.
> >>>
> >>> 1) LINUX_EFI_POISONED_MEMORY: Used to track memory block that got
> >>>    poisioned, and will be passed around during kexec.
> >>> 2) PG_hwpoison on struct page: Used by the memory subsystem to avoid
> >>>    touching it.
> >>
> >> How are both kept in sync? See below.
> > 
> > The EFI table is only written when there is a memory failure. That is
> > the only thing that writes to it:
> > 
> > 	action_result() -> efi_hwpoison_record_pfn() -> set_bit()
> > 
> > You can see it on patch "mm/memory-failure: efi: record
> > hardware-poisoned frames into the poisoned-memory table"
> > 
> > Then, when the kernel kexecs into a second kernel, the EFI config table
> > is queried and the pages are poisoned from it at boot, as they are
> > getting into the buddy allocator, in __free_pages_core().
> 
> I am not sure that is really the right place. That means we only poison free
> memory. Shouldn't we poison as soon as we initialize the memmap, and check
> whether any memblock allocations ended up on that poisoned memory and bail out?

__free_pages_core() is how we hand over pages from memblock to page allocator
initially -- from memblock_free_pages(), deferred_free_pages() and
hotplug. It is the right place to never allow them on free lists.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


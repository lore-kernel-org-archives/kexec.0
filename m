Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407CDC5B572
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8mfqQYpJG4Z8J2l9JjdOqW1TWeahmTbum2iA6ehX2+g=; b=uy9l4JbwIvA56Sx6gcMKVFm9YY
	peEqWXcgg3vJmAON1vZQM2SL0wE/z/pWOkDvp50/iTFNYUeTMeUhVw0nMaH6TxTGf1lIhZBMeL3Ys
	AnCqLHaaWrT+M460rXEzMnQI0wz9f+T0+i/EdZNf21+o4mSyXSQH9w2caTNQJwtD/ZX1/0kUwbBPP
	JT19w6PjXJp/nJ2heae3s1rRwHkkP7zJ87GoiS3DrOYInotX2nRQ+SCbOUp0BLki2MpeCmZmc/Axy
	/wPbKIbKfEGb4YcrokHlIiIXPEMLOwmC54JyJVMcHURI9Scevsl8IZ0htic1SmdXAE7jNg7SiMtFg
	RHQZ/L1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7nW-0000000G9vV-2i4z;
	Wed, 12 Aug 2026 12:11:06 +0000
Received: from confino.investici.org ([2a11:7980:1::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu7nU-0000000G9ub-149j
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 12:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786536660;
	bh=8mfqQYpJG4Z8J2l9JjdOqW1TWeahmTbum2iA6ehX2+g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Z0GoJT6oZ2E7z/tP/DLMI9/1CiRr+s7B5Brw9oseXNCOERPWQYVvmqIZHeWudRXwM
	 XsvorshiurXHZeIbeTL8CJqvCfP51lTXWY46QVWJiX0Z6NfhS/R5kKR1V7DqgYNZDR
	 mHNZV+tP+WHCnEA5yagYxH7As2SvnkP7tJmeddzU=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hKnQD4gJ4z10yH;
	Wed, 12 Aug 2026 12:11:00 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hKnQD1X4Tz10yG;
	Wed, 12 Aug 2026 12:11:00 +0000 (UTC)
Date: Wed, 12 Aug 2026 13:11:00 +0100
From: Bradley Morgan <include@grrlz.net>
To: Breno Leitao <leitao@debian.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, rmikey@meta.com,
 riel@surriel.com, kernel-team@meta.com, Kiryl Shutsemau <kas@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_0/2=5D_kexec=3A_keep_the_ne?=
 =?US-ASCII?Q?xt_kernel_off_hardware-poisoned_pages?=
In-Reply-To: <anxhWTKwMvkVHBPs@gmail.com>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org> <6D17A62B-3124-492F-9593-63F857DD475F@grrlz.net> <anxhWTKwMvkVHBPs@gmail.com>
Message-ID: <960FB52E-6229-42DA-B01C-B61878E75D2E@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_051104_445254_0B19E9E5 
X-CRM114-Status: GOOD (  10.28  )
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

On 12 August 2026 13:07:49 BST, Breno Leitao <leitao@debian.org> wrote:
>Hello Bradley,
>
>On Wed, Aug 12, 2026 at 12:36:59PM +0100, Bradley Morgan wrote:
>> On 12 August 2026 12:31:50 BST, Breno Leitao <leitao@debian.org> wrote:
>> >Changes in v6:
>> >- Split the pre-existing top-down underflow out into its own patch, and
>> >  drop the "if (poison < kbuf->memsz)" guard from the hwpoison hunk now
>> >  that the loop bail-out covers it. (Mike Rapoport, Sashiko)
>
><snip>
>
>> >- Link to v5:
>https://patch.msgid.link/20260810-kexec_posioned-v5-1-95e1b5e2e656@debian.org
>> 
>> This is a two patch series with one patch, why?
>
>This is a patch series with _two_ patches, isn't it?
>
>	[PATCH v6 1/2] kexec_file: stop the top-down search before it underflows
>	[PATCH v6 2/2] kexec: keep the next kernel off hardware-poisoned pages
>
>If you asking why it was split, we decided to split the fix into
>a separate patch, and keep the "feature" in separate patch. The
>discussion happened in
>

I'm only CCed in 2/2 :(


>https://lore.kernel.org/all/anskyrEVUlnTVEgF@kernel.org/
>

Thanks!


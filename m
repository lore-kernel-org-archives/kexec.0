Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50070E92FD6
	for <kexec@archiver.kernel.org>; Mon, 29 Dec 2025 20:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFOfciBWxGED9ovPE7cH1JV9gALiFqQxu0wxUOdjvnE=; b=C658SnSYYgrFhvjDFWMps0JGT8
	mBE9niUMu4oociEq3vTdJ/BVxDWllJ3mU3bMrzeBDAVeGEVsUH8rkj73kqoeMx0NvIOsMzlwYQfZB
	jsKar/sNc/pIIpReu2sfOkPPWmCQMSqWDBUDHFe9QFKiIba/v1WGZb8hK7eVYJALgmP49I4a9Yj1a
	nnbxGNelOGosGLxaU4YdVPPch3qRAMOv0zVYF5vJ6JakugKfNOmi5TQ3qSE2l4Tou0cAQpDEqIuIg
	GniT8fhEzV6vrfbPC34E/BMBGWTwitEWBf5RJMv+d6DMEqQwwSQM8B/ACCChqvXR71oXqrySnS9uj
	NL4gGCLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKES-000000043yo-2HuW;
	Mon, 29 Dec 2025 20:52:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKEN-000000043yR-0d2U
	for kexec@lists.infradead.org;
	Mon, 29 Dec 2025 20:52:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E3E6742A99;
	Mon, 29 Dec 2025 20:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5167C4CEF7;
	Mon, 29 Dec 2025 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767041561;
	bh=MwPgzvD78n3pW90vWtwAVJoET5+u4jzMiVKZ1kjYoMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UgX7+AkltaYMgD/psdVzZtaRdtN4IQkW/L62pxQLIpOZU5+2igPik9iHaYIuXbpvn
	 lf+6ZtmgovxFo3WJ/g5L6uwhSXEko/5MDlib/U+xUEZlrqWeBeELPMqGTtB0NWebdA
	 tlL8FScMql/gqwNNxDZXkYeoNAFrKbJsZJTsgDAEQRI0MUx67zlDWAHtTzRHv0WN+v
	 hzH5NVYupexrRdVyfO1thgNLpV604PjbDfTz9Fcw3H+ZCPMkJKkNSeI8szZcV6vCbB
	 uvZe6Ewy0vj89rsxgYcrgjxOKXpkOLc6mUZlDGceI9K/HvTvMyM/1gaeLqKJGSU80z
	 d3ntCSsWSi/IQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Mike
 Rapoport <rppt@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: simplify page initialization in kho_restore_page()
In-Reply-To: <CA+CK2bBv2wpduYQF_fwzciH4HxZ6eFjwZMSpZwW0AC6KXL4msg@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 23 Dec 2025 12:49:39 -0500")
References: <20251223104448.195589-1-pratyush@kernel.org>
	<CA+CK2bBv2wpduYQF_fwzciH4HxZ6eFjwZMSpZwW0AC6KXL4msg@mail.gmail.com>
Date: Mon, 29 Dec 2025 21:52:37 +0100
Message-ID: <868qel9fje.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251229_125243_211965_9CDDCEED 
X-CRM114-Status: GOOD (  16.97  )
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

> On Tue, Dec 23, 2025 at 5:45=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> When restoring a page (from kho_restore_pages()) or folio (from
>> kho_restore_folio()), KHO must initialize the struct page. The
>> initialization differs slightly depending on if a folio is requested or
>> a set of 0-order pages is requested.
>>
>> Conceptually, it is quite simple to understand. When restoring 0-order
>> pages, each page gets a refcount of 1 and that's it. When restoring a
>> folio, head page gets a refcount of 1 and tail pages get 0.
>>
>> kho_restore_page() tries to combine the two separate initialization flow
>> into one piece of code. While it works fine, it is more complicated to
>> read than it needs to be. Make the code simpler by splitting the two
>> initalization paths into two separate functions. This improves
>> readability by clearly showing how each type must be initialized.
>>
>> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>> ---
>>
>> Notes:
>>     This patch is a follow up from
>>     https://lore.kernel.org/linux-mm/86ms42mj44.fsf@kernel.org/
>>
>>  kernel/liveupdate/kexec_handover.c | 41 ++++++++++++++++++++----------
>>  1 file changed, 27 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexe=
c_handover.c
>> index 2d9ce33c63dc..304c26fd5ee6 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -219,11 +219,33 @@ static int __kho_preserve_order(struct kho_mem_tra=
ck *track, unsigned long pfn,
>>         return 0;
>>  }
>>
>> +/* For physically contiguous 0-order pages. */
>> +static void kho_init_pages(struct page *page, unsigned int nr_pages)
>
> Here and in other places below, it is better for nr_pages to be
> unsigned long. This is consistent with other places in mm, where we
> have gradually moved on from int/unsigned int to unsigned long for
> npages (see gup.c for example). Otherwise, LGTM.

Thanks. Will do.

[...]

--=20
Regards,
Pratyush Yadav


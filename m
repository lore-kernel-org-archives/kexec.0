Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF616FF886F
	for <kexec@archiver.kernel.org>; Mon,  4 May 2026 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tVb+ppMB0w8s3UvWnM7bUt3mkeqrxtOjP4Bg9jTK9xs=; b=ss7obupBUUQ3yTFY39uBAzI3+7
	QMRwW2uqmbx75jfRVNkL00zk1wNaBOoPOL3BRwPCvfVPa+xJS80jEn8SbEvjiXlMtTj4rXjYfnXj5
	ioVpAoS1sED5oIg0G2jGXZrTzPYtyROfAQgkZl8RU7MKkCIW0jO/+9oHU9lJIrO64qeIdQXS/WmVq
	9i8k3qAUmyt5r2ykKTCa+8P2Wep1wcIrlg7pvpjb8S1umMCkDotVeCj733ARDFr6A+uLkyeLyACZL
	lzRxvr0o3lwHRePOSlTNksIJkaMY3gL5nnGY4N7HrDQ1kTGqe0hBNjGF/5+3SnQFlvpBwzrUpE8FS
	Wk8AKQ5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJsSA-0000000DAAz-0l9i;
	Mon, 04 May 2026 12:31:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJsS6-0000000DA9f-2y9u
	for kexec@lists.infradead.org;
	Mon, 04 May 2026 12:31:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DDE2240326;
	Mon,  4 May 2026 12:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51516C2BCB8;
	Mon,  4 May 2026 12:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777897869;
	bh=NPNbC063QOfWG5TCrFhK1JH71yuTWi/FepePvYALnQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KNNU7bwpyY9vGuO2B5LRRiwBmdQM48/MI7eTNCBHqV7ntd1c5gB87cTdUbAtRMhXy
	 zTnSZhjE7VW33WT1TXwl6QP69riPJ5I5YIQToisIlhbrS6ZL5zWYT5CchS0QTEpOZm
	 dmQsbbPa5lnvLMYrbH5Vt/gVThqBdZGxdbYygzsF+LD/A5ExZl5AvW2uGcQs6RKgv2
	 9WamxQKCwoHPrN/gnTh3HZeXZ/RdnYWSDTRryzrJVLdyfk6IZFpxo1RUiV9lxlk5bA
	 kDmZW7om+r1aAMMZZtLgXdsSEJpFAeRIkPRBFF0C6G1k6k2V+rX6naG+bqlWbWs4Zx
	 +drSNMW/parbg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  Michal Clapinski <mclapinski@google.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock tests: define MIGRATE_CMA
In-Reply-To: <CA+CK2bChn3bAFBnmD-fNw2zh-JrAaA73DNmm416EbjXr=mTakA@mail.gmail.com>
	(Pasha Tatashin's message of "Mon, 4 May 2026 06:32:11 -0400")
References: <20260504102742.3833159-1-pratyush@kernel.org>
	<CA+CK2bChn3bAFBnmD-fNw2zh-JrAaA73DNmm416EbjXr=mTakA@mail.gmail.com>
Date: Mon, 04 May 2026 14:31:06 +0200
Message-ID: <2vxz8q9z2w6t.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260504_053110_764924_E23B2565 
X-CRM114-Status: UNSURE (   9.18  )
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

On Mon, May 04 2026, Pasha Tatashin wrote:

> On Mon, May 4, 2026 at 6:27=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>>
>> kho_scratch_migratetype(), defined in include/linux/memblock.h uses enum
>> migratetype. This breaks build for memblock tests with:
>>
>> ./linux/memblock.h:634:73: error: parameter 2 (=E2=80=98mt=E2=80=99) has=
 incomplete type
>>   634 |                                                        enum migr=
atetype mt)
>>
>> Fix it by defining enum migratetype and MIGRATE_CMA. As is the case with
>> the other headers in tools/testing/memblock, do not bring in the whole
>> thing, only what is needed.
>>
>> Reported-by: Mike Rapoport <rppt@kernel.org>
>> Closes: https://lore.kernel.org/linux-mm/afcdDm4aAJvNaQqH@kernel.org/
>
> Link does not open for me.

Dunno why. Works fine for me... Maybe some temporary issue with lore?

[...]

--=20
Regards,
Pratyush Yadav


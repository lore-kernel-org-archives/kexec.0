Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C772C28B25
	for <kexec@archiver.kernel.org>; Fri,  7 Mar 2025 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6uBJ1YUDIOKuMkF8J+Ow27cEIe6pHr5CJF/jr/dLLA4=; b=hPNh8nNKQa3i8wejWSDp3seOvY
	x7sEyaS3LX1ECxdsmBUUJTtr2LJ9qAs0GuD2jB0JXcbVlylAs8skLOysh5ug27G74qaJnR2YJDZMz
	Ej6JXu05zdVsmaOWN/OftRr82kuLHTCAXPOj/H+csQeRrKJQBIQZA+efSQeSthsyzeXzSvEGRuUAw
	miK9rywkqgUbD/5PiGn1TfD157Y32INdhWm/vo9/n3g19ggdHOh160jH8WaiwLQuW9+WX4NX5H7iu
	d88QQVlmckhR66B6kgPvIO/DunJs/opeD7ODpYa9dsCHkpHWukDid917UVHLL0NJADIAcQstHAwBy
	EVFVgTbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZhM-0000000EgJr-19QC;
	Fri, 07 Mar 2025 15:33:16 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqZZV-0000000EdxH-0WIN
	for kexec@lists.infradead.org;
	Fri, 07 Mar 2025 15:25:10 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E458441061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741361108; bh=6uBJ1YUDIOKuMkF8J+Ow27cEIe6pHr5CJF/jr/dLLA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U+c0IOxtLK/yHL6U9gVkTGNWfKeHe7Cxjetxvjp7L3+fhF0t5VqDLayHbnkOecFGu
	 qYn3EHi24lLNRlLwjvlcLjABGf3zNwLrc8NYTpQSqMb92Gzc3qmlijh49B1IC8QrGG
	 UGpuzlIDPTGX+TwKiLQ0xQM6aM9HjXgxRQ5961CtqRyW7hfcBlIFZrACerkGfbpFkp
	 qu8xTV/BIFh3GFTh4pYOiZCjBYXHWrLS+X/cWVmYzCIxv2PeaasmQLVOj730bUc7dd
	 7PzVO1c/UzvHCkp59SI9KNrfQho474Mgp4bMa0u0xA2UxewlYHUGniiP9REVJ7Voo4
	 LlVqxpyEj6WqQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E458441061;
	Fri,  7 Mar 2025 15:25:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Hugh
 Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse
 <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport
 <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
 <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dave
 Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Wei Yang
 <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/5] misc: add documentation for FDBox
In-Reply-To: <mafs0v7skj3m2.fsf@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-3-ptyadav@amazon.de> <87ikok7wf4.fsf@trenco.lwn.net>
 <mafs0v7skj3m2.fsf@amazon.de>
Date: Fri, 07 Mar 2025 08:25:07 -0700
Message-ID: <87ecz87tik.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_072509_163241_90DFFEA5 
X-CRM114-Status: GOOD (  17.83  )
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

Pratyush Yadav <ptyadav@amazon.de> writes:

> On Fri, Mar 07 2025, Jonathan Corbet wrote:
>
>> Pratyush Yadav <ptyadav@amazon.de> writes:
>>
>>> With FDBox in place, add documentation that describes what it is and how
>>> it is used, along with its UAPI and in-kernel API.
>>>
>>> Since the document refers to KHO, add a reference tag in kho/index.rst.
>>>
>>> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>>> ---
>>>  Documentation/filesystems/locking.rst |  21 +++
>>>  Documentation/kho/fdbox.rst           | 224 ++++++++++++++++++++++++++
>>>  Documentation/kho/index.rst           |   3 +
>>>  MAINTAINERS                           |   1 +
>>>  4 files changed, 249 insertions(+)
>>>  create mode 100644 Documentation/kho/fdbox.rst
>>
>> Please do not create a new top-level directory under Documentation for
>> this; your new file belongs in userspace-api/.
>
> I did not. The top-level directory comes from the KHO patches [0] (not
> merged yet). This series is based on top of those. You can find the full
> tree here [1].
>
> Since this is closely tied to KHO I found it a good fit for putting it
> on KHO's directory. I don't have strong opinions about this so don't
> mind moving it elsewhere if you think that is better.

I've not seen the KHO stuff, but I suspect I'll grumble about that too.
Our documentation should be organized for its audience, not for its
authors.  So yes, I think that your documentation of the user-space
interface should definitely go in the userspace-api book.

Thanks,

jon

(Who now realizes he has been arguing this point of view for over ten
years ... eventually it will get across... :)


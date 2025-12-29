Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81530E92FE0
	for <kexec@archiver.kernel.org>; Mon, 29 Dec 2025 21:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IFBTXFUtqPcg1tLY2+KvZ863A9bOk+zjL0Z86ZoeYHw=; b=3257Gy40kgvN+trx3nYF3IhBjU
	5QP6pr1TRHonHvh2qwCQCqThbgnTJZa31YCXdTURjJJ5CsF3CA8KgO01Zum3pST7565ETPExA1Ppd
	cvyPcMbBtEv1wPG2WIjUKHi9bLVYttmC1vHEfUazGzqNm7za1cx2BPsiNH04MbJWbqsNFL42qOkBA
	zNyWs4vgP/988v/H74NgP4oRV0YgDYXk9qiPzriMndoLa+WzAs+cP3y813uTR9oMnHUXj1PVfyidW
	u6w6VMqoBlrzkTUxqb6vR/yTlQ8TBWiHb8kjAP0PAAmKOYOO2+znD/15lIUBk4YmsgVizXRgp0BUg
	hIuTHNWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKnC-0000000459h-1kV4;
	Mon, 29 Dec 2025 21:28:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vaKn9-0000000459M-2RlV
	for kexec@lists.infradead.org;
	Mon, 29 Dec 2025 21:28:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F5EE43F3E;
	Mon, 29 Dec 2025 21:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F370C4CEF7;
	Mon, 29 Dec 2025 21:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767043719;
	bh=SVRqYR0GXBh37EIJDTe7QP6vSom4boVYlTrlJiH7Y3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jHPY0Zio4UWt0Jmie7XDhylPHKe4oeCNafzP75gZq+v2MHP/cHARsw1IvKXp6pZs3
	 VTYUGouFCZwVkUTMADLvPuHp22ZPOzpY/hEBy61azE/0jQl33SnjvIZ/fAXdRKZyUS
	 C0fVsk8KmYItSJo8KycqEcqD1J5WeUUu22DFatpuQ0Zvxg7yOCosB/EBu3u3jZAfjO
	 jrUdmThHREyv8RBcILupv7zDt03yOYEnTav0jTYjUsvYfBCxQI+Iw3RHvYXusasxGy
	 qgm20EGBgpnFZHnEdqjZNnQ2cPSrWDLkAPsn+PUi80K0IDOhqeoPic9S0U22uMTwNc
	 hY4CnEv0Ihteg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,
  "Pasha Tatashin" <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  "Andrew Morton" <akpm@linux-foundation.org>,  Dan
 Carpenter <dan.carpenter@linaro.org>,  Jason Gunthorpe <jgg@nvidia.com>,
  Samiullah Khawaja <skhawaja@google.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason Miu
 <jasonmiu@google.com>,  <linux-arch@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in
 vmlinux section
In-Reply-To: <e4d1c333-7e22-47ee-81a0-2efc4ca6b17c@amazon.com> (Alexander
	Graf's message of "Sat, 13 Dec 2025 16:10:22 +0900")
References: <20251211042624.175517-1-pratyush@kernel.org>
	<e4d1c333-7e22-47ee-81a0-2efc4ca6b17c@amazon.com>
Date: Mon, 29 Dec 2025 22:28:32 +0100
Message-ID: <86ecod7zb3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251229_132839_685393_8C63E0D2 
X-CRM114-Status: GOOD (  23.17  )
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

On Sat, Dec 13 2025, Alexander Graf wrote:

> Hi Pratyush,
>
> On 10.12.25 20:26, Pratyush Yadav wrote:
>> As live update evolves, there will be a need to update the serialization
>> formats for the different file types. This could be for adding new
>> features, for supporting a change in behaviour, or to fix bugs.
>>
>> If the current kernel does not understand the same set of versions as
>> the next kernel, live update will inevitably fail. The next kernel will
>> be unable to understand the handed over data and will be unable to
>> restore memory, devices, IOMMU page tables, etc.
>>
>> List the set of versions the kernel understands in a section in vmlinux.
>> This can then be used by userspace tooling to make sure the set of file
>> descriptors it uses have the same version between both kernels. If there
>> is a mismatch, the tooling can catch this early and abort live update
>> before it is too late.
>>
>> The versions are listed in a section called ".liveupdate_versions". The
>> section has a header that contains a magic number and the version of the
>> data format. The list of version strings directly follow this header.
>> Only the version strings are listed, and it is up to userspace to map
>> them to file descriptor types.
>>
>> The format of the section has the same ABI rules as the rest of LUO ABI.
>>
>> Introduce a LIVEUPDATE_FILE_HANDLER macro that makes it easy to define a
>> file handler while also adding its version string to the right section.
>>
>> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
>
> To support multi-version preservation and resume, how about you add a "profile"
> hint to the handlers? Then you can tag the handlers with "current" and a
> "previous". You then expose one section table with supported versions per
> profile. And that means you can from user space select the local profile to
> serialize and match that against the target profile of the target system.
>
> It also allows you to support more "profiles", such as elaborate downstream
> version combinations, that upstream will not have to care about.

So in essence you want to tie the versions into a "version set"? If you
want to use a new version even for one component, you would create a new
version set.

Interesting idea, but I am curious. Do you see a reason for grouping
versions together in this fashion? Why not let each version be changed
independently?

-- 
Regards,
Pratyush Yadav


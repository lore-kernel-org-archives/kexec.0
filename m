Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAD606A326
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m6vGzyRb;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=PRfyFtAJ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=EJOG05Mf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cfkgwX+JUpucBEMRMXNCp7qzYju/oBKPyn0BC2hQAJ8=; b=m6vGzyRbRWVlEE
	cHCB8/1XQNXobho/yrBKD4HazxC6dML9X0xrs6swKSBgiHdfPqSq65GH+YIBRotrUeyefuUxNjfah
	2EPsjHw0aGbHw1goh/nfGHyICuifopZgbB9COXAX0dbVC2ATl/f57+34NUVi4fPXjYpu8bM5JveD9
	RVjDNPEfaIotNxy0Qnb7B8itqt9rIuQhx6eVNQwhnIJ4+CrCd2TT0kqDvhsjZatXEcnXaqFrBB4EZ
	bGzRpRvh9aeIet47SzfpOjATMEQyxGs28JutoPW8rhdngBaw7IrT95Q2F9oKp59BPwOstxuBmHwhM
	sIuYE3bcrjeGWuS8gt5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKkw-0000000CcY0-0lpN;
	Fri, 06 Nov 2026 14:17:26 +0000
Received: from mail.mainlining.org ([5.75.144.95])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKks-0000000CcXY-2yth
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:17:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793974582; bh=cfkgwX+JUpucBEMRMXNCp7q
	zYju/oBKPyn0BC2hQAJ8=; b=PRfyFtAJmOt7pvxJzSuijDJYDCUJu+yGZBijxZ5MAnB5YKWcPx
	J6uz18/wTtM9bV0a0t335JAKhminuyFaAHbbbWEmqytuIWXLNIEZEbGOj85OgjtV7Y7hYmG3Yj8
	q4Cb+jR9pMpU+zd6tTar1Y3XjqphesY6+dDGV3/4qKogVBcdzqvsi2gaSs1nO1OfTVhs9DQf3Cq
	TinBPJRk0thXhx8rvC3oOANM/0fPis4wQDIWbQwf3uow7Y8TYbKX4c0YmfkUaVRpvxgiXpzE2Sy
	WmnEroeSf0cpwhf9u1Y6Fanf6Cm1nQFhDFcayE82GXz+ve/1dk+009K9lnDkRoAay5g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793974582; bh=cfkgwX+JUpucBEMRMXNCp7q
	zYju/oBKPyn0BC2hQAJ8=; b=EJOG05Mf7mgqOIXke6l7vMrTx/h3Frh4SrlcLSW5LJBEjqcc3K
	2gQSVA/PUCQcXGAjqDMuuMXxjI879QVRopDg==;
Date: Fri, 06 Nov 2026 14:16:23 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Usama Arif <usama.arif@linux.dev>, Mikhail Zaslonko <zaslonko@linux.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev,
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
 ruirui.yang@linux.dev, jbohac@suse.cz, david@kernel.org,
 hbathini@linux.ibm.com, leitao@debian.org, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kas@kernel.org,
 hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_crash=3A_keep_crashkernel_C?=
 =?US-ASCII?Q?MA_pages_reserved_if_activation_fails?=
In-Reply-To: <20261106140556.1667159-1-usama.arif@linux.dev>
References: <20261106140556.1667159-1-usama.arif@linux.dev>
Message-ID: <91E33A6A-41C5-4AFC-9311-453066E631F1@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_061722_921767_D932DBF9 
X-CRM114-Status: GOOD (  19.81  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 6 November 2026 14:05:54 GMT, Usama Arif <usama.arif@linux.dev> wrote:
>On Fri, 6 Nov 2026 12:21:12 +0100 Mikhail Zaslonko
><zaslonko@linux.ibm.com> wrote:
>
>> 
>> 
>> On 04-Nov-26 15:56, Usama Arif wrote:
>> > reserve_crashkernel_cma() adds each crashkernel CMA area to
>> > crashk_cma_ranges[] as soon as it is declared. If the area later fails
>> > activation, e.g. because movablecore= put the ZONE_MOVABLE boundary
>> > inside it, cma_activate_area() releases the pages to the buddy
>allocator
>> > as ordinary memory. The range is still handed to the crash kernel and
>> > excluded from the vmcore, so kernel data that lands there is
>overwritten
>> > by the crash kernel and missing from the dump.
>> > 
>> > Mark the areas with cma_reserve_pages_on_error(), so that a failed
>> > activation leaves the pages reserved: lost to the first kernel, but
>safe
>> > for the crash kernel to use.
>> > 
>> > Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
>> > Signed-off-by: Usama Arif <usama.arif@linux.dev>
>> > ---
>> s390 hits this without movablecore= (adding the s390 maintainers and
>> linux-s390) since ZONE_DMA ends at 2G here.
>> CMA tries to reserve areas above 4G first, but falls back to lower
>> memory when it doesn't fit, so a cma area can end up across the 2G
>boundary.
>> I ran into this while adding crashkernel=,cma support for s390, which I
>> will post soon, and came up with the same fix.
>> 
>> About dropping the range instead, as you offered for v2: I'd keep this
>> version. With the range dropped, the kdump kernel gets less memory than
>> configured, and that only shows at crash time. With this patch, the
>> the first kernel 'loses' the memory as with a regular crashkernel=
>reservation
>> of the same size.
>
>Yes, I do agree with this. Losing memory in first kernel is preferrable
>and it will then force someone to fix whatever is broken rather than
>finding out when their kernel crashes.
>
>> 
>> There is a second problem in the same loop: all areas are named
>> "crashkernel", which breaks the CMA sysfs and debugfs entries when
>> there are several. I've sent a separate fix for that:
>> 
>>
>https://lore.kernel.org/r/20261106104309.3669583-1-zaslonko@linux.ibm.com
>> 
>
>Thanks! I reviewed this now.
>
>> Reviewed-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Well, now that that predicament arises, I see that this patch is a "hidden
gem" sort of thing

Reviewed-by: Bradley Morgan <brads@mainlining.org>

(Thanks for telling me about how you accounted for that bitmap_zalloc()
failure)

>> 
>
>Thanks for testing and reviewing!
>
>Usama

--- Thanks!


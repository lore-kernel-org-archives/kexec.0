Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31B3CD37BE
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pqPUNyfX/DvUavK2Y8wT0ZghDSAbcNGXOS89KdqJQ/4=; b=2Nckd1QlxFdj2egikGHDStbQOt
	5uwLVZu4hhLhumJgXLkF4WSK8P+TluInbW8m7Of/J3pK2pA4jdvC96Vrr3SbVH8DYumXFO+9ifuoH
	SqL0Ar4pBA02N/+HVevkuTwFHmtmYzQ0wTbRSE5Bn3wZ48uhPdFBamS1JwKyAcCXi+FKKElMJTCgL
	A36ZkhL+TkX2ppbqCwVK3MH2zWsKDF6/yCh5OFSMUMtLxpOi1uWSD5lYsexiZAIcquzoh9p3+gb6g
	SakNjE3jVw0u6ThliD6Wq4B68jDM9VTLuOLef3voLfL8vm6/+bI11BgH1a5BbiTrUuyKFsFWYOwn0
	LsDG33Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMToB-0000000EGiv-1Ikh;
	Mon, 11 May 2026 16:48:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMTo9-0000000EGiK-2Kwz
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 16:48:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 072DB44171;
	Mon, 11 May 2026 16:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6EFC2BCB0;
	Mon, 11 May 2026 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778518120;
	bh=QQGKCQXAtFFxjOd54vbilU9n1JNF7kVa2ekxD5peAds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=K5XIpmrIAV/EGwIzcIzruPImlbD5rxQPu7qAr+y4fWfSrVRzeAUiPf0NmgswdXG8q
	 UEhHoDOyTtOUgWhO6lVxIZ7X1xlIp/Fa5itBYE/YcMMWo5DRg5qerGQTFtNGwoADkn
	 xta5TMHWThbryariRnvp3CDvuri4wcDfS/qG+e/mUHrR2qg3ZeagEIhg/hfAeBJUtX
	 n4VxRiB0SufY4hZXWTbw957xB7AWNqygka1jMpQwuT2tF14af+A3M81ANr9x4SYRe2
	 0XBpI8tLpYzDK6ci9Cp8EobEiY6fpRIN/YXN2BYe5UNdPQEoJhgEU9egOzVtFDTgIT
	 Oh1jbHOfE7Ldg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] kho: return virtual address of mem_map
In-Reply-To: <agHHzJS7bLPHk1GJ@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 15:13:00 +0300")
References: <20260429133928.850721-1-pratyush@kernel.org>
	<20260429133928.850721-12-pratyush@kernel.org>
	<agHHzJS7bLPHk1GJ@kernel.org>
Date: Mon, 11 May 2026 18:48:37 +0200
Message-ID: <2vxza4u5c2oq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_094841_644261_BB166109 
X-CRM114-Status: GOOD (  12.08  )
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

On Mon, May 11 2026, Mike Rapoport wrote:

> On Wed, Apr 29, 2026 at 03:39:13PM +0200, Pratyush Yadav wrote:
>> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>> 
>> There are currently 3 callers of kho_get_mem_map_phys(). Two of them,
>> kho_mem_retrieve() and kho_extend_scratch() need the virtual address.
>> The third, kho_populate() doesn't care. Make things simpler by
>> directly returning the virtual address. Rename kho_get_mem_map_phys() to
>> kho_get_mem_map() to accurately reflect what it returns.
>
> This should be moved earlier, before replacing open-coded get_mem_map()
> with a call to kho_get_mem_map_phys().

Do you mean move it before patch 2 "kho: store incoming radix tree in
kho_in"?

I can do that. I did it this way to show a clear need for this function,
but I don't mind doing it as a preparatory step.

>  
>> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 28 +++++++++++++++-------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)

-- 
Regards,
Pratyush Yadav


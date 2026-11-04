Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B7606A32F
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zAmj/+1T;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4/4svk5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qimrld6Qquu3/RsDXXsu/ihBQCwzuzT0jn+pZL1CadM=; b=zAmj/+1Tr2eG9pLNkT720/olHb
	YpzaQBbJLX/Dz8opoqgKKXiat1+fym4pE/6ea16E4IzL4RTRLw/ZDAoGSDhqsOlsU1DzNH4FV/e3y
	JOhjqY4nOKt1IfBiXs9909h6HMGj1hKj5I4/dK9qO1uD+MSH3Iz+m4MUaEWM5tJxBPmefm1F04bLa
	bx3oAtA8GLi7uQKbd1vTCql3cUaEvONt0GLm0tV9TgAXK0F1j1l30bYCNa278SHlaXUyn17+ii/6O
	KywHoJ3AL/aGijHhNwj92BP9oIReTOzYE8KKBF3mEES/bUDLykUr4CZduUm/awsRpUcxa5B44oyAa
	8IgLr7Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZxe-00000005Ht8-363I;
	Wed, 04 Nov 2026 12:19:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZxe-00000005Hsa-0nIP
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 12:19:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82D4D60F0E;
	Wed,  4 Nov 2026 12:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B771F0093A;
	Wed,  4 Nov 2026 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793794765;
	bh=qimrld6Qquu3/RsDXXsu/ihBQCwzuzT0jn+pZL1CadM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=b4/4svk5xILGPqtP0/hwSWfdCQyIEn7TvGLMRqs6SVM2qgtnJStNRGARXPHXsGO/W
	 JbY1D+VPYxoXvMZmIlWgfmJ3yVe14wVT6w08BHZTT4TgPKvw/xJlozDoibhyjndx5x
	 z6/QCycXlGIj4lV7LBOdScLxYtYkgITbtLogDDXqe8DG5AMY7YzqQCdY4pGVg7g77k
	 z/L8LNVlOQn9lueTtR6Dxl3fqSQa5pLTzmcN+FTmzmE3uDIAmpHRv/xNTC3PE6CQ6w
	 CPexOQidh7O5eMEfOFfg8ShJFNeW13SLdMLDCd0GA+SVTueP6vY/QYGWfRBvh9XvTx
	 byUQEBEzPkFxA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [RFC PATCH 0/2] memblock: keep reserve_mem regions out of KHO
 bootmem
In-Reply-To: <70686061-787c-4c99-ba5b-ff982c8cc2ad@gmail.com> (Jose A. Perez
	de Azpillaga's message of "Wed, 4 Nov 2026 11:50:02 +0100")
References: <20261021211058.83483-1-azpijr@gmail.com>
	<2vxzqzhhg8l3.fsf@kernel.org>
	<32dd1f28-db55-4674-99bc-74d9d3ab25db@gmail.com>
	<70686061-787c-4c99-ba5b-ff982c8cc2ad@gmail.com>
Date: Wed, 04 Nov 2026 13:19:21 +0100
Message-ID: <2vxzfqxglrg6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, Kees Cook <kees@kernel.org>, Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04 2026, Jose A. Perez de Azpillaga wrote:

> On 10/22/26 10:16 PM, Jose A. Perez de Azpillaga wrote:
>> On 10/22/26 3:37 PM, Pratyush Yadav wrote:
>>> On Wed, Oct 21 2026, Jose A. Perez de Azpillaga wrote:
>>>
>>>> On a KHO boot, a reserve_mem= region that can't be revived (new name,
>>>> size or alignment) can be allocated from KHO bootmem, which the next
>>>> kernel boots out of. With CONFIG_KEXEC_HANDOVER_DEBUG preserving it
>>>> fails; without it, the next kernel's memmap ends up on top of it.
>>> What's your use-case? Why are you adding new reserve_mem regions after
>>> cold boot? I'd rather avoid making purely theoretical fixes.
>> 
>> I don't have one, I found it through the TODO. a different reserve_mem=
>> in the cmdline passed to kexec is enough to hit it.

If there was a use case, I wouldn't mind fixing it. But I'd rather not
add code we don't have a use case for.

>> 
>> if it isn't meant to work across a live update, would you rather have
>> reserve_mem() fail on KHO boot when it can't revive the region?

This sounds good I think.

>> 
>
> ping, I can send a v2 either way.

-- 
Regards,
Pratyush Yadav


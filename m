Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9ABCD37B5
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nruSBVin2AnJ4xuEZsU7eASbiUQRmQz7coGwKMFwyGU=; b=gQ3/2vo8yeEfUGEcEgjKGW5Kps
	4yQw8iMjaJvqjmqQ65yu/KVF8S8/VTzFo7bgkGa6IG0zz0NiE+JJxQ5VmVKZ2l4HoPPEMONIaqbEY
	FVf8m6CmUgBAKk/ifVm02nunPCSxWwcknw7DlqdHQSW/iaCCLlkDWX36zhTe4DLTUSMcrj3lHjpDC
	fg+v30G+3tVC3JlujSdAfntEmE4QgladN1DY7qGGLDYCsDWiTANGQLE9KMxnq0xaq8OZMZzatm/C7
	T9nTf7zey1x/WWljfPGz1GKMwAjwjf7nVjwi0jeUzJfavQH2WZ86bckb7lyktSfxezrbOW2YLAJCF
	chcA/zdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOcQ-0000000DHwG-1z7C;
	Mon, 11 May 2026 11:16:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMOcP-0000000DHvt-0vb6
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:16:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 94F7560120;
	Mon, 11 May 2026 11:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53BEC2BCB0;
	Mon, 11 May 2026 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498172;
	bh=Cgr7dbdvhm+vZKERk5dxhhhYWa222txnv0pTlKfbbPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XxDLx8OQlTJzTWhzEJVMPQxzWbFEUDSCJSCegy80OPVoDTShXI2Tdm4lfz33ZL4PS
	 54OVbyNThxvluqIIA2UTAXbzddMOUCH20W5rJiX6TPY7tNr/+r3uBTk12Dp6STSbQ/
	 u4jk+TQanegSXftX5NC9CQary5YfBScG3s1SxsOyT475F4Wr1lWNik0F+ihmDe1Uaz
	 lDpdL6DKACihz3aVjsR9LGkpGy3KUxYsqG2M4/Yz5JSnokvXMst9UVLl8a2USUBon7
	 sTvOeve5KCd2HBslzPxND+MbXaIwXB9+4qnspcwDN96IMiZP9ie8EAi0qJoR/knnq9
	 FJHkv5gIEzJkg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  sourabhjain@linux.ibm.com,
  jbouron@amazon.com,  akpm@linux-foundation.org,  linux-mm@kvack.org,
  bhe@redhat.com,  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com,
  changyuanl@google.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v2 1/3] kho: skip KHO data for context-preserving kexec
In-Reply-To: <agGxkHPx7W7P5AUS@kernel.org> (Mike Rapoport's message of "Mon,
	11 May 2026 13:38:08 +0300")
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
	<20260506182039.2623553-6-pasha.tatashin@soleen.com>
	<agGxkHPx7W7P5AUS@kernel.org>
Date: Mon, 11 May 2026 13:16:08 +0200
Message-ID: <2vxzik8uci2v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

> On Wed, May 06, 2026 at 02:20:41PM -0400, Pasha Tatashin wrote:
>> A preserve_context kexec returns to the current kernel, which means the
>> 2nd kernel does not use KHO data (and their memory spaces don't
>> overlap). Passing KHO data to the 2nd kernel via setup_data or
>> devicetree is unnecessary.
>> 
>> Add a check in kho_fill_kimage() and return early if preserve_context is
>> set, to avoid passing KHO state during context-preserving kexecs.
>> 
>> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 4fde8325c49f..2eec2a169c83 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -1702,7 +1702,8 @@ int kho_fill_kimage(struct kimage *image)
>>  	int err = 0;
>>  	struct kexec_buf scratch;
>>  
>> -	if (!kho_enable || image->type == KEXEC_TYPE_CRASH)
>> +	if (!kho_enable || image->type == KEXEC_TYPE_CRASH ||
>> +	    image->preserve_context)
>>  		return 0;
>
> Sashiko says it's unnecessary:
>
> https://sashiko.dev/#/patchset/20260506182039.2623553-5-pasha.tatashin@soleen.com
>
> I tend to agree :)

Hmm, good point. I take back my suggestion then.

-- 
Regards,
Pratyush Yadav


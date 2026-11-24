Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C90606A334
	for <kexec@archiver.kernel.org>; Tue, 24 Nov 2026 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=siV0pXUe;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rgt3qNyH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=REPVVlJkeD+ZeFzs7zAo1+Ptfc+JAlFq2umyUtgb25c=; b=siV0pXUeTqGL1b0h8SkoOVQaZk
	0Eoyc+7buCmzjEmpP40aWW3L70r5BBkx08oTFPjO9UndAqnjfhgO1WAoY16x11wyrOfPMkKM6wDWy
	AS4bsV08tR8BUjFDaS+mX+TAEITWFjOfqoyRYikcqrqthTY7Cw1TJCdhM4Cz3L/Z4MX2LF2NGzdLz
	zrCZ/bkxIbpSCYJUk1GOk7DoQxhxy8nH0YLq1DO1cotx9dXESkPYj2miz+pRtPhBXEJCxGgdDNzK5
	UFnhxMi+u3F0flCBn+AVdcZ5D6o1FStEJpMZohzxqNZI++8lbqhi+dOEEdtqm8ky+QWf4thC5YPf3
	BMP0adPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVs3B-00000006qJl-2B0P;
	Tue, 24 Nov 2026 15:03:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVs3A-00000006qJJ-1w37
	for kexec@lists.infradead.org;
	Tue, 24 Nov 2026 15:03:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E2D9460F86;
	Tue, 24 Nov 2026 15:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33E51F000E0;
	Tue, 24 Nov 2026 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795532595;
	bh=REPVVlJkeD+ZeFzs7zAo1+Ptfc+JAlFq2umyUtgb25c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Rgt3qNyHPCldkjic2773LwWjg9d3P/FLq5Qu1r0gEa12eaPtA6b7aA0ONNNWg+Q16
	 3MfPbdPUHrYiiRtHBN8UHBcbbVwSQH6Nxwtr4Vauzk0jdXWVWTNwZW2Q0U1jAkSg/I
	 a8jjMCJFLDOGujcH8zGjkxrbasfDekPP2ucvZ2rPiNWCHHS73zxGZWYhlzEVmPdvTb
	 YIAZGT5zRos71jgHCl5iotePibJWLcBWeFVNhUyF6P8IitYK6Ilzkdb+nYWenk4yzv
	 ZiLUWimuKPUmIfOmwI2kpapgw9Kn5gUqxdpMc4Swk2LhTfMzrU4jHWJNAuXbSZC2te
	 G3U/5Zf2x/zRg==
From: Pratyush Yadav <pratyush@kernel.org>
To: "David Matlack" <dmatlack@google.com>
Cc: "Pratyush Yadav" <pratyush@kernel.org>,  <kexec@lists.infradead.org>,
  <linux-doc@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-kselftest@vger.kernel.org>,  <linux-mm@kvack.org>,  "Alexander
 Graf" <graf@amazon.com>,  "Andrew Morton" <akpm@linux-foundation.org>,
  "Baolin Wang" <baolin.wang@linux.alibaba.com>,  "Christian Brauner"
 <brauner@kernel.org>,  "David Hildenbrand" <david@kernel.org>,  "Hugh
 Dickins" <hughd@google.com>,  "Jonathan Corbet" <corbet@lwn.net>,  "Liam
 R. Howlett" <liam@infradead.org>,  "Lorenzo Stoakes" <ljs@kernel.org>,
  "Michal Hocko" <mhocko@suse.com>,  "Mike Rapoport" <rppt@kernel.org>,
  "Pasha Tatashin" <pasha.tatashin@soleen.com>,  "Randy Dunlap"
 <rdunlap@infradead.org>,  "Samiullah Khawaja" <skhawaja@google.com>,
  "Shuah Khan" <skhan@linuxfoundation.org>,  "Suren Baghdasaryan"
 <surenb@google.com>,  "Vlastimil Babka" <vbabka@kernel.org>
Subject: Re: [PATCH v4 07/19] liveupdate: Add helpers to track the files
 that LUO manages
In-Reply-To: <DN2SLUVNO0L5.3NUHFPC0J7QTG@google.com> (David Matlack's message
	of "Mon, 23 Nov 2026 10:13:37 -0800")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-8-dmatlack@google.com>
	<2vxzbj7j3ga2.fsf@kernel.org> <DN2SLUVNO0L5.3NUHFPC0J7QTG@google.com>
Date: Tue, 24 Nov 2026 15:03:09 +0000
Message-ID: <2vxz7bi2z2z6.fsf@kernel.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23 2026, David Matlack wrote:

> On Fri Nov 20, 2026 at 3:15 AM PST, Pratyush Yadav wrote:
>> On Wed, Nov 11 2026, David Matlack wrote:
>>> @@ -788,8 +797,7 @@ int luo_file_finish(struct luo_file_set *file_set)
>>>  		luo_file_finish_one(file_set, luo_file);
>>>  
>>>  		if (luo_file->file) {
>>> -			xa_erase(&luo_preserved_files,
>>> -				 luo_get_id(luo_file->fh, luo_file->file));
>>> +			luo_untrack_file(luo_file->fh, luo_file->file);
>>
>> This looks dangerous.
>>
>> Since the previous patch set luo_file->file when xa_insert() failed,
>> this will trigger in a failed retrieve. Except, the file was never
>> tracked to begin with.
>>
>> While I don't see anything that actually breaks because of this today,
>> I think it is a bug in the making.
>>
>> I think the below is a bit better. Although this change probably makes
>> more sense in the previous patch, since that introduced the problem.
>> This patch should just replace the xa_erase() with luo_untrack_file().
>>
>> 	if (luo_file->file)
>> 		fput(luo_file->file);
>>
>> 	if (luo_file->retrieve_status > 0)
>> 		luo_untrack_file(luo_file->fh, luo_file->file);
>
> Good catch, I'll fix this in the previous patch in v5.
>
> (But luo_untrack_file() needs to be called before fput() in case the
> latter drops the last reference.)
>
> So:
>
> 	if (luo_file->retrieve_status > 0)
> 		luo_untrack_file(luo_file->fh, luo_file->file);
>
> 	if (luo_file->file)
> 		fput(luo_file->file);

Right, makes sense. Thanks!

-- 
Regards,
Pratyush Yadav


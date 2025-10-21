Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4AFCCD1A5
	for <kexec@archiver.kernel.org>; Tue, 21 Oct 2025 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IqvbLN5ZgsnjvT0M+y4ZUEk2UJBRh2BxrolCHDhGhac=; b=nsHyjL5wW4DHuz2pakZDrdRoqQ
	lggh+gOVEzUX7AOWXyP80PdM1AHcxo5+8NYX95DXA66Txrjrrr+ceJTtAb5OaEd5lveF1rl4XgBIU
	AgCH0JgJvaZZNYPVvHs5wBN3RfYWQ/q9IBU5x72mgO6KPF96jDsK3i5/hukYo/Z0ZURCmJQKmvLCD
	vEUX5dhxQj39fnr6n6+81bzv7OIk3We4S2lfrsGusozkCibT/k+IH2DzIzL8KiWhNvTK3o85H9l6D
	n0tmbpJWOuqI0osK+410yN8LdGi7XfPNcUkTxB81Lxv0bwoUTXOLJAXJN6rEo2+VSj/Ob2zeKfynL
	HgZ9yp2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBL3Y-00000000oqX-0Pmk;
	Tue, 21 Oct 2025 22:42:16 +0000
Received: from out-177.mta1.migadu.com ([95.215.58.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBL3U-00000000opS-1dXQ
	for kexec@lists.infradead.org;
	Tue, 21 Oct 2025 22:42:14 +0000
Message-ID: <bcdb064a-41c5-4ea9-ae71-be347f3b7317@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761086528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqvbLN5ZgsnjvT0M+y4ZUEk2UJBRh2BxrolCHDhGhac=;
	b=fr4Rj0uOUNFoWJEKsRb+tkT0s0qx5XjptRPE0N4jDennWFPfmuHELgBk5VdRmXhE1SzWqI
	iSoq+5HiSrn0lBqZqJDXnl/GtUT0bPFWz8p1WCSB2bRiB49D63HLnbps3POlDYmOR9X9wa
	rDTE14xhSYaDAcIWF1GpvcebJDCHkXs=
Date: Tue, 21 Oct 2025 15:42:00 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] kexec: Use %pe format specifier for error pointer
 printing
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
 rppt@kernel.org, changyuanl@google.com, akpm@linux-foundation.org,
 bhe@redhat.com
References: <20251016200320.4179702-1-yanjun.zhu@linux.dev>
 <aPdVSyLRKeRN3i6z@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <aPdVSyLRKeRN3i6z@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_154212_773916_DD995EC9 
X-CRM114-Status: GOOD (  12.60  )
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

On 10/21/25 2:41 AM, Simon Horman wrote:
> On Thu, Oct 16, 2025 at 08:03:20PM +0000, Zhu Yanjun wrote:
>> Make pr_xxx() call to use the %pe format specifier instead of %d.
>> The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
>> -EINVAL) when given an error pointer created with ERR_PTR(err).
>>
>> This change enhances the clarity and diagnostic value of the error
>> message by showing a descriptive error name rather than a numeric
>> error code.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Thanks,
> 
> This looks good to me, even though I note that this file
> has moved in linux-next.

Thank you very much. In next-20251021, I noticed that the directory is 
now kernel/liveupdate/.

If a new commit is needed to reflect this change, please feel free to 
let me know.

Yanjun.Zhu

> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 



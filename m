Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F43CCCD1A7
	for <kexec@archiver.kernel.org>; Tue, 21 Oct 2025 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/ZIuMu80DL4YHvTXi4wKlBoPxDfHVooxaFJqOtUjU8=; b=zeTevC/Y1FhxaSFYT7P1Akgk0U
	SmvSi9/iJNpwltUArmbakFcqYZRE0kk8c+FC9dimn31j1FlL5Y78HoBbc2PrqTaj4ExkWClPlK6/O
	ngfPm7nbxbBoa6Y9wP7vXlUzDwZ4hzL5CMjI87aFS95oX3wTfc2NIEOGHDSLKUWDDzr5qr1Y3pWIT
	KWXn4GOhy30g+E3ly+kMQjPp8xH8lzegF+k4vb4zlzVpNsgikK8JEQsxVz7MKLYfuV2Hs8m/hmIcx
	nqy3CMJ0SBC3wccMARZOL0lc4A1fzM1OJ8cwL6rcgyflBsrCDlPTCdO6pGmzgdXt5o7zcH11Cnto7
	NPIAPBLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBCqr-0000000HEUU-2a3d;
	Tue, 21 Oct 2025 13:56:37 +0000
Received: from out-186.mta0.migadu.com ([91.218.175.186])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBCqp-0000000HERa-0VVZ
	for kexec@lists.infradead.org;
	Tue, 21 Oct 2025 13:56:36 +0000
Message-ID: <d988780e-bca0-4ad8-9ebe-97e6248072e5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761054988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/ZIuMu80DL4YHvTXi4wKlBoPxDfHVooxaFJqOtUjU8=;
	b=RKuGP32j4IHlZtowsmFIltam/JgXymORLiTTqtVjn3YyPXiwP3ZqmO5Cj1B0MSySm7em7X
	eUVdNzQVrCO6Ztv1MhZhqdpzMQOZAc9aYK6fjNEVlMJhmqZ5qmA15WBkDJo/GNcAVu2vxX
	bvWhUSXDtd6tm3O0h3ZtT8Vt+RVSe9M=
Date: Tue, 21 Oct 2025 06:56:19 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] kexec: Use %pe format specifier for error pointer
 printing
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
 rppt@kernel.org, changyuanl@google.com, akpm@linux-foundation.org,
 bhe@redhat.com
References: <20251016200320.4179702-1-yanjun.zhu@linux.dev>
 <aPdVSyLRKeRN3i6z@horms.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <aPdVSyLRKeRN3i6z@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_065635_297597_DEA69D05 
X-CRM114-Status: GOOD (  10.53  )
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


在 2025/10/21 2:41, Simon Horman 写道:
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
> Thanks,
>
> This looks good to me, even though I note that this file
> has moved in linux-next.

Thanks a lot.

Yanjun.Zhu

>
> Reviewed-by: Simon Horman <horms@kernel.org>

-- 
Best Regards,
Yanjun.Zhu



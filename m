Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3383FC982F1
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HGkT9Ui8IWBvThLwNwtH5JiFUDnabT7ULMWL9InJHFU=; b=AUlSTIYaVWuwJlQJr53/DSmQiT
	cqGgGz1CcgYeYepW9/s30e/qyFVHAgWU+AIxlEQGEsUr1/Sonyk7PGXQbg9IWCI1emNGglrr56Hzs
	NMbBxQBU+/vURxP54+CRzD+S56Z7HGtER7iGiGg3NkmzVwszLm9FmsoS9KuotMryKmycUuHRoNLOG
	OMpJfZ3rbX6o+tHg6arREBrwrmcVrwKELa8pzv/3xHKAx/6/2jPiU7KiPVMxDK0lqz7f/cO9iGpWx
	2Eabogq6V+0AgJmwgeGrsXkczMJObIcaHqZUp3lcrSHcrSLLzNtTOFR9XQioXiPziM0LbK4+toJuG
	imCd15+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wod-00000004vFd-32K1;
	Tue, 22 Sep 2026 09:29:31 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8woc-00000004vFB-0ajZ
	for kexec@bombadil.infradead.org;
	Tue, 22 Sep 2026 09:29:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HGkT9Ui8IWBvThLwNwtH5JiFUDnabT7ULMWL9InJHFU=; b=B9NsoqnNh+sEuuUpZwONvtxiiS
	M+pGegbomSx6CZAVRrIBpL/BAFAFv2oPUPai9WRPLfghs5viVXe48MHRrfWyCq9xuh5SD//32AV/c
	taKVtW2fMmjOUTh866T3ukAHyiHHtwZ5gan5zzM/dsk7/8hX/zwREDyvH4s3ueQ5jfzBqY9q0aTk9
	KJUVRadNsIJOguNErkrTEKsijx+tcrm8U9qRyIPeEPRb+txVsEChHa274rQB7nIfUtxBQDch76z/g
	RohoVDBceXc+pXWng/DHFrlo6dnqtoM46kBNds2gcPJDawkHoo+R2T6YDxy+YQ4saLuZgYHmUXNYt
	fzSLdGzQ==;
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8woY-0000000DMn3-2nNB
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 09:29:28 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HGkT9Ui8IWBvThLwNwtH5JiFUDnabT7ULMWL9InJHFU=;
	b=stpcFFVUA5sWEn3kkPHrfPiLr8qBRiZbNZDh7aVd9XnAuytPymZceOrcl8vSrbJBulCPVDCTw
	olYFpOv609kH+6MaWDjwTkqVpeODVsVsPvdBngDQ3tJ8srYzmm23k97FGyQxixbsn8Vuj4RMKxU
	zUe4jbOpnHoBTAbKsk4aHxI=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hpvd5362fz1T4JM;
	Tue, 22 Sep 2026 17:17:29 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 69CFE202E6;
	Tue, 22 Sep 2026 17:29:19 +0800 (CST)
Received: from [10.173.124.160] (10.173.124.160) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 17:29:15 +0800
Subject: Re: [PATCH v5 0/9] mm/memory-failure: keep hardware-poisoned pages
 out of the next kexec
To: Breno Leitao <leitao@debian.org>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <rmikey@meta.com>, <riel@surriel.com>,
	<harry@kernel.org>, <linux-cxl@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <kernel-team@meta.com>, Ard Biesheuvel
	<ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton
	<akpm@linux-foundation.org>, <kas@kernel.org>, <kexec@lists.infradead.org>,
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner
	<hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador
	<osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	<hannes@cmpxchg.or>, <shakeel.butt@linux.dev>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <d6e35901-f74d-bf81-75d3-bac4b26d9d72@huawei.com>
 <arJBkNOgbR8NrgFP@gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <16baab50-692c-308b-d60d-1b0a328df1e3@huawei.com>
Date: Tue, 22 Sep 2026 17:29:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <arJBkNOgbR8NrgFP@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.124.160]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100004.china.huawei.com (7.152.185.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_102927_417981_1D25017D 
X-CRM114-Status: GOOD (  20.83  )
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

On 2026/9/22 17:14, Breno Leitao wrote:
> Hello Miaohe,
> 
> On Tue, Sep 22, 2026 at 02:27:59PM +0800, Miaohe Lin wrote:
>>> A bit is never cleared, which is a known limitation: it stands for a
>>> whole unit, so an unpoison of one frame cannot tell whether the unit as a
>>> whole is good again.
>>
>> Thanks for your patches. I have a question about unpoison: If a bit is never
>> cleared, after we do some memory-failure+unpoison tests, kexec will lose the
>> tested memory without reboot?
> 
> Correct, A bit stands for a 2M unit, so every tested page that falls in
> a distinct unit costs 2M in each kernel after the kexec.
> 
> Worth being precise about the state today: the unpoison itself works.
> The frame goes back to the allocator and num_poisoned_pages drops. Only
> the bit stays, so the next kernel poisons the frame again. Test loop
> in, memory out, and nothing gives it back.
> 
> Important to say that nothing block us from unpoison the bitmap, and in
> fact my initial patchset had it. I also _think_ we should unpoison the
> bitmap once we unpoison the page. 
> 
> I have just kept it out of this patch in order to simplify the patchset and
> get the basis correct, and then evolve on top of it.
> 

Makes sense to me. Thanks for your work.

> That said, If you think this is a must have in first patchset, I am more
> than happy to do it now, but just keep it in mind that it will grow the
> patchset by about 2 extra functions.
> 
> Thanks the review,
> --breno
> .
> 



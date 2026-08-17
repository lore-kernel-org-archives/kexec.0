Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFED1C5DF7A
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 10:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvCm+OYu+HXm7z1snfmD5E2E44f/n02MTod4Pvfjj44=; b=HxQqyR26sj8Uc4aIALa7ZtS4Ql
	QHXgcLbpRI8i3u21JA9q5E47APSLQXhqO2Tnj9zEcMOrFm8PZ1pSHQMyA5HwcCjty/rhuZetRuqfM
	LaeOSQPIvVlLP+MjY+8iZTJ/da9inmhAhV4fql5sbmCa2BPesbMCOVRL+sloA5vTx6QTytpSK9jHF
	DecYBR5V6gOpifdjoBrah8DUA66lYE59eqDG6QtGvNPlf4JzX/jBnG3AJbOhAO+fWQQ91JpZAE8I7
	ZoastUDG8a79K9aTio2dzgpScimIaM9u2qfUu+cRhe+lpjjomKM3izSYdQMGIkHTAaFGVrIEcJM/S
	ZFSF1EQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvuqj-00000005xNI-2lWX;
	Mon, 17 Aug 2026 10:45:49 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvuqf-00000005xMZ-1y2j;
	Mon, 17 Aug 2026 10:45:47 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zvCm+OYu+HXm7z1snfmD5E2E44f/n02MTod4Pvfjj44=;
	b=BMVVaj1TlTcvAO97yhiftu6cLaZm1WU583Ib9pBTHVzdqZyUhA0lYazOeZxhhDxb2qvD7vCVQ
	FzFrvcY0iU/2/lv/BMEdCkUqEhEF3hPQw/wIcsO1DO51XouQIxSPJ8yJrmpLCUFIcKlxBG6DMMB
	yp9zBBwo1ZikZVrb5doRDS0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hNq3Z6cxqzcb0T;
	Mon, 17 Aug 2026 18:35:22 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 61E8D40538;
	Mon, 17 Aug 2026 18:45:39 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Aug 2026 18:45:37 +0800
Message-ID: <df1317a2-68f1-4eb8-9fea-952349f672cb@huawei.com>
Date: Mon, 17 Aug 2026 18:45:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: crash: Add crash hotplug support
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <will@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<thuth@redhat.com>, <mark.rutland@arm.com>, <jic23@kernel.org>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <robh@kernel.org>,
	<kees@kernel.org>, <coxu@redhat.com>, <makb@juniper.net>, <piliu@redhat.com>,
	<graf@amazon.com>, <ebiggers@kernel.org>, <jbouron@amazon.com>,
	<bgwin@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20260729031235.2840255-1-ruanjinjie@huawei.com>
 <20260729031235.2840255-6-ruanjinjie@huawei.com> <an3rUZ7rd1mQH0Gz@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <an3rUZ7rd1mQH0Gz@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_034546_234635_4A7A3315 
X-CRM114-Status: GOOD (  19.33  )
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



在 2026/8/14 0:05, Catalin Marinas 写道:
> Hi Jinjie,
> 
> On Wed, Jul 29, 2026 at 11:12:35AM +0800, Jinjie Ruan wrote:
>> +/**
>> + * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it with old
>> + *			       elfcorehdr in the kexec segment array.
>> + * @image: the active struct kimage
>> + */
>> +static void update_crash_elfcorehdr(struct kimage *image)
>> +{
>> +	void *elfbuf = NULL, *old_elfcorehdr;
>> +	unsigned long mem, memsz;
>> +	unsigned long elfsz = 0;
>> +
>> +	/*
>> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>> +	 * memory resources.
>> +	 */
>> +	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
>> +		pr_err("unable to create new elfcorehdr");
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Obtain address and size of the elfcorehdr segment, and
>> +	 * check it against the new elfcorehdr buffer.
>> +	 */
>> +	mem = image->segment[image->elfcorehdr_index].mem;
>> +	memsz = image->segment[image->elfcorehdr_index].memsz;
>> +	if (elfsz > memsz) {
>> +		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
>> +			elfsz, memsz);
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Copy new elfcorehdr over the old elfcorehdr at destination.
>> +	 */
>> +	old_elfcorehdr = phys_to_virt(mem);
>> +
>> +	/*
>> +	 * Temporarily invalidate the crash image while the
>> +	 * elfcorehdr is updated.
>> +	 */
>> +	xchg(&kexec_crash_image, NULL);
>> +	memcpy(old_elfcorehdr, elfbuf, elfsz);
>> +	dcache_clean_inval_poc((unsigned long)old_elfcorehdr,
>> +			       (unsigned long)(old_elfcorehdr + elfsz));
>> +	xchg(&kexec_crash_image, image);
>> +	pr_debug("updated elfcorehdr\n");
>> +
>> +out:
>> +	vfree(elfbuf);
>> +}
>> +
>> +/**
>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>> + * @image: a pointer to kexec_crash_image
>> + * @arg: struct memory_notify handler for memory hotplug case and
>> + *       NULL for CPU hotplug case.
>> + *
>> + * Update the kdump image based on the type of hotplug event:
>> + * - CPU add and remove: No action is needed.
>> + * - Memory add/remove: Update the elfcorehdr to reflect the current memory layout.
>> + *
>> + * Prepare the new elfcorehdr and replace the existing elfcorehdr.
>> + */
>> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
>> +{
>> +	if (image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +		return;
>> +
>> +	update_crash_elfcorehdr(image);
>> +}
> 
> Looking at powerpc, they pass the arg down to update_crash_elfcorehdr()
> to handle the memory hot-unplug case. It looks like the notifier is
> called before the memblock_remove(), so the update above will still
> count the memory being removed.

Hi Catalin,

After delving into the code flow, I believe you are correct.

We need to manually remove the hot-unplug memory here, just like in the
PowerPC case. Will update the code sooner.

> 
> There are a few Sashiko comments as well, though some might be about
> existing issues (it would be nice to have them fixed ;)).

Thank you! I will take a close look and try to fix them later.

Best regards,
Jinjie

> 



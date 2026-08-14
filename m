Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C545C5DF66
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 01:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xaqTDDrnpKGWx+l1h+fUl97CPMUm+8Ht+uaiucS3/dQ=; b=Y8piyLZcLgAKgzl+V4npvjeuXP
	mgrqmeJgOZGpEY+wMMvlsVNuB6kpc7Roy71Al7PpDnYvmtzTwzYsWgUd+0VzvbbHD7z/XKv5IbY3x
	+D4pTNajhgrncoT3BD4/5DcyRjpN51HqyQQAznBqoJfsGOmECRCqI6QFJQQoJ3AyYHZts28y0IRPk
	bUkx5fTjVZ4hF3/COHEB4FufcjDT8KCDpIcRCpscV3WNzlY0qV2yd/e5uD6P9IlHVCIhGVzVcB9bK
	OLHgJtA5AH176CAsg1/qCWY7s2IYGCSeCS2R+4jQxt5YsnQjBx+ijOlMkrouJGHPWVp+D1XyllRAQ
	Ccjof2Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wugX1-00000001nBl-0j9w;
	Fri, 14 Aug 2026 01:16:23 +0000
Received: from canpmsgout08.his.huawei.com ([113.46.200.223])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wugWv-00000001nB6-2iOp;
	Fri, 14 Aug 2026 01:16:20 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xaqTDDrnpKGWx+l1h+fUl97CPMUm+8Ht+uaiucS3/dQ=;
	b=mflgm/SJEFWTm7QId0SN+rFG7pHOZIJLNok3nfujlNgdELL/0SveikjSn6UBgeA+pZh1iDink
	hJsz2QDHHU5t2TTpUKNRiv/+Og+6MDIxx776LEp2/0ensfarZHXa+RwZfEQ34EBKU+Ax6jKEYi6
	yY6hIS1GXAkEIT0eM6fuN44=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hLkYJ3flvzmVX8;
	Fri, 14 Aug 2026 09:05:24 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 983D14055B;
	Fri, 14 Aug 2026 09:16:02 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Aug 2026 09:15:59 +0800
Message-ID: <64f3a67a-51c6-4c01-a23b-301b619f2884@huawei.com>
Date: Fri, 14 Aug 2026 09:15:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] arm64: crash: Add crash hotplug support
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
 <an3Xe_5-B4qdiN8o@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <an3Xe_5-B4qdiN8o@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_181618_404815_0110D31B 
X-CRM114-Status: GOOD (  13.73  )
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



在 2026/8/13 22:40, Catalin Marinas 写道:
> On Wed, Jul 29, 2026 at 11:12:30AM +0800, Jinjie Ruan wrote:
>> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
>> image becomes stale, potentially leading to incomplete crash dumps.
>>
>> Currently, userspace udev rules reload the entire kdump image upon such
>> events, which is inefficient and leaves kdump inactive for a long time.
>>
>> Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
>> support") introduced a kernel mechanism to update only the elfcorehdr.
>> This patch set implements crash hotplug support for arm64.
>>
>> As Baoquan suggested, it also addresses and fixes several
>> pre-existing code issues and Sashiko AI review findings extracted
>> from the previous patch set.
>>
>> The major improvements and fixes included in this series are:
>> - Fix several memory leaks for arm64.
>> - Simplify arm64 load_other_segments().
>> - Implement infrastructure for arm64 crash memory hotplug support.
>>
>> This patch set is rebased on liveupdate/crashkernel-cma.
>>
>> Link: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> 
> Is there any dependency for the first 3 patches on the above branch?

Hi Catalin,

The first three patches have no dependencies, only the last two patches
have dependencies

> Patches 2/3 look like fixes and they depend on patch 1. Not sure about
> cc stable, maybe patch 2.

Yes, you are right! The cc stable label has been added to patch 2 and
patch 3, I think both of them are needed.

> 
> [...]
> 
>> Jinjie Ruan (5):
>>   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
>>   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
>>   arm64: kexec_file: Fix image->elf_headers memory leak in retry loop
>>   arm64: kexec_file: Simplify load_other_segments()
>>   arm64: crash: Add crash hotplug support
> 



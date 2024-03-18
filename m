Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75677C54E5D
	for <kexec@archiver.kernel.org>; Mon, 18 Mar 2024 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZT1o1XvMSzW9txVs66P1bK+LbQGDMGo67iL/yjh2BL0=; b=gQ9YE74QyuhVHC
	auTOCw5lhp+e/ASHlTP+Gy1SZUZ7E5nbtcvUIF6XY06UngDVwodWDjGnUCz2sQO/hSNz3O12+JsMn
	8y0NRzq2vNpHlZ0wJyALKx4ZRwzZhidULo34iFRJdWslcOJe0ElbqS2ZKxOd2BBZKTdCUoDGgT/b/
	peZi7rJ+4QFVQvaUGTputPKVR0uqR1+DujBqhrX56/BVLRtiLGdp888qXjdtYZpb3ry5KlCZ8/upJ
	LfSXm0JjuPXsqN+GqG2y9yCoLKA+bHAQkbKXDnbDC6UjibmiMlUchXhsdlT8JUpvOV7QAug3e+WCd
	ACiLrYnpzEVtADL2lFpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmBg8-00000008SY3-0MFU;
	Mon, 18 Mar 2024 12:01:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmBg3-00000008SWO-1PFd
	for kexec@lists.infradead.org;
	Mon, 18 Mar 2024 12:01:17 +0000
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TytfW6KKgz1h2m9
	for <kexec@lists.infradead.org>; Mon, 18 Mar 2024 19:58:27 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (unknown [7.185.36.180])
	by mail.maildlp.com (Postfix) with ESMTPS id 676B61400C9
	for <kexec@lists.infradead.org>; Mon, 18 Mar 2024 20:00:59 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 20:00:59 +0800
Received: from dggpemm500019.china.huawei.com ([7.185.36.180]) by
 dggpemm500019.china.huawei.com ([7.185.36.180]) with mapi id 15.01.2507.035;
 Mon, 18 Mar 2024 20:00:59 +0800
From: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC: Louhongxiang <louhongxiang@huawei.com>, "wangbin (A)"
	<wangbin224@huawei.com>, "chenhaixiang (A)" <chenhaixiang3@huawei.com>,
	"Fangchuangchuang(Fcc,Euler)" <fangchuangchuang@huawei.com>
Subject: Question about Address Range Validation in Crash Kernel Allocation
Thread-Topic: Question about Address Range Validation in Crash Kernel
 Allocation
Thread-Index: Adp5K+6hdQeyz3pNQuKQdPVezMrmaA==
Date: Mon, 18 Mar 2024 12:00:59 +0000
Message-ID: <8606fd02d6de4eb3b7c80e4ce3449458@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.95]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_050115_583098_D3A231E5 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Dear kexec Community Members,

I encountered an issue while using kexec-tools on my x86_64 machine.
When there is a segment marked as 'reserved' within the memory range allocated for the crash kernel in /proc/iomem,the output appears as follows:
2d4fd058-60efefff : System RAM
  2d4fd058-58ffffff : System RAM
    49000000-58ffffff : Crash kernel
      53cbd000-53ccffff : Reserved

The crash_memory_range array will encounter incorrect address ranges:
CRASH MEMORY RANGES
000000002d4fd058-0000000048ffffff (0)
0000000053cbd000-0000000048ffffff (1)
0000000059000000-0000000053ccffff (0)

Read the code, I noticed that the get_crash_memory_ranges() function invokes exclude_region() to handle the splitting of memory regions, but it seems unable to properly handle the scenario described above.
The code logic is as follows:
...
	if (start < mend && end > mstart) {
		if (start != mstart && end != mend) {
			/* Split memory region */
			crash_memory_range[i].end = start - 1;
			temp_region.start = end + 1;
			temp_region.end = mend;
			temp_region.type = RANGE_RAM;
			tidx = i+1;
		} else if (start != mstart)
			crash_memory_range[i].end = start - 1;
		else
			crash_memory_range[i].start = end + 1;
	}
...
If start < mstart < mend < end, resulting in crash_memory_range[i].end becoming less than crash_memory_range[i].start, leading to incorrect address ranges.
I would like to know if this behavior is reasonable and whether it is necessary to validate the address ranges for compliance at the end.

Thank you for your time and assistance.

Chen Haixiang

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

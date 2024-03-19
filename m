Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C848BC54E5D
	for <kexec@archiver.kernel.org>; Tue, 19 Mar 2024 07:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e3aIN2QnT9Yo+UDiUzDDY6UN24fM3nvhES7/kMUpMWM=; b=PXwe+UB23ViCzx
	rq0Io87uG+6kLPPhzI7HH6eHXg80xP2Co1JAjppp4j7jA2dl47QeZ64YYn+V/5S7Cvc3x2zwgCXkB
	eDjVAZ/crzfdTgpOqhQDRPLckDA8cU4gVb5aMFulJ4jNQK6VPGbfyQ1eJclHGBtznNxOwMliarEcg
	Y/GXJgwUB1ZZ+Yw+u1wFukEzPPJfzWeMff0+LUzbfo7NgQrcGbK+Vy1V+ZCR4vpt6PlbyWEox21g7
	RkFagArad8FXnFtfQUUFwYZXmSDB4pD+Zg0JseN2Vm7C07N0StOt4oRz3Dy9A6b3x7A5oivTdAv0z
	cAzcTsGtyj7gE3CA3rNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmTqB-0000000Bgx4-2dcY;
	Tue, 19 Mar 2024 07:24:55 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmTq7-0000000Bgvv-05eR
	for kexec@lists.infradead.org;
	Tue, 19 Mar 2024 07:24:53 +0000
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TzNT91MDCz1R7G3;
	Tue, 19 Mar 2024 15:22:05 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (unknown [7.185.36.178])
	by mail.maildlp.com (Postfix) with ESMTPS id EA8C6140411;
	Tue, 19 Mar 2024 15:24:37 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 15:24:37 +0800
Received: from dggpemm500019.china.huawei.com ([7.185.36.180]) by
 dggpemm500019.china.huawei.com ([7.185.36.180]) with mapi id 15.01.2507.035;
 Tue, 19 Mar 2024 15:24:37 +0800
From: "chenhaixiang (A)" <chenhaixiang3@huawei.com>
To: Baoquan He <bhe@redhat.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Louhongxiang
	<louhongxiang@huawei.com>, "wangbin (A)" <wangbin224@huawei.com>,
	"Fangchuangchuang(Fcc,Euler)" <fangchuangchuang@huawei.com>, "chenhaixiang
 (A)" <chenhaixiang3@huawei.com>
Subject: Re: Question about Address Range Validation in Crash Kernel
 Allocation
Thread-Topic: Question about Address Range Validation in Crash Kernel
 Allocation
Thread-Index: Adp5zbX8dQDTfOF1R6+PWKxdc3yfog==
Date: Tue, 19 Mar 2024 07:24:37 +0000
Message-ID: <464d781a34694cb996560fed0558e635@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.95]
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240319_002451_428113_A905E928 
X-CRM114-Status: GOOD (  26.86  )
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

Thank you for your reply!
The kernel version on my machine is kernel-5.10, and the kexec-tools version is kexec-tools-2.0.27. 
However, my issue seems to be a bit different. On my machine, I can see the crashkernel memory segment in /proc/iomem. However, for some reason, within the address range allocated for crashkernel, there is also a segment marked as 'Reserved' (I'm not sure who marked it). In this scenario, kexec-tools calculates the CRASH MEMORY RANGES incorrectly.
```
cat /proc/iomem
2d4fd058-58ffffff : System RAM
  49000000-58ffffff : Crash kernel
    53cbd000-53ccffff : Reserved
```
I'm not sure if the crashkernel memory segment should not include other markings, and if not supported, whether kexec-tools should raise an error.
Thanks
Chen Haixiang
----------
On 03/19/24 at 9:38qm, Baoquan He wrote:
> Hi,
> 
> On 03/18/24 at 12:00pm, chenhaixiang (A) wrote:
> > Dear kexec Community Members,
> >
> > I encountered an issue while using kexec-tools on my x86_64 machine.
> > When there is a segment marked as 'reserved' within the memory range
> allocated for the crash kernel in /proc/iomem,the output appears as follows:
> > 2d4fd058-60efefff : System RAM
> >   2d4fd058-58ffffff : System RAM
> >     49000000-58ffffff : Crash kernel
> >       53cbd000-53ccffff : Reserved
> 
> What kernel are you using? the version of kernel, and kexec-tools?
> 
> If you are testing on the latest mainline kernel, you could meet the issue Dave
> have met and fixed in below patch:
> 
> [PATCH] x86/kexec: do not update E820 kexec table for setup_data
> https://lore.kernel.org/all/ZeZ2Kos-OOZNSrmO@darkstar.users.ipa.redhat.com/
> T/#u
> 
> Thanks
> Baoquan
> 
> >
> > The crash_memory_range array will encounter incorrect address ranges:
> > CRASH MEMORY RANGES
> > 000000002d4fd058-0000000048ffffff (0)
> > 0000000053cbd000-0000000048ffffff (1)
> > 0000000059000000-0000000053ccffff (0)
> >
> > Read the code, I noticed that the get_crash_memory_ranges() function
> invokes exclude_region() to handle the splitting of memory regions, but it seems
> unable to properly handle the scenario described above.
> > The code logic is as follows:
> > ...
> > 	if (start < mend && end > mstart) {
> > 		if (start != mstart && end != mend) {
> > 			/* Split memory region */
> > 			crash_memory_range[i].end = start - 1;
> > 			temp_region.start = end + 1;
> > 			temp_region.end = mend;
> > 			temp_region.type = RANGE_RAM;
> > 			tidx = i+1;
> > 		} else if (start != mstart)
> > 			crash_memory_range[i].end = start - 1;
> > 		else
> > 			crash_memory_range[i].start = end + 1;
> > 	}
> > ...
> > If start < mstart < mend < end, resulting in crash_memory_range[i].end
> becoming less than crash_memory_range[i].start, leading to incorrect address
> ranges.
> > I would like to know if this behavior is reasonable and whether it is necessary to
> validate the address ranges for compliance at the end.
> >
> > Thank you for your time and assistance.
> >
> > Chen Haixiang
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DE5C79FA0
	for <kexec@archiver.kernel.org>; Tue,  8 Sep 2026 07:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G7nz+2I01rp2LskTbFRR2FK0vPBroOC8XutcipcnIsM=; b=y0qyGzJyc3n4Ai5aml3+4WTmnn
	wjf5u5gX8JjpG2o/3t2God3xNneqwmWsAWpsNnlODIWlXEiRhWL8zv5qHqP5/mMTSd8g4cVo3eYEU
	KcGLGQnqwupNFA8aK7q/9TP+8FZCq7CVKoWPB5W1koqd6txZcg1LBIt+lIcg1I7uyqAhAhkBoAvDp
	dNMqSuVfXX9gCHEe6FpA5OnnqXfZ5a8ZOMHAu/PU8mPkdx4UctT7poLdPKZFjPq67S3seopKAKYc1
	aGa5rmmdO4r3EIp2h06Hsfz8Ryz0/acdCBhDrubgSlJuol6nU56c2E7B0yEXVhq+KoZ30ZRM4Bt1W
	iZRzlWrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qAv-00000008Gg6-1xjw;
	Tue, 08 Sep 2026 07:23:25 +0000
Received: from canpmsgout11.his.huawei.com ([113.46.200.226])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3qAr-00000008GfY-2YE5;
	Tue, 08 Sep 2026 07:23:24 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=G7nz+2I01rp2LskTbFRR2FK0vPBroOC8XutcipcnIsM=;
	b=hyaS2dA64DcCg3GRIM7kcjDzC2hUqQBzbi0wYEmlK75paxqrzZ4Qk09vQIT+D6ItcGzT9PK7K
	+Fa6fiPBtKYscFQTRzVIbY6yweWimJ2oM5lKsGuwlq23S1Lfx1H1u//nCgErq4AFzAXXYPebOeM
	yjA4Etr6FTTSMfxdr1fEXw0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfFVy3mfZzKmVp;
	Tue,  8 Sep 2026 15:12:10 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D100C40586;
	Tue,  8 Sep 2026 15:23:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 15:23:05 +0800
Message-ID: <92050fca-96ff-46e6-aca8-3cecd7cfb778@huawei.com>
Date: Tue, 8 Sep 2026 15:23:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: Huacai Chen <chenhuacai@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<jic23@kernel.org>, <tan.shaopeng@jp.fujitsu.com>, <zengheng4@huawei.com>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <robh@kernel.org>,
	<coxu@redhat.com>, <tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>,
	<adityag@linux.ibm.com>, <djbw@kernel.org>, <seanjc@google.com>,
	<liaoyuanhong@vivo.com>, <vishal.l.verma@intel.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260907125404.922123-1-ruanjinjie@huawei.com>
 <20260907125404.922123-6-ruanjinjie@huawei.com>
 <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260908_002322_295986_08605296 
X-CRM114-Status: GOOD (  17.54  )
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



在 2026/9/7 22:05, Huacai Chen 写道:
> Hi, Jinjie,

Hi Huacai,

> 
> On Mon, Sep 7, 2026 at 8:53 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> During kexec image placement retry loops, any midway failure causes
>> the loader to truncate `image->nr_segments` back to its initial state
>> to purge the failed segments.
>>
>> However, this truncation introduces a memory leak. The CMA pages
>> allocated via kexec_add_buffer() during the failed attempt are tracked
>> in the `image->segment_cma` array. Because the subsequent cleanup paths
>> only iterate up to the truncated `nr_segments` boundary, these allocated
>> CMA pages outside the new boundary are permanently leaked.
>>
>> Fix this by explicitly releasing the associated CMA buffers in
>> the failure paths before `image->nr_segments` is reduced.
> I'm not sure but does the elf version have similar problems as the efi version?

This issue does not exist in the ELF version, as the retry loop for
load_other_segments() does not exit here.

Best regards,
Jinjie

> 
> Huacai
> 
>>
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: WANG Xuerui <kernel@xen0n.name>
>> Cc: Youling Tang <tangyouling@kylinos.cn>
>> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: stable@vger.kernel.org
>> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
>> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/loongarch/kernel/kexec_efi.c          | 1 +
>>  arch/loongarch/kernel/machine_kexec_file.c | 6 +++++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
>> index 5ee78ebb1546..15fd797ff3de 100644
>> --- a/arch/loongarch/kernel/kexec_efi.c
>> +++ b/arch/loongarch/kernel/kexec_efi.c
>> @@ -86,6 +86,7 @@ static void *efi_kexec_load(struct kimage *image,
>>                  * We couldn't find space for the other segments; erase the
>>                  * kernel segment and try the next available hole.
>>                  */
>> +               kexec_free_segment_cma(image, kernel_segment_number);
>>                 image->nr_segments -= 1;
>>                 kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>>                 kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
>> index 5412aa9f3568..62a5be102065 100644
>> --- a/arch/loongarch/kernel/machine_kexec_file.c
>> +++ b/arch/loongarch/kernel/machine_kexec_file.c
>> @@ -217,7 +217,11 @@ int load_other_segments(struct kimage *image,
>>         return 0;
>>
>>  out_err:
>> -       image->nr_segments = orig_segments;
>> +       while (image->nr_segments > orig_segments) {
>> +               kexec_free_segment_cma(image, image->nr_segments - 1);
>> +               image->nr_segments--;
>> +       }
>> +
>>         kfree(modified_cmdline);
>>         return ret;
>>  }
>> --
>> 2.34.1
>>



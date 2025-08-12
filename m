Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0EFC87FCB
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cdSSw5y33BjQl+3DCjsck3nUXe8hfMl/gV1/fxuV90E=; b=CjsZfMcwwblJQZLyamYUZiqY9e
	00Wi/cJLqsXTCRKXiiLbd1bajqF36cTGjl5zHDt2ACx0ysZnjhJu1shau9jr6P//Rr63Cd5tWaIJi
	rwn1gAdTAV4VTvk2KSmOtAMG/pa6WpcB8D7oQI5X1+oKvmTn2PY3LE9V1Dggy9XrBElUGGStPx2fp
	Fd4BXFF9yBP8mteX2Dj3X6j2vibHrc5KwVXmyU7Q9r86+NRqDqo2sUDq+e/S1zcwyvMQrZEp8aFkc
	hSMcsVeyQlc0TgcTusQYP6fqNuVzy8d0k3M5ShoZQ4WZjB6zzlyBky74bedUz5ge27YtX9v78H08y
	W76oLoag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uliOy-0000000A14Z-1JSK;
	Tue, 12 Aug 2025 06:22:28 +0000
Received: from out-177.mta1.migadu.com ([95.215.58.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uliOw-0000000A143-0CKO
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 06:22:27 +0000
Message-ID: <a04147a8-a087-4965-84e8-1c8aed5b62f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754979742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdSSw5y33BjQl+3DCjsck3nUXe8hfMl/gV1/fxuV90E=;
	b=X90fpE5jdVzGSdGKSCrC+Xs7F1eCChQ5F5KnEXLLuQMWZQDLJ+ofFFNaTEeqeqjKIKSh1b
	K7+7TbCqALWveeqrCCikaN5ldJG+U1KpNcPm1P1Okt2b/cFxkmZWNSbE6cleoI2uOr9FO4
	1vLOHWxh7ZxIoh+YLnjkillPxMLovw0=
Date: Tue, 12 Aug 2025 14:21:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] Add kexec_file support for LoongArch
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <CAK3+h2zXBcAgtWJLXhAzzTZQ6_7Epqc6HuOassm_o5JAftK+Gw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <CAK3+h2zXBcAgtWJLXhAzzTZQ6_7Epqc6HuOassm_o5JAftK+Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_232226_226193_6F7CD390 
X-CRM114-Status: GOOD (  17.74  )
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

Hi, Vincent
On 2025/8/12 00:20, Vincent Li wrote:
> Hi Youling,
>
> On Mon, Aug 11, 2025 at 2:28 AM Youling Tang <youling.tang@linux.dev> wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> This patchset implement kexec_file_load() support on LoongArch.
>>
>> This patch series enables us to load the LoongArch vmlinuz.efi or
>> vmlinux.efi by specifying its file decriptor, instead of user-filled
>> buffer via kexec_load() syscall.
>>
>> To use kexec_file_load() system call, instead of kexec_load(), at kexec
>> command, '-s' options must be specified. kexec-tools needs to apply the
>> corresponding patches. These patches can be found in repository [1] and
>> will be submitted to the kexec-tools community later.
>>
>> The basic usage of kexec_file is:
>> 1) Load second kernel image:
>>   # kexec -s -l vmlinuz.efi --initrd=initrd.img --reuse-cmdline
>>
>> 2) Startup second kernel:
>>   # kexec -e
>>
>> For kdump:
>> 1) Load capture kernel image:
>>   # kexec -s -p vmlinuz.efi --initrd=initrd.img --reuse-cmdline
>>
>> 2) Do something to crash, like:
>>   # echo c > /proc/sysrq-trigger
>>
> I am new to this feature but I am interested to test this feature, How
> do I get the second kernel or capture image vmlinux.efi and
> initrd.img, do I need to build them separately and how?
There is no need to build separately. The kernel images and
initrd of the first kernel and the second kernel can be the same
(because LoongArch is a PIE kernel when RELOCATABLE is enabled).

Thanks,
Youling.
>
>> Link:
>> [1] https://github.com/tangyouling/kexec-tools/commits/main/
>>
>> Youling Tang (6):
>>    LoongArch: Add struct loongarch_image_header for kernel image
>>    LoongArch: Add kexec_file support
>>    LoongArch/kexec_file: Add initrd loading
>>    LoongArch/kexec_file: Add crash dump support
>>    LoongArch/kexec_file: Add "mem" parameter to limit memory usage of
>>      kdump kernel
>>    LoongArch: Enable CONFIG_KEXEC_FILE
>>
>>   arch/loongarch/Kconfig                     |   8 +
>>   arch/loongarch/configs/loongson3_defconfig |   1 +
>>   arch/loongarch/include/asm/image.h         |  58 +++++
>>   arch/loongarch/include/asm/kexec.h         |  12 ++
>>   arch/loongarch/kernel/Makefile             |   1 +
>>   arch/loongarch/kernel/kexec_image.c        | 112 ++++++++++
>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++-
>>   arch/loongarch/kernel/machine_kexec_file.c | 234 +++++++++++++++++++++
>>   8 files changed, 448 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/loongarch/include/asm/image.h
>>   create mode 100644 arch/loongarch/kernel/kexec_image.c
>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>>
>> --
>> 2.34.1
>>
>>


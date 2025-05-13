Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6274C3ABC3
	for <kexec@archiver.kernel.org>; Tue, 13 May 2025 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hb7Kk1GYJlwj73IqJFxNS4iF7nkINP060GXNS8ftp34=; b=LMQD60PZoRe0Z2bzxud/V2P/3/
	Z88bsn7Yuc+xNM9Cu0fiocXV8fjZgkiZbRo30g+FO9O0LEjo2f5qpB8o1iJb3HdxhN16WvsNJPvQX
	Uo0OJgYmUnkxqAKZ1kAep2KQgux2g4Otfxpxe4VJm30LZY5QgDlULRpCF4+wTpus3dyT2wl+SC/Bf
	XwcqFUg8IJ6daD/r4ZUMaPJ7NJlzFXgkyUqw/1cxW2pvFfQMPEzeJTLEzC9GOOwDbNGBA6rK4sNuW
	FuuR3qugKTCTPcwoYzAozeBAMiCPGolEtSdlY900DrCQtWGsEjZ758fxn7sZvxwFb0GB6Ogz72uFa
	NXmVbjgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uErT5-0000000Clte-39PN;
	Tue, 13 May 2025 15:22:55 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uErS8-0000000ClcO-1rro
	for kexec@lists.infradead.org;
	Tue, 13 May 2025 15:21:58 +0000
Received: from [100.70.65.85] (unknown [20.1.194.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 873B5201DB17;
	Tue, 13 May 2025 08:21:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 873B5201DB17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747149714;
	bh=hb7Kk1GYJlwj73IqJFxNS4iF7nkINP060GXNS8ftp34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VReNskEFToT5zqzhoNgTGn+GoXBLuNeT62GG3iA7pbi/R2DhrjIel2HDliQdlITxi
	 tFvCbJXJD9HwWiokiU0dGQle3wzjFNbYme0tM/V0/sQKICee4ieBmpsgWMLMX0hWGQ
	 /C2L+BV8mL0Q7A6vEYk3jJUcPsBxSHGb8jTfOxIg=
Message-ID: <71439e57-87e2-436f-ba55-77c0539e9538@linux.microsoft.com>
Date: Tue, 13 May 2025 08:21:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
 <aCKtlthQWnq+xyat@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aCKtlthQWnq+xyat@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_082156_535497_F45F7B94 
X-CRM114-Status: GOOD (  20.18  )
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

On 5/12/2025 7:25 PM, Baoquan He wrote:
> On 05/02/25 at 01:03pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> Kdump kernel doesn't need IMA to do integrity measurement.
>> Hence the measurement list in 1st kernel doesn't need to be copied to
>> kdump kenrel.
>>
>> Here skip allocating buffer for measurement list copying if loading
>> kdump kernel. Then there won't be the later handling related to
>> ima_kexec_buffer.
>>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 3 +++
>>   1 file changed, 3 insertions(+)
> I applied this patch on top of below IMA patchset, and did a test.
> [PATCH v13 0/9] ima: kexec: measure events between kexec load and execute
>
> When I loaded kdump kernel as below with '-d' specified:
>
> /sbin/kexec -s -d -p --command-line=BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.15.0-rc6+ ro console=ttyS0,115200N81 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 acpi_no_memhotplug transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0 hugetlb_cma=0 pcie_ports=compat disable_cpu_apicid=0 --initrd=/boot/initramfs-6.15.0-rc6+kdump.img /boot/vmlinuz-6.15.0-rc6+
>
> I can see that this patch works to skip copying measurement list to kdump
> kernel as expected..
>
> =====Without this patch===
> [48522.060422] kexec_file: kernel: 000000006fbcb87f kernel_size: 0xe99200
> [48522.067742] PEFILE: Unsigned PE binary
> [48522.094849] ima: kexec measurement buffer for the loaded kernel at 0x6efff000.
> [48522.102982] crash_core: Crash PT_LOAD ELF header. phdr=00000000cae5d7e6 vaddr=0xffff8da640100000, paddr=0x100000, sz=0x5af00000 e_phnum=67 p_offset=0x100000
> ......snip...
> =====
>
> =====With this patch applied====
> [ 2101.704125] kexec_file: kernel: 0000000046d8985c kernel_size: 0xeab200
> [ 2101.711436] PEFILE: Unsigned PE binary
> [ 2101.734752] crash_core: Crash PT_LOAD ELF header. phdr=000000006fc83a51 vaddr=0xffff899480100000, paddr=0x100000, sz=0x5af00000 e_phnum=67 p_offset=0x100000
> ......snip...
> =====>
>
> My only concern is the patch subject is not very sepcific, it better
> relfect the exact action taken in this patch, like:
>
> ima: do not copy measurement list to kdump kernel
>
> Other than above concern, please feel free to add my:
>
> Tested-by: Baoquan He <bhe@redhat.com>
> Acked-by: Baoquan He <bhe@redhat.com>
Thanks!
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 38cb2500f4c3..7362f68f2d8b 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	void *kexec_buffer = NULL;
>>   	int ret;
>>   
>> +	if (image->type == KEXEC_TYPE_CRASH)
>> +		return;
>> +
>>   	/*
>>   	 * Reserve extra memory for measurements added during kexec.
>>   	 */
>> -- 
>> 2.43.0
>>



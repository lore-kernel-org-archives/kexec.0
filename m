Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78686CCF9F0
	for <kexec@archiver.kernel.org>; Thu, 30 Oct 2025 11:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ik0Dn6yoIaOsn0IBZHf2Z40Y5QF2XOwk9Yc8uDtsDqQ=; b=MNaIVU6jt4DJb3n4wzaMigZs+9
	CIV7GqUCS7CBSp080+iJ6IJ5lXR4JcKKLkDwnvEonY/q/rJi0VH437G/n0jGeLZ8O4mD8Adg6ouuk
	qvzEW80DPNGLkj2/CaLMV+/xXrDrfec9uwHwsy14c+ud6DswqwCP/nFTDknqj/J3fi484ayOSJnMd
	+IE6dPcWyERiWLbZcJuHhYf7EkM0yEhGR31U2DBbsoSRd994vfpyNd2WfmwmT9L+JO4h6GNB861uS
	1HUuv1EZVP/AhNsoDGAe0aOxthNZAGmLASZnjLVciY3L8wxIoH9Skdh1SXpayILlf0qlDc98fdxef
	pTk6kX+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vER2n-000000044DL-1OTf;
	Thu, 30 Oct 2025 11:42:17 +0000
Received: from smtpbg154.qq.com ([15.184.224.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vER2g-000000044Bz-08YW
	for kexec@lists.infradead.org;
	Thu, 30 Oct 2025 11:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761824497;
	bh=ik0Dn6yoIaOsn0IBZHf2Z40Y5QF2XOwk9Yc8uDtsDqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jNlULWf8s3rVMsXUtMVjqfY3V/r6moayXcXzV8n8bmIzeh+SIhnaD3rzhspYg5Wh+
	 mfognda4c8anoziMnfTjou+BtMh728k3QJdpxGg2xuzEUgx8Os9uyogWZn5ODMynj2
	 yWfCScHy4KeY/1JSHpz+heI0ViFQPGumtJE/ZStw=
X-QQ-mid: zesmtpsz6t1761824494tf6ab64b2
X-QQ-Originating-IP: QXnFLkcs8cNnZkKau4C6E+YnpRJf3CGmtKZQ0dBfhww=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 19:41:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10291608667741570973
Message-ID: <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
Date: Thu, 30 Oct 2025 19:41:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MmGwrenOE7FGs/rAUmOa2nkG4+s0TV4xml3w6J0CRi7e5DdnD4qXg2ZH
	6N+TEiz939magCHvZyvrwZuVSoCByVm6hVRo4UsbNG8x100kNzSJRbU3euLMWQMprL/WjOg
	t0mdG5gQa57BfZni7gdxZmUp4O+dRIH6yzeZoHhAZYQwriC2Cns6nvd7beyr77kzlLAdUB9
	7bcYe7OSyDayyz0lMCqqZZkxx/MTP2R+O11TY+WepY8EIMycEHWEm029jms15YgbgUXJ0M/
	Wv/2dDhdoNw/z76Tnggn/jU3wE5b0EH6QQpDCaVjuxRRmCCN98UrtCRShQfkHruvLQVEoyD
	XjQy1H02aENA8j4fhRPHtJcjjyBG5oonvNMa4w3LwugHogboqdTb1MD8FAI5USm6jTiUOnn
	uhC73Lmsvqa8mSG9NlYOcQt86uWNvwfxw7IKb1wmPJ/LYmZALxPtEcLjV4PFGcMXH5cm5RJ
	tarRCdxzoMxqLhMDVCvQitK/dFI7xVrfnZyMnOA66nE0H7S0WarwhF6jXTn1CY1FeIrHZpz
	e9yVoKwWn3Zslizvri5y/O5yf34XpFl9PEkoYlsudpOl4DSmtEgQ9YaSgkBOa0JMTnJxOiA
	tH4tPEMbH1qIbnDDknuRiu8jGvNxUeeusC9SPyIoVgBUoNxHmGcaOMRhzBmF0qBn8EPgWHz
	ktveVZDV8ozE1mUq4WOaNIoqHn6x8NMZdAedR5D7d1kK3WqMy302IfUXMOsMZSKe7mBENYr
	2JcqyXHIDQjyq1D0Gc7mMjClpIJlD/tqKL7ndV8FxmBlwCgBrTONe+ej3W93v/9LAV19Q3t
	SPTYD5r/SbqcPf5xH09X4VR6z3r3M2b+CPbVkg1H+kz/IGdmY/FFRhrdn1TIg5a8ahdFLbE
	WnCI5I913qesJhtwYJwzQmzHh9eD+LdMCD2JZYBxBbF/DfMirickCDcPq3VLpDV2EdYAZR3
	ArRI+w+6WmeXACWv0EXAofrbCN84X7gycjgRDLQHqYYyF9L1B1eSwMsffXw0P8CxkLnkqPY
	q7Cm0YVi2Zbpb1eMRC
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_044210_987422_5A5B3F64 
X-CRM114-Status: GOOD (  16.36  )
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


在 2025/10/30 17:42, Baoquan He 写道:
> On 10/30/25 at 03:33pm, Qiang Ma wrote:
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>
>> Especially in the RISC-V architecture, kexec_image_info() has been
>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>> message if required")). As a result, when using '-d' for the kexec_load
>> interface, print nothing in the kernel space. This might be helpful for
>> verifying the accuracy of the data passed to the kernel. Therefore, refer to
>> this commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required"), debug print information has been added.
> kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
> doesn't work when you unset CONFIG_KEXEC_FILE.

Yes, I just actually tested it and it really doesn't work when unset 
CONFIG_KEXEC_FILE.

In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.

>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   kernel/kexec.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index 28008e3d462e..02845a7499e9 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>>   	for (i = 0; i < nr_segments; i++) {
>> +		struct kexec_segment *ksegment;
>> +
>> +		ksegment = &image->segment[i];
>> +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>> +			      ksegment->memsz);
>> +
>>   		ret = kimage_load_segment(image, i);
>>   		if (ret)
>>   			goto out;
>> @@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>> +		      image->type, image->start, image->head, flags);
>> +
>>   	/* Install the new kernel and uninstall the old */
>>   	image = xchg(dest_image, image);
>>   
>> -- 
>> 2.20.1
>>
>>
>


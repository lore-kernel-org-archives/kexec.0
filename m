Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82E1C48BEB
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 09:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:References:
	In-Reply-To:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PElD2k3MbG6y5hJfba97Su4k3TFkHAQQM9YpzyD4Pmc=; b=DeuQ+eKsPelVHa
	UrBBlTS2D8sCbJzVlTlAo9LxX/h541ppE84sFc1tcatI6HqzA6ZbYJKea936sBUn1UGndQV68d+3J
	ofNXIrqS12REIA/DWSCJHlAZhSs54Ek+Ckv3Gpn3Jit3YEQFrUYqYBOf9cqFUtq7spUCHQEXu3BsM
	Df27dCVc+XlIhMhrTfby03NqpCBRkgIf6nMKI7MGY1QO7UFr6rkVMMUfhgYWSQUCZcNhkec5p4lin
	Go0nZwIld9kS2IopS54rnVQGXO7QJ2zUF3dc8vkoLmwmyXWdvUzRIxBSYkfL6wJciLAXbduHwpFv/
	REZzk9WfxH4TaVleo6TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5Jk-00000004Dhm-1o2f;
	Thu, 22 Feb 2024 09:24:36 +0000
Received: from m16.mail.163.com ([220.197.31.5])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5Jh-00000004DgY-00Nu
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 09:24:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Vv+6eYhYqxT5hunqvGaonr/mo3RX0vy18gjG7AgJ+Uc=; b=W
	8ptBf2nSSlH0jnCte9xw5t+dh8fhrjUtTFGKma8ymqqBhe8Yig+jq+0VnW0CLE0T
	NpvMDgsLXuwjrN3drAjm0rxyNc+hJE83M1EWIdoraO+y1Z6D0mJiM8qzYb1rif8S
	vQp/gn7hBtz23bEsAgno2TsARlORalf3wx0lU9ZCPw=
Received: from gaoshanliukou$163.com ( [60.27.226.204] ) by
 ajax-webmail-wmsvr-40-110 (Coremail) ; Thu, 22 Feb 2024 17:24:20 +0800
 (CST)
X-Originating-IP: [60.27.226.204]
Date: Thu, 22 Feb 2024 17:24:20 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Baoquan He" <bhe@redhat.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: Re:Re: [PATCH v2] kexec: copy only happens before uchunk goes to
 zero
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <Zdb7ogmu/7IOBN3U@MiWiFi-R3L-srv>
References: <20240220021106.694-1-gaoshanliukou@163.com>
 <Zdb7ogmu/7IOBN3U@MiWiFi-R3L-srv>
X-NTES-SC: AL_Qu2bCvmSvEAt5iaYZ+kXnEYQh+k3XcK4u/0u2YFVP5E0vyTz9gklc3FYEGD13tqONS+OvhamXzFUycRfWoJfRpPvWbfIbQ9dsutaYlvl2nql
MIME-Version: 1.0
Message-ID: <187a4850.c0d8.18dd0214ffe.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3_zrEEtdlEif9AA--.33381W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbB0BmM8mWXwByflwABsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_012433_435961_80ACA912 
X-CRM114-Status: GOOD (  10.72  )
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


At 2024-02-22 15:45:38, "Baoquan He" <bhe@redhat.com> wrote:
>On 02/20/24 at 10:11am, yang.zhang wrote:
>> From: "yang.zhang" <yang.zhang@hexintek.com>
>> 
>> When load segments, all of the copying and the rest
>> only happens before uchunk goes to zero.
>
>The code change looks good, while the log can be improved with more
>details so that people can more easily get what's wrong and fixed.
>
>===
>When loading segments, ubytes is <= mbytes. When ubytes is exhausted,
>there could be remaining mbytes. Then in the while loop, the buf pointer
>advancing with mchunk will causing meaningless reading even though it
>doesn't harm. 
>
>So let's change to make sure that all of the copying and the rest only
>happens before uchunk goes to zero.
>===
>
>Please take above words as reference to udpate patch log and post v3,
>and you can add:
>

>Acked-by: Baoquan He <bhe@redhat.com>
Thanks, i update the commits and post v3.>
>> 
>> Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
>> 
>> ---
>> v1 -> v2:
>> - Only copy before uchunk goes to zero
>> 
>> V1: https://lore.kernel.org/lkml/20240130101802.23850-1-gaoshanliukou@163.com/
>> ---
>>  kernel/kexec_core.c | 44 ++++++++++++++++++++++++--------------------
>>  1 file changed, 24 insertions(+), 20 deletions(-)
>> 
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index d08fc7b5db97..2fc3d0e3715a 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>>  				PAGE_SIZE - (maddr & ~PAGE_MASK));
>>  		uchunk = min(ubytes, mchunk);
>>  
>> -		/* For file based kexec, source pages are in kernel memory */
>> -		if (image->file_mode)
>> -			memcpy(ptr, kbuf, uchunk);
>> -		else
>> -			result = copy_from_user(ptr, buf, uchunk);
>> +		if (uchunk) {
>> +			/* For file based kexec, source pages are in kernel memory */
>> +			if (image->file_mode)
>> +				memcpy(ptr, kbuf, uchunk);
>> +			else
>> +				result = copy_from_user(ptr, buf, uchunk);
>> +			ubytes -= uchunk;
>> +			if (image->file_mode)
>> +				kbuf += uchunk;
>> +			else
>> +				buf += uchunk;
>> +		}
>>  		kunmap_local(ptr);
>>  		if (result) {
>>  			result = -EFAULT;
>>  			goto out;
>>  		}
>> -		ubytes -= uchunk;
>>  		maddr  += mchunk;
>> -		if (image->file_mode)
>> -			kbuf += mchunk;
>> -		else
>> -			buf += mchunk;
>>  		mbytes -= mchunk;
>>  
>>  		cond_resched();
>> @@ -866,11 +868,18 @@ static int kimage_load_crash_segment(struct kimage *image,
>>  			memset(ptr + uchunk, 0, mchunk - uchunk);
>>  		}
>>  
>> -		/* For file based kexec, source pages are in kernel memory */
>> -		if (image->file_mode)
>> -			memcpy(ptr, kbuf, uchunk);
>> -		else
>> -			result = copy_from_user(ptr, buf, uchunk);
>> +		if (uchunk) {
>> +			/* For file based kexec, source pages are in kernel memory */
>> +			if (image->file_mode)
>> +				memcpy(ptr, kbuf, uchunk);
>> +			else
>> +				result = copy_from_user(ptr, buf, uchunk);
>> +			ubytes -= uchunk;
>> +			if (image->file_mode)
>> +				kbuf += uchunk;
>> +			else
>> +				buf += uchunk;
>> +		}
>>  		kexec_flush_icache_page(page);
>>  		kunmap_local(ptr);
>>  		arch_kexec_pre_free_pages(page_address(page), 1);
>> @@ -878,12 +887,7 @@ static int kimage_load_crash_segment(struct kimage *image,
>>  			result = -EFAULT;
>>  			goto out;
>>  		}
>> -		ubytes -= uchunk;
>>  		maddr  += mchunk;
>> -		if (image->file_mode)
>> -			kbuf += mchunk;
>> -		else
>> -			buf += mchunk;
>>  		mbytes -= mchunk;
>>  
>>  		cond_resched();
>> -- 
>> 2.25.1
>> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

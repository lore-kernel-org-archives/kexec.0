Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BFBEDF020
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 02:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lvn+uOB5MSzhQfC88CvOnl7GbTsv9utGmhB1j+EiHpk=; b=F8pWFclMu8d8OpUnoWEe6NIiSF
	hT5Ar8Ji9HjKWRsNp9Nx1VTm4hcD/5OEsAfmqE5wPIE+te47xFLfnVUmGW+VPl7BsUr0kq8keTGpO
	A/hH0bItOMGgxaoCMceJmftAPYcVop04hpqeA8vouqfFDsBpoH0jMzle89KMWc4tyHpZC7MjwgXEL
	Tu4+H2mPNjV8gEXUKRZUWVPwo9XRv9emaz2Zb/1bYM1gvOtOUI6nbjet1olgeeiMOkgRQ9fXXf/J3
	I+VIVbOZqCQ2p/6YFeahEOA/sbzUZFAcJHAm4czSLxXuZvEahSW/MuPe4VWsHiK4XxDmVF2iQ0uaE
	vUeFyJqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMZu-00000001Jyq-1S5p;
	Thu, 12 Feb 2026 02:37:14 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqMZr-00000001Jxy-0Rwq
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 02:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lv
	n+uOB5MSzhQfC88CvOnl7GbTsv9utGmhB1j+EiHpk=; b=XG7a5huMj/vxPKDcXx
	lfroxUrLkRQLEUcFGZnjTeIpt9vzxystePlkfKBR7T3CfvJ7QVh2lyJuBrqrXDeD
	KRX4fmMj0ELP2UTwkY7jk561zmX3tO0c04LcQAicsWKqrzkx4gbh43eeHiw0U+3G
	bPlQL/EXCPLyv0HMCgXivG8Fs=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCHgI6wPI1pT0+EOw--.855S2;
	Thu, 12 Feb 2026 10:36:36 +0800 (CST)
From: ranxiaokai627@163.com
To: pratyush@kernel.org
Cc: akpm@linux-foundation.org,
	kexec@lists.infradead.org,
	graf@amazon.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	rppt@kernel.org
Subject: Re: [PATCH v2 1/2] kho: fix missing early_memunmap() call in kho_populate()
Date: Thu, 12 Feb 2026 02:36:32 +0000
Message-ID: <20260212023632.209376-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2vxzy0kzr5ha.fsf@kernel.org>
References: <2vxzy0kzr5ha.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgCHgI6wPI1pT0+EOw--.855S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw13Xr43AFWUKF15XF1DKFg_yoW8Kr1Upr
	Z5G3W7Cw48tayjqa17ZF1ag34Ygw4ktw1fta4Uta4fJw1DZrn3XrWxJF1vkFnFvr9Ig3W8
	tF40qa93W3W8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUGoG9UUUUU=
X-Originating-IP: [2409:8a62:14:e170:5054:ff:fe85:ffcf]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbC7hT5RmmNPLQ4JQAA30
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_183711_553751_6899ED1C 
X-CRM114-Status: GOOD (  13.94  )
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

>Hi Ran,
>
>On Wed, Feb 11 2026, ranxiaokai627@163.com wrote:
>
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> kho_populate() returns without calling early_memunmap() on success
>> path, this will cause early ioremap virtual address space leak.
>>
>> Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
>> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index fb3a7b67676e..3c705b08a489 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -1463,13 +1463,14 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  	struct kho_scratch *scratch = NULL;
>>  	phys_addr_t mem_map_phys;
>>  	void *fdt = NULL;
>> +	bool populated = false;
>>  	int err;
>>  
>>  	/* Validate the input FDT */
>>  	fdt = early_memremap(fdt_phys, fdt_len);
>>  	if (!fdt) {
>>  		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
>> -		goto err_report;
>> +		goto report;
>>  	}
>>  	err = fdt_check_header(fdt);
>>  	if (err) {
>> @@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  	kho_in.scratch_phys = scratch_phys;
>>  	kho_in.mem_map_phys = mem_map_phys;
>>  	kho_scratch_cnt = scratch_cnt;
>> -	pr_info("found kexec handover data.\n");
>>  
>> -	return;
>> +	populated = true;
>> +	pr_info("found kexec handover data.\n");
>>  
>>  err_unmap_scratch:
>>  	early_memunmap(scratch, scratch_len);
>>  err_unmap_fdt:
>>  	early_memunmap(fdt, fdt_len);
>
>I meant to say all these labels should be renamed, not just err_report.
>So "err_unmap_scratch" should be "unmap_scratch", and "err_unmap_fdt"
>should be "unmap_fdt".

Hi, Pratyush,

Thank you so much for your patient guidance and detailed help.
v2 did look a bit strange. I will update the code.

>> -err_report:
>> -	pr_warn("disabling KHO revival\n");
>> +report:
>> +	if (!populated)
>> +		pr_warn("disabling KHO revival\n");
>>  }
>>  
>>  /* Helper functions for kexec_file_load */
>
>-- 
>Regards,
>Pratyush Yadav



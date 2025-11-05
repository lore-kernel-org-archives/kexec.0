Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC82CCFA04
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 07:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P/IEUU8bwmpdz3eEeNkRu3EBPrJTlvjCdOgyW7LQAoE=; b=V9Mu9D9dBfPYVwRFah43S2q2c8
	aboMrMIUdA9719HPFbHxoIbzzjzYgYlhAOZp5sYWfyJXSOyteZ06MQiFONUHt8vmyTuGt6iHGmt8w
	BBr0/g5kfAnK/GU7GVdx8lLP4d45IZAJn6y9FfRDshqh8WRuMDNzaNuddCDsSE/MeRewb84ob05YD
	Lrf/bKlGD2T/f5qpf1RHLF1dZpej9L0ksC6vAfhmG0yQmCBASpfgpPN3zenyMtwmWD9FrV/nF426z
	NnW7DeeQW+nesq7++GxpV/8tHExycf/tCdLT2hvWYyvl/HZ5Hbc5dkVW+I6XjVchSBmFERDiboJiJ
	0PRw6jJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXcB-0000000D8VV-247p;
	Wed, 05 Nov 2025 07:07:31 +0000
Received: from smtpbg150.qq.com ([18.132.163.193])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGXc6-0000000D8KG-3qPv
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 07:07:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762326413;
	bh=P/IEUU8bwmpdz3eEeNkRu3EBPrJTlvjCdOgyW7LQAoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VYc0Njxe9u6lbHZrlxDnvhtrs+EraGkeVszom7ShtHCi98MF8ok6nsHkz890uZuJu
	 bAWhBF6N+lIy+nw07YxEHj7MKiR5ZHSH0CU3IWlkuuQvjtHJmss1U85dcbMwxfvnUJ
	 bnp0WWlPjewXC5SU4BhrD0QWBtSSZEWcYUAwRRPo=
X-QQ-mid: esmtpgz16t1762326411t6bbd595a
X-QQ-Originating-IP: frkdY+kACG4+OT633H1PI1zyXz5wdWpQMA9xqgstCf8=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 15:06:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1361723058384456180
Message-ID: <DB8D55DA58E28E7A+e01fbd66-c45e-40f1-9d4e-44f18b04a716@uniontech.com>
Date: Wed, 5 Nov 2025 15:06:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] kexec_file: Fix the issue of mismatch between loop
 variable types
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-5-maqianga@uniontech.com>
 <aQq/CHi10ihT8/sn@MiWiFi-R3L-srv>
 <0C92443D3E2100AF+c669d240-1ee8-4897-a30d-3efefe161085@uniontech.com>
 <aQr1K/+I91RhVGuo@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQr1K/+I91RhVGuo@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NBjdfkqVynM2oGVMqfIjVrxjjhWnOiLWnNnY3EB5BoBK/eUiJoz4qEn0
	SgJt8UsCHFqb2vpO34+eoJEGUjXVXINzL/J/JUEPoqfZiuPTli6EVqqS8+GmcM1REMrMbv9
	y605huBj+TL8Lg5/SlqUw98YjlSsuUrBMXATk/VQ2aEqHfwwn0LTf5tlQS3RYJb7WSHSsz+
	Z5U8/45XGDJ8w+NPM+vNqx9OfCTEXXQgT7GSTBrTC5+doloSo/R9MJpRKxO1E5i/x+6/Ht+
	bqP9LAd+JtDjw0cN/PisAJKBO4sv7VPTMVcsrB8k8Z1kT5vnW1ghoCck9RFJJZY4mpPtglf
	sp9g/sOFlLwILwRyIip51zGQFt8iiDA1GRbieA/ui+Q7s2oY/P+qriVby2bcPIzKSL+/9AB
	Yv2iR6DZa1vHhhQnlaeI161pcgyRx08TQOuZImfX2MQKfqy0MRX6eNNYnY2nnfhcb9QNZqf
	O0D2JZKYsApqkw9csknm8fzp8ggPENPl2EIds3dO0S4lqDUS71nPu/oouB63ORGIP3K3GKo
	7e3up7o0q4Ky2KEUhy3DK4awaLntwJapTh5azTqIGZDf7Nzz5s5avWkG5qhgbd8Oiu3zcJE
	bzwqjsuKp+1/TccbSfPBiRINdi6TJio728Q/Qe3PZd7kRijs/jVVPNeRzAM+0sjHMEykEwp
	2GoGj3bY2rop6RIuxt7J6Dj78yULP1ilbCAek/uTcb0gAwI7NTkGWLDu1Iq2S/3nk+Dp8xg
	cWU3SlPEF1MzhmWur9mP6n0yxaebTnNt89eCiOYQ8HPuk+c/Tkhi31+81hECvqicLOnL1RB
	lIbFCLqyiuWziUYsAbqdLRV7duXEg+RRWg5ZSPCNdCNHFN5vKuQkGZQ0R/NqmQW4TNNbr8c
	LVgmBsLbTFKvbmBvhdZC71p+TY0JgjtU1imdkB4ff0Dkv7uXANlSzbrmGe+8fNb9ZmP2Li2
	qVw0qYudnf6r46Ujd2D0bxxePPJxID6WWduTHhu2cAsQEB8MmFewCnPOZLuZg7H1aVec+K5
	tIuXllbc+ihF024vT7
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_230729_008800_5013F8E5 
X-CRM114-Status: GOOD (  12.17  )
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


在 2025/11/5 14:56, Baoquan He 写道:
> On 11/05/25 at 11:47am, Qiang Ma wrote:
>> 在 2025/11/5 11:05, Baoquan He 写道:
>>> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>>>> The type of the struct kimage member variable nr_segments is unsigned long.
>>>> Correct the loop variable i and the print format specifier type.
>>> I can't see what's meaningful with this change. nr_segments is unsigned
>>> long, but it's the range 'i' will loop. If so, we need change all for
>>> loop of the int iterator.
>> If image->nr_segments is large enough, 'i' overflow causes an infinite loop.
> Please check kexec_add_buffer(), there's checking for the value which
> upper limit is restricted to 16.
>
>          if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
>                  return -EINVAL;
Oh, then this patch is really not necessary.
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> ---
>>>>    kernel/kexec_file.c | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index 4a24aadbad02..7afdaa0efc50 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -366,7 +366,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>    	int image_type = (flags & KEXEC_FILE_ON_CRASH) ?
>>>>    			 KEXEC_TYPE_CRASH : KEXEC_TYPE_DEFAULT;
>>>>    	struct kimage **dest_image, *image;
>>>> -	int ret = 0, i;
>>>> +	int ret = 0;
>>>> +	unsigned long i;
>>>>    	/* We only trust the superuser with rebooting the system. */
>>>>    	if (!kexec_load_permitted(image_type))
>>>> @@ -432,7 +433,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>    		struct kexec_segment *ksegment;
>>>>    		ksegment = &image->segment[i];
>>>> -		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>>    			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>>    			      ksegment->memsz);
>>>> -- 
>>>> 2.20.1
>>>>
>


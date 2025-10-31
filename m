Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8F0CCF9E3
	for <kexec@archiver.kernel.org>; Fri, 31 Oct 2025 02:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4/lEo+iFPcejD1HYzXXHmJ4Wq2MvRqAfEXFOQWInZU=; b=Uynn3M89aRHecyqkQ41ipxVbDR
	2P0wL9qS/K617nl2BDaxD+4N3pcYvQY/uzKtmK7ZAWiSVD5Nfkdw8xbM6MutBwQ8/jfKxbpXnCXyr
	Vi36G5pb/SAlGr44Vi579FhBix4lMyusckn8iLMKHlesuC6H6vVviP/jplGuCLG/IIQ9WjybqCcDH
	ow9GzHUQAqlcdW9cS+vaK5blhc+FjaWjaIU48l0zRpwCenPI2DIknIZaNsydOhdadOzGZAcPXXB57
	+IzJH+L5VElC8XiSaenYUjRaJVTdUzj/0QlgLrCTwlWzvaDCqnIYsb29HoSsT4gUppoaIqWTqT6r+
	Jwm273jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEf4K-00000005HFO-3vsb;
	Fri, 31 Oct 2025 02:40:48 +0000
Received: from smtpbguseast1.qq.com ([54.204.34.129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEf4G-00000005HEj-213s
	for kexec@lists.infradead.org;
	Fri, 31 Oct 2025 02:40:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761878411;
	bh=l4/lEo+iFPcejD1HYzXXHmJ4Wq2MvRqAfEXFOQWInZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IqD/KbRSO0wd1FlEP8dj4zGpyouFW1LhXqtO5p145K1GfBPWOf3AhZ6HH4CYUdRSN
	 i79WfmbSnXG8BPGJBWQ8hDajrLDqmzkBBvRiCKJma9uwKqR4Qi1IANccaQdTZr0q1/
	 FqnRbnBDI43fDi998HIxJGIsZ2FK8v8JdPbFzkCE=
X-QQ-mid: zesmtpsz9t1761878408t66b41fc2
X-QQ-Originating-IP: aN5SbCMpn4nq2ydWUTEjzwYfahQbWdRio1m+8vmqXrk=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 10:40:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6865774659081570964
Message-ID: <9362A6495165FCC0+d659800e-6751-4d26-a8b8-183705798e96@uniontech.com>
Date: Fri, 31 Oct 2025 10:40:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251030073316.529106-1-maqianga@uniontech.com>
 <aQMzFnqMC0MnLZFO@MiWiFi-R3L-srv>
 <C798DAB0066FD66B+590e2398-b667-40dd-abfb-99dcd728b573@uniontech.com>
 <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQNvHdZcVzletjdi@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MShfLn39PbN2mOtH9g2M/3s94fDr9DbJUoSZlrIp2Hq+eSD77Us+HnjJ
	E97E0+LsZlQLxsg7hg7thfDTyek6gq3Rh5pEIwtjdj0s3Cgeuem5EOUebgV4robtEQWo415
	OkYwLfnUd4H1Qfbtn4+68NtlDVsPOSn7aLRRB4t5Bax8udO2S/MVHbI0PqVF5tvFPI4d44z
	WKb1WNMMNWwwsZQ3Mb7f6CwUN1K9eTJAMBpGjRL8Ex2XqUaiafsxZn90ygfmEX3Hf0r+cns
	bS4z+HZNdmSSuneHDmr9bjjrGShWYNL0QwJ1Oi+BKpy/+fMhvu0sARXo34wsvglB35/SQTl
	6+a2itCS72n5/v2BAUM2r9JwyvDfiMbcohO2aqvAg8kmRkIIQpZ5jwxRPjSEcHml0uFr11m
	eN9zfcrAfyTCVlnmWaXA6r8EiGtuFDrvPbyRlanvy9K+EZj0E+eP9mGWW+j0i1hHe7a5EPy
	TztkbGJ9VESGhG9XGTh0mXgnkrhAZ7kScvRdpic3B1TObM5MAcu1qU3YlaEtHDJIT9EsFE/
	Dg/MapYZ5oBkysv/0qBNEivesSv32dF52AKLHuXRWiGrCbCLzFrATUqdTBTr88Ynzek75Z+
	aweTdbvgg9g1YFjuYLNQAVt01LH8vtX/iRVGO9JB02gGNQGXtz6lR6zfJABC/ubYc6/xFed
	Vl01RvwSU0sj5/DUDUq4hx/Y1d6KVA9GtdpEHEtxY6OrK2q5bT6BuLksO4hSQVEYOiQoTEn
	3Oy3uHLPbnbAP5VZTtVzLq1q2NSTiYUejbiF1WjFqCotf4Ev3Jp/N5GnRCHRmxERmyJg99o
	Wr+Wpt+7ZyUbQAuHKA4G34JGa1L6iif/BtpTZBo2BjMqzR8fQZbS03g9MTRigpNoOfH6qev
	F1nNTqOVW4bp7V29F6ooDiJs23q3d2+TmwW9KdHm2vRy4UwiJm5byn8PzYt7oi8uIY2krC6
	XAv8HdpH8ivFgDoxqj1GygwfDfe7UwPN2Fp2WUDGWp+pGpAQ2cDeCbiWu8dOlLJGyhoo/vB
	lP6muhXCiQsvjH5TGpBX9i/cntOhY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_194045_341263_57AEDC0C 
X-CRM114-Status: GOOD (  14.91  )
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


在 2025/10/30 21:58, Baoquan He 写道:
> On 10/30/25 at 07:41pm, Qiang Ma wrote:
>> 在 2025/10/30 17:42, Baoquan He 写道:
>>> On 10/30/25 at 03:33pm, Qiang Ma wrote:
>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>> if required") has added general code printing in kexec_file_load(),
>>>> but not in kexec_load().
>>>>
>>>> Especially in the RISC-V architecture, kexec_image_info() has been
>>>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>>>> message if required")). As a result, when using '-d' for the kexec_load
>>>> interface, print nothing in the kernel space. This might be helpful for
>>>> verifying the accuracy of the data passed to the kernel. Therefore, refer to
>>>> this commit a85ee18c7900 ("kexec_file: print out debugging message
>>>> if required"), debug print information has been added.
>>> kexec_file_dbg_print setting when CONFIG_KEXEC_FILE is set. I doubt it
>>> doesn't work when you unset CONFIG_KEXEC_FILE.
>> Yes, I just actually tested it and it really doesn't work when unset
>> CONFIG_KEXEC_FILE.
>>
>> In the next version, I can add a KEXEC_DEBUG for the kernel and kexec-tools.
> Hold on please, it may not need that highweight change. I will reply to
> you tomorrow if I have other idea.
Ok. My current idea is to refer to kexec_file, define a kexec_dbg_print,
initialize it in the kimage_alloc_init(), modify KEXEC_FLAGS and 
kexec_dprintk,
and add the judgment of kexec_debug.
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> ---
>>>>    kernel/kexec.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>> index 28008e3d462e..02845a7499e9 100644
>>>> --- a/kernel/kexec.c
>>>> +++ b/kernel/kexec.c
>>>> @@ -151,7 +151,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	if (ret)
>>>>    		goto out;
>>>> +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
>>>>    	for (i = 0; i < nr_segments; i++) {
>>>> +		struct kexec_segment *ksegment;
>>>> +
>>>> +		ksegment = &image->segment[i];
>>>> +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>>>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>>>> +			      ksegment->memsz);
>>>> +
>>>>    		ret = kimage_load_segment(image, i);
>>>>    		if (ret)
>>>>    			goto out;
>>>> @@ -163,6 +171,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	if (ret)
>>>>    		goto out;
>>>> +	kexec_dprintk("kexec_file_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>>>> +		      image->type, image->start, image->head, flags);
>>>> +
>>>>    	/* Install the new kernel and uninstall the old */
>>>>    	image = xchg(dest_image, image);
>>>> -- 
>>>> 2.20.1
>>>>
>>>>
>


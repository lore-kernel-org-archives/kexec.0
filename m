Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EE7D41D74
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 04:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fdr0ZP0w/Sjov31RGjLIPHkpNfMDDts+euLiceguBy4=; b=aMyq02J47P/M/TPBDJrQwN5vec
	aKRpOInfLOcxoQTa4AnwrOITKZbCHjvHKvATXaZAa+lVWm9yinPDKANdSirJZ/TAZs0cTNZ817whF
	11YyWqiLHBnKahQ0xrjgHZH9FruFmUeB4I++1mUdQQZLMqlnXYC/GmxobjN5QwGp+a9RZXLmglrDv
	uKRhibqr9Rhshgcb/wGo0L90RUCNzdd2OFODHv0qEAo19do76bcjM7BslfiVCw18bHqWrErd9EJa6
	cfKZlOV8qtB398lN0rYwHw4atYMv4m7/L64ZDmfFmZ+XUtYP4jkkJWaET9elayOcExMQE6Ac833/f
	BGod1lGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV0Pl-000000033sY-2QYN;
	Mon, 15 Dec 2025 04:42:29 +0000
Received: from smtpbgjp3.qq.com ([54.92.39.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV0Pf-000000033rl-3578
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 04:42:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765773714;
	bh=Fdr0ZP0w/Sjov31RGjLIPHkpNfMDDts+euLiceguBy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GJu6X71Is3Lkamul3aQRzAg3UwsT+nUffu7tBmmMdZ+krUCYwZKAAeQRfSbq3pnH1
	 E2Y3ZJv0xaMAvWqKbox5aYF/JIW7QRPkQ3K4ruRx7RkGhK0BNNTkcPGHo3Pb4JMuAs
	 9E34C5K1ILsrcdZweW0FUYKFWowMo+3MBZnLFP7M=
X-QQ-mid: zesmtpgz4t1765773712tc25e9e7b
X-QQ-Originating-IP: RZ5Bn6JYtjJw8Sf/rZoBW86qip1yAw1FTIr/24rJDew=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Dec 2025 12:41:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4627978995181762442
Message-ID: <C2FBF39E1F0503D4+8030be33-fd88-4f18-b631-a4fecaf62c5a@uniontech.com>
Date: Mon, 15 Dec 2025 12:41:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251212071656.834079-1-maqianga@uniontech.com>
 <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
 <84FB6FCADDAE5EBE+e11782ba-7483-40f4-8a40-a5e26f51183d@uniontech.com>
 <aT9h54lX3J+cO0gf@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aT9h54lX3J+cO0gf@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NkHKfw09D6j8EJfWJaDIxnE5nnauTDl7p4a9QMmwD/ANqCOBgxAOJy5n
	vj0IaPG0XszNtXF2WW4olbH6Z3xZBlQZxrLUPLeeyEMIqx9CBsQBVjFHNSuMiN+hv3a7tub
	R9pIcn2vjFsouiDGXggLRd0wXrSZB2SrZKqbPtFnl6nqoOQYZknOVZn97R6QsepQCqIBVMt
	ZCZXtTr3aXnt0K7mMYMIG4rNXZ8bRhacIznbNA7cmsrijjxT8f6id9EZ3CZaBj0MTQGcHL7
	wS5d1oDNBNiL/VgO4HLOw+zRKNxslJAABCd+QhKUqaK4u1tZWVw3wheHCqmg1NXSwO0xqU5
	MhTiq5e4hJERDShRdl8y4BOcMYNNblkllLGlMH9RQa3MbPazoG5axhFrpT7q4tAZnLFcO13
	Y1KEN042BKsT0XS9iN+v2Q9CBy7K/9hj0WkCrIvjVdoiGWIk5sel9IpWCFt7h0DjzaLjVDO
	ecSqV2OB4fdarEpaNq3RFABL+ZIBThFpbs+aCx0dlXsCCB0ngGojauQE9AGdlJyJX+LxYBi
	PjxHP2Q1Uv1L9F0Oy3dSDKQLCYPxVJ69pjUJ1iPNk1mSTRd1utKDo7GN5c8vPlJcpQeEnNR
	SxIE4AAZ04Xz7xz863Z3+sQGjAq1MFQL2LQGa0CADSPtTs801ldeRtMT2E07HKvuBv8eBHc
	VHtRCPtY73PzRFeghY+TI7uZ71ihEUyYuzeTL4uz7MGWebDsoUSRgeG7argHCgS8VtHT0Yi
	pOAvG2jFPTwhnswXTc5dwuhkEGKxnWTXv92uUonli+8X/UDoaqF1CbDoy8oOROyjYUUVE0x
	nXFxKzPQMUOtiCJAvUgiUKy5S+pFnVW2nsA/4/XcI8tfhs8AtP/BN8mULIt8fqjTUYlxwt5
	7X1TFFt7U/6pzh04mgwBJ2lW7JK31FhDmVQxD3XzbuLYxzzf5DqfONrgiaPuwuPg4X0PNGl
	t48v8WCKRKHhMjMobBYxGwsx5pBI15D5+LGrBorAjHEYkfWMYypx7kiWVyPFOhLcLY4Knvf
	rbg9ezIROuXDA/Ki2FGpKwNyxUoLo=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_204224_442982_B489A72D 
X-CRM114-Status: GOOD (  12.84  )
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


在 2025/12/15 09:18, Baoquan He 写道:
> On 12/14/25 at 07:35pm, Qiang Ma wrote:
>> 在 2025/12/12 18:53, Baoquan He 写道:
>>> On 12/12/25 at 03:16pm, Qiang Ma wrote:
>>>> The image is initialized to NULL. Then, after calling kimage_alloc_init,
>>>> we can directly goto 'out' because at this time, the kimage_free will
>>>> determine whether image is a NULL pointer.
>>> Rechecked the code flow, in kimage_alloc_init(), if anything wrong, the
>>> allocated memory are all freed via out_free_control_pages and
>>> out_free_image accordingly, any place missed? If no, I think the current
>>> code is correctly handled.
>> I rechecked the code and found no omissions.
> Hmm, my bad, I didn't say my question clearly. I checked code, didn't
> find anything wrong in the current code. In kimage_alloc_init(), the
> allocated memory are all freed on failure, no memory leaked. Means you
> are fixing correct code.
Oh, I see. I recalled that this fix was in preparation for patch
"kexec: add kexec flag to control debug printing" for kexec_dbg_print
to be reset to false in kimage_free.

In that case, I don't think this patch should be posted separately.
>
>>>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>>>> ---
>>>>    kernel/kexec.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>>
>>>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>>>> index 28008e3d462e..9bb1f2b6b268 100644
>>>> --- a/kernel/kexec.c
>>>> +++ b/kernel/kexec.c
>>>> @@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	unsigned long i;
>>>>    	int ret;
>>>> +	image = NULL;
>>>> +
>>>>    	/*
>>>>    	 * Because we write directly to the reserved memory region when loading
>>>>    	 * crash kernels we need a serialization here to prevent multiple crash
>>>> @@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>>>    	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
>>>>    	if (ret)
>>>> -		goto out_unlock;
>>>> +		goto out;
>>>>    	if (flags & KEXEC_PRESERVE_CONTEXT)
>>>>    		image->preserve_context = 1;
>>>> -- 
>>>> 2.20.1
>>>>
>



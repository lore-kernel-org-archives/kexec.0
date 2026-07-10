Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301EDC44501
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 08:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmZvZ43u+oXaLFxfFTok3OdwfaEUc3Aj5Jdw1XOk+94=; b=4Ll1EaYI8cBRQAVsdYOvczOUOa
	t8RcMP2TFEG7Rgmf9DwNpQC5GbIL5q/8545USo9wx4dA1GQgbxZQjgjDJSSo1+GSA8CFaU3XvdcV6
	pYPVXdU3ZUK0sTVjNiuIgIESQ63Do45Y+f7yTReTnj6iEL1rqEXMZSihzFlILbse2XA/kW7uLWAij
	0CRh2hptt5Hb5XBykobS4tL1xOlRG5Jpp/gvTNOhtWl01x/DkArtQ52uqVsmxluFxaPh690YHlV5B
	4jCCgXPw+1V9qD7ICotLT6hRo4rhgF3R5op5/I32wOcBs9jAyXH+E+/wFQseO3gONImgPcETMSJLQ
	BKvH3D1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi69W-00000004P5P-3mGy;
	Fri, 10 Jul 2026 08:00:06 +0000
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi69U-00000004P3X-175r
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 08:00:05 +0000
Received: by mail-yx1-xb12d.google.com with SMTP id 956f58d0204a3-664ce3000e6so621084d50.0
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783670403; x=1784275203; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mmZvZ43u+oXaLFxfFTok3OdwfaEUc3Aj5Jdw1XOk+94=;
        b=ez2RcR3mVCHbc2/4+LAtyWwyJv8edpLmRWIoEcPzLdJ+i9AkPMwt//Lz92ZYsbjttU
         8IXbN0JEKL/2mpUXqbITj7AA8QK6HtKwKr+u9ZgYC3q1p9URFLTipoRLkmUjxW/PQJCa
         4FVWkSDMSY7EVaJT3xLq8k3XKNinipumDe+NvWmHQdq/hd295p9Q+u8LlxgYE+KARPVL
         WEUjgAWx5sWJ1ak/w/PwL6OYvzAXGWV9uVKbNKJzpq5DKK8a4S15gTj0X1rHAWHw9MVH
         Ip5fJ9riWO5laG4Z4b9zkh5pKqkdYerMJt1Pm4l4Ssk6S2h2Lt3EbR4/HUP7OP8sCp8B
         c6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670403; x=1784275203;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mmZvZ43u+oXaLFxfFTok3OdwfaEUc3Aj5Jdw1XOk+94=;
        b=ijgauYuQpJrjTE6KwHryCeW3yCbg0WCLITgWFgZwJ2tpAQSoItRI2FzorKfPFJxtuk
         cHZK59p6VtfiC8rCAn5S5ZFrcmlHRJwtH3/VZ4gcINzN+FkaRIhI4UoyOoGoTVMjwaA4
         4Gl8hnzZ6lOXgG5PbQO623xQg/D2PaQYo/v/LWMP1Nh+uDDuI3IqsnCv7zOq5l5ow14c
         qcaAvGC9tIldlrJfvwiLjBI1Nc9djgkv/QydmfHZA7g3FPBEpBsVMPauG9sdKsGdROYH
         FJCRDx/Im8hvV1wJjmY5MmedlJjYh7Zusg14Off8MWRXsbrFW51jOGNOL0ORXdDsTkhj
         FT9g==
X-Gm-Message-State: AOJu0YwV+L/jeZCA3/i6zOiYmjCR3amPn9yZoReR6DN+k0TOuOcziCTX
	wVkKeEKGXQsUBb1ieBXnSlTy/dvxQw66rSiyofNFbVXK3uIrE/bUiMo4
X-Gm-Gg: AfdE7clCek+U6cSBZZ6LCnk3gsuH4h+Jbpbbt3Fj0BzPqMQGLd3jmILC6VrBMkCL/D3
	dTMndr6mjMGZNPe9CJuIYCnC7oOUOFJfGrvs+nvVk0WEe0wqrls2OC3OJZ/+SpCdJ23bMtvvHhi
	5qCuCaAq4rnwvrQyNoVmC6LQiiyRivbx6twYIwUxxZLV+UQvfrXB5tlopdldlmP+gOXY51l4khA
	13mmkY9PE5lwxJOngXFhRFSwVnZZZE/Lvmdjkkq/TEo0L47WOTFlh7QPDvMItoLOoKd3BO0CTXG
	54RjRXKndVZToZCryjAoh1G/m8ipgfJoeqfJHfcC7jcK3G3U7oXZxT4zIzht0vDfJFIdmxynBFf
	tts+9oST+imU4AY6VK/UbN4Nejw5IsXZi2y+rZeL4yN2Hjpbd98zX/0SGiJEJL5r7W/cXlA7l4p
	sIhyDi3l/NN0SaSRUNmUnNT4jaq2XUtBo=
X-Received: by 2002:a53:ac94:0:b0:667:789e:5564 with SMTP id 956f58d0204a3-6679f1a48a0mr7395401d50.73.1783670403027;
        Fri, 10 Jul 2026 01:00:03 -0700 (PDT)
Received: from localhost (tpcc3a204.netvigator.com. [219.76.18.204])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c201dc7sm39007147b3.41.2026.07.10.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:00:02 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 10 Jul 2026 15:59:19 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/9] crash_dump: Read the number of dm-crypt keys from
 reserved memory
Message-ID: <alCmK9nvZp11aHET@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-5-coiby.xu@gmail.com>
 <0e2328f1-a057-45d5-8889-c5c333826b45@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0e2328f1-a057-45d5-8889-c5c333826b45@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_010004_309973_5BD3CAA9 
X-CRM114-Status: GOOD (  11.25  )
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

On Wed, May 06, 2026 at 07:48:00PM +0530, Sourabh Jain wrote:
>
>
>On 02/05/26 05:13, Coiby Xu wrote:
>>In case user adds/deletes the keys by mistake, it's safer to read the
>>number of keys from reserved memory.
>>
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Reported-and-Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 36 +++++++++++++++++++++++-------------
>>  1 file changed, 23 insertions(+), 13 deletions(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 6377ee86ec50..a3e460714d23 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -88,21 +88,31 @@ static int get_keys_from_kdump_reserved_memory(void)
>>  {
>>  	struct keys_header *keys_header_loaded;
>>  	size_t keys_header_size;
>>-
>>-	keys_header_size = get_keys_header_size(key_count);
>>-	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>>-	if (!keys_header)
>>-		return -ENOMEM;
>>+	int r = 0;
>>  	arch_kexec_unprotect_crashkres();
>>  	keys_header_loaded = kmap_local_page(pfn_to_page(
>>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>>+	if (keys_header_loaded->total_keys <= 0 ||
>>+	    keys_header_loaded->total_keys > KEY_NUM_MAX) {
>>+		pr_warn("keys_header saved to reserved memory may be corrupt\n");
>>+		r = -EINVAL;
>>+		goto kunmap;
>>+	}
>
>Yes it is good to do a sanity check before using it.
>
>- Sourabh Jain

Thanks! Yeah, better safe than sorry!

-- 
Best regards,
Coiby


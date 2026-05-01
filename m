Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19518CCFA13
	for <kexec@archiver.kernel.org>; Sat,  2 May 2026 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZbQqiA/fecMgvSQZW2ffEuq3Qf9g5f25sCTnXGKHio=; b=ISb9VFLU7TqtdenVshsHpzw0Vu
	OdmTuCE21gzHLWzOlGXwGFcxQk520K//69hVaDsTOxLDAtTmJPUnWmRaVJp4lNJqPY8EXllFhpe9C
	sW5NlmrI1xMvekxusZM3EHFzugwQ14LOVL++1eTJ5rXQVVIbQ8cLN4D4/MFHx8ITZTfmcNJHuCftH
	hNxkbUY07NYO1jlWMWDJEgTNqQ8HB+CaJntBfR4Ij7yQXSeakys+Kp74qok0rcmIPECNjRHrfe0IX
	iThg6knt/7eOed2Ux0tC8ufmv4WOzpfl7MbCCXV6DnhIHqlfPuh9vrhdcKvHAq+7SjSs8GBPCea3X
	RYDGVLsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxmD-00000007sDV-0iUa;
	Sat, 02 May 2026 00:00:09 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxmB-00000007sD5-1BVA
	for kexec@lists.infradead.org;
	Sat, 02 May 2026 00:00:08 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-82418b0178cso1253904b3a.1
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 17:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777680006; x=1778284806; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jZbQqiA/fecMgvSQZW2ffEuq3Qf9g5f25sCTnXGKHio=;
        b=XSajo4q4lnmqCg/JoNP1mOWN2psja1lcLhF76YgwhcRWrNdp77gLRU/AI1exBEDuz7
         AWhCXit86KCF6wQJWdnUSY+Zx5qA01LK20txtBTg9BwAflRORz5O9X1U/fFcbt2CWycP
         ZzOcyRJP3SA6cZOhryRnpKCGeHuS9RXk49qylHlq0gxrcUu9qQPITqI6rpSY4E2O4og9
         QMfgdvdheRwayntaZunhFNtVCEMAiV61hnlX1SziBs0/mXHVadpj0uETeXT99sFNP2PX
         GNPdkOJNwkzUZzlrOwGEZ/siLH5jwDvjsf2EsE67ZlreJ2l1sIvlB4tQgYF6KTnyd53c
         DWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777680006; x=1778284806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZbQqiA/fecMgvSQZW2ffEuq3Qf9g5f25sCTnXGKHio=;
        b=lTzXCXqlgNZpAcLnZKPVjvx5tivgWC8zgcU8gBgUaWfi4vGfPdgzmDiwaiEf2cnd+x
         LYmxrQdxy/PiukCJ6zW3UeS4WwujCy8gISOgIHJLEaKheLgkbHQfFpwXYeZlr87Yneva
         JDhsaok3gJD7KDUey3wuusSMQKNUrtRwks0LMmpSwEHQQa8p+IdQxYelywcHgdCiV095
         JYtBXa4PfKu/k5S/6nLZoboPVjUIvb1CbUmnN7EOC2SXwAXL/vgcKCcwmm2qOg22ZJ0o
         QRhvacMzKLFvk1aX0lgEo6EOwah/eX4vH1QbJ4t5vCVv0RjLj7pqnUu420iWiSZzDPhH
         uRPw==
X-Gm-Message-State: AOJu0YwC9gJSPGc38Ou0pyTgRkLQH4t0IOLlRauxxTQ1k7SGyDnDfd8w
	9gocwsm+5goaDcKItpCDc0/zuNLwc1ZfvebQBs4U05eA1kbCUIzCeIGn
X-Gm-Gg: AeBDieuL8iAILs2so/EBA+sMI0vaSGvewE/jHLDnRj3FcfFcXUNcClSFqpvgKfq18YH
	REGBPy/ETr1r3IYSP5zowBYVyBa8OptjfuteeTn4nuqXuzyBocJGqNrj5CKKFtKZsmKohMAr7Fx
	bP4BNjbAUMrgCBWLzJjeM9vv3n3pAdkpRfwGyPf4QVqU4zG3GjtHcpLJy3eHV6XhjbbeIMjeHoe
	Zu+xToz3JYVBkMVVKlKpdjyGXsLd0yv25H4OnKnSovZ7ZhYPf5ncmljH9OjA27MnZwFWzFopEJd
	L7BFBxBhRbbERcyRQLUfXogjFufodxVPwUXK99hDS8Y0s+rD/PVrYB2gMjhkbEbI6BMXo3vlV0i
	cZNJkQOscd2w4Ok3AgT2+qr17fScVldiPrhkCeBsBW7G8mtHzbwrmtsTg7n24Gy2fQrTc3uofcP
	6S9DWnQ3/TnCcNtcEmsuXNwIIRpTLrLw==
X-Received: by 2002:a05:6a00:1bc9:b0:82f:4386:7989 with SMTP id d2e1a72fcca58-8352d20264bmr1064459b3a.24.1777680005486;
        Fri, 01 May 2026 17:00:05 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351587db67sm3674725b3a.13.2026.05.01.17.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:00:04 -0700 (PDT)
Date: Sat, 2 May 2026 07:49:48 +0800
From: Coiby Xu <coiby.xu@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <afU7EcMFfM4PZZfy@Rk>
References: <20260403100126.1468200-1-coxu@redhat.com>
 <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
 <adRIwaLxqIoIDkTF@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adRIwaLxqIoIDkTF@Rk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_170007_327129_F676C733 
X-CRM114-Status: GOOD (  14.95  )
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

On Tue, Apr 07, 2026 at 08:44:39AM +0800, Coiby Xu wrote:
>On Fri, Apr 03, 2026 at 07:48:29PM +0530, Sourabh Jain wrote:
>>Hello Coiby,
>
>Hi Sourabh,
>
>>
>>On 03/04/26 15:31, Coiby Xu wrote:
>>>If kexec_add_buffer fails, keys_header will be freed. And depending on
>>>/sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>>following two problems if the kexec_file_load syscall is called again,
>>>  1. Double free of keys_header if reuse=false
>>>  2. UAF of keys_header if reuse=true
>>>
>>>Address these problems by setting keys_header to NULL after freeing
>>>kbuf.buffer and re-building keys_header when necessary respectively.
>>>
>>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>>Cc: stable@vger.kernel.org
>>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>>---
>>> kernel/crash_dump_dm_crypt.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>>index a20d4097744a..92eebef27156 100644
>>>--- a/kernel/crash_dump_dm_crypt.c
>>>+++ b/kernel/crash_dump_dm_crypt.c
>>>@@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>> 		return -ENOENT;
>>> 	}
>>>-	if (!is_dm_key_reused) {
>>>+	if (!is_dm_key_reused || !keys_header) {
>>> 		image->dm_crypt_keys_addr = 0;
>>> 		r = build_keys_header();
>>> 		if (r)
>>>@@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>> 	r = kexec_add_buffer(&kbuf);
>>> 	if (r) {
>>> 		kvfree((void *)kbuf.buffer);
>>>+		keys_header = NULL;
>>> 		return r;
>>> 	}
>>> 	image->dm_crypt_keys_addr = kbuf.mem;
>>>
>>>base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
>>
>>Sashiko raised seven concerns on this patch. Most of them are
>>not directly related to the changes introduced here, but I
>>think they can be addressed along with this fix.
>>
>>https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com
>
>Thanks for pointing me to the Sashiko's code review and also sharing
>your meticulous analysis!
>
>>
>>
[...]
>>
>>4. get_keys_from_kdump_reserved_memory() may run into issues
>>   if kexec_crash_image->dm_crypt_keys_addr is larger than a
>>   page size during memcpy. Because kmap_local_page only maps
>>   one page.
>>
>>How about moving this in a loop and do map and copy page by page?
>
>Yeah, looping over the pages should be a robust solution.

After failing to reproduce the predicted issue, I realized there is no
need for looping page by page because kexec_add_buffer will try to find
a continuous physical memory region. So I dropped this idea in v2. But
thanks for helping me learning something new:)

-- 
Best regards,
Coiby


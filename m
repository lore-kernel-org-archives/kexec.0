Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D35FB5173
	for <kexec@archiver.kernel.org>; Tue,  7 Apr 2026 00:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QAKgvtlNper5lCbakuqzfiLcu5MRQF/fn6jWM++Sjr8=; b=Ga2NXkTAJN4JYe4ANe25hggXsT
	c/xDJiqkC6ZX9wLMCFOo8hrpRTFFft1uTOQCP0Kf5b5mGIqSOzKx+pV22Myf6x3pZoq+TskUIC7/L
	E2tE2beQNEjUH/J58i/Sipo4Rqjb0Yd7aI0WVRKSnWRBc2TY/Dd9RxYENVyQJA1PfxnbGBoOCeom1
	RD++skIyTmVehNpjs1aHGbgV7gnEIiGhumwrvZywdhoPag2CLLlaDFVoRLRGi7lW9T1snBbG1UZ+d
	sQ3sNdcupASAp/AorEp/8QF/RLsBYwjyevdFmW43L8NV7TY0Zb534dJLdr2JyDKq5R6fYirHCza1y
	0XAuhFsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9uZ8-00000005fUf-41aa;
	Tue, 07 Apr 2026 00:45:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9uZ5-00000005fUD-2Y8u
	for kexec@lists.infradead.org;
	Tue, 07 Apr 2026 00:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775522708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAKgvtlNper5lCbakuqzfiLcu5MRQF/fn6jWM++Sjr8=;
	b=XfLR8zZPcde3X/dauCpruPDxPeX3gjmlQjuQV6VgJPIx1bIJGrXJYwJQUgesHBIjb4eq3p
	CfVp3RIWy5HWqN/tAaw5bb5OMNKZZlGmw7Fwlcir1XN2cEnUigQZIy2BcdYkUiFmVivZbI
	94oGkoU55wKky+VeuH1r8VCLyaulZd4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-ltgvAUkGONKaHsW2-6Vrew-1; Mon, 06 Apr 2026 20:45:06 -0400
X-MC-Unique: ltgvAUkGONKaHsW2-6Vrew-1
X-Mimecast-MFC-AGG-ID: ltgvAUkGONKaHsW2-6Vrew_1775522705
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35c0cbe0f64so10800395a91.0
        for <kexec@lists.infradead.org>; Mon, 06 Apr 2026 17:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775522705; x=1776127505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAKgvtlNper5lCbakuqzfiLcu5MRQF/fn6jWM++Sjr8=;
        b=gRLEVybDl4r2/v90wRllhB8s/qeMdR5om3DEkv+dZeJ4YYJGWuiG6d36PsZlFyJkM+
         5JLXh/XaxiIVT4LrlOQbHUrbmTQ+t2xuagQaETJgQaUgZzZDYKDI2/akZmjAaWmZDNo/
         Z8nNeGssI4lGXvQm3w4W9tB7/e1ijCrDSIv+K4ATh5FGihtrDYilbQ6mDQB/K8EAfgTB
         2wRGV5tvyN1bsVEYpbgNYHxbc7GHoS2gSmeXvx6VrHV1wZ6Y+guuCE3vRFx9w3VXk5dv
         CgMwPx+NslcBQFSCuo3JTa+2+uGqqn8g7+5UAWlV735M5UwvNs/Ydnt6k0yrTUFraoBW
         IH8w==
X-Gm-Message-State: AOJu0YxdUC7svcpnsw5EraiFOY7PN6cURcdkxLbtIVM22sxO3IXqbkka
	nQN8+gssMjRNbGOBPpgxUnkEVXtWyrDr0IBv7gTJeQQc2XoL4ot+DbeEmxJcbSStHoeYkzUxlxQ
	ZNsPN/9VRmJbEq9tCCwlPy/U+goZpsUNiRpGx05j8zl6KFkTA8AA7WtwEyFYwqQ==
X-Gm-Gg: AeBDietFB/URCFs1fPxFF5DKQOLEeoJl0g35GXgVu7LKsP9kxZqTVVL52z+DMQft74L
	h9ZiGer3KsT8HsSMTWBSjRHTfE/jDizeFjCk0TX6cZA9MFwquVjRinD4nsNHFPDmXEIM3/Dcwug
	3Vj4/UiOQJVhvt6vynB/12pe0u3E33E6pdLGBkeym8Eh4BFoIkcbkuwK8YFs8MygTSLIv2DU88/
	u6b2+JdW+CXgSp5DpB0ND859xPYNNpUcK7AIgGjfYy1gkBHf+8cKVg0wCUlJC6jQdK0MhTXpSBR
	fLY8PIndQTwxMUSPEsRa1T0kWwZRcSW4Cr3+HqOdyr1iTFN8CaGtXnNs6frYVATJaoY6JiFa+z0
	yESBmOzmmwVOD
X-Received: by 2002:a17:90a:d2ce:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-35de678fc27mr13201176a91.1.1775522704911;
        Mon, 06 Apr 2026 17:45:04 -0700 (PDT)
X-Received: by 2002:a17:90a:d2ce:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-35de678fc27mr13201139a91.1.1775522704261;
        Mon, 06 Apr 2026 17:45:04 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe623d94sm20615062a91.7.2026.04.06.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:45:03 -0700 (PDT)
Date: Tue, 7 Apr 2026 08:44:39 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <adRIwaLxqIoIDkTF@Rk>
References: <20260403100126.1468200-1-coxu@redhat.com>
 <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2hdvfAWW6CksLBrGHeWDy0H19NmzXZkzN6gr5O5oNZc_1775522705
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_174511_759518_5BB9DD83 
X-CRM114-Status: GOOD (  31.65  )
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

On Fri, Apr 03, 2026 at 07:48:29PM +0530, Sourabh Jain wrote:
>Hello Coiby,

Hi Sourabh,

>
>On 03/04/26 15:31, Coiby Xu wrote:
>>If kexec_add_buffer fails, keys_header will be freed. And depending on
>>/sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>following two problems if the kexec_file_load syscall is called again,
>>   1. Double free of keys_header if reuse=false
>>   2. UAF of keys_header if reuse=true
>>
>>Address these problems by setting keys_header to NULL after freeing
>>kbuf.buffer and re-building keys_header when necessary respectively.
>>
>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Cc: stable@vger.kernel.org
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index a20d4097744a..92eebef27156 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  		return -ENOENT;
>>  	}
>>-	if (!is_dm_key_reused) {
>>+	if (!is_dm_key_reused || !keys_header) {
>>  		image->dm_crypt_keys_addr = 0;
>>  		r = build_keys_header();
>>  		if (r)
>>@@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	r = kexec_add_buffer(&kbuf);
>>  	if (r) {
>>  		kvfree((void *)kbuf.buffer);
>>+		keys_header = NULL;
>>  		return r;
>>  	}
>>  	image->dm_crypt_keys_addr = kbuf.mem;
>>
>>base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
>
>Sashiko raised seven concerns on this patch. Most of them are
>not directly related to the changes introduced here, but I
>think they can be addressed along with this fix.
>
>https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com

Thanks for pointing me to the Sashiko's code review and also sharing
your meticulous analysis!

>
>
>1. build_keys_header() does not release key_header memory on
>   error. This can cause incorrect keys to be loaded for the
>   kdump kernel in subsequent system calls.
>
>Can be addressed by releasing keys_header on error path.

I'll address this issue! Thanks for the suggestion!

>
>2–3. get_keys_header_size() uses key_count to find the size of
>key_header buffer, which can lead to out-of-bounds access
>at two places.
>  a. Around kexec_add_buffer()
>  b. In build_keys_header()
>
>I think there is one more place where this applies is:
>  c. In get_keys_from_kdump_reserved_memory() at memcpy
>
>I agree with solution provided by Sashiko of using keys_header->total_keys
>instead.

Thanks for showing me where out-of-bounds accesses can happen! I'll do
some testing to see if using keys_header->total_keys is sufficient.

>
>4. get_keys_from_kdump_reserved_memory() may run into issues
>   if kexec_crash_image->dm_crypt_keys_addr is larger than a
>   page size during memcpy. Because kmap_local_page only maps
>   one page.
>
>How about moving this in a loop and do map and copy page by page?

Yeah, looping over the pages should be a robust solution.

>
>5. Related to releasing the keyring_ref reference count, but
>   I did not fully understand this concern.

My latest test already covers the case where there are two keys to
iterate over. I'll dig more into keyring_ref to see if Sashiko's
concerns is valid.

>
>6. restore_dm_crypt_keys_to_thread_keyring() does not release
>   previously allocated keys_header, leading to a memory leak.

Thanks for raising the concern! Although we can assume the system will
reboot soon after vmcore dumping is finished, it's better to free
keys_header.

>
>As per kdump.rst, restore was introduced to handle CPU and
>memory hotplug cases. Is it needed when there is no in-kernel
>update to the kdump image on CPU or memory hotplug events?
>
>But in that case, we rely on a udev rule to reload the kdump image
>again.
>
>I am confused about when exactly we need to restore.

To clarify, reuse other than restore is needed for non in-kernel update
when handing CPU/memory hotplugging. Yes, a udev rule is also needed in
this case.

For restore, it's to restore dm-crypt keys in kdump kernel. I'll see if
I can update the documentation to improve clarity.

>
>
>7. Possible memory leak and data races due to concurrent kexec loads.
>
>I think we can ignore this because both kexec system calls are protected
>by the same lock.

I agree, this concern can be dismissed.

>
>I also noticed that kdump.rst still says CONFIG_CRASH_DM_CRYPT is
>only supported on x86_64 for now. With the patch series below,
>this needs to change, right?
>https://lore.kernel.org/all/20260225060347.718905-1-coxu@redhat.com/

Yes, the documentation will need to updated. Thanks for the reminder!

>
>- Sourabh Jain
>
>
>
>

-- 
Best regards,
Coiby



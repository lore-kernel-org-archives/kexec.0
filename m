Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BF4C61DBE
	for <kexec@archiver.kernel.org>; Sat, 29 Aug 2026 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IxDEN5h3lEQH8b8SjBjggeIIHExzyIDlG18CyIBp748=; b=cZlUEtkcaADeaWm32J4RUtGeve
	e5cRX6VTBjWfDEB4N6d7PJeVEOohaLWo7kj2Pc2twnMQxiuVBqSphYvLXAZHvh3+l8mNktcjP0RgM
	VAJKBRxUqDWPnqa40ftpGjWM7OCzVLzJdiDebLkhbSiw+RHD2Yc7bpxh5cg9talmwsz4c8VZMWudv
	JCTG0oM4blHJXjWE/qELFb/e/8z5X8pR16HAm8uwOwZDlfruq0osCifa3/r5IHtZ/g1l85pmXf3GK
	9TXMhtklgdSUbkzIq3uK8x+bN3lWu2dpUqaRcqamGPDLGEFWMkcOIiXQid6IgsOsP9qQrgZBtIW2N
	i0hZ5E2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Hzj-00000006yeX-1Psi;
	Sat, 29 Aug 2026 12:17:11 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Hzh-00000006ye8-0B7J
	for kexec@lists.infradead.org;
	Sat, 29 Aug 2026 12:17:10 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-cc1c7364550so1997452a12.1
        for <kexec@lists.infradead.org>; Sat, 29 Aug 2026 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788005828; x=1788610628; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxDEN5h3lEQH8b8SjBjggeIIHExzyIDlG18CyIBp748=;
        b=kp3CXM1SOzAl62MC2GYHUb4Gj089SSEIFHOwwtlA+IdRUdtLSiI5P1ji1SZxbY1CBt
         1shJ3YpGCHAvbo7C11ueIbpS+BUnwWQV7Z1wtbf0NKJvgYZ72VUT24g92urzl3VVCWrJ
         7pKf7vtpW4NSL8fOIhKF/+xOygWAUo1WLdsUukAs8NtTS9bvUNHcL9KqI8/BxaUTIZtd
         z/r5liwGr3WjYba6SW0UjJih4T59oe759hRp9WVdVXVHMe7C4AogBHjnUXCvCGc0+yZe
         I6Df/432lFHwI48JB2wFQPCdby1zHZggqhIIpLJa2AD+C5smTm+QJERo9cnx7Zyvuf24
         6tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788005828; x=1788610628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IxDEN5h3lEQH8b8SjBjggeIIHExzyIDlG18CyIBp748=;
        b=cVWD2XWydbnwXv5NqrO3llGd+LeCIez4juBDumvGOf2gHlzusgZ0GL1++b6gufp+rY
         ngnhf7HDlkPwK1WAe8zuPeLMkAQPrUgP/T0qxLozD4fj87IU1BRgGlvM5rkbHyXEj2HH
         tBqA+val9vZhIumq3CY5Fw8xO8zBtDwHjGysN/OshpDPmrnKZcadwgDYlmEOctos3kfZ
         4gHvdqwlWhqohDACU5ZUiTynk+OdahokaCavnxSgCCjxwQYvuwkhzIvo4qdCnnRE6U66
         a7f4bMsX6pAbuRzObpdZHtve1Sfhr6Mb74zWKdtFy0Jo5vL24Jvk7YGAiGkYtyS70H5v
         baSg==
X-Gm-Message-State: AFuF++nNxYtLzDLt4YxMC/X40HPQve/7972bDYe8yHyDh/0EK8SinRLK
	j6a+G9xopvPob1jeNLLBr6J4cXG2ppGtfZlntgiP3y7TOx599YbPRW0p
X-Gm-Gg: AYBFou3yRTAepc3kAoDnb4cFCempWrrPYWGTikuzn29teuc+wMlTjwDlQZYryjOFHsx
	TvKDE2Y5ODS6Ll9NpR2Mx8jR8/ZrNPdOPYELuqfOiXSxKCx9mvX9K1izqhw8Pt3guoHfv6esySM
	8HDaf6Zrvj6h/Xqx33xV7wKR0D7SpL57KrNV3wSK8hyJVranPylTJhX728lEwTWPVcWLaNBxgbk
	emdp2oXCAOS5itB7LLCUM8OM028HdHj+/fZPCwL7IYpxo4fT36Hx0iUUCfO9Pi2TFIe36dhVcZH
	ZNkn3qrWkY6nCR2NZ5MRrljTZfqAWgJLDSamefw6NVHd6SnI4ei2HghzfGUKmGgzXUs+zEJYeiC
	Q41AR5jXf87FviNk32AQnRBeZaV0w/O0bYQbuRhb+ha08gfO32mH0LXmeqDHUNz2Ivin6guWuf1
	kYIv1OuTeWaFpkbSJopPs1YAoaZHB0dCs4IWHuPx+HEiwgrpn3qclN0IhwAj/C6E/a
X-Received: by 2002:a17:90b:56c7:b0:398:9bd4:d18 with SMTP id 98e67ed59e1d1-3989bd41466mr9165110a91.23.1788005827437;
        Sat, 29 Aug 2026 05:17:07 -0700 (PDT)
Received: from localhost ([45.112.44.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-398b18b4074sm2555834a91.12.2026.08.29.05.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 05:17:06 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Sat, 29 Aug 2026 20:17:00 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
Message-ID: <apLKk_P9wHc9uSZQ@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-3-coiby.xu@gmail.com>
 <86f3b10d-6fc2-4dbc-a20b-5d2365601be2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86f3b10d-6fc2-4dbc-a20b-5d2365601be2@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260829_051709_089973_0BB45DE6 
X-CRM114-Status: GOOD (  18.56  )
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

On Sat, Aug 29, 2026 at 12:32:46PM +0530, Sourabh Jain wrote:
>
>
>On 28/08/26 14:18, Coiby Xu wrote:
>>If writing to the configfs group happens concurrently during
>>kexec_file_load syscall, it may lead to the following issues,
>>   - buffer overflow if dm-crypt keys are added after allocation
>>   - stale total_keys if dm-crypt keys are removed during iteration
>>   - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>     set true
>>
>>So hold config_keys_subsys.su_mutex for the entire sequence during the
>>kexec_file_load syscall to ensure a consistent snapshot. To have serial
>>access to config/crash_dm_crypt_key/reuse, use the kexec lock as we also
>>need to access kexec_crash_image serially.
>>
>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 28 ++++++++++++++++++++++++----
>>  1 file changed, 24 insertions(+), 4 deletions(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 4335b6cb1fc4..026c7de4ad85 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -7,6 +7,7 @@
>>  #include <linux/configfs.h>
>>  #include <linux/module.h>
>>  #include <linux/sysfs.h>
>>+#include "kexec_internal.h"
>>  #define KEY_NUM_MAX 128	/* maximum dm crypt keys */
>>  #define KEY_SIZE_MAX 256	/* maximum dm crypt key size */
>>@@ -296,14 +297,20 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>>  	bool val;
>>  	int r;
>>+	if (!kexec_trylock()) {
>>+		r = -EBUSY;
>>+		goto unlock;
>
>
>Are we unlocking a lock that we didn't acquire? How about returning 
>-EBUSY directly instead?

Ah, thanks for catching my mistake! And also thanks for prioritizing
reviewing my patch!

>
>
>>+	}
>>+
>>+	r = -EINVAL;
>>  	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>>  		kexec_dprintk(
>>  			"dm-crypt keys haven't be saved to crash-reserved memory\n");
>>-		return -EINVAL;
>>+		goto unlock;
>>  	}
>>  	if (kstrtobool(page, &val) || !val)
>>-		return -EINVAL;
>>+		goto unlock;
>>  	if (is_dm_key_reused) {
>>  		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
>>@@ -311,12 +318,15 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>>  		r = get_keys_from_kdump_reserved_memory();
>>  		if (r) {
>>  			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
>>-			return r;
>>+			goto unlock;
>>  		}
>>  		is_dm_key_reused = true;
>[...]
>>  	}
>>-	return count;
>>+	r = count;
>>+unlock:
>>+	kexec_unlock();
>>+	return r;
>>  }
>>  CONFIGFS_ATTR(config_keys_, reuse);
>>@@ -421,6 +431,8 @@ static int build_keys_header(void)
>>  	return 0;
>>  }
>>+static bool mutex_acquired;
>>+
>>  int crash_load_dm_crypt_keys(struct kimage *image)
>>  {
>>  	struct kexec_buf kbuf = {
>>@@ -432,6 +444,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	};
>>  	int r = 0;
>>+	mutex_lock(&config_keys_subsys.su_mutex);
>>+	mutex_acquired = true;
>>+
>>  	if (key_count <= 0) {
>>  		kexec_dprintk("No dm-crypt keys\n");
>>  		return 0;
>>@@ -481,6 +496,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>
>I explored the kexec_file_load syscall entry path and noticed
>that there is a path where the call to
>kimage_file_post_load_cleanup() can be skipped.
>
>For example, if kexec_file_load is called and everything goes well
>but kexec_post_load() fails, we skip
>kimage_file_post_load_cleanup(), and consequently
>kexec_file_post_load_cleanup_dm_crypt() as well.
>
>If that happens, the config_keys_subsys.su_mutex remains locked,
>which could cause problems with the next kexec load, right?

Thanks for exploring the kexec_file_load syscall entry path! I took a
further look at it. Even though kimage_file_post_load_cleanup can be
skipped, kimage_free will be called regardless which will in turn call
kimage_file_post_load_cleanup. 

     // kernel/kexec_core.c
     void kimage_free(struct kimage *image)
     {
     	/*
     	 * Free up any temporary buffers allocated. This might hit if
     	 * error occurred much later after buffer allocation.
     	 */
     	if (image->file_mode)
     		kimage_file_post_load_cleanup(image);
     }

But I realize by using kexec lock to ensure serial access to
is_dm_key_reused, we can actually release the mutex lock at the end of
crash_load_dm_crypt_keys function which can make the code simpler and
potentially more robust. Thanks for inspiring me to find a better
way!

>
>- Sourabh Jain
>
>>  		kfree_sensitive(keys_header);
>>  		keys_header = NULL;
>>  	}
>>+
>>+	if (mutex_acquired) {
>>+		mutex_unlock(&config_keys_subsys.su_mutex);
>>+		mutex_acquired = false;
>>+	}
>>  }
>>  static int __init configfs_dmcrypt_keys_init(void)
>

-- 
Best regards,
Coiby


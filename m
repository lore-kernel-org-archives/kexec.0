Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2968C624CE
	for <kexec@archiver.kernel.org>; Mon, 31 Aug 2026 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zG2Wsg/BzhPMjOE3JgOxdh5m31QBgm88y6qID8vV1kI=; b=pxEhHnZ8En3gB0I3vMFDlI8pTP
	XkUc4pUQKJmDZzjksE+QQW1B+jS7fxEIZyu7ZtKSWIzKBYgAsW/h5fSu2++gbkF5oti5VAufOlwZk
	Hmtbm5/qSyUS8+izaKA4qQVM/yZab7gD4ME/fLTzVe4P8itlB94GQmW6/FqLd6aS3ZxqPA9r05EYo
	P4NdXXsJyhtMdYRHHSYYb/NAoxbyE8ytV4ryC0/c7TbrdB2xZ2I9r70AT06MYlez1O38TIMmAJOBs
	8tbJN2yJYxK+s7d16BTVG04rlEQRjlxWT/yNWjDylaS1OcRSQ7hf0W1GEtKeKgDiMSCEMNE2dW7RZ
	qdB7arzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12AI-00000009Qub-2CWh;
	Mon, 31 Aug 2026 13:35:10 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x12AF-00000009QrZ-18Nd
	for kexec@lists.infradead.org;
	Mon, 31 Aug 2026 13:35:09 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-853c947bfefso2794756b3a.0
        for <kexec@lists.infradead.org>; Mon, 31 Aug 2026 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788183305; x=1788788105; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zG2Wsg/BzhPMjOE3JgOxdh5m31QBgm88y6qID8vV1kI=;
        b=Qy0UXMRDaRVrsnmDqI5lwhmUBjh3QYYPViZR2MWGQxov0g0QapWuObAGGowRNuAiUw
         tp/HyiiprcmErzvzj7Ysy72NXb1xwBQDRhqkHTgeOGbmJPfrzoMrsX2X270KLmAvAJXb
         zPjuk5eIkxX+69QfoobJ6FW4vP73EnZ9crbCYQNnfbz2kh53Cqcz6yOWciloGQpmroAq
         gr/jylsV7lKb6iRNzrMzpOgHcwqYj631Vki7RSzQGam0ys+wz862Xqa5vhQlH9srVVC0
         66k6HPwkz6w5UxJpUQlzVkVQfeS9AeCGLU0BgpWns2WqLQA8QPMKzwho7L+5x8SdkyFc
         2QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788183305; x=1788788105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zG2Wsg/BzhPMjOE3JgOxdh5m31QBgm88y6qID8vV1kI=;
        b=AAsyvKzYbDW8/27axNBEdgXEpVCd0hV9K3vG7UjR+yjK1X7SwLBVc+9PQRBgUNUysQ
         E5MozH6qharEHAH9KV6vswKStGOreb7ztkuxjJf14fNl7XAAUMUH3EOnCv4sWk8G7yuY
         u9oGTmSi0JIk5l/w0uuOhR2QitlizNv61SysYBhx/3N/m+zsUgOyXDU6tzWpGA43qj/B
         CAKNoAg68htu74BYjXxZqH2KK85lyifOuR+gbK6tHTa2VZQpMf4vbz14ZnYeCPYsKUWI
         IYhoJpd9gbIKRlPNA+Z5r5C97pwfrrLAT5L6Rd37cLKJ/Fl5k7LiYw+gbHjxVuURk2Qc
         DRiA==
X-Gm-Message-State: AFuF++lQ9opk8Vxu/QfW5/ltS5sO2Fs7XAE0t05tc4su0+uG2VhUYAgC
	ohJLtS2LK9F3B5SZG0mNFhWbWESXlWngTa0RANg7ZofMrYclnc02qcoR
X-Gm-Gg: AR+sD13X/ri9mRvwTkjP/kFa4qkXx/z4iksXrlGSO6KW8kJwFOdzQfdXqtR9UrmhXGw
	cx8QwrBKvZ/6gfgTUSJmbdh+YF9Qs/QsiYZy5vPGwmi8q+MvLqqp77RByHokEXzfN6Pi+fZbC33
	bUBWIDpQKgNTXfmsc8OuPDcfJM0x3q0+j1Z+ltz7/2crtT4TfWdc9oVpIm1z+P3+6HUQhW/qnX6
	H8gaKh+9YsmKk+1qKgxPqRDF5k4Tv7cCLxmWaVUH+H82uLh6vYaXseXVtA8MZyBVYqKHun7OKch
	Gkx0DF1+X3WrxaPNDWYNFzRQKpY0pENbClWViS/grV6WQuTY/AUDBZbRSTLnTP1cbZCLTvlvQyG
	koOtjYg/eoimTvIl9IyJCGd0Fd2y8NY2Rm4XLpYnUA/QJLAAugS9NY2OPiwFX5RST2OCooXKwaf
	Nrz1MFREE09ad95N0GRM54gBWYqbaxfWaIoa+cGpDHaOgxrOC/Bng30g==
X-Received: by 2002:a05:6a00:1390:b0:857:72f8:dca3 with SMTP id d2e1a72fcca58-859972b7fddmr6498579b3a.9.1788183305220;
        Mon, 31 Aug 2026 06:35:05 -0700 (PDT)
Received: from localhost ([45.112.44.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8569f49f50bsm3843564b3a.11.2026.08.31.06.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 06:35:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 31 Aug 2026 21:34:30 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 8/9] crash_dump: Disallow
 configfs/crash_dm_crypt_key/reuse if crash hotplug supported
Message-ID: <apWAp7FamnxneZ3v@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-9-coiby.xu@gmail.com>
 <38e371e9-1f0a-4e9f-a5e1-0b9d696379da@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <38e371e9-1f0a-4e9f-a5e1-0b9d696379da@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_063507_433500_2B7EF248 
X-CRM114-Status: GOOD (  21.58  )
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

On Sun, Aug 30, 2026 at 01:28:59PM +0530, Sourabh Jain wrote:
>
>
>On 28/08/26 14:18, Coiby Xu wrote:
>>If crash hotplug is supported, dm-crypt keys saved to reserved memory
>>will be taken care of automatically. Thus it doesn't make sense to use
>>configfs/crash_dm_crypt_key/reuse. Not reserving
>>image->dm_crypt_keys_addr makes it implicitly to disallow using this
>>API. Currently x86_64 and ppc64le have implemented crash hotplug
>>feature.
>>
>>Also update the doc accordingly. Note two doc issues are fixed as well.
>>
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  Documentation/admin-guide/kdump/kdump.rst | 16 ++++++++++------
>>  kernel/crash_dump_dm_crypt.c              | 13 +++++++++----
>>  2 files changed, 19 insertions(+), 10 deletions(-)
>>
>>diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>>index 7587caadbae1..0bf2eb100a05 100644
>>--- a/Documentation/admin-guide/kdump/kdump.rst
>>+++ b/Documentation/admin-guide/kdump/kdump.rst
>>@@ -577,9 +577,10 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>>  1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
>>      # Add key #1
>>-    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
>>+    VOL1_UUID=7d26b7b4-e342-4d2d-b660-7426b0996720
>>+    mkdir /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID
>>      # Add key #1's description
>>-    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
>>+    echo cryptsetup:$VOL1_UUID > /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID/description
>>      # how many keys do we have now?
>>      cat /sys/kernel/config/crash_dm_crypt_keys/count
>>@@ -591,15 +592,18 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>>      cat /sys/kernel/config/crash_dm_crypt_keys/count
>>      2
>>-    # To support CPU/memory hot-plugging, reuse keys already saved to reserved
>>-    # memory
>>-    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
>>-
>>  2. Load the dump-capture kernel
>>  3. After the dump-capture kerne get booted, restore the keys to user keyring
>>     echo yes > /sys/kernel/crash_dm_crypt_keys/restore
>>+For CPU/memory hot-plugging, you can reuse keys already saved to reserved
>>+memory before reloading the kdump image,
>>+    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>+
>>+Note if crash hotplug is supported, this API is totally unnecessary thus will
>>+be disabled automatically.
>>+
>>  Contact
>>  =======
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index b7629174e4db..3aaa0f9c3117 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -324,7 +324,7 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>>  	r = -EINVAL;
>>  	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>>-		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory\n");
>>+		pr_debug("dm-crypt keys haven't be saved to crash-reserved memory or crash hotplug supported\n");
>
>Nit: the above line is more than 100 characters. There is no
>complaint from checkpatch, but I feel we should reduce it to
>below 100 characters.

Thanks for the reminder! Documentation/process/coding-style.rst
explicitly states,
     However, never break user-visible strings such as printk messages because
     that breaks the ability to grep for them.

In fact, scripts/checkpatch.pl will issue a SPLIT_STRING warning if we
break the user-visible strings. So I think this is accepted unless
kexec/kdump subsystem has a hard column limit.

>
>Also, I checked that we don't have pr_fmt defined for this file,
>but we do have pr_debug and other pr_* calls. See if defining
>pr_fmt helps reduce the character count in the above line.

If I'm not mistaken, pr_fmt only adds a prefix. So I don't think it will
help reduce the character count in this particular case.

>
>But the overall idea of handling crash hotplug support with
>crash dm-crypt looks good to me. So feel free to add:
>
>Reviewed-by: Sourabh Jain sourabhjain@linux.ibm.com

Thanks for reviewing and ack'ing the patch!

>
>Thanks,
>Sourabh Jain
>
>
>>  		goto unlock;
>>  	}
>>@@ -519,9 +519,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>  {
>>  	/*
>>-	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
>>-	 * keys_header from being cleaned up during unloading when
>>-	 * is_dm_key_reused=true
>>+	 * For CPU/memory hot-plugging without CONFIG_CRASH_HOTPLUG, the whole kdump
>>+	 * image will be reloaded. Prevent keys_header from being cleaned up during
>>+	 * unloading when is_dm_key_reused=true
>>  	 */
>>  	if (!is_dm_key_reused) {
>>  		kfree_sensitive(keys_header);
>>@@ -532,6 +532,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>  		mutex_unlock(&config_keys_subsys.su_mutex);
>>  		mutex_acquired = false;
>>  	}
>>+
>>+#ifdef CONFIG_CRASH_HOTPLUG
>>+	if (image->hotplug_support)
>>+		image->dm_crypt_keys_addr = 0;
>>+#endif
>>  }
>>  static int __init configfs_dmcrypt_keys_init(void)
>

-- 
Best regards,
Coiby


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDDC5DF87
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nYw354gvkQJ8jmQ1k/6yhNWm33Mvtpn0ssaQx3WcD2A=; b=gHoRomdYDswJ3B+PttSanHLnrF
	rw/yT1xWORboUkFXCjddN6SKgBQkSJsa64DU8zKxgmNeKi70Io0uQ21qmD2YwRocny8v5NVE0uoLP
	obq1xVq/RxRu27TmU6WOpbmSCwfTqQX9KzLoiulJ8UvOh2E5B6y3gHv5owY54wX1rhTaHmCtw9D9e
	pPyTJPsLbDf6FcF8aeuW6eSzAB1CugssrrVuY0yJ9IppQ5QJmzPNA0LQNLuxMj/G4mUQNRNS+GKK6
	nciX6dggXd0PQ0ki+JxGsjKMNbxvJKBSQrqyXoOQadwDHb3IrZDfzQQ5b2snqUW/s+pfjNQn8HoKI
	D/F6qZgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwdHQ-00000009USZ-2hMd;
	Wed, 19 Aug 2026 10:12:20 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwdHM-00000009UPx-3ov3
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 10:12:18 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso837532a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Aug 2026 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134336; x=1787739136; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYw354gvkQJ8jmQ1k/6yhNWm33Mvtpn0ssaQx3WcD2A=;
        b=tIsg5lRIw4+M1te8p5hjjzr5pP/vl7heTsAswKe0QNdWBMVOS3Ji+OcjilK10mDwya
         KW43jz5vIYbAW8xJjowKWNnZdYu/Wej7twX8u+xredMgEln+O90qiXzAtKC2/lGMMLUN
         XxFx1qYu7fogWlgiY4Dvqvk6nyRSOwKsd6xullZYj5H0RpOfi56FgNGo/nAaDdeG2B/M
         Yemh+k+xochu5V6AF9a/GY4XN2BgPpBCNJqNjBx6VSPLwTRuuFxO5H7xz0YLAa78vM8n
         SnIkBNUV4DYYXOP69zQJVRdQb9oIhof4ycDUe3UQGk2nLHxweNtCb87FMY1CVnZwOsIA
         UGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134336; x=1787739136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nYw354gvkQJ8jmQ1k/6yhNWm33Mvtpn0ssaQx3WcD2A=;
        b=GxJ9biCxJMIvqdabGyWdtkaUvdmsQZmoE3uns9/tPa8ie3I7E2Nn698vzmSrRTW4ph
         dliQu0dxZKrB6RV427Q8xGiKabFJnPtdY/zU+TxDAFvSA7yy+RHGDVooXdaQgKietTFL
         +d2ODI0nylNEKlvd+gM3gQu/4eJVw4AYC/LpNPZhHQEe4ritDd1t7JTo7v9JLf6+SGPE
         SdBupPQCAi/eASDnwES7ckdZo6+hcdyeVEDtSGwSOarslGOdqpwJR2cq654VkqjHRnmW
         FUE2+l0Ih+jZAMZSoG7ZN2pJTjtgOD5yyWUfH7ALlaYKsx82LI7O2wtqtIebo0035+Cs
         c+hw==
X-Gm-Message-State: AFuF++kk0Mywb4w5eS+fQCYht08T5OKlX6sifuyD+vqMQsqowKHZWrsB
	J42xo7VmmAxswfgWmdKMNyJJH+aJGvYekSkeosqb7weNEMSjy/Fg/Jqh
X-Gm-Gg: AR+sD107j4gL48tNIgHPUu1S0lT+rXjJp6dI8KmK45fuw1Pj5fCIV6402QTb75NKxLA
	e4YT7Ksc2UCIXBFQMks0Exxqy6WKd9S5pRsty1Bq3rhMAv1hmKVkx4DRVm+anw+hLvVqTC1lWjj
	2n0Nas4bVfs4eyswNJ7EurZsR8hyqAAOHZs2QpuoBxnjZ78ml0Q9ySFe6us5Id96bj26OOHx63L
	UNEdcL5acUCgDofaSxWu852nr6nzYuVR4y2LpZ+BrvtkwjyJIrOLDmzkL/lc6EKVYIGMkbbtMr+
	iWpBNWQP6od+s4R7fD9VYNfVzD6i8GRRycLL1f4pXgrOw6IdiszRPzCVnVoYZZSolbrf4TmHCIs
	zewjkbX2DEloxNa8QISRacHrEHF5PPhgWcxl46YOzpU37Wf/uArn5A9LX1X00Xwv4w6LNtteUJM
	FqQAhwTnE4gkr8kc5V5XM7WYo3ziFUKuHRI5X/jm0NHZMDL+JTJ1tc3F72tSMJ
X-Received: by 2002:a17:90b:5630:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-3957f68f7bdmr869671a91.0.1787134335601;
        Wed, 19 Aug 2026 03:12:15 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:3ae5:75e6:e4f4:4401:4289])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96ca41sm2089556a91.4.2026.08.19.03.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:12:15 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 19 Aug 2026 18:09:52 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Coiby Xu <coxu@redhat.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] crash_dump: Disallow
 configfs/crash_dm_crypt_key/reuse if crash hotplug supported
Message-ID: <aoV8HkBNGRclxMPl@Rk>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-10-coiby.xu@gmail.com>
 <96a78b35-94f7-4b63-97d3-d0841681e2b4@linux.ibm.com>
 <anQb8aIXKXYzKqAR@Rk>
 <8d857834-e014-44d9-a112-d7fc8482d7c3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d857834-e014-44d9-a112-d7fc8482d7c3@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_031217_733729_197384CE 
X-CRM114-Status: GOOD (  18.94  )
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

On Sun, Aug 09, 2026 at 05:36:50PM +0530, Sourabh Jain wrote:
>
>
>On 06/08/26 11:03, Coiby Xu wrote:
>>On Wed, Aug 05, 2026 at 05:39:28PM +0530, Sourabh Jain wrote:
>>>
>>>
>>>On 29/07/26 09:06, Coiby Xu wrote:
>>>>If crash hotplug is supported, dm-crypt keys saved to reserved memory
>>>>will be taken care of automatically. Thus it doesn't make sense to use
>>>>configfs/crash_dm_crypt_key/reuse. Reserving image->dm_crypt_keys_addr
>>>>is also unnecessary. Currently x86_64 and ppc64le have implemented
>>>>crash hotplug feature.
>>>>
>>>>Also update the doc accordingly. Note two doc issues are fixed as well.
>>>>
>>>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for 
>>>>CPU/memory hot-plugging")
>>>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>>>---
>>>> Documentation/admin-guide/kdump/kdump.rst | 16 ++++++++++------
>>>> kernel/crash_dump_dm_crypt.c              | 23 ++++++++++++++++++++---
>>>> 2 files changed, 30 insertions(+), 9 deletions(-)
>>>>
>>>>diff --git a/Documentation/admin-guide/kdump/kdump.rst 
>>>>b/Documentation/admin-guide/kdump/kdump.rst
>>>>index 7587caadbae1..0bf2eb100a05 100644
>>>>--- a/Documentation/admin-guide/kdump/kdump.rst
>>>>+++ b/Documentation/admin-guide/kdump/kdump.rst
>>>>@@ -577,9 +577,10 @@ with /sys/kernel/config/crash_dm_crypt_keys 
>>>>for setup,
>>>> 1. Tell the first kernel what logon keys are needed to unlock 
>>>>the disk volumes,
>>>>     # Add key #1
>>>>-    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
>>>>+    VOL1_UUID=7d26b7b4-e342-4d2d-b660-7426b0996720
>>>>+    mkdir /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID
>>>>     # Add key #1's description
>>>>-    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > 
>>>>/sys/kernel/config/crash_dm_crypt_keys/description
>>>>+    echo cryptsetup:$VOL1_UUID > 
>>>>/sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID/description
>>>>     # how many keys do we have now?
>>>>     cat /sys/kernel/config/crash_dm_crypt_keys/count
>>>>@@ -591,15 +592,18 @@ with 
>>>>/sys/kernel/config/crash_dm_crypt_keys for setup,
>>>>     cat /sys/kernel/config/crash_dm_crypt_keys/count
>>>>     2
>>>>-    # To support CPU/memory hot-plugging, reuse keys already 
>>>>saved to reserved
>>>>-    # memory
>>>>-    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
>>>>-
>>>> 2. Load the dump-capture kernel
>>>> 3. After the dump-capture kerne get booted, restore the keys to 
>>>>user keyring
>>>>    echo yes > /sys/kernel/crash_dm_crypt_keys/restore
>>>>+For CPU/memory hot-plugging, you can reuse keys already saved 
>>>>to reserved
>>>>+memory before reloading the kdump image,
>>>>+    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>>>+
>>>>+Note if crash hotplug is supported, this API is totally 
>>>>unnecessary thus will
>>>>+be disabled automatically.
>>>>+
>>>> Contact
>>>> =======
>>>>diff --git a/kernel/crash_dump_dm_crypt.c 
>>>>b/kernel/crash_dump_dm_crypt.c
>>>>index b5b78656cf06..46d6b31c3ca4 100644
>>>>--- a/kernel/crash_dump_dm_crypt.c
>>>>+++ b/kernel/crash_dump_dm_crypt.c
>>>>@@ -310,6 +310,15 @@ static ssize_t 
>>>>config_keys_reuse_show(struct config_item *item, char *page)
>>>>     return sysfs_emit(page, "%d\n", is_dm_key_reused);
>>>> }
>>>>+static bool crash_hotplug_support(struct kimage *image)
>>>>+{
>>>>+#ifdef CONFIG_CRASH_HOTPLUG
>>>>+    return image->hotplug_support;
>>>
>>>I don't think it is good idea to access kexec_crash_image 
>>>properties without
>>>holding the kexec lock.
>>
>>Thanks for raising the concern! Let's discuss this issue in [PATCH 
>>v3 03/10].
>>
>>>
>>>Also, would it make sense to move this API somewhere else?
>>
>>Can you help me understand why to move this API? Is it because using
>>ifdef in .c file is discouraged?
>
>This API is used to verify crash hotplug support, which is not 
>directly related to crash_dm_crypt_keys.
>It also seems to be generally useful.
>
>- Sourabh Jain

Thanks for the clarification! After trying to make use of existing
crash_check_hotplug_support API in kernel/crash_core.c, I realize there
is no need to explicitly disallow configfs/crash_dm_crypt_key/reuse.
Because image->dm_crypt_keys_addr will be set to 0 when crash hotplug is
supported. Thus in fact the reuse API has already been implicitly
disallowed. So I will drop the unnecessary crash_hotplug_support
function in next version.

-- 
Best regards,
Coiby


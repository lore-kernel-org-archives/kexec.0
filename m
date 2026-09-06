Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D304C79F99
	for <kexec@archiver.kernel.org>; Sun,  6 Sep 2026 12:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FpdcKrJLKQFKxdneH8MEpLcde77LFmEiZubVtCmbqlQ=; b=rPz7eo4cEuR9ufSMa6ezbtZNhw
	jJM+1AjL/3qRcr/49/UjS6q/k8p6vBUmE+wvDgJsa35Dy9G4SXF0SnltAZTZUnIKFmtKnONbriD3X
	rkrbmMRPGHE7TNsctcgqlVBQuAMUaiqofWqowDFdaImToDS9Y2HBhrJi6eijCp5Q3X2fAXaCUv0C2
	lXphHgc2rOmdRNKvn189qtNcEnSOlr+tMUZ7NxJq0gYAUTIidhYrBBqBI8lCjMir6/l3CbiQz9R+C
	GzrXXRdaCCxpuRQq6aK2yRw1RwUWb59AkSWF1xK1T9NaFyUdbqQ06LEKXQHIDL5R0Vk/tiQF1+Raa
	NBk5BGug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3BqW-0000000517M-3vll;
	Sun, 06 Sep 2026 12:19:40 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3BqV-0000000516o-0s5j
	for kexec@lists.infradead.org;
	Sun, 06 Sep 2026 12:19:40 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2d942c7cc2fso19782075ad.3
        for <kexec@lists.infradead.org>; Sun, 06 Sep 2026 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788697178; x=1789301978; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpdcKrJLKQFKxdneH8MEpLcde77LFmEiZubVtCmbqlQ=;
        b=aFvrLy/6Y19FJfgq5N4b02e6BCo98yi4uIqnCHLrmPCIWJN7tOqgqtH6gN5qaER/Bh
         Q4u06xW13RvV0SVCfG3F9pRVPE62W07LjJtSKNLHEskI2bg3zxcVTAV3qO4RwX9ko/TR
         vB+CawHbmBawcv6X93WHStshiv8+9q/v2cMJkMmPsSHKXWgLRn5LeMdsvvXGli/MH695
         8fTtqTPfkfyjI2MGgYQrMDYVt6K3e3ucM6EcGGD+4/oKECXfArz2C6bNA/pwmd7GQfJ6
         Xu0RLJJCEuMUaWgsHKpcmL5VZMFPYpeRDh0nxxWKBLujjvKNIcdXabIK2YLoqb/sIwfC
         rfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788697178; x=1789301978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FpdcKrJLKQFKxdneH8MEpLcde77LFmEiZubVtCmbqlQ=;
        b=eobZOdqADYSKg6vfxVn5IqALctRK3bQOZkS5Lushe98dSeJHdPmNwyQ/fKnJIvqd+2
         7HwZP4e+0kCdpoTTReXjUIgSYeVsd4mU97GVyGQ/b2NeRPXNxDaooKT4zQYM/Mtd8NHY
         14/c3kslBnhWXlztTIRfBdqPC4PMAQQLJq1UB8vgRt9b2ZjV0/VopNasiwrLzs0rAiGA
         LQfHvTdmDvs1pxyjOcWfi95jH2rLRv50ZTy0/mXFJCpe9WO0BtITwfNV/BcV1A1cb/jR
         0nNXMeVaVKt+6zWeejP+qr3rwTNcp6hZpw8jeJiUeUaz5Idqy6rnX9T7IQIu8euI8X/j
         RJrA==
X-Gm-Message-State: AFuF++lU/TGt3+n8JZqNLUMyU+m3ASIXGOWa9zfH844vCVGDXXaj6EgQ
	TTQrCvdnPw00HtXXS5T+M0sIa1lF8wyypltPnr92KSXCjBsgGDGw9cSIijPJQ31YRWc=
X-Gm-Gg: AYBFou3UgmM5aYG2Lv+dY1rGaLWkuA1AWZjXk7veOa0B3sGWfHk/kKcl7ezK832OjJP
	PaOrhKxH+mw+yGv4hewGYHRsv6IFPc6pzu52XjrRc2KzAZ9/5qggttIefIyN855pdEL1E1JJK4K
	H9r+HOxf73CvwMU7M92uIXHLNMYoK2V9UXoWIUoZlkdat3r7tEehfSMczpSnNQyIQItpjmIQsJu
	qBAjcq7g3XhKJiH868LK6YwZ5mGa5bQSIbj9DV6MI7Gq43C2DChUkKc3DW4ZrOWIAJV9bqLJV1u
	w2iWFqFoeuSoV3phv+j15QwZj8ULN3SgCrLHumw3X2Y02BwLgSBg0Gkez12rzPRTUlzWjTwgkkp
	mdPmYNEqaLh4J5qlWV4IzmvWnmWmaR9hIyfwtnJ5CBM7ivjUSaYUOXUGJy0LK8PA3713yX4Jb9e
	dfV34+F5vr94LOq/B0+qmA8Czvbx+712xI0p3vpkNirEhkmTEUPXoWYWrIGHFPb2Kp8fPHag==
X-Received: by 2002:a17:903:3b51:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2db1250d4e4mr167739125ad.2.1788697177605;
        Sun, 06 Sep 2026 05:19:37 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:61d3:d76a:f196:4cf:cc30])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm20462005eec.27.2026.09.06.05.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:19:36 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Sun, 6 Sep 2026 20:18:23 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
Message-ID: <ap1US-aayjZTm1UG@Rk>
References: <20260828084900.1496839-1-coiby.xu@gmail.com>
 <20260828084900.1496839-3-coiby.xu@gmail.com>
 <86f3b10d-6fc2-4dbc-a20b-5d2365601be2@linux.ibm.com>
 <apLKk_P9wHc9uSZQ@Rk>
 <ccf3c0ae-f04b-4d81-b09e-daa5c785ec10@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccf3c0ae-f04b-4d81-b09e-daa5c785ec10@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260906_051939_255329_BB88CFDC 
X-CRM114-Status: GOOD (  16.37  )
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

On Sun, Aug 30, 2026 at 11:07:30AM +0530, Sourabh Jain wrote:
>
>
>On 29/08/26 17:47, Coiby Xu wrote:
>>On Sat, Aug 29, 2026 at 12:32:46PM +0530, Sourabh Jain wrote:
>>>
>>>
>>>On 28/08/26 14:18, Coiby Xu wrote:
>>>>If writing to the configfs group happens concurrently during
>>>>kexec_file_load syscall, it may lead to the following issues,
>>>>  - buffer overflow if dm-crypt keys are added after allocation
>>>>  - stale total_keys if dm-crypt keys are removed during iteration
>>>>  - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>>>    set true
>>>>
>>>>So hold config_keys_subsys.su_mutex for the entire sequence during the
>>>>kexec_file_load syscall to ensure a consistent snapshot. To have serial
>>>>access to config/crash_dm_crypt_key/reuse, use the kexec lock as 
>>>>we also
>>>>need to access kexec_crash_image serially.
>>>>
>>>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump 
>>>>reserved memory")
>>>>Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>>>---
>>>> kernel/crash_dump_dm_crypt.c | 28 ++++++++++++++++++++++++----
>>>> 1 file changed, 24 insertions(+), 4 deletions(-)
>>>>
>>>>diff --git a/kernel/crash_dump_dm_crypt.c 
>>>>b/kernel/crash_dump_dm_crypt.c
>>>>index 4335b6cb1fc4..026c7de4ad85 100644
>>>>--- a/kernel/crash_dump_dm_crypt.c
>>>>+++ b/kernel/crash_dump_dm_crypt.c
>>>>@@ -7,6 +7,7 @@
>>>> #include <linux/configfs.h>
>>>> #include <linux/module.h>
>>>> #include <linux/sysfs.h>
>>>>+#include "kexec_internal.h"
>>>> #define KEY_NUM_MAX 128    /* maximum dm crypt keys */
>>>> #define KEY_SIZE_MAX 256    /* maximum dm crypt key size */
>>>>@@ -296,14 +297,20 @@ static ssize_t 
>>>>config_keys_reuse_store(struct config_item *item,
>>>>     bool val;
>>>>     int r;
>>>>+    if (!kexec_trylock()) {
>>>>+        r = -EBUSY;
>>>>+        goto unlock;
>>>
>>>
>>>Are we unlocking a lock that we didn't acquire? How about 
>>>returning -EBUSY directly instead?
>>
>>Ah, thanks for catching my mistake! And also thanks for prioritizing
>>reviewing my patch!
>
>No worries at all! Happy to help, and thanks for the patch.

Thank you:)

>
>
>>
>>>
>>>
>>>>+    }
>>>>+
>>>>+    r = -EINVAL;
>>>>     if (!kexec_crash_image || 
>>>>!kexec_crash_image->dm_crypt_keys_addr) {
>>>>         kexec_dprintk(
>>>>             "dm-crypt keys haven't be saved to crash-reserved 
>>>>memory\n");
>>>>-        return -EINVAL;
>>>>+        goto unlock;
>>>>     }
>>>>     if (kstrtobool(page, &val) || !val)
>>>>-        return -EINVAL;
>>>>+        goto unlock;
>>>>     if (is_dm_key_reused) {
>>>>         pr_info("Already got dm-crypt keys, please continue 
>>>>with kexec_file_load syscall\n");
>>>>@@ -311,12 +318,15 @@ static ssize_t 
>>>>config_keys_reuse_store(struct config_item *item,
>>>>         r = get_keys_from_kdump_reserved_memory();
>>>>         if (r) {
>>>>             pr_warn("Failed to get dm-crypt keys from reserved 
>>>>memory\n");
>>>>-            return r;
>>>>+            goto unlock;
>>>>         }
>>>>         is_dm_key_reused = true;
>>>[...]
>>>>     }
>>>>-    return count;
>>>>+    r = count;
>>>>+unlock:
>>>>+    kexec_unlock();
>>>>+    return r;
>>>> }
>>>> CONFIGFS_ATTR(config_keys_, reuse);
>>>>@@ -421,6 +431,8 @@ static int build_keys_header(void)
>>>>     return 0;
>>>> }
>>>>+static bool mutex_acquired;
>>>>+
>>>> int crash_load_dm_crypt_keys(struct kimage *image)
>>>> {
>>>>     struct kexec_buf kbuf = {
>>>>@@ -432,6 +444,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>>     };
>>>>     int r = 0;
>>>>+    mutex_lock(&config_keys_subsys.su_mutex);
>>>>+    mutex_acquired = true;
>>>>+
>>>>     if (key_count <= 0) {
>>>>         kexec_dprintk("No dm-crypt keys\n");
>>>>         return 0;
>>>>@@ -481,6 +496,11 @@ void 
>>>>kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>>
>>>I explored the kexec_file_load syscall entry path and noticed
>>>that there is a path where the call to
>>>kimage_file_post_load_cleanup() can be skipped.
>>>
>>>For example, if kexec_file_load is called and everything goes well
>>>but kexec_post_load() fails, we skip
>>>kimage_file_post_load_cleanup(), and consequently
>>>kexec_file_post_load_cleanup_dm_crypt() as well.
>>>
>>>If that happens, the config_keys_subsys.su_mutex remains locked,
>>>which could cause problems with the next kexec load, right?
>>
>>Thanks for exploring the kexec_file_load syscall entry path! I took a
>>further look at it. Even though kimage_file_post_load_cleanup can be
>>skipped, kimage_free will be called regardless which will in turn call
>>kimage_file_post_load_cleanup.
>
>Ah yes, I missed that. That said, we are calling
>kimage_file_post_load_cleanup() twice for every kexec_file_load, so this
>needs to be looked into separately.

Thanks for the reminder! I have a further look at
kimage_file_post_load_cleanup and can confirm repeatedly calling
kexec_file_post_load_cleanup_dm_crypt won't cause any trouble.

Btw, I think there is no need to call kimage_file_post_load_cleanup
twice because kimage_free is to be called for sure. I also notice
kimage_file_alloc_init also calls kimage_file_post_load_cleanup which
seems unnecessary as well. kimage_file_alloc_init even calls
kfree(image) which may lead to UAF. Anyways these are separate issues
thus shall be addressed in separate patches.


-- 
Best regards,
Coiby


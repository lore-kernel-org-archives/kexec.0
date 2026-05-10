Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DD7CD3447
	for <kexec@archiver.kernel.org>; Sun, 10 May 2026 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izTavQ1kcYexIfsKLH8QAsQNmpLtV1TAYj1P+kBMhkU=; b=PANiA8CuTBCxPOTk4LAUfUqlU1
	R1yOg/2Mq/vcPchIR5/WcbmGCSa4VlmPeKyriUf2bEUxNasZVyRwK9dbb9J6eJTQBzJa6qdOG9wNC
	nmkJtnG7BL+uDJlU3dqjBednyNWtcRS4nawAGAdP9ExQ/TkLHwt/eauzCXpToGKcQZWZM3sEzbP6H
	q1pbhFaLWJNgCzsh7nalNWMkH6yQV9E3qIZaRn2nEgJkHtPc+icovipD4yTTqwznGyi0HSWlS1xVZ
	yObjrxr2991PLWiM52372lkjbuhj2K7c5iODxx6Gui/NIpsrPE0TWhgJ4q/Mxpw02IG7V8sXHHfpy
	bZjMLZvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLrwT-00000009sUk-1VBM;
	Sun, 10 May 2026 00:22:45 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLrwQ-00000009sU5-1rAJ
	for kexec@lists.infradead.org;
	Sun, 10 May 2026 00:22:44 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-36536771300so3000529a91.1
        for <kexec@lists.infradead.org>; Sat, 09 May 2026 17:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778372561; x=1778977361; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izTavQ1kcYexIfsKLH8QAsQNmpLtV1TAYj1P+kBMhkU=;
        b=mM1tNU39g3a/igjP5qOpnIa0E6VKBwb4kM8l4CU/+MM5LXizYPd7QAd0bm8jd/+ZeY
         2wJ6x0DQ4YdV0IT557GNGv80xM+bEhuMUfW6yoy8k8/JImxdWD+EPrEPMOk0C7vi71s4
         B+x7RAFLJGExcgfkvLQGTchqAhwl5pxFUu474GwqW/phT2strIYgFKMlcnG946OW854e
         x0D5dG49m0vBP0HeW3ZsSTkhodCAIsCBLOhZwqQevjeKR3gbaebDV19klG5ZXux+VD56
         TWN4DiKLCNcgihPKFEwsh42no6KkqnrE6PDPs1He3iaqTPbQQYylp3jw3AQ89FanJuJZ
         PTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778372561; x=1778977361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izTavQ1kcYexIfsKLH8QAsQNmpLtV1TAYj1P+kBMhkU=;
        b=cduEpqZJsY1n/ZXS3+TCRvUMw7LwBi0p8X2e/ZLitDmFlkVtcToa6fQJC0wEsG3KAz
         FM0BjJdMaHOf5m/mI+VpLVGk8ooWIUMFEXpB9BmnSaEq3LTXZ1hFC0DKNGigAPTdCH44
         Vo1thW82lEkpR7EftOyEE3EzJh/dSOjfmtDauzY5WjxgGFcclcp4VLOLvsh5qeyZMC5o
         P+oSjiXbObEM03yBzjwEhxMmHfmMbPSWpBvDRVlcPS+15/8Ne2VerDd6XObKoOWssuf6
         5K+xJ5Js5Hx2gOaOLfO0jGTQsV2cQxme6UcJOCIKUAazHEE24SFS1glepyYn4BW/JOIt
         yGfQ==
X-Gm-Message-State: AOJu0YzSp3b/jfH6qk0ivOP/q9EJiTCc9/S48HMFuL1637Rnqjd4WC/T
	7/OKnEbDmhjO3umB+pjVawuVHJpOt8Pqnq/MsWJNeyXplzU+n+hiHIpg
X-Gm-Gg: Acq92OGKwrLgMQ5tY0A1bkKwHMhVOVpOkQ0K8+pNdDm1UOnhlwSO+Y55g0maDwJKFuh
	pM0bwN1I9QUrdIQ4k6vVa5BQxLrcQpQcwzTnHEtGgeRw0F5lk47gQ8EA1Obd/9DShtaMkT/tfbh
	ASva9Jfk8dspmeE0LOjGoIhCGeSZ0grmLooTpzKU9I08LB5KjJewh3dWntTvj5BZ/K4ARc+9omX
	ZuDPqyHzN5kYBfNPO98E3jugvDcixjtYW8ATEI5ZyrFVaAzUL+CAeFztIKaRN7HUzb3E8Fq7t/1
	M5s3wBUN5h04ojMyDzezu9Uz6Sa57ND/T2iCg0Wom3vDEa4n+eZPxUSa7iz/6ar4LgwKfQuPrN2
	jWhmfpIWiFwVh/01PtYRq9CiSsF0M96MDoYqhLw7NmYJ1JLafe60qf9J3txQ7MIC+iVuy/1UAg1
	0FmEGaAxsMJLlyg9QmXE0=
X-Received: by 2002:a17:902:eb0a:b0:2bc:8e7d:3dce with SMTP id d9443c01a7336-2bc8e7d4c19mr15563205ad.27.1778372560719;
        Sat, 09 May 2026 17:22:40 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e75fffsm59176605ad.59.2026.05.09.17.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 17:22:39 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Sun, 10 May 2026 08:14:55 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <af_JKzEAwp9r-ZSS@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-3-coiby.xu@gmail.com>
 <fdb25929-2b47-4f92-b6a9-8caea1642fff@linux.ibm.com>
 <af3RQa8aU_F79XOw@Rk>
 <e460f764-997e-4a63-be7d-1ceb5a503d32@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e460f764-997e-4a63-be7d-1ceb5a503d32@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260509_172242_497113_CF3C68C0 
X-CRM114-Status: GOOD (  31.39  )
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

On Sat, May 09, 2026 at 01:36:59AM +0530, Sourabh Jain wrote:
>
>
>On 08/05/26 18:03, Coiby Xu wrote:
>>On Wed, May 06, 2026 at 05:58:31PM +0530, Sourabh Jain wrote:
>>>Hello Coiby,
>>
>>Hi Sourabh,
>>
>>Thanks for reviewing the patch!
>>
>>>
>>>On 02/05/26 05:13, Coiby Xu wrote:
>>>>If kexec_add_buffer somehow fails, keys_header will be freed. Depending
>>>>on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>>>following two problems if the kexec_file_load syscall is called again,
>>>>  1. Double free of keys_header if reuse=false
>>>>  2. UAF of keys_header if reuse=true
>>>>
>>>>To address these problems and also make it easier to reason about the
>>>>code, keep two invariants,
>>>>  1. keys_header will always be freed at the end of kexec_file_load
>>>>     syscall except during kdump image unloading for CPU/memory
>>>>     hot-plugging support
>>>>  2. There will always be valid keys_header if reuse=true
>>>>
>>>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump 
>>>>reserved memory")
>>>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for 
>>>>CPU/memory hot-plugging")
>>>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
[...]
>>
>>>
>>>
>>>
>>>>         kexec_dprintk(
>>>>             "dm-crypt keys haven't be saved to crash-reserved 
>>>>memory\n");
>>>>         return -EINVAL;
>>>>     }
>>>>-    if (kstrtobool(page, &is_dm_key_reused))
>>>>+    if (kstrtobool(page, &val) || !val)
>>>>         return -EINVAL;
>>>
>>>Why can’t we allow the user to set is_dm_key_reused = false and free the
>>>key_header? That way, the next kdump kernel load will recreate the
>>>For example, a user may add more keys and want the new keys to be 
>>>included
>>>in the kdump image from next kdump kernel load.
>>
>>Personally, I want to limit the reuse configfs API to the case of
>>CPU/memory hotplug thus to make the code simpler. And for the case of a
>>user adding more keys, I don't think there is a need for using the reuse
>>API.
>
>
>Yes, there is no need for it, but I think the user is forced to use
>key_reuse because once it is set to true, it cannot be set back to false.
>
>For example, the kdump kernel is loaded using the kexec_load system call
>and reuse is set to true. The user may later add a couple of new keys and
>want to include them in the kdump image.
>
>I think the next kdump kernel load will reuse the key_headers even though
>the user does not want it. Hence I see a problem here.
>
>Well user can load kdump kernel a second time, and at that point the
>keys will get updated. But do we really want this behavior?

key_reuse won't be set to true automatically unless an user explicitly
does so. Thus I don't think it's forcing users to use it. And by design
key_reuse is set only for the hotplug case.

For the cause of loading kdump kernel again, I don't see the need to set
key_reuse.

I also had the urge to allow writing false to the reuse API and even
implemented it. But later I deleted the code to avoid over-engineering
because I'm not sure how it is supposed to be used. Besides this reuse
API already makes it much harder to reason about the code. Shall all
architectures implement CONFIG_CRASH_HOTPLUG, I'll delete it immediately
so crash_dump_dm_crypt.c can be much easier to maintain.

>
>
>>
>>>
>>>
>>>>-    if (is_dm_key_reused)
>>>>-        get_keys_from_kdump_reserved_memory();
>>>>+    if (is_dm_key_reused) {
>>>>+        pr_info("Already got dm-crypt keys, please continue 
>>>>with kexec_file_load syscall\n");
>>>>+    } else {
>>>>+        r = get_keys_from_kdump_reserved_memory();
>>>>+        if (r) {
>>>>+            pr_warn("Failed to get dm-crypt keys from reserved 
>>>>memory\n");
>>>>+            return r;
>>>>+        }
>>>>+        is_dm_key_reused = true;
>>>>+    }
>>>>     return count;
>>>> }
>>>>@@ -366,9 +384,6 @@ static int build_keys_header(void)
>>>>     struct config_key *key;
>>>>     int i, r;
>>>>-    if (keys_header != NULL)
>>>>-        kvfree(keys_header);
>>>>-
>>>>     keys_header = kzalloc(get_keys_header_size(key_count), 
>>>>GFP_KERNEL);
>>>>     if (!keys_header)
>>>>         return -ENOMEM;
>>>>@@ -412,7 +427,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>>>         .top_down = false,
>>>>         .random = true,
>>>>     };
>>>>-    int r;
>>>>+    int r = 0;
>>>>     if (key_count <= 0) {
>>>>@@ -421,14 +436,15 @@ int crash_load_dm_crypt_keys(struct kimage 
>>>>*image)
>>>>     }
>>>>     if (!is_dm_key_reused) {
>>>>-        image->dm_crypt_keys_addr = 0;
>>>>         r = build_keys_header();
>>>>-        if (r) {
>>>>-            pr_err("Failed to build dm-crypt keys header, 
>>>>ret=%d\n", r);
>>>>-            return r;
>>>>-        }
>>>>+        if (r)
>>>>+            goto out;
>>>>     }
>>>>+    /*
>>>>+     * keys_header will be copied to reserver memory later and then be
>>>>+     * cleaned up at the end of kexec_file_load syscall
>>>>+     */
>>>>     kbuf.buffer = keys_header;
>>>>     kbuf.bufsz = get_keys_header_size(key_count);
>>>>@@ -438,18 +454,33 @@ int crash_load_dm_crypt_keys(struct kimage 
>>>>*image)
>>>>     r = kexec_add_buffer(&kbuf);
>>>>     if (r) {
>>>>         pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>>>-        kvfree((void *)kbuf.buffer);
>>>>-        return r;
>>>>+        goto out;
>>>>     }
>>>>+
>>>>     image->dm_crypt_keys_addr = kbuf.mem;
>>>>     image->dm_crypt_keys_sz = kbuf.bufsz;
>>>>     kexec_dprintk(
>>>>         "Loaded dm crypt keys to kexec_buffer bufsz=0x%lx 
>>>>memsz=0x%lx\n",
>>>>         kbuf.bufsz, kbuf.memsz);
>>>>+out:
>>>>+    is_dm_key_reused = false;
>>>>     return r;
>>>> }
>>>>+void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>>>+{
>>>>+    /*
>>>>+     * For CPU/memory hot-plugging, the kdump image will be 
>>>>reloaded. Prevent
>>>>+     * keys_header from being cleaned up during unloading when
>>>>+     * is_dm_key_reused=true
>>>>+     */
>>>>+    if (!is_dm_key_reused) {
>>>>+        kfree_sensitive(keys_header);
>>>>+        keys_header = NULL;
>>>
>>>Since crash_load_dm_crypt_keys() sets is_dm_key_reused = false, 
>>>keys_header will
>>>always be released here, right? Then why is the above free under 
>>>an if condition?
>>
>>Thanks for raising the question! This is to prevent "kexec -u" from
>>cleaning up keys_headers because kexec_file_post_load_cleanup_dm_crypt
>>will also be called during "kexec -u". Without the if condition,
>>keys_headers will not be available during reloading.
>
>Agree. But do we really run kexec -u and then kexec -p to reload the kdump
>kernel on hotplug events? I am under the impression that the udev rule
>simply reloads the kdump kernel using kexec -p without explicitly running
>kexec -u.

Yes, "kdumpctl reload" will be called during hotplug events 
https://github.com/rhkdump/kdump-utils/blob/main/kdump-udev-throttler#L51
So there is explicitly unloading first and then reloading.

>
>And if that is the case, I think we should clean key_headers on kexec -u.

Most of the cases is_dm_key_reused is false thus keys_header will be
cleaned on kexec -u.

>
>- Sourabh Jain
>
>
>>
>>>
>>>IIUC, for the case where CONFIG_CRASH_HOTPLUG is not enabled, this 
>>>is how key
>>>restore works:
>>>
>>>After loading the kdump kernel for the first time, the state of 
>>>the variables is:
>>>
>>>is_dm_key_reused = false
>>>keys_header = NULL
>>>
>>>For example, if 2 CPUs are hot-removed and kdump is reloaded twice:
>>>
>>>Then the sequence of operations needed to ensure the loaded keys 
>>>can be reused is:
>>>
>>>Udev rule triggered on the 1st CPU hotplug:
>>>echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>>Restore the key header from the reserved area
>>>Reload the kdump service/kernel
>>>
>>>Udev rule triggered on the 2nd CPU hotplug:
>>>echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>>Restore the key header from the reserved area
>>>Reload the kdump service/kernel
>>>
>>>What I don’t understand is the need to restore the key header from 
>>>crashkernel
>>>memory for every hotplug operation.
>>
>>I think there is no easy way to tell if there is another hotplug and
>>considering hotplug is a rare event. So I guess it's OK to restore the
>>key headers for every hotplug operation.
>
>

-- 
Best regards,
Coiby


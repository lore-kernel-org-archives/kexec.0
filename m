Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F0AC43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 07:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ShLnV8gFSlWWUTTTcWYbLbIKdnzp7WaWpPnsAa0/Uk=; b=J4JBxLGvC35Tj2IdVdXDA132+X
	WzUHQVztwNfiH3HgkpXviHig/4rByxfQC9hsfI7875p86CjFoCjvj7+WXPjrNABAiMM8kjbR2SxSH
	kBPcVyRDIv0+eHj7u4yE9Fpia98Ff+nIhF3kqEhxCdSZ53ELTdN8XecQL+zIBygxGBQLa108fYio3
	n9zLkTxArGLfdhKrEAIkGkAcepy0Pd7CrSCTUIr50PyHHWLqiQq2v8hJbS24g57nDw1KEly7JjEmn
	k5WV6ib6lUlw3PzAQQPKEUbZgDCInOyXuv6AEHmmluXMeIG3BOM2jNhxZ/jHg46prvzk4tZdLCOwP
	dWFOQINQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi62B-00000004NSS-2giq;
	Fri, 10 Jul 2026 07:52:31 +0000
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi629-00000004NS6-14Fp
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 07:52:30 +0000
Received: by mail-yx1-xb12b.google.com with SMTP id 956f58d0204a3-664d78637f8so952291d50.3
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 00:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669948; x=1784274748; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ShLnV8gFSlWWUTTTcWYbLbIKdnzp7WaWpPnsAa0/Uk=;
        b=OSFAnTUSUzXg74cNmzJkqU+Cd7t9DbAfAHHOhw4qAHiKY9p0FktcBsBYy8NlM/KKDf
         3LGTDqD6kVT4538+JjZCvWQNGgBhElRpaVQg/sGv2prMxIUSCimj2P4AcKDBvD5k958w
         AmbLXvW7nISG9CbZ/Bxr0kQnVfCe9DVbxwn/0JBYZg6W8Vze6waeeLAcbb+SpskmGVEq
         bgsBV8sZTI2DOihxYtIoO/nlZd/ZRJ1TIzU2HvDNFzF3sod2ARYveSVQuGzmPZDTlep7
         8vo/RXPN5sSspwmlZEqynuSISi6a4p7WNXJwlGuuzGOMgYHI7K6H5tAMGg+9pWWJrIOY
         kjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669948; x=1784274748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ShLnV8gFSlWWUTTTcWYbLbIKdnzp7WaWpPnsAa0/Uk=;
        b=azuO+qGsKHHeLum6kyMAp5LUz1TMpyhynJTb4H9m7k8uvfaCrAu+K2ingHsPekjwAC
         uc+4Axs7NL+i3kZNZi7iRNKNWG3X46HhGPcqI+zqb9DQR5Wm0VG3pekfViFW9MKM0BiL
         nz4PASkJnzVZToyOhoaSxHoo6+qJv9YdQkanc1m2wnuedbU2djZZG/2GD3dAtD3GygAp
         0T0fJt9BuFiAMMiSuBmVWhEwPdcGqguGfSqnZjJuwKy3+ba7o6m9rx9EpjU7cawQwOd+
         KgK0xhe+KUs4nJNO/4VFJusYePR+UbzCV8yoxrc0S/FHqaiSHMX2c74sDoTKHU/b0I8H
         gcNw==
X-Gm-Message-State: AOJu0YzGMDmbi/hvv+dkoH73QBTWsjlT3IxbKRvPrZXAExqYSpGRBBCX
	VZYd8qWpsncbZGkEBqcO8ECKTaRXYczR88yOrckjUksLbR3ogBYvvMy9
X-Gm-Gg: AfdE7ckReGWNSz/MPtZB/ISUTCfcFn3GYjHKeTUhFcbzQHm0WVFxp+6B+e0zAiqhkjs
	pf3/2Slnrf0RAqtxuGGVhMXlIUybVD1yXjCq/iLs5lE9B5p5XBwBh+KhEFhBoiJvrPfVNYZjraa
	EglmybONrjMb8NhUts0BXy4ohUluAEyrg8k5gzFnSRcsjZbO1qzeO7kt1yexC6mK+DT2zPW26kx
	rFH5QVJCvFb9ezDaDi0wk2UuZxKMG630Hlphdv2IT1JpiNnK3X7kFJqCcTICBxgFPyuFI4H1yry
	En7b1fOiUXx2QgaISoIUYgJaUi4HADI8cFN79FHf4M3jaHuFrCw+kQDztFSWjx9/febKiDGLl40
	UVRJOAS35jbhkswgBA8yfhVK45rnKEG/yShaZVrg6zYHV5lL2dZ7PIBcvHd+pGQ581zEWdC5j79
	aqbaCxnQ6F7fGvxEGnAoh4kNDNGLCq5a4=
X-Received: by 2002:a05:690e:e8d:b0:667:b04d:c0ca with SMTP id 956f58d0204a3-667b04dd090mr6451470d50.69.1783669947817;
        Fri, 10 Jul 2026 00:52:27 -0700 (PDT)
Received: from localhost (tpcc3a204.netvigator.com. [219.76.18.204])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66787a5b4adsm6234059d50.18.2026.07.10.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:27 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 14 May 2026 17:09:30 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <agWQGAz5vhLyW_0w@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-3-coiby.xu@gmail.com>
 <fdb25929-2b47-4f92-b6a9-8caea1642fff@linux.ibm.com>
 <af3RQa8aU_F79XOw@Rk>
 <e460f764-997e-4a63-be7d-1ceb5a503d32@linux.ibm.com>
 <af_JKzEAwp9r-ZSS@Rk>
 <54a27f47-a7cd-458c-9b27-7b84949aa453@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54a27f47-a7cd-458c-9b27-7b84949aa453@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_005229_327809_3AA5CA59 
X-CRM114-Status: GOOD (  23.24  )
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

On Tue, May 12, 2026 at 11:12:16AM +0530, Sourabh Jain wrote:
>
>
>On 10/05/26 05:44, Coiby Xu wrote:
>>On Sat, May 09, 2026 at 01:36:59AM +0530, Sourabh Jain wrote:
>>>
>>>
>>>On 08/05/26 18:03, Coiby Xu wrote:
>>>>On Wed, May 06, 2026 at 05:58:31PM +0530, Sourabh Jain wrote:
>>>>>Hello Coiby,
>>>>
>>>>Hi Sourabh,
>>>>
>>>>Thanks for reviewing the patch!
>>>>
>>>>>
>>>>>On 02/05/26 05:13, Coiby Xu wrote:
>>>>>>If kexec_add_buffer somehow fails, keys_header will be 
>>>>>>freed. Depending
>>>>>>on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>>>>>following two problems if the kexec_file_load syscall is 
>>>>>>called again,
>>>>>>  1. Double free of keys_header if reuse=false
>>>>>>  2. UAF of keys_header if reuse=true
>>>>>>
>>>>>>To address these problems and also make it easier to reason about the
>>>>>>code, keep two invariants,
>>>>>>  1. keys_header will always be freed at the end of kexec_file_load
>>>>>>     syscall except during kdump image unloading for CPU/memory
>>>>>>     hot-plugging support
>>>>>>  2. There will always be valid keys_header if reuse=true
>>>>>>
>>>>>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in 
>>>>>>kdump reserved memory")
>>>>>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys 
>>>>>>for CPU/memory hot-plugging")
>>>>>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>[...]
>>>>
>>>>>
>>>>>
>>>>>
>>>>>>         kexec_dprintk(
>>>>>>             "dm-crypt keys haven't be saved to 
>>>>>>crash-reserved memory\n");
>>>>>>         return -EINVAL;
>>>>>>     }
>>>>>>-    if (kstrtobool(page, &is_dm_key_reused))
>>>>>>+    if (kstrtobool(page, &val) || !val)
>>>>>>         return -EINVAL;
>>>>>
>>>>>Why can’t we allow the user to set is_dm_key_reused = false 
>>>>>and free the
>>>>>key_header? That way, the next kdump kernel load will recreate the
>>>>>For example, a user may add more keys and want the new keys to 
>>>>>be included
>>>>>in the kdump image from next kdump kernel load.
>>>>
>>>>Personally, I want to limit the reuse configfs API to the case of
>>>>CPU/memory hotplug thus to make the code simpler. And for the case of a
>>>>user adding more keys, I don't think there is a need for using 
>>>>the reuse
>>>>API.
>>>
>>>
>>>Yes, there is no need for it, but I think the user is forced to use
>>>key_reuse because once it is set to true, it cannot be set back to 
>>>false.
>>>
>>>For example, the kdump kernel is loaded using the kexec_load system call
>>>and reuse is set to true. The user may later add a couple of new 
>>>keys and
>>>want to include them in the kdump image.
>>>
>>>I think the next kdump kernel load will reuse the key_headers even 
>>>though
>>>the user does not want it. Hence I see a problem here.
>>>
>>>Well user can load kdump kernel a second time, and at that point the
>>>keys will get updated. But do we really want this behavior?
>>
>>key_reuse won't be set to true automatically unless an user explicitly
>>does so. Thus I don't think it's forcing users to use it. And by design
>>key_reuse is set only for the hotplug case.
>
>Oh, I got it now. So, on kdump kernel load, key reuse will always be
>set to false.
>
>And when the user wants to reuse the key, they can just set the key reuse to
>true and reload the kdump kernel. After the reload, key reuse will be set to
>false again by the kernel itself.
>
>Thanks for clearing up my doubts.

My pleasure! Good to know we are on the same page now:)

>
[...]
>>>>>>+    if (!is_dm_key_reused) {
>>>>>>+        kfree_sensitive(keys_header);
>>>>>>+        keys_header = NULL;
>>>>>
>>>>>Since crash_load_dm_crypt_keys() sets is_dm_key_reused = 
>>>>>false, keys_header will
>>>>>always be released here, right? Then why is the above free 
>>>>>under an if condition?
>>>>
>>>>Thanks for raising the question! This is to prevent "kexec -u" from
>>>>cleaning up keys_headers because kexec_file_post_load_cleanup_dm_crypt
>>>>will also be called during "kexec -u". Without the if condition,
>>>>keys_headers will not be available during reloading.
>>>
>>>Agree. But do we really run kexec -u and then kexec -p to reload 
>>>the kdump
>>>kernel on hotplug events? I am under the impression that the udev rule
>>>simply reloads the kdump kernel using kexec -p without explicitly 
>>>running
>>>kexec -u.
>>
>>Yes, "kdumpctl reload" will be called during hotplug events https://github.com/rhkdump/kdump-utils/blob/main/kdump-udev-throttler#L51
>>So there is explicitly unloading first and then reloading.
>
>Oh ok, then it makes sense.
>
>BTW, I got the impression about not using kexec -u on kdump service reload
>from the repo below:
>
>https://github.com/openSUSE/kdump/blob/master/70-kdump.rules.in [Udev Rule]
>https://github.com/openSUSE/kdump/blob/00979dc621ba35285b85bf55917a5b0dfd273114/init/load-once.sh#L22 
>[Wrapper to load once for multiple hotplug]
>https://github.com/openSUSE/kdump/blob/00979dc621ba35285b85bf55917a5b0dfd273114/init/load.sh#L312 
>[load kdump script]

Thanks for sharing how openSUSE support hotplug! I believe current API
shall also work for openSUSE if they plan to support LUKS-encrypted dump
target.

-- 
Best regards,
Coiby


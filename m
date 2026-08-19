Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5F3C5DF87
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ftunS58cBiMcbygydM2prujXSBPcF6lUAvIxlRiSWpU=; b=s1ATBG61yrHzp5mzsa4JyD6zc3
	qZmaO/iPaSUxZyeBuPSPqS/nuOjI1Q4TlA6m9gTp4Za0BKkBzYE+oyy1wH1LcaCA44kvFgIYwOhBh
	VGLdcPN+LnheP9fhKinPqUxk8ukMKK1t1+u2sIa5COHMOlKTG6v3eL/KMNNz9atFoJidRaOn2Du4a
	+bn+BGZdFfljxw8Kf0yM5AcA+NDq6BO5Kr9oFr8Mr+cRu+avI6I/rYvHyoU0xcSgRakHEAbM+xbuz
	8xUPGJJHV3fgiujQpHSCoLd3VLW8hQJSKCdmz4PeLRiejF5difaVNqEbY6SzcZKF5vEGl3S0u0MZF
	ukoL98bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwdHL-00000009UPU-0g9B;
	Wed, 19 Aug 2026 10:12:15 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwdHI-00000009UOi-422n
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 10:12:14 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-382ef647e20so920371a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Aug 2026 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787134331; x=1787739131; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftunS58cBiMcbygydM2prujXSBPcF6lUAvIxlRiSWpU=;
        b=FhZvgBOTH+Cilpk9s4Q+a7y1a+SkAwjTEg170LauiC3H8FuOVQ3r2NEJhqCIwNjKG8
         isyEnOSWaUsqJhRk4JZQ/uVho4ChtMfP8XcJMgQpW6PK4thWiE2GNCWGdYcD34SfbRNn
         Gwi6nbGa5ON75C2WWere3C2/5I1CaCir2/1PsOyTp18BEr94xKfqofd8N28IFmIJQk+V
         f+/IZkwpuzmck9Mqh8Zmp6vJeD3aaTxR5rWj8bn3tSqgTpcrw7ubyPmvaDrBq8DuUF7J
         NVAVHarDV6BZTM/92mcPk5cfXlrTkpS6M+sLdfRQxX3jxo32RbnNW3WHonSsUpCWdW+E
         HXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787134331; x=1787739131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ftunS58cBiMcbygydM2prujXSBPcF6lUAvIxlRiSWpU=;
        b=H46TaSAQnCMCssG5tfKGul2LqdCix9umm7l844M5sTcdKfxRAOoOpWRi6iCZD4LkZ9
         YR8u2+XBvLkOlvsX/21XExepeEhgHGnmUNLyeRaHntf/R76Oz+jgFPBMSfs8j9ygmN2H
         1Pi0CEor6mo2UwJPFUsEKb0lNINc6uxJR9/86kh2PgtXviN69QJIJU746SBNifjjGWpa
         VEUoWm0CbyxKj3hY60nytY9fi2wrQh1g9L0xA0L7lbECxlcnUpCpGpqi9R0lHPgaHUgH
         UvgIppQHOdsXvfVUgpE57QY4/IjopR9PNGitX8kqM0ym3wGlqS5wRak2BeWFfFpYsqKn
         W4cw==
X-Gm-Message-State: AFuF++mMVbsUJDjSmvhpKL8zmCduFyWw9gG2A1CEJA8QZ6HZxk3KNJOJ
	PF3jGganV7T6HA0V8il6xo8nC+EALoEOkzjWXwuqlznCl2SOtG5pYnS6
X-Gm-Gg: AR+sD107SrxUWDniPlF+0n/jbecVpwgSTgF0ekNGX8NBP00wnPMHofkT2BD7uKnOpzb
	Ybp5vqWPWN+tq9y8KmhIb4KJiTa5tZDW9AwnFQyf6Yiv05U0UJyp42X0f71G9A722dImOEpCqzM
	OuIwkq6W7UlpRNUN3kx5KSGKN7TZwQcbz+tVgYKlLje4gso3XHr/XFD0Dbv2NNLRu3cwilseSKX
	4JQO0hw/4vkcHYRPWWo2mt8tioo56KTFV9H7AAW+rKkgIoh97AZCUCVidW3A7ibkjvsjFo27ixd
	E7ZVPRG5+Nuwt5iQDpEoXyidE/pAFmdxBmZCb/b/GdLWOwCEba4eDOAQr5hVQAEtb7910o1sZ3C
	ISGi2qm3xZMd9Kd8gIOa/vlfMBEAiFIPW5PP51VSt6q5Y5sdGF832kSJqa0UOtTaEKOSqUJW8GG
	9MPm1y+QNrcIabL7tFEupLfGdnsWToRpvlKsVwvR8vG1tVVDmaakBc6StN2qovDtfoK0YZROA=
X-Received: by 2002:a17:90a:ec88:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-3958128686dmr6708038a91.16.1787134331282;
        Wed, 19 Aug 2026 03:12:11 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:3ae5:75e6:e4f4:4401:4289])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fc00b22sm742530a91.3.2026.08.19.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 03:12:10 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 19 Aug 2026 18:08:21 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] crash_dump: Disallow writing to dm-crypt
 configfs during kexec_file_load syscall
Message-ID: <aoV-TEyU7vLPVQMW@Rk>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-4-coiby.xu@gmail.com>
 <3010bbe1-844f-4513-9941-f4e92e581769@linux.ibm.com>
 <anQVIaMHXEx8hvep@Rk>
 <91f569f4-c370-49f1-8656-245f35793199@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91f569f4-c370-49f1-8656-245f35793199@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_031213_008068_823DE388 
X-CRM114-Status: GOOD (  22.09  )
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

On Sun, Aug 09, 2026 at 05:26:54PM +0530, Sourabh Jain wrote:
>Hello Coiby,
>
>On 06/08/26 10:50, Coiby Xu wrote:
>>On Wed, Aug 05, 2026 at 04:00:51PM +0530, Sourabh Jain wrote:
>>>
>>>
>>>On 29/07/26 09:06, Coiby Xu wrote:
>>>>If writing to the configfs group happens concurrently during
>>>>kexec_file_load syscall, it may lead to the following issues,
>>>>  - buffer overflow if dm-crypt keys are added after allocation
>>>>  - stale total_keys if dm-crypt keys are removed during iteration
>>>>  - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>>>    set true
>>>>
>>>>So hold config_keys_subsys.su_mutex for the entire sequence during the
>>>>kexec_file_load syscall to ensure a consistent snapshot.
>>>>
>>>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump 
>>>>reserved memory")
>>>>Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>>>---
>>>> kernel/crash_dump_dm_crypt.c | 23 +++++++++++++++++++++--
>>>> 1 file changed, 21 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/kernel/crash_dump_dm_crypt.c 
>>>>b/kernel/crash_dump_dm_crypt.c
>>>>index 4335b6cb1fc4..d2e66c6fe6f3 100644
>>>>--- a/kernel/crash_dump_dm_crypt.c
>>>>+++ b/kernel/crash_dump_dm_crypt.c
>>>>@@ -293,6 +293,7 @@ static ssize_t config_keys_reuse_show(struct 
>>>>config_item *item, char *page)
>>>> static ssize_t config_keys_reuse_store(struct config_item *item,
>>>>                        const char *page, size_t count)
>>>> {
>>>>+    struct mutex *lock;
>>>>     bool val;
>>>>     int r;
>>>>@@ -302,8 +303,12 @@ static ssize_t 
>>>>config_keys_reuse_store(struct config_item *item,
>>>>         return -EINVAL;
>>>>     }
>>>>+    lock = &to_config_group(item)->cg_subsys->su_mutex;
>>>>+    mutex_lock(lock);
>>>
>>>Is this lock only protecting against races between key reuse and 
>>>kexec_file_load(),
>>
>>The lock here is to protect against races between key reuse and
>>kexec_file_load.
>>
>>>or does it also handle the case where a new key is added during 
>>>key reuse or
>>>kexec_file_load() is running?
>>
>>For the cases where a key is added/deleted, configfs will automatically
>>take care of them because it will acquire mutex lock automatically.
>>
>>>
>>>If it is only intended to protect key reuse versus 
>>>kexec_file_load(), why can't we use
>>>the kexec lock instead?
>>>
>>>The reason I'm asking is that, in upcoming patches, the key reuse 
>>>path accesses
>>>kexec_crash_image properties and the crash reserved region 
>>>directly. Doing so
>>>without taking the kexec lock (using kexec_trylock()) could lead 
>>>to race conditions.
>>
>>After comparing the kexec lock approach with the configfs mutex lock
>>approach, I think the latter is a simpler solution because
>>1. the kexec lock is non-blocking and we have to repeatedly try until the
>>   lock get acquired. So it means user space has to make changes as
>>   well.
>>
>>2. configfs already acquires the mutex lock automatically for
>>   creating/deleting configfs items. So if we use configfs mutex lock,
>>   it means one less place to use the lock.
>>
>>In config_keys_reuse_store, kexec_crash_image will be checked before
>>accessing its properties and the crash reserved region. Can you
>>elaborate on what the race conditions are? Will acquiring the lock
>>before accessing kexec_crash_image properties and the crash reserved
>>region help protect against these races?
>>
>>In theory, the kexec lock can be a more robust approach. But considering
>>only root can write to the crash dm-crypt keys configfs and load kdump
>>image, I'm not sure it's necessary to adopt a bit more complex solution.
>
>The reuse function accesses the kexec crash image properties and crashkernel
>memory without taking the kexec lock. This could lead to race conditions or
>other problems.
>
>Since we need to take the kexec lock anyway, my suggestion is: can we 
>use the
>kexec lock instead of cg_subsys->su_mutex if the purpose of the mutex 
>is only
>to synchronize reuse with kexec_file_load?
>
>As we know, kexec_file_load already runs under the kexec lock. So using the
>same lock should provide the required synchronization.
>
>- Sourabh Jain

After 1) digging into the git history to learn more about what problems may
happen without ensuring serial access to the kexec crash image
properties and 2) noticing kexec-tools won't retry when kexec_file_load
syscall failed with -EBUSY due to kexec lock acquisition failure which
implies it's very unlikely to fail to get the kexec lock, I'm convinced
it's better to switch to kexec lock for the reuse function. Thanks for
the suggestion!

-- 
Best regards,
Coiby


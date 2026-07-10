Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58103C44501
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCAmxz9yPqRWofgVSMKF/vo2jh71M7LEVaHKWn5/sH8=; b=2L5/3zZaquy/5f1YwNiLRG/sdI
	cA++6NGOg5Fv7lx6zNWKZSmkeMxMCt5mb9sCMtl9eTwdsOUkVCxV16oHlrh1J8GazpDnbf69y7cfy
	Jba6M6K8WYhC14furvAcv27ckyRrJQrHFaFVWonfaEUfotpIWLRE+AqALUTOVuGbMQfWqY+ikzDAt
	WxapGqFqbk/GwmL01xaqgH7tt88HFtqCoJfeQhSJ8XQDxiGmW9htXP4ApX75CyXOFJAiSAvdlFwVL
	7sk1rnncUH2GgZVSL5a5ibgfZ9clKo+2IjAmu4YIRmJMZ5MC3YMEsbyOv8AEUhPPmpTBlfse75onP
	2VQZ/J4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi5zw-00000004NM4-1KqO;
	Fri, 10 Jul 2026 07:50:12 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi5zp-00000004NLS-3DAX
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 07:50:08 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-81dfdbd86d1so6395807b3.1
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669804; x=1784274604; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wCAmxz9yPqRWofgVSMKF/vo2jh71M7LEVaHKWn5/sH8=;
        b=c5CCkTThZH1FYtoywgbHa6IxOuZrLDXfLZTsG0m0vendobkLEQ6i1nFIGRQPIPyUrZ
         jey0jk/Ms30bfI7K2aNfP0z+N93k5YmAo/kUKNb+OEsjG/VbQG/Hyx20RWrf+y+btKnP
         fpAiTsSdiMRVTAWLtRWdfJX0n9kd3pv4t5rfE7dB3kqyaWAFjnozGHKzXhh4iA7ZRKjg
         EtFMStMKYW3MwF4u77QJ9B2Pu4CAjnKe7JyAeYHhNW4zMPoG5h5yrf5Vrhl3g31Bc6wd
         O1sNzW1C0567Sn7DLkQefPMHgWdLiZo8UwPe0KbXtLurmLYEyR0zSek5xCaQzL6aeclq
         4e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669804; x=1784274604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wCAmxz9yPqRWofgVSMKF/vo2jh71M7LEVaHKWn5/sH8=;
        b=C/3cwlZnZsSy2E9F1YEZ2Nb94/l8ZALUc52Ki5gKQjhxjDJg+R7N7ogZGyMN/oU0tn
         VrU5hZ4yL7ER0YA2gdWeMTFXCzVApTmyqzEhf5kdykGsh/BCqGCtnk12wQNwr5jzQ+Ob
         myIS0iuhf9tClAW/XRDq0qQ6dmls+GrfCqArL0s2ALvnh6TcMweupo1fiDY7leF57hv2
         VlBpWXN6qeVIxsEhjSn1iRyxz1esYf9xVuiINxkiG62lmaPWy682r7gUps8dHlBNjO7W
         rWDun7yp1qFRbUt7Xs94n1thP03l6gVUuxLsXh+aiJKfU8TzpMsCo5RPoR3HX0bt7mH0
         kd7Q==
X-Gm-Message-State: AOJu0Yx9KXshpdw8AEV/vB4TtknOvX82nxSGvzC5+Va7swGmGS56WNtt
	2oJRzSI3Qclm6gM+OGPKbFdJ3c3Tk/gG4rS4A3ueSbN0eER6xjfWpKkh
X-Gm-Gg: AfdE7cnWlrN2tjnQDhgW9Uf11vG9TJKC8dsaO6OnB5TsGYYZyk9U2l7+V7ba4L4+9ro
	FIMv6QHV/mv+kpe+RptHzI2PhyhODqd/KaMABkN7Cls0Z0HLwTjnOdgO6yP17YdvvcQAZbQ3eFe
	GbmYPIx3e1cg0ETNl/ha95Uh+uREJj3Zn9Gu1qL5u1ps8JpK2ui45p2XL7oKZy/3HzceC0KYnv6
	/daFL6jEWgiP1nK+bbju309jqqIZS8oAXn+YSHEGgAvkYm4hGcD0nkXA4VwVy9po7SXMO2r/9fn
	ywTXR8P91PiL3b7e2Y8zH2FFMguKSNBJGkcSa6lk22cafhasKakUrkKEjZVLQi7+Rb+YSDQjF8t
	p/g8qlisi2UjL+InjELLkxiXg+01TXPsmrreW6PBClnLKYZvq9IvQ1bNr48JqiTQokzEZ/555XR
	zJxFnvczno1/4wNyuZ+709HK3Da7VJSE21Lbm33fzoDg==
X-Received: by 2002:a05:690c:6885:b0:81e:76f0:dbce with SMTP id 00721157ae682-81e76f0dde3mr28503047b3.26.1783669804054;
        Fri, 10 Jul 2026 00:50:04 -0700 (PDT)
Received: from localhost (tpcc3a204.netvigator.com. [219.76.18.204])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1feb43sm39038737b3.40.2026.07.10.00.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:50:03 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 10 Jul 2026 15:47:09 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
Message-ID: <alBPjp24oXRmz6Kv@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-4-coiby.xu@gmail.com>
 <b6a29516-ff17-4a36-b90c-812160fa8d19@linux.ibm.com>
 <af3dlOG-X9geaP8w@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af3dlOG-X9geaP8w@Rk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_005005_814411_5A4AE21A 
X-CRM114-Status: GOOD (  20.71  )
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

On Fri, May 08, 2026 at 09:08:39PM +0800, Coiby Xu wrote:
>On Wed, May 06, 2026 at 07:26:16PM +0530, Sourabh Jain wrote:
>>
>>
>>On 02/05/26 05:13, Coiby Xu wrote:
>>>If writing to the configfs group happens concurrently during
>>>kexec_file_load syscall, it may lead to the following issues,
>>>  - buffer overflow if dm-crypt keys are added after allocation
>>>  - stale total_keys if dm-crypt keys are removed during iteration
>>>  - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>>    set true
>>>
>>>So hold config_keys_subsys.su_mutex for the entire sequence during the
>>>kexec_file_load syscall to ensure a consistent snapshot.
>>
>>
>>Yes, this will solve many synchronization problems when a  user tries to
>>perform any operation under our configfs_subsystem while the kernel is
>>executing the kexec_file_load system call.
>>
>>Now, regarding the third point about freeing key_header: this will work
>>only if configfs takes the su_mutex lock before invoking the store callback.
>>I am not sure whether it actually does.
>
>I can confirm configfs will automatically acquire the su_mutex lock when
>creating configfs item. But I forgot to try if writing to an item will
>also acquire the mutux lock. I'll do an experiment and share the result
>later.

You are right that writing to an attribute of an configfs item won't be
protected by the mutux lock. Thanks for raising the concern! 

>
>>
>>However, based on my previous comment on (2/9), if we keep 
>>config_keys_reuse_store()
>>under the kexec lock, this will be taken care of. This is because the entire
>>kexec_file_load system call already runs under the kexec lock.
>>
>>
>>>
>>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>>---
>>> kernel/crash_dump_dm_crypt.c | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>
>>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>>index 4d8a3331bbe7..6377ee86ec50 100644
>>>--- a/kernel/crash_dump_dm_crypt.c
>>>+++ b/kernel/crash_dump_dm_crypt.c
>>>@@ -429,6 +429,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>> 	};
>>> 	int r = 0;
>>>+	mutex_lock(&config_keys_subsys.su_mutex);
>>> 	if (key_count <= 0) {
>>> 		kexec_dprintk("No dm-crypt keys\n");
>>>@@ -479,6 +480,9 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>> 		kfree_sensitive(keys_header);
>>> 		keys_header = NULL;
>>> 	}
>>>+
>>>+	if (mutex_is_locked(&config_keys_subsys.su_mutex))
>>>+		mutex_unlock(&config_keys_subsys.su_mutex);
>>How about release the lock in crash_load_dm_crypt_keys() itself? 
>>Given that config_keys_reuse_store() is placed under kexec lock?
>
>Thanks for proposing another solution! I'll give a try and make a
>comparison.

After comparing the kexec lock approach with the configfs mutex lock
approach, I think the latter is a simpler solution because

1. the kexec lock is non-blocking and we have to repeatedly try until the
    lock get acquired. So it means user space has to make changes as
    well.

2. configfs already acquires the mutex lock automatically for
    creating/deleting configfs items. So if we use configfs mutex lock,
    it means one less place to use the lock.

So I prefer the configfs mutex lock approach unless I miss something,

Sorry it took me long time to get back to you. I got a bit sidetracked
by things including exploring ways to prevent these issues using unit
tests, Smatch or even rust. But I think it's better I do them in a
separate patch set.

-- 
Best regards,
Coiby


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7BECD3436
	for <kexec@archiver.kernel.org>; Fri,  8 May 2026 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TaNuSxrcULkdilLhsv0noZRaTWQoCQ38fAARlU5eCIA=; b=U7DNPus0lV6O6ingLIpGLrnNfY
	ofnncar5PGlgv+cyRwWwTqJTc9k0mYENkFwegj4KIa7Et6k4ESH4c3Y8J9Wmz9Al1tZFwdzvEGisx
	r4SMUfK3BhoGyJByPj56Gpnt7RZTMr+8Joz+WsNu2GW4dB4+dxIbexabTb3JqYslDpy2rkyj/z+Hg
	RFuCyJeXSIM3XU5SXsx2+0s/ycx7HtmWe2sjKj8rvdpoAUDn3uGqAJLSaZ/yrcYIjxr8kIlagXi45
	32h4O6R92X+pFs8H5EvtYMVhmhkHdoChHQzarweCNg71FlmqsEfDZMWaj45WbGPnbWLgq48toWnAK
	zIClZdkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLL3E-00000006WWw-3nqh;
	Fri, 08 May 2026 13:15:32 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLL3C-00000006WW7-0h4F
	for kexec@lists.infradead.org;
	Fri, 08 May 2026 13:15:31 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ba4efedbeaso14297545ad.1
        for <kexec@lists.infradead.org>; Fri, 08 May 2026 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778246129; x=1778850929; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TaNuSxrcULkdilLhsv0noZRaTWQoCQ38fAARlU5eCIA=;
        b=As6xqZCg9d4jDub0iVaSGvjrYzriVXH4Jqmvi6Je1vFYDst4jlFze5c/UzxEnW+a7e
         Is2dl7iqaFylmZiBjfNRV6a1fk4qoutah7xqu4tj/BCdx43q3WAXtnKoIw7gsBIurJSJ
         lRI5DxaHJInUE9Ewo61mSnDYkVxZi/Ag4b8uCWWvS4F4lLf4DlsgLYIS2zyzXG6zPJ+D
         3ojRmgI9ul+rWsRC88DpsRk9z4z367MulaHYlcxStOu5hWIIIbKyPW4CMRqyQBUAQMcP
         y6Gn81Va9ZcIezAsjdEc6pjrAzBv/CEvAkHUJTBkx78yp1vynnjLpkhkkDQzdIJZsS9u
         0fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778246129; x=1778850929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaNuSxrcULkdilLhsv0noZRaTWQoCQ38fAARlU5eCIA=;
        b=PNpi4XMIlxY+ZSu+jUeT5TiXf22aJSX4y910go3u7G59XaZYA8zZ6vhFodtiiERLSM
         E/yFhWSNUo/emLLEI2q8KxveBqrKZrudVbeep3rBJiZ5rw379f0GMCJaDanFoZmCxzN9
         aYp4B6Bo3ENMfgqZw6FET2NmrGVJ8f107J9fmgaAB7WF4Th2jW8W86gYEk2XpDMc7H8H
         tD83kuSQgchI7+Dl48ZW7kLnK9N/afF3cvZzbh5F2a/ut97q4GiM/Pr8eb0SuWP7Qhxd
         R5hpoeH2DnVQX0VJc2kFpspSOvcMWzF8ACqh1fnsN0XN0zrEPGfLXxM1JqFW4zKBeL1O
         F/zg==
X-Gm-Message-State: AOJu0YyhZeyFtDlnOcHjebb6AE2cSo6ovpW8dE+0a3qdMfS4zcHcUyHe
	81We2zg4SrIg0659hEFfJ7jjCEQ0/BGNXSzNZLSgxvNrkuEqnekuFr+b
X-Gm-Gg: Acq92OFNz9qlDiaOGoJO1ZEg9gSWKpKgbf4jkITccUZr9k/9z3D3TFJoOCp2Ikj9AC/
	Hd8s7eGfWkWaC6D1g11Fx8w4291AdjzEFw9/WcLnm7UFZ+kzhcpx2eQZ/AwcTG5H5cBGRdo5BuN
	HanQOGZtQBPonhkmO7op27TOIHOgj6mH79h7gGTDTIf5f2BfLXwOLONA4ndoUX4zLbxBCpjeoaF
	LVV4XlM8z5m2YRaUjA4dlJM5BTOxvr8P2QdWFrP89ojeybhK1HYGOa5vRw7GKF4uT/9v9EjcQj2
	H+Ek5jkyaQjeiyLtjUOBUPZ7JR4BBVqxUWSje/Kjbt7WDggq4sL4CJJ5kVkseX4FZZljJiSV5g9
	lQLnRy7l2G6u2YcrrWueJli0aSBWxBz7Q5YohC2snjxeEWPzAxdrgkWcYz1uPYnv3+IVnYE/4FF
	KJNfyrbvhfeSGwqn9MpIqdz8wQYJv0pg==
X-Received: by 2002:a17:902:8641:b0:2ba:6ffa:bde0 with SMTP id d9443c01a7336-2ba79c20bb9mr101621615ad.19.1778246128725;
        Fri, 08 May 2026 06:15:28 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d409eesm21600515ad.32.2026.05.08.06.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:15:28 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 8 May 2026 21:08:39 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
Message-ID: <af3dlOG-X9geaP8w@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-4-coiby.xu@gmail.com>
 <b6a29516-ff17-4a36-b90c-812160fa8d19@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6a29516-ff17-4a36-b90c-812160fa8d19@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_061530_204304_A1E408D2 
X-CRM114-Status: GOOD (  17.00  )
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

On Wed, May 06, 2026 at 07:26:16PM +0530, Sourabh Jain wrote:
>
>
>On 02/05/26 05:13, Coiby Xu wrote:
>>If writing to the configfs group happens concurrently during
>>kexec_file_load syscall, it may lead to the following issues,
>>   - buffer overflow if dm-crypt keys are added after allocation
>>   - stale total_keys if dm-crypt keys are removed during iteration
>>   - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>     set true
>>
>>So hold config_keys_subsys.su_mutex for the entire sequence during the
>>kexec_file_load syscall to ensure a consistent snapshot.
>
>
>Yes, this will solve many synchronization problems when a  user tries to
>perform any operation under our configfs_subsystem while the kernel is
>executing the kexec_file_load system call.
>
>Now, regarding the third point about freeing key_header: this will work
>only if configfs takes the su_mutex lock before invoking the store callback.
>I am not sure whether it actually does.

I can confirm configfs will automatically acquire the su_mutex lock when
creating configfs item. But I forgot to try if writing to an item will
also acquire the mutux lock. I'll do an experiment and share the result
later.

>
>However, based on my previous comment on (2/9), if we keep 
>config_keys_reuse_store()
>under the kexec lock, this will be taken care of. This is because the entire
>kexec_file_load system call already runs under the kexec lock.
>
>
>>
>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 4d8a3331bbe7..6377ee86ec50 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -429,6 +429,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	};
>>  	int r = 0;
>>+	mutex_lock(&config_keys_subsys.su_mutex);
>>  	if (key_count <= 0) {
>>  		kexec_dprintk("No dm-crypt keys\n");
>>@@ -479,6 +480,9 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>  		kfree_sensitive(keys_header);
>>  		keys_header = NULL;
>>  	}
>>+
>>+	if (mutex_is_locked(&config_keys_subsys.su_mutex))
>>+		mutex_unlock(&config_keys_subsys.su_mutex);
>How about release the lock in crash_load_dm_crypt_keys() itself? Given 
>that config_keys_reuse_store() is placed under kexec lock?

Thanks for proposing another solution! I'll give a try and make a
comparison.

-- 
Best regards,
Coiby


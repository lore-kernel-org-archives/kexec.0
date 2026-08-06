Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B435FC55ABF
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 05:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CvIeePQsxZu1lvyuPmffHvVuX4dHxWUDRkiO5wuokgc=; b=2aVBykXZz2IgEiVPcq6p8/kJXA
	R06RRwf+5njfjj3H2KI97MzWaWgm6oEjGUqrVdb+V706r5aYRi1KeUGJFpr66t7njV2zAvUngUYLA
	xjkX6dpL7Oi+LPOxB/XnXH3imiTb+Xzvo+3zZnyMK3VH20ZuvTM5MkUaiS3rLIgyYDtFQGQAXFORz
	JxS0v6KmcYXXCmxsD/IW4ImJO9JoxinZa6XDg2jZIZKQP9R78y4E3J4SzjcxypqZJEXFHFJCsipuY
	oSwCqRxMvE4Ilzx3yEGfxm6E3zMEn/boQsZapF9txH/7R92xOJ5H1AHYnHb+iAA3h1e+IVi8uaS/t
	/lhIs+/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrqbQ-00000004yof-3htM;
	Thu, 06 Aug 2026 05:25:12 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrqbO-00000004ynW-0TxK
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 05:25:11 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so1719147b3a.1
        for <kexec@lists.infradead.org>; Wed, 05 Aug 2026 22:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785993909; x=1786598709; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CvIeePQsxZu1lvyuPmffHvVuX4dHxWUDRkiO5wuokgc=;
        b=XJ5IQBtQi0OH0agoABeNulsV1frHVoT8cjW0aaHLkZPCTUfhw7xry7uQ82HDQmwzZy
         tG02Npx7VZQ93ZpoCfSsFt/rKpf9oJqOK7se+GLlk6la4RpOKBHXrGkCVcNgrKRVBTPZ
         4CSy8HYY70kSRJoPb44HyuxQYl/A+/cYwdGnzHL0AjFmItlY2NgLkYzaS//cRh25I/mQ
         /EB6iNZYupe+xUv6WSClZpSEHCn7sjdTrrQTFjpU+Kwsy36X0VHyf5f1StSX764jRYE+
         8VD6W0RA84Q/s9WcKVVz3m1BGJPW8LzLfNdFnN2d9K5VUn8GgiNA/oFdFqMHTTY2liix
         j4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785993909; x=1786598709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvIeePQsxZu1lvyuPmffHvVuX4dHxWUDRkiO5wuokgc=;
        b=sazo9v331/EEgUBdvdvewkmlGwwsJZ2ihK2mt0Ddh6JZEWJkcrYKGtwOcAPrQqrULh
         bcp4ku8GTvIA7HIam+rKFknvcnmm3lUy8d7k8B8bzIXQ1W5gXef0lsUn5nqc7gE8gwwo
         zvF8/S+A0G96t8hrPyhnwDM1Q7J8XKcHNzIUohQnZFgShx0mj8khHz8xJbHRVnXhk9EB
         vI9c1xnzOTM1ekoHIQBuD8OM5rRskLNBxV//ok4IbswIaekVFbkKqMGfbZJZ1ADLzPu0
         j9SyNRVnApaa+NFR6z/j6r4eLqfD5udJCKHOpYzb1M5mEeFcWwKX0b2q8OkUP1v81jT5
         S9Xg==
X-Gm-Message-State: AOJu0Yy60Jff4QJekb6DsJjeYVNn4fWDBU9bkjtpgn25TTcvySr/LwOB
	nLtOQE7FLy5SlYD/FN2t406Xeb6BVUayHQG61JBxGrnKW+BS0UikeMA7
X-Gm-Gg: AR+sD10amlF16a9jwVe+BSmEa+Wf2Pd997xxtDKmrVLcR3F+qT31mBbqer8Z890r1TC
	s38NDt5bbonv4htZzXKXa/nHeh4ABrrAVsiHNcusjDK0c4QYLJxkg7X8TTsmPvB4tgWoCh9Kxz+
	Ji7GtS5sBttFDTpo0b7IS6ghDaYWJMWZcKghQW5sFwAncdKC5cMmSJ1f6SIEnYU/GlUEZynJG8O
	FMQwdsKs7xL3XRD4SriOKuQfslGu0UsFJphldxyXbBtH0dvs879F4YU0Fp1sTK+p9ZdmSA59t4h
	3RJdSFCf6Yvxh//TcefT45m47C81VBE/xxDZ1twf+lwX6a4Yb0fI2mG9KdPSX+t3vqi0eL8XlKK
	l7SYDiNn2bsuTk4FFeO1ePZDEId3N+N2ecA5yXuJNBPC7pWuQ6kyRwRHsH+QDmJI49ugxTB88Lc
	LtzvKt9XXhfTmDutJqDiWFGnoYvTz8FsaDXyPjbRjFRT80kEKxzGxK
X-Received: by 2002:a05:6a00:300e:b0:84c:4bf4:10c3 with SMTP id d2e1a72fcca58-84f2e0cc682mr14367528b3a.38.1785993908992;
        Wed, 05 Aug 2026 22:25:08 -0700 (PDT)
Received: from localhost ([2a09:bac5:55f3:25d7::3c5:8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f456b7368sm562220b3a.37.2026.08.05.22.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:25:08 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 6 Aug 2026 13:20:58 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] crash_dump: Disallow writing to dm-crypt
 configfs during kexec_file_load syscall
Message-ID: <anQVIaMHXEx8hvep@Rk>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-4-coiby.xu@gmail.com>
 <3010bbe1-844f-4513-9941-f4e92e581769@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3010bbe1-844f-4513-9941-f4e92e581769@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_222510_157675_1CF10EDD 
X-CRM114-Status: GOOD (  22.29  )
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

On Wed, Aug 05, 2026 at 04:00:51PM +0530, Sourabh Jain wrote:
>
>
>On 29/07/26 09:06, Coiby Xu wrote:
>>If writing to the configfs group happens concurrently during
>>kexec_file_load syscall, it may lead to the following issues,
>>   - buffer overflow if dm-crypt keys are added after allocation
>>   - stale total_keys if dm-crypt keys are removed during iteration
>>   - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
>>     set true
>>
>>So hold config_keys_subsys.su_mutex for the entire sequence during the
>>kexec_file_load syscall to ensure a consistent snapshot.
>>
>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 4335b6cb1fc4..d2e66c6fe6f3 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -293,6 +293,7 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>>  static ssize_t config_keys_reuse_store(struct config_item *item,
>>  					   const char *page, size_t count)
>>  {
>>+	struct mutex *lock;
>>  	bool val;
>>  	int r;
>>@@ -302,8 +303,12 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>>  		return -EINVAL;
>>  	}
>>+	lock = &to_config_group(item)->cg_subsys->su_mutex;
>>+	mutex_lock(lock);
>
>Is this lock only protecting against races between key reuse and 
>kexec_file_load(),

The lock here is to protect against races between key reuse and
kexec_file_load.

>or does it also handle the case where a new key is added during key reuse or
>kexec_file_load() is running?

For the cases where a key is added/deleted, configfs will automatically
take care of them because it will acquire mutex lock automatically.

>
>If it is only intended to protect key reuse versus kexec_file_load(), 
>why can't we use
>the kexec lock instead?
>
>The reason I'm asking is that, in upcoming patches, the key reuse path 
>accesses
>kexec_crash_image properties and the crash reserved region directly. 
>Doing so
>without taking the kexec lock (using kexec_trylock()) could lead to 
>race conditions.

After comparing the kexec lock approach with the configfs mutex lock
approach, I think the latter is a simpler solution because
1. the kexec lock is non-blocking and we have to repeatedly try until the
    lock get acquired. So it means user space has to make changes as
    well.

2. configfs already acquires the mutex lock automatically for
    creating/deleting configfs items. So if we use configfs mutex lock,
    it means one less place to use the lock.

In config_keys_reuse_store, kexec_crash_image will be checked before
accessing its properties and the crash reserved region. Can you
elaborate on what the race conditions are? Will acquiring the lock
before accessing kexec_crash_image properties and the crash reserved
region help protect against these races?

In theory, the kexec lock can be a more robust approach. But considering
only root can write to the crash dm-crypt keys configfs and load kdump
image, I'm not sure it's necessary to adopt a bit more complex solution.


>
>- Sourabh Jain
>>+
>>+	r = -EINVAL;
>>  	if (kstrtobool(page, &val) || !val)
>>-		return -EINVAL;
>>+		goto unlock;
>
>The jump above skips setting count, causing the function to return 
>count instead of -EINVAL.
>Is this really intended?

Thanks for catching this issue! In the end of the function, r instead of
count should be returned.

>
>>  	if (is_dm_key_reused) {
>>  		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
>>@@ -311,11 +316,15 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>>  		r = get_keys_from_kdump_reserved_memory();
>>  		if (r) {
>>  			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
>>-			return r;
>>+			goto unlock;
>>  		}
>>  		is_dm_key_reused = true;
>>  	}
>>+	r = count;
>>+
>>+unlock:
>>+	mutex_unlock(lock);
>>  	return count;
>>  }
>>@@ -421,6 +430,8 @@ static int build_keys_header(void)
>>  	return 0;
>>  }
>>+static bool mutex_acquired;
>>+
>>  int crash_load_dm_crypt_keys(struct kimage *image)
>>  {
>>  	struct kexec_buf kbuf = {
>>@@ -432,6 +443,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	};
>>  	int r = 0;
>>+	mutex_lock(&config_keys_subsys.su_mutex);
>>+	mutex_acquired = true;
>>+
>>  	if (key_count <= 0) {
>>  		kexec_dprintk("No dm-crypt keys\n");
>>  		return 0;
>>@@ -481,6 +495,11 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
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


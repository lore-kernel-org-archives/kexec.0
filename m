Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472E4CD3447
	for <kexec@archiver.kernel.org>; Fri,  8 May 2026 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pq4oubkGSHD3iNhoYVouRXapXaXo+/ohcQ6g5Iy0JNI=; b=C2rlxEI8lQixbL1aI1xxdWekID
	JLNAt7PGKIDtu3NecPzSsnzIboQFqW/CEPTaOa3puxrTUNJkKrNBij8cVSmEsj21JgiLGr2E1iaUh
	toadI6d+D69MTDaNNW5FOaMKaExJt+dgvcig1VgJ4E0ySjuYV6e5CgbOsFjLwSa+dolIKsTYmx2cd
	T8jeORGF5ocNxPGMzJDoL/Sb3kw6HMuZDDrIDJ8YupJxDEeRG+PJ6W5bwT/C1tW1CldGBKd7u8r1e
	M66CiQel8yFrYZx8uINy/KZhAwc/TfRRrTu1G8/5F+pKCCx3mmjzhV7rBGiY4ZM36z96M71QHu5nZ
	wFWsSpkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLKVZ-00000006UCd-2c5r;
	Fri, 08 May 2026 12:40:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLKVY-00000006UBe-2T0A
	for kexec@bombadil.infradead.org;
	Fri, 08 May 2026 12:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=pq4oubkGSHD3iNhoYVouRXapXaXo+/ohcQ6g5Iy0JNI=; b=bcPZDhSGTcrlcMxuzMO0V44+xy
	d2Nm95GKDaIIviZKYaWYX2H9hHMTGo+X11PfKrLR0p54MOTJOkyXxM/CfGOAQw8HZVV7TlfKmedmj
	O76gxg/PTN3UC6jo6oejik47Q9M5Y78lR6kouPmDUseKrhhxgR4wkx0KMe3TexfkJqo5o+a6A/V6x
	zv9opA/WvZjXz5CuovxUYjK3XOpSPccksSywQgiOG769pk8JQF6ZGeZWr7lI3d4YTsblq1f/BKsXM
	c6J2gi9+UuFMW/QAxuiC1B3jw4rx8b8cnluWdWwnfR7h6ZO9I32k1QscZKr/Tr03ljAYULb3YW6rb
	Yf9D0NJw==;
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLKVR-00000006Hwb-2osk
	for kexec@lists.infradead.org;
	Fri, 08 May 2026 12:40:43 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso774028a12.1
        for <kexec@lists.infradead.org>; Fri, 08 May 2026 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244035; x=1778848835; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pq4oubkGSHD3iNhoYVouRXapXaXo+/ohcQ6g5Iy0JNI=;
        b=A03h1jMAGdUYTGzMzcFXvf8Cc1rJIGx+d7vZdeJ1Vz38gVxpKFr9/S3otzHMy93bQy
         pMjlzPY1B5iWHA+yhCUUtEn0dqciGRiu3iwPgy1G4UK3dvlkhTdSZVCXa7JU1/NF+CG5
         tnRK4ph+Yaxn1LPWSTJY39fZjWJJyvlgKTwyDUAw+YnXcXAF2txa+jd4Qng+daCMLJ8K
         mLasHW7KATBa9ozuS/q1P5VunHJm7b29oUXDgvQdHDCq8ib71/l+eiG8NgRkvvpQJD2o
         aIEMGj3ddCteFxkAUaw1/UVBQ7KBFECKzTK/dvaePWreUzR0LVBxAo5T3J7pFH80sAOs
         B8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244035; x=1778848835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pq4oubkGSHD3iNhoYVouRXapXaXo+/ohcQ6g5Iy0JNI=;
        b=qYjNIvo9iXsavt41lg2bgu8hHaIzIYpeNvfmIXLiMCaAnOc1pAfxgqGv0ND1U+brMr
         C6LzdNyFR9HhaitPSnZk4SaqqhYJaKVxWJaYPOvzP12LszwOaEDJiHZrQc3B014tp5X8
         o0A8vvHj+1VDtWCh5pBckbreKjbJURjyKHzhRPgkf9iiUEYTygy38ohQrYCD8C/ZbDSg
         WSlzH6luN+n6nve8JIMHwUqdrx+a6Ff5xw5KO8zqD9b5ZDQRyTQtaI8o7SB0cmoUMEVB
         4470MUSmKV1LLfQ+mwGGl6nyTEDfUgMs9twojAejSMRu3HPspFGJO/DcMSRMc08RIhNO
         iGFg==
X-Gm-Message-State: AOJu0YwxdNdFAg8JuPhBJcazf6FlPoGHoKKkMATIYfhk8PjhdilROuXi
	5vbtvAEAF2zG1BKeY/hNcvQ0p8dVK1CUk7cPBc6sPwSpkvHt08RMkw4b
X-Gm-Gg: AeBDievqko0W9rBd3XjrHHePyf9tLQykHWME3GxjlfGuu8KTcjo/1OpPz0Kdrd9jM5w
	SKb54Em1ykciWuCyrFkX/O6YjmyXQibJE6hdQaCdJCakB5AFsPymJ7ml7vP8mx53SI4MA8buCWo
	zeM2zPs5473a3LPpcuAYiddG2O/zeOWuTeGsGtBBoFZIuxLqeHlIfmUF1laogWD4Q2R6QCyZCOs
	8wKOQOglLE3V1ARiT5/gNrwSKhnLWXmvhmKkcoX+CfY4QKNOsDy9RsT9C+t+lyeBUBzbi3C1Ao/
	QatWWt3Uoab8By8cLpCDi5iw7SahAwHDKsMdnmaks0vAnPuq00Pv+CuAY5jo4Qet+L4Dp4bGcUh
	+MTEExcBrt2I1+Ght8B7sONmCzDGO30xuvQyKQd18rPqQCMNGfM6r2tTvDG5ncEudKXnHYlDstM
	jtkFkY4WbRk8RZWrNfmP4=
X-Received: by 2002:a05:6a21:328b:b0:3a2:e8f1:b859 with SMTP id adf61e73a8af0-3aab16e9fc8mr3271432637.28.1778244035114;
        Fri, 08 May 2026 05:40:35 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a20ebsm12491875b3a.53.2026.05.08.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:40:34 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 8 May 2026 20:33:14 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <af3RQa8aU_F79XOw@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-3-coiby.xu@gmail.com>
 <fdb25929-2b47-4f92-b6a9-8caea1642fff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdb25929-2b47-4f92-b6a9-8caea1642fff@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_134038_093347_D7740914 
X-CRM114-Status: GOOD (  29.25  )
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

On Wed, May 06, 2026 at 05:58:31PM +0530, Sourabh Jain wrote:
>Hello Coiby,

Hi Sourabh,

Thanks for reviewing the patch!

>
>On 02/05/26 05:13, Coiby Xu wrote:
>>If kexec_add_buffer somehow fails, keys_header will be freed. Depending
>>on /sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>following two problems if the kexec_file_load syscall is called again,
>>   1. Double free of keys_header if reuse=false
>>   2. UAF of keys_header if reuse=true
>>
>>To address these problems and also make it easier to reason about the
>>code, keep two invariants,
>>   1. keys_header will always be freed at the end of kexec_file_load
>>      syscall except during kdump image unloading for CPU/memory
>>      hot-plugging support
>>   2. There will always be valid keys_header if reuse=true
>>
>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  include/linux/kexec.h        |  6 ++++
>>  kernel/crash_dump_dm_crypt.c | 65 ++++++++++++++++++++++++++----------
>>  kernel/kexec_file.c          |  2 ++
>>  3 files changed, 56 insertions(+), 17 deletions(-)
>>
>>diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>index 8a22bc9b8c6c..91256d7ff434 100644
>>--- a/include/linux/kexec.h
>>+++ b/include/linux/kexec.h
>>@@ -552,6 +552,12 @@ void set_kexec_sig_enforced(void);
>>  static inline void set_kexec_sig_enforced(void) {}
>>  #endif
>>+#ifdef CONFIG_CRASH_DM_CRYPT
>>+void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image);
>>+#else
>>+static inline void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image) {}
>>+#endif
>>+
>>  #endif /* !defined(__ASSEBMLY__) */
>>  #endif /* LINUX_KEXEC_H */
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index eac4f436a8d4..4d8a3331bbe7 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -84,18 +84,25 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>>  	return r;
>>  }
>>-static void get_keys_from_kdump_reserved_memory(void)
>>+static int get_keys_from_kdump_reserved_memory(void)
>>  {
>>  	struct keys_header *keys_header_loaded;
>>+	size_t keys_header_size;
>>-	arch_kexec_unprotect_crashkres();
>>+	keys_header_size = get_keys_header_size(key_count);
>>+	keys_header = kzalloc(keys_header_size, GFP_KERNEL);
>>+	if (!keys_header)
>>+		return -ENOMEM;
>>+	arch_kexec_unprotect_crashkres();
>>  	keys_header_loaded = kmap_local_page(pfn_to_page(
>>  		kexec_crash_image->dm_crypt_keys_addr >> PAGE_SHIFT));
>
>Accessing kexec_crash_image without holding the kexec lock could lead to
>undefined behavior.
>
>I think this section of code should be called by holding kexec lock.
>
>
>>-	memcpy(keys_header, keys_header_loaded, get_keys_header_size(key_count));
>>+	memcpy(keys_header, keys_header_loaded, keys_header_size);
>>  	kunmap_local(keys_header_loaded);
>>  	arch_kexec_protect_crashkres();
>>+
>>+	return 0;
>>  }
>>  static int restore_dm_crypt_keys_to_thread_keyring(void)
>>@@ -283,17 +290,28 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>>  static ssize_t config_keys_reuse_store(struct config_item *item,
>>  					   const char *page, size_t count)
>>  {
>>+	bool val;
>>+	int r;
>>+
>>  	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>
>The above check should be performed after acquiring the kexec lock.

Good suggestion! I'll try to hold the kexec lock in next version.

>
>
>
>>  		kexec_dprintk(
>>  			"dm-crypt keys haven't be saved to crash-reserved memory\n");
>>  		return -EINVAL;
>>  	}
>>-	if (kstrtobool(page, &is_dm_key_reused))
>>+	if (kstrtobool(page, &val) || !val)
>>  		return -EINVAL;
>
>Why can’t we allow the user to set is_dm_key_reused = false and free the
>key_header? That way, the next kdump kernel load will recreate the 
>
>For example, a user may add more keys and want the new keys to be included
>in the kdump image from next kdump kernel load.

Personally, I want to limit the reuse configfs API to the case of
CPU/memory hotplug thus to make the code simpler. And for the case of a
user adding more keys, I don't think there is a need for using the reuse
API.

>
>
>>-	if (is_dm_key_reused)
>>-		get_keys_from_kdump_reserved_memory();
>>+	if (is_dm_key_reused) {
>>+		pr_info("Already got dm-crypt keys, please continue with kexec_file_load syscall\n");
>>+	} else {
>>+		r = get_keys_from_kdump_reserved_memory();
>>+		if (r) {
>>+			pr_warn("Failed to get dm-crypt keys from reserved memory\n");
>>+			return r;
>>+		}
>>+		is_dm_key_reused = true;
>>+	}
>>  	return count;
>>  }
>>@@ -366,9 +384,6 @@ static int build_keys_header(void)
>>  	struct config_key *key;
>>  	int i, r;
>>-	if (keys_header != NULL)
>>-		kvfree(keys_header);
>>-
>>  	keys_header = kzalloc(get_keys_header_size(key_count), GFP_KERNEL);
>>  	if (!keys_header)
>>  		return -ENOMEM;
>>@@ -412,7 +427,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  		.top_down = false,
>>  		.random = true,
>>  	};
>>-	int r;
>>+	int r = 0;
>>  	if (key_count <= 0) {
>>@@ -421,14 +436,15 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	}
>>  	if (!is_dm_key_reused) {
>>-		image->dm_crypt_keys_addr = 0;
>>  		r = build_keys_header();
>>-		if (r) {
>>-			pr_err("Failed to build dm-crypt keys header, ret=%d\n", r);
>>-			return r;
>>-		}
>>+		if (r)
>>+			goto out;
>>  	}
>>+	/*
>>+	 * keys_header will be copied to reserver memory later and then be
>>+	 * cleaned up at the end of kexec_file_load syscall
>>+	 */
>>  	kbuf.buffer = keys_header;
>>  	kbuf.bufsz = get_keys_header_size(key_count);
>>@@ -438,18 +454,33 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	r = kexec_add_buffer(&kbuf);
>>  	if (r) {
>>  		pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>-		kvfree((void *)kbuf.buffer);
>>-		return r;
>>+		goto out;
>>  	}
>>+
>>  	image->dm_crypt_keys_addr = kbuf.mem;
>>  	image->dm_crypt_keys_sz = kbuf.bufsz;
>>  	kexec_dprintk(
>>  		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>>  		kbuf.bufsz, kbuf.memsz);
>>+out:
>>+	is_dm_key_reused = false;
>>  	return r;
>>  }
>>+void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
>>+{
>>+	/*
>>+	 * For CPU/memory hot-plugging, the kdump image will be reloaded. Prevent
>>+	 * keys_header from being cleaned up during unloading when
>>+	 * is_dm_key_reused=true
>>+	 */
>>+	if (!is_dm_key_reused) {
>>+		kfree_sensitive(keys_header);
>>+		keys_header = NULL;
>
>Since crash_load_dm_crypt_keys() sets is_dm_key_reused = false, 
>keys_header will
>always be released here, right? Then why is the above free under an if 
>condition?

Thanks for raising the question! This is to prevent "kexec -u" from
cleaning up keys_headers because kexec_file_post_load_cleanup_dm_crypt
will also be called during "kexec -u". Without the if condition,
keys_headers will not be available during reloading.

>
>IIUC, for the case where CONFIG_CRASH_HOTPLUG is not enabled, this is 
>how key
>restore works:
>
>After loading the kdump kernel for the first time, the state of the 
>variables is:
>
>is_dm_key_reused = false
>keys_header = NULL
>
>For example, if 2 CPUs are hot-removed and kdump is reloaded twice:
>
>Then the sequence of operations needed to ensure the loaded keys can 
>be reused is:
>
>Udev rule triggered on the 1st CPU hotplug:
>echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>Restore the key header from the reserved area
>Reload the kdump service/kernel
>
>Udev rule triggered on the 2nd CPU hotplug:
>echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>Restore the key header from the reserved area
>Reload the kdump service/kernel
>
>What I don’t understand is the need to restore the key header from 
>crashkernel
>memory for every hotplug operation.

I think there is no easy way to tell if there is another hotplug and
considering hotplug is a rare event. So I guess it's OK to restore the
key headers for every hotplug operation.


-- 
Best regards,
Coiby


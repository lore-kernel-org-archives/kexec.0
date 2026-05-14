Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD71C44506
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yGROxrVsDdWg08azYq6DXXbTXSIemX2xa+e3jxJ14pI=; b=KTDd8+Ipxuqow5AYA6vUYxJO4o
	Z2PUe54rsGFtTBQYSJqSr7GpBPjJTvYXiCb7WJ5qaI8PyfSZjkrGsWH6RmNY6LZ6sPEGK9Ent5j/W
	mx0QgIhaYUcsOQ3HFz5WBONLQYDi2+iOsaZUDV7MbSaRc/K3RHthlI4uB89RTeCSXEseU8f1AW8eV
	4frNnr8Kd2owDAHMC2WW/K5k4v7lK9f7yMfWQZNi0xD4V+2cgbKm1DM3gznJ/pD1wrLU/W3YyINGm
	KeXwMgKnCYiuvyhXJOGfalLebFPHWZS0ZhIqEs+ackkMo22YeTOE1FNlUj+WlEk/UBVapHaB9t/IZ
	4fGOuRbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi62E-00000004NTr-37Pv;
	Fri, 10 Jul 2026 07:52:34 +0000
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi62C-00000004NSb-2D1d
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 07:52:33 +0000
Received: by mail-yx1-xb129.google.com with SMTP id 956f58d0204a3-6611669cd16so923149d50.0
        for <kexec@lists.infradead.org>; Fri, 10 Jul 2026 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669951; x=1784274751; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yGROxrVsDdWg08azYq6DXXbTXSIemX2xa+e3jxJ14pI=;
        b=d5YnGHR9QI5BRRZwH05K3lDfpHyxeIkEAn560qNaGWI81HnBcxSzm6wgqS7WgvNhkR
         R2eU7WufEucqIeRvyaobXVkj+fItjlrgubpM9IoK7Jv7xTB7RSavJcCYBJiXKQxlqPuM
         u6Gnhtlq71ZBuTV7JIKKIBHSsacudacKToAtWPgrg+O3/1CG46pF6fPPb6NjFWvI0mLY
         royOMp6pKwQeasf//ka0+bfJ4CJTxnZ+giCCJeVsoqvjx+tuyVtNUU1PI3VY5sSODOqO
         w4BFVM4exkPRSCGfJMzK7KqiNS/tj75FV6dg6eCCQ9WwIHnIDOlCGd1o6qsIQn/O/q6V
         FjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669951; x=1784274751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yGROxrVsDdWg08azYq6DXXbTXSIemX2xa+e3jxJ14pI=;
        b=YObZYCeyDRFYXPAZ/FOmzOXBiIGNJCjhx0073mrQwfvMrJ8068nJXH0puHdGLccIQy
         5dhte2fRpqTb2De2xkhr3Xlm9faR4Ntu/xmESnUG2yvfWcAQrIcvsM2Upx+1NwJjCENc
         Tkq90I191LQHwPyYNFkoyqARgYE1Z8EHj0nYvwNpBNtoJA6cWKadS5eMJTOMehzE0ay/
         lKCAIJM82qXuAvY49Qxcj7Qaf69FJLgCyBt3kyzzNsW37lnzW7TgPC9TFN6SfuTQxRbO
         ecJt+dymY8p7wMvc5ZrFUKkVFtC9EKvyB17pzoPoAuwFqV8SwQkDZoPC346d7gVa1VvS
         hZ1A==
X-Gm-Message-State: AOJu0YxqwP6ZDflNFGe5Pouau+219Vgd6KL9tc/2YzY/BKEvzvlteGHI
	3hNTx1+6KvWvLgzrvCL447/V9rGfO7xFL15h4l2kxsq4Zm7qABCG0tbY
X-Gm-Gg: AfdE7ck1r/0K/I1L+8nowJgQrUp81QNXxg1fkIHMoS2rfijWNrdmUuT3i1T2dgirSet
	r5l24vt4/k+Xo8C0qtBo1xbOyc7M6VemJ5ExV4To6di2yiLDFrPPAJn1wnOiA/myAyq9a6NGhLq
	2MuCFQN/2yW4IDUto2Za0eGZPtfmD6s4xEsY4JIfb8nJ32t0XlANXE4UTWbx5unEd1qC+Na3NkW
	r+NnnPL5Dmy2f+wcY/+x4EXijZVC+DRHtBrk2N+M1kXROL/rBKDw58iX0JWd4wjzI0Pb3lX6SeI
	D+eFyoWzu7bVj/9Axk9nMGZqU3vCljPSATFdREcoiFJdLv0wmZPxUUB1KxcRnOhs1VYLXq/fNhx
	/D1iQmaG5oFH3wm2/+fqEUMIU6UH89sZd3C4hwXMQTssXiIzYV3rQGDU6y3AkqKZuTQ/iq1V4dz
	wqXffZbRtEcuYUsrqOE7FeWLexOpMisqFjjQQtaJQw1g==
X-Received: by 2002:a05:690e:4105:b0:664:de27:9ddc with SMTP id 956f58d0204a3-6679f10be4dmr7511574d50.38.1783669951329;
        Fri, 10 Jul 2026 00:52:31 -0700 (PDT)
Received: from localhost (tpcc3a204.netvigator.com. [219.76.18.204])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667879ca0d7sm6156458d50.12.2026.07.10.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:30 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 14 May 2026 17:13:31 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Coiby Xu <coxu@redhat.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] crash_dump: Disallow
 configfs/crash_dm_crypt_key/reuse if CONFIG_CRASH_HOTPLUG enabled
Message-ID: <agWRYmkYVz1rhnr8@Rk>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
 <20260501234342.2518281-9-coiby.xu@gmail.com>
 <5af6fd0b-0eca-4089-b76c-45dcc4bf01ed@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5af6fd0b-0eca-4089-b76c-45dcc4bf01ed@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_005232_576783_D2B6776B 
X-CRM114-Status: GOOD (  17.44  )
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

On Wed, May 06, 2026 at 09:39:35PM +0530, Sourabh Jain wrote:
>
>
>On 02/05/26 05:13, Coiby Xu wrote:
>>If CONFIG_CRASH_HOTPLUG is enabled, dm-crypt keys saved to reserved
>>memory will be took care of automatically. Thus it doesn't make sense
>>to use configfs/crash_dm_crypt_key/reuse. Reserving
>>image->dm_crypt_keys_addr is also unnecessary. Currently x86_64 and
>>ppc64le have implemented CONFIG_CRASH_HOTPLUG feature.
>>
>>Also update the doc accordingly. Note two doc issues are fixed as well.
>>
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  Documentation/admin-guide/kdump/kdump.rst |  9 ++++++---
>>  kernel/crash_dump_dm_crypt.c              | 14 +++++++++++---
>>  2 files changed, 17 insertions(+), 6 deletions(-)
>>
>>diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>>index 7587caadbae1..73f2e9500c60 100644
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
>>@@ -593,7 +594,9 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>>      # To support CPU/memory hot-plugging, reuse keys already saved to reserved
>>      # memory
>>-    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
>>+    # Note if CONFIG_CRASH_HOTPLUG is enabled, this API is totally unnecessary
>>+    # thus will be disabled.
>>+    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>  2. Load the dump-capture kernel
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 36e51807d94f..7a7cae17f578 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -304,6 +304,11 @@ static ssize_t config_keys_reuse_store(struct config_item *item,
>>  	bool val;
>>  	int r;
>>+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
>>+		pr_info("CONFIG_CRASH_HOTPLUG already enabled");
>>+		return -EINVAL;
>>+	}
>>+
>
>Deciding this solely at compile time can create issues. For example, 
>the kernel
>may be built with CONFIG_CRASH_HOTPLUG, but if kexec tool loads the kdump
>kernel using the kexec_load system call without hotplug support, it can
>cause problems. It is rare but possible.
>
>How about this:
>
>#ifdef CONFIG_CRASH_HOTPLUG
>    if (kexec_crash_image->hotplug_support) {
>pr_info("crash image is loaded with hotplug support\n");return -EINVAL;
>    }
>#endif
>
>This code should be placed after validating kexec_crash_image.

I didn't know CONFIG_CRASH_HOTPLUG isn't sufficient to tell hotplug
support is available. Thanks for pointing it out! Although
crash_load_dm_crypt_keys is only called during kexec_file_load syscall,
it will be good to apply your suggestion!

>
>
>- Sourabh Jain
>
>>  	if (!kexec_crash_image || !kexec_crash_image->dm_crypt_keys_addr) {
>>  		pr_info("dm-crypt keys haven't be saved to crash-reserved memory\n");
>>  		return -EINVAL;
>>@@ -486,15 +491,18 @@ int crash_load_dm_crypt_keys(struct kimage *image)
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
>>  		keys_header = NULL;
>>  	}
>>+	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG))
>>+		image->dm_crypt_keys_addr = 0;

I'll also adjust this part accordingly. Thanks!

Sorry I didn't notice this email and the email for [PATCH v2 2/9] had never
been sent out because of a msmtpqueue lock issue until last week.

-- 
Best regards,
Coiby


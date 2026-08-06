Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B6D2C55838
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 05:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ce6Z7GRW5DQHMpISjPPGbM/uRj0Rdd5zOogRucAGwTA=; b=fpv5eDx7m9cysF7dlx7MLxG2Co
	hU2f5uspQJuIf7ACWYVmQUe+34jAL5RwUutgb2K6GuyLV5ddxqTSczklCQ/Xmx05MMZcCYgm9jhup
	g18GWIUO6fV+dmkbL8cFG3jIkkeRhWveOXog7hQ4Y2No7HS6+wV260Egfc1DdFdGx0e6AFcYchYMq
	JXmrjlkscPAiyzUijGz2YycB7CBYqf2K+0PchBNsRDZuXOHTlDk4NByVsQu19PRE2ELwh4CwiUvYR
	GkIlytBalXg6HQf30MhhbSsrqBEillY94q6+l+oWOL1lJqm9u6ZS5aQlON3Je8rcB0XOATD6ARY6l
	jox6w5kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrql5-00000004zc4-2aqW;
	Thu, 06 Aug 2026 05:35:11 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrql2-00000004zbf-2OkR
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 05:35:10 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1590513a91.1
        for <kexec@lists.infradead.org>; Wed, 05 Aug 2026 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785994507; x=1786599307; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ce6Z7GRW5DQHMpISjPPGbM/uRj0Rdd5zOogRucAGwTA=;
        b=mFxJbqWeglko+C4gqPL2qtolR8G11c3sBx2o8F/Bb9rAybmAPH1JAqk0YhH7FGU6pn
         mNx0ZDL7Ri8Ok7sK9EarOcJqGpbDsTxxkAPoeVzNUnk1Ic26BC3LeONR9qZogXkb4R+P
         PhahixHxYmaand8BS3cip/KcWOsz0Pu7s+1AIV+kCoVXLy7kwn84nauK3Lsg8QeXbz56
         eyb5O6clxYt3JkZmNRCUVPXr8e7vdpvUoAuGSNswisgptcLcw47c1A5IvE/DV32N1qfr
         /x2fVhKi2MWMFxkuYeVfMuL2BEcVq7Iff/C8CCtsCnzRqHej0Ba0Q44iDhYf7CXX9Dk7
         /PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785994507; x=1786599307;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ce6Z7GRW5DQHMpISjPPGbM/uRj0Rdd5zOogRucAGwTA=;
        b=Og4FMF6D3iChD2c2GdrrUhCrGXDSR4SPDzoyNEi9LQeWAZkyDWIA5D58jCU8MRfZhj
         rHofa7w/YeEDCcjzfBEBylrntjPlsJXJRYLJOnAc552VunSHm8A7AhCX+dcd54qy2lbn
         aWf8jtcoUACOekRsW2d8uPQDeoXjB+bTF0dnHbF/KehENrjZAoGiBCFwfN3VB07GFA9l
         tJdV77OpJPSYy2p/SCVPb/3MtP9q+aIgUCN8Vx8NNJmSGKQ7PRzDvoMBL1jE6va98hdu
         wjs5iwBRICNleU1MoEWtXEB3lp7Er+mj4rtFn1RQDcXaukRldMu1ID0EurcR7CMABv8M
         lFQg==
X-Gm-Message-State: AOJu0Yyf3FHlPqVAg02qRXL2HHI/1kkM0wB/PEIe3Ux185hxjH4EU5KJ
	b8Z9Y6zaJWcFgXyeNNsTDHyANhkrf5Yj+AYoRAcqRJcjvI04/cVPg5Q+
X-Gm-Gg: AR+sD13JLQkbMx8IBXAycJSm8gB+oVVS4UVxSkpQoq6qiiXTg1WVNEPdKOrZJr9x7R5
	BVEFDZY7vBijZo9xw/Pscy7WsG6l0YSl/9VJ8l9Rr2i98jzUN3mudxyMCiU/WU4xeukJPwZdf8C
	MOvHlqUcao2veZ9RIYaazmCFgiS7EW4SnMCf+PxYbeIFbrqdhHfMERxwATsjLNkslaRWLyo251N
	KeRVEuP70xyZrQK+uws46zxIBeW5t4uPtt2T/oAHqN92FBmHyExhXCzhVoFx/CYv4mIoP90jRvF
	85kqySdPALryE+5T85OQ/AyLr9Bc3xMHq1NtM4/jqlgvgTMFcETKFGzbhiZm7iAa6HPn4kqDmPU
	4XIxLqV/r48DBMM3pXD1m4ad72VsDXtAtrgz3VgOd2aJVW7Ht456lCaTAWcYJL0OCOUHZtqcN3u
	2SWkwDPYqcN1vJseyOt7UWdIKRi7/frtvg0nN9EPAU5SQ=
X-Received: by 2002:a17:90b:264c:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3903c59936cmr13203948a91.8.1785994507344;
        Wed, 05 Aug 2026 22:35:07 -0700 (PDT)
Received: from localhost ([2a09:bac5:55f3:25af::3c1:3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085e0eb56sm772257a91.10.2026.08.05.22.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:35:06 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 6 Aug 2026 13:33:03 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Coiby Xu <coxu@redhat.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] crash_dump: Disallow
 configfs/crash_dm_crypt_key/reuse if crash hotplug supported
Message-ID: <anQb8aIXKXYzKqAR@Rk>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-10-coiby.xu@gmail.com>
 <96a78b35-94f7-4b63-97d3-d0841681e2b4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <96a78b35-94f7-4b63-97d3-d0841681e2b4@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_223508_616881_903692F5 
X-CRM114-Status: GOOD (  16.73  )
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

On Wed, Aug 05, 2026 at 05:39:28PM +0530, Sourabh Jain wrote:
>
>
>On 29/07/26 09:06, Coiby Xu wrote:
>>If crash hotplug is supported, dm-crypt keys saved to reserved memory
>>will be taken care of automatically. Thus it doesn't make sense to use
>>configfs/crash_dm_crypt_key/reuse. Reserving image->dm_crypt_keys_addr
>>is also unnecessary. Currently x86_64 and ppc64le have implemented
>>crash hotplug feature.
>>
>>Also update the doc accordingly. Note two doc issues are fixed as well.
>>
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  Documentation/admin-guide/kdump/kdump.rst | 16 ++++++++++------
>>  kernel/crash_dump_dm_crypt.c              | 23 ++++++++++++++++++++---
>>  2 files changed, 30 insertions(+), 9 deletions(-)
>>
>>diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>>index 7587caadbae1..0bf2eb100a05 100644
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
>>@@ -591,15 +592,18 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>>      cat /sys/kernel/config/crash_dm_crypt_keys/count
>>      2
>>-    # To support CPU/memory hot-plugging, reuse keys already saved to reserved
>>-    # memory
>>-    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
>>-
>>  2. Load the dump-capture kernel
>>  3. After the dump-capture kerne get booted, restore the keys to user keyring
>>     echo yes > /sys/kernel/crash_dm_crypt_keys/restore
>>+For CPU/memory hot-plugging, you can reuse keys already saved to reserved
>>+memory before reloading the kdump image,
>>+    echo true > /sys/kernel/config/crash_dm_crypt_keys/reuse
>>+
>>+Note if crash hotplug is supported, this API is totally unnecessary thus will
>>+be disabled automatically.
>>+
>>  Contact
>>  =======
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index b5b78656cf06..46d6b31c3ca4 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -310,6 +310,15 @@ static ssize_t config_keys_reuse_show(struct config_item *item, char *page)
>>  	return sysfs_emit(page, "%d\n", is_dm_key_reused);
>>  }
>>+static bool crash_hotplug_support(struct kimage *image)
>>+{
>>+#ifdef CONFIG_CRASH_HOTPLUG
>>+	return image->hotplug_support;
>
>I don't think it is good idea to access kexec_crash_image properties without
>holding the kexec lock.

Thanks for raising the concern! Let's discuss this issue in [PATCH v3 03/10].

>
>Also, would it make sense to move this API somewhere else?

Can you help me understand why to move this API? Is it because using
ifdef in .c file is discouraged?

>
>- Sourabh Jain
[...]

-- 
Best regards,
Coiby


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49215C79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxNdm96bKIoWq/16pYhKcq8ECSivtcVW8xJ/F+AWQTI=; b=i53WJWg8PToJXwUW7K8YUKa7cJ
	YBCYcrcNh2x/yX/Q1J++CULLyVU9T9s5PrkB5izc3qL2SFX3H+0hL1sw5dMQhV4z0KtMk023DY0P0
	rvprGUm0scYZMyMqE6NXUzmR93k1IJP9AZq4nJaTopy8gx+DpFVAPCkmYOI1EVtyS0NirawLYl/51
	ExX9KCm4fgeEq7IPwHjnPK6Np+AYxYwX9dWDVTkG+l04CriP9aapMM/jCcFTRA8oszImpYpUWv8Da
	tvi3cPTHCHxwTcy3fzhYUhvju6j+e2aUjN2/3uwqrjuKwyRBJ6oieiLkx4WYOehDSGkm3EpjOFzyW
	ys8YdXQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IOF-0000000Bo4S-0AoM;
	Wed, 09 Sep 2026 13:31:03 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4IOA-0000000Bo1i-0IhR
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:31:01 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-c294183384fso35440666b.1
        for <kexec@lists.infradead.org>; Wed, 09 Sep 2026 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960656; x=1789565456; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dxNdm96bKIoWq/16pYhKcq8ECSivtcVW8xJ/F+AWQTI=;
        b=esbbHtkCPBNNN+kohxEd7GHx2LBzKcghOrTzJTXpO1ZAofepXcy9+K7IwLUunNBMB/
         MJB6BfKqQsuSGjGc1e4jpgJeYTBEjvUoqL2qbzcycJkyg4ddJlWb8AmVRjIpc9Q38Fy2
         XdoGxTWYoCKSl+AuLh2aT+kb8N/xYlsvO8XMWrN7+2uXbY82sYzTpU5qE/JAgbHNVoId
         woCe6MJ7z9cJurxa7DyyV1tuho1Ej4O+byUNEauOqD3WxeUeBYluE/CawoU45UgcIUiM
         S9GwlHiw68NNDp17bTdUVd/7pkbbKWCzyJq6ytXCmgVHE3bExqjeMVjghJbOa8NoUaNh
         buhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960656; x=1789565456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dxNdm96bKIoWq/16pYhKcq8ECSivtcVW8xJ/F+AWQTI=;
        b=ILe7poF+53L0wnJeArq2AEYiZVLQN8q7LvV730ytg64jXzDdj6MZhjf8aaWsWh36oQ
         pNiecdcQNA2s1zgVyYUh7gBdLSRVvhtBzJLzx8p+4welJ1csCOFgeOFvQSzj5XupEHn7
         LK2ppmR8rNMuonCBWsR765hhCiLJ5Nd5VLMD0BNIlOvgN9n/o8cmv52LntH/DaVUK5Ka
         8v7oTcRc5IaBQ+c8g/0ZjPluvIAPFTu2bj/du0c/UvPpUoD4njXUo3NyCrvDEFV7ba5L
         /sZrgpr1g1jhL/cjqeVPqHB+RSWSooxW+zsMb9FRE8sRFBXiySyXmz+F5cnV5+cHSqRl
         k3SQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5CQeUlyqJNWazw+7jpxaAe5BgSssTDMvCTWlk6aNIenUcHh2xd3qIA1KOd9GnUOeGPo36ag==@lists.infradead.org
X-Gm-Message-State: AFuF++ku05UGEyCI7JuLQ8HdApiVXwg3R0kUioUU2LMCBlaf5PJPQ6to
	GOYLX2QofpTpq0j7W/5hHSBg1Bhb6/yEsqfiSDYwWq2Pw8MCenoehEvL
X-Gm-Gg: AYBFou3Ko7p5h3YSRbnaAmmPUgVVjldVZHTkUA5bL3n2ZYkOgtQzSpmti5a/MHhWxTQ
	F46kA/SpjG+QGOaFoIBmuoobvOJyIOGwuX/00ONnMesIM3n1rDllJbLDyQeRSI/T/Br3FGKBCm0
	BGOXjIfc5aFDISouyCYbWLHulFzyNSsBGWtfkyu7vV4v177n+xD9W6mrmMJpFUtKOLKdYegaOWo
	Ae0jHNelR7mtcHcL2ggsyshxDGG9OXQEoqR081m/WpJ0QyCepzphsYIAYgarkzFdzF0gtTFYC+z
	moRJhEfaYusiCcXWvGZeh2eCJdbnhCUD31q6mbIIwgSHTUjlonjK/FBlaEcc1g8JHdq6hctEtvm
	jktm0zv/mjrR/XFW6uE5aXWYBAzDDJb87ANcOhQqpE9s1+xqAskuwolMBcvffX0nIeHe9raeKVI
	ViyjbF++LsHrrY799IqgCphLlTwGkOhqxoTus2A32jG3p37fZMffYYwvNJyD5U9Y7TCA==
X-Received: by 2002:a17:907:1c18:b0:c16:4e5:944a with SMTP id a640c23a62f3a-c260ca241admr1431773366b.21.1788960655994;
        Wed, 09 Sep 2026 06:30:55 -0700 (PDT)
Received: from localhost ([45.112.44.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26e956ea81sm568148766b.33.2026.09.09.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:30:55 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 9 Sep 2026 21:29:14 +0800
To: sashiko-reviews@lists.linux.dev
Cc: Baoquan He <baoquan.he@linux.dev>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Dave Young <ruirui.yang@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, open list <linux-kernel@vger.kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org
Subject: Re: [PATCH v5 3/9] crash_dump: Disallow writing to dm-crypt configfs
 during kexec_file_load syscall
Message-ID: <aqFe50U0bp4dguMT@Rk>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-4-coiby.xu@gmail.com>
 <20260909004722.649E21F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909004722.649E21F00A3A@smtp.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_063059_245761_B9CE5A04 
X-CRM114-Status: GOOD (  16.04  )
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

On Wed, Sep 09, 2026 at 12:47:21AM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
>New issues:
>- [High] Severe locking imbalance in `crash_load_dm_crypt_keys()` leads to a leaked mutex on the error path and unlocking an unacquired mutex on the success path.

Thanks for catching this issue! I'll address it in new version.

>
>Pre-existing issues:
>- [High] Premature and unconditional reset of `is_dm_key_reused` to false breaks ARM64/LoongArch kexec load retries and defeats intended cleanup logic.
>--
>
>commit a9405cf8948ba39213612c61a1f3b10b23f437e4
>Author: Coiby Xu <coiby.xu@gmail.com>
>
>crash_dump: Disallow writing to dm-crypt configfs during kexec_file_load syscall
>
>This commit prevents concurrent writes to the configfs group during the
>kexec_file_load syscall by utilizing config_keys_subsys.su_mutex. It aims to
>avoid buffer overflows, stale keys, or memory leaks caused by changes to
>dm-crypt keys during iteration.
>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index 3a416933979f8..580534d43b66e 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>
>[ ... ]
>
>> @@ -478,6 +490,9 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  		"Loaded dm crypt keys to kexec_buffer bufsz=0x%lx memsz=0x%lx\n",
>>  		kbuf.bufsz, kbuf.memsz);
>>
>> +unlock:
>> +	mutex_unlock(&config_keys_subsys.su_mutex);
>> +
>
>[Severity: High]
>Looking at crash_load_dm_crypt_keys(), if kexec_add_buffer() fails earlier
>in the function, it jumps to the out label, bypassing this unlock label.
>Does this leak the config_keys_subsys.su_mutex if the lock was acquired?
>
>Also, on the success path, mutex_unlock() is executed unconditionally. If
>is_dm_key_reused was true at the top of the function, the mutex was never
>acquired. Can this cause a kernel panic or corruption by unlocking an
>unacquired mutex?
>
>>  out:
>> -	return r;
>> +	is_dm_key_reused = false;
>> +	return r;
>>  }
>
>[Severity: High]
>This is a pre-existing issue, but since the error and success paths
>unconditionally reset is_dm_key_reused to false here, does this break
>architectures like ARM64 that might retry segment loading?
>
>If load_other_segments() retries the load sequence, the second pass
>through crash_load_dm_crypt_keys() will see is_dm_key_reused as false,
>find zero keys, and silently load nothing into the kdump kernel.
>
>Additionally, crash_dm_crypt_cleanup() checks !is_dm_key_reused to determine
>whether it should free keys_header. Since the flag is unconditionally cleared
>here first, does this defeat the intended cleanup protection logic?
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260909003657.1570544-1-coiby.xu@gmail.com?part=3

-- 
Best regards,
Coiby


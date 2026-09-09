Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95223C79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IF7gGSnNHvzeRxMeQJEXPfnNoiV1RgOi8xQaXNAluos=; b=zCHSBvbboy4e5nhcYQmNqSzizN
	Mpg92DosYHPmEhcdiM1sYUxUUdm6BASDtQ2TjTu59uxGFnx2bQ1T+nqLFQ2XbAqoe9WbCxRXKfNNY
	QMBWRY/THs12UZbZj2VPtr76I1kU2PDR3V7ZqOsQ0oYnHaJspjD+UaLAxs/JDeQJc7znEXmUcOutM
	PBehcAqOzt7GpxoQ3dQ2NpQ8uZJt/qS5s3voKcu0IoAgK4/ozY9wrJJPOBvsq0beSeS7KMZ0KyM40
	pELNpP1xMKCURZFeS5BZrhaiMiX6MzEhr5ljCZruRWAFtQGR6FnV4SDrlsXrQIZ5Fuk1Okd0F3Qe2
	YVjJ2a9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ISO-0000000BooK-25BS;
	Wed, 09 Sep 2026 13:35:20 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4ISL-0000000Bomj-2CeB
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 13:35:19 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-86c0e4dd49cso75614337b3.3
        for <kexec@lists.infradead.org>; Wed, 09 Sep 2026 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960916; x=1789565716; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IF7gGSnNHvzeRxMeQJEXPfnNoiV1RgOi8xQaXNAluos=;
        b=LstI6DJvNaCspImSb/CHQJWSVOlh3BXKFA2HXXQQuHply0IUjQmPlS5wL52Q8u14xv
         ncaMdvihtuLK20jUjP33WgzpDAB2j1x3iMjrL26e+m9W/m8h2vU7xUJz6QwQ24WrL8ow
         Nu6vnVJtzbev+lRXtkbukd1DatAhvwyXzyLeNQm8CCydI3e/s+Tbin1mVKfc2hJy9Lmh
         MxQaLdwCQO+qGRe5i5hw7Zfsns1B8ppoPj8RAnTBJ6yt3tMr4t5pm+hYgW7wGuJlK8tE
         B4JBpV5LmmyKdebgqeNM/cUpyPvbee0InD1ZDzk6efPaCSlksSjvehDRtXM3xNcD9DuO
         ngEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960916; x=1789565716;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IF7gGSnNHvzeRxMeQJEXPfnNoiV1RgOi8xQaXNAluos=;
        b=mwT6LJJF6LW7u2t0/1v68f3Ajh96uaxWCBbT6OW54IqBMuf9/wEClHRhrczVkkKEme
         tX79Y4IXbPPZ3Fsvm1AYnVsyQ1HcQkOvb3YQbuiqCjUIMXzhycPfYxsxxx+4ZBGsgxzf
         2GoTKWnW54UGxVcWqSo5w4IeyTVUfy32zh5tvjpqOUiO2c6eNfcTDgR3WOY9sZZKt5jF
         D2oiE//6QmBko5m2wC2OM5vmsehJ8Rsyc1N0FEI0x2Vz6lqyEF7mfxLDl+MteuRKzXKM
         3Q8qxMx/uNasvUFwxcnS8PegvBgIUmpCxvy/w0P1babl4SQiNLxm2rQAseUFWplZD19H
         fZmQ==
X-Gm-Message-State: AFuF++kNwCKyQsonvBs/bN7JvRntTgKRzVXJqKe0ZlqZyc6/qq27YFB+
	ud5DSfzUIbFRhPiNAo7eTKyvYZPk6sEPZA+ERL2GgixWFLSfnGfDCs+U
X-Gm-Gg: AYBFou2ZDzcUZxLk8yrRr6HUS1kB3WOIOHYMUkfnsloEXlAVijesh7AWo7R2i+2zF0V
	jmBJg/64EHP+b0Ty7D7XsnFgXaca49Yx+AkzmAUWxloNcucR9ZYue6fUdQ7L1ywHKInj6Y/J9JJ
	N5amIye8JH1qyajP4teey302uLOTqz5c5edoPyIYG5P0/jxmEaYesDC9JDcoyOsDpHDBFXhvs+Q
	Qk9rLP6WyaZnxXtbmdMRlAOmkv469DbdIEAyfGDRwsAgxkTK2Rpqwp261Gy+l6Ale8OKJJCzZDD
	npWgBy2iffuRT4cuB6eYOyEc1XbAb0fW4yxUjZeXMUulT/LwyGai5EDYyOoOakdBAc/LyHbJ9nT
	CC+d5RP31togTaFvmfafhzWgHf2z4D/kTMSinV0NSmKQTNeQTRxsZ6cd2xbvGVJ+joMiJKnzMI1
	m5+sDuokDCVupJ+Xgbdz+Y69dFZ4qk5cv50vEfWTtnT2/s5QeWO9Ttnol2vbvkijeQcw==
X-Received: by 2002:a05:690c:ed6:b0:816:b469:cd12 with SMTP id 00721157ae682-87122f5564bmr131074277b3.8.1788960916082;
        Wed, 09 Sep 2026 06:35:16 -0700 (PDT)
Received: from localhost ([45.112.44.120])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-881575de059sm2427287b3.18.2026.09.09.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:35:15 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Wed, 9 Sep 2026 21:33:02 +0800
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <baoquan.he@linux.dev>, 
	Dave Young <ruirui.yang@linux.dev>, Pratyush Yadav <pratyush@kernel.org>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 8/9] crash_dump: Disallow
 configfs/crash_dm_crypt_key/reuse if crash hotplug supported
Message-ID: <aqFfvCpcrbN-8qcs@Rk>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-9-coiby.xu@gmail.com>
 <c0d5f2e9-9bd1-46fb-8111-d3af6b6c9e66@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c0d5f2e9-9bd1-46fb-8111-d3af6b6c9e66@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_063517_590546_36A928C4 
X-CRM114-Status: GOOD (  18.25  )
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

On Tue, Sep 08, 2026 at 10:46:03PM -0700, Randy Dunlap wrote:
>
>
>On 9/8/26 5:36 PM, Coiby Xu wrote:
>> If crash hotplug is supported, dm-crypt keys saved to reserved memory
>> will be taken care of automatically. Thus it doesn't make sense to use
>> configfs/crash_dm_crypt_key/reuse. Not reserving
>> image->dm_crypt_keys_addr makes it implicitly to disallow using this
>> API. Currently x86_64 and ppc64le have implemented crash hotplug
>> feature.
>>
>> Also update the doc accordingly. Note two doc issues are fixed as well.
>>
>> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>> ---
>>  Documentation/admin-guide/kdump/kdump.rst | 16 ++++++++++------
>>  kernel/crash_dump_dm_crypt.c              | 12 ++++++++----
>>  2 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 7587caadbae1..0bf2eb100a05 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -577,9 +577,10 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>>
>>  1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
>>      # Add key #1
>> -    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
>> +    VOL1_UUID=7d26b7b4-e342-4d2d-b660-7426b0996720
>> +    mkdir /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID
>>      # Add key #1's description
>> -    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
>> +    echo cryptsetup:$VOL1_UUID > /sys/kernel/config/crash_dm_crypt_keys/$VOL1_UUID/description
>>
>>      # how many keys do we have now?
>>      cat /sys/kernel/config/crash_dm_crypt_keys/count
>> @@ -591,15 +592,18 @@ with /sys/kernel/config/crash_dm_crypt_keys for setup,
>>      cat /sys/kernel/config/crash_dm_crypt_keys/count
>>      2
>>
>> -    # To support CPU/memory hot-plugging, reuse keys already saved to reserved
>> -    # memory
>> -    echo true > /sys/kernel/config/crash_dm_crypt_key/reuse
>> -
>>  2. Load the dump-capture kernel
>>
>>  3. After the dump-capture kerne get booted, restore the keys to user keyring
>
>                             kernel is booted,

Thanks for catching this typo! I'll apply your suggestion to next
version!

[...]

-- 
Best regards,
Coiby


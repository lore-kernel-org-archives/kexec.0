Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50755C0219B
	for <kexec@archiver.kernel.org>; Wed, 12 Feb 2025 00:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eua/hApNBjEqd+RMENEi87Sr+Mh/D0hB/oWXPr8GJgk=; b=m+ZEDGd09irEZwq5WpT3fcTXMA
	NYlTbiIHjVEatB5HsO30ZzR/s31EPzBa3gMJrsONhf3Gq0eZE31GzEFJxtWfE6VwrNmkc5VzoRpvy
	O3BogHe0iDzsBuzXw2ZSfPW5ganySILrz8scIiK7CkJI/46gbs7GePUbjnlfFWfnR4ckdPUMNYLRZ
	99Cp83hJK0Hqloumrr4moWNegktBVrFQ9KGe8usWn3vwMGq9TqjAx/ZR4Qwmtpy53ELPcnBlQ/34M
	6Ia8LKddDA5OPQ1Hi2VM5DpnW1Tj7oUyVdQ9MMa9ikbHcpaky30vy7/YjDeeutCxb5/k6vgdHTHmQ
	3/H659EQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ti0u3-00000005kDQ-3m4g;
	Wed, 12 Feb 2025 00:46:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ti0t4-00000005k4P-492o
	for kexec@lists.infradead.org;
	Wed, 12 Feb 2025 00:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739321157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eua/hApNBjEqd+RMENEi87Sr+Mh/D0hB/oWXPr8GJgk=;
	b=F7Q+1cUwtjFx88vB6UAeWKVYkzqr3SgSGz1YoDgIvuLffSVa/NVD4YmmBSWiJnFkaPQ5tc
	IXrlfpAxgDR3k8kdl6/eMgtSyJUHmncLDbDs5NK6AbGUMo7K0OdRVpT7K1dpblB54IwqVW
	ZccO3SbKQr5Xw3ltU07ttRfJCGXT9ac=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-qx-rW1KdOnqjeMh0nhnXOQ-1; Tue, 11 Feb 2025 19:45:56 -0500
X-MC-Unique: qx-rW1KdOnqjeMh0nhnXOQ-1
X-Mimecast-MFC-AGG-ID: qx-rW1KdOnqjeMh0nhnXOQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fa6409c0baso9077973a91.1
        for <kexec@lists.infradead.org>; Tue, 11 Feb 2025 16:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739321155; x=1739925955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eua/hApNBjEqd+RMENEi87Sr+Mh/D0hB/oWXPr8GJgk=;
        b=pzdAv0iholqQHpQL+x2yJeuWNN9QB7VsmOeOOzevKQU34NmU3eZnatwPRDhnx9EnqF
         48QpM98RksEmXS8F9aYGZ1nXoBE1GqXfIDw8umH0MVfOv2Mt01VdHd9SLIjVaeQ+H9fX
         eLJK+N+evcEbUykZ1MBsL1CFiasrgoDGlVZvU+Gzi9RmzpmBADALq616qsB6p3Oq7lb/
         XTFpWUczt0aBe8+SWVHrTYhKjwe+yqo2pLsfta4FZQ+P/WJ+QcYUAW50CzuqDPtIxMV6
         WmVZ8lsB8SuUpmNzCFOmDf0Uf6+vqYrCINmsJMh+w1/xGatqJlzubF++uauw3OYKK+fd
         ykbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi4ycQoJKb0xE3gwmnSp6sT2/SC4dGDUcFf0lm4UhV21T+te3PCViP9t26wiVX1heFq3qZ4Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwY1Wd7ieEZARJ+xmB9RbQ7igjAfXIdQwmQQyrxMwpwoIyDmHY
	lk2MqCUv1udw2QS/wdJ22GwQtg7FiHUTzM0DaByOOs41k32bYyiymyeRglzL8ROIfeq0MAqwkkw
	DGKWePcDVETpE/hP4zDAj1AN9Q/etWtgaJv6sfP1NHAKKJmX1Y5+lm0sZvQ==
X-Gm-Gg: ASbGnctTNXH7UaRXP2R0OKEXD54cOBEci3SqDMM7Qqdf4y04vTtJwsFCcEuV16ig6E/
	Y7sGGBoz30AyPauFbS876bZJ0L4ySPUuNqKuO+70pY5CdGnDDA35sVDeQwJiZPJ9n5M+ks5CTs7
	EqEaqZpTN1cQXktba9ZdGecG9EKqBecK89x5wLlY1voRVR8PAKh6/m4DfGwzFhb2zWOhAqdzYZC
	+EL5W3adfZwxhVi0JBOPTl95cC4GaAH6Q2Am6CcnuwB+6iQUoOOrKa+oprzYW2GORtxW0VN
X-Received: by 2002:a17:90b:544f:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2fbf5c0f653mr2103367a91.14.1739321155473;
        Tue, 11 Feb 2025 16:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6IIMJ+3Hvx8Id8rTg0AZzH7XEwW28qToMrNpGHIdmEypuProqH9OrCUS32B2pihOhAwnVBg==
X-Received: by 2002:a17:90b:544f:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2fbf5c0f653mr2103334a91.14.1739321155171;
        Tue, 11 Feb 2025 16:45:55 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9908960sm202009a91.41.2025.02.11.16.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:45:54 -0800 (PST)
Date: Wed, 12 Feb 2025 08:43:21 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <uo2q3jxzcu3d4noiznxpw5woaclikmywyzi7yjlnpef3fdjt4e@idvs7tiv3znb>
References: <20250207080818.129165-1-coxu@redhat.com>
 <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z6sljm1lurDKPCvj@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M65nxrZa7lMQ2hmrXq2_15D0b8q8kQR-Z7DEC3WrXSw_1739321155
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250211_164559_097257_F92E4E48 
X-CRM114-Status: GOOD (  26.16  )
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

On Tue, Feb 11, 2025 at 06:25:18PM +0800, Baoquan He wrote:
>On 02/07/25 at 04:08pm, Coiby Xu wrote:
>> LUKS is the standard for Linux disk encryption, widely adopted by users,
>> and in some cases, such as Confidential VMs, it is a requirement. With
>> kdump enabled, when the first kernel crashes, the system can boot into
>> the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore)
>> to a specified target. However, there are two challenges when dumping
>> vmcore to a LUKS-encrypted device:
>>
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes; For cloud confidential VMs, depending on the policy the
>>    kdump kernel may not be able to unseal the keys with TPM and the
>>    console virtual keyboard is untrusted.
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump. Take Fedora example, by default, only 256M is reserved for
>>    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>>    to be reserved for kdump. Note if the memory reserved for kdump can't
>>    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>>    1st kernel.
>>
>> Besides users (at least for Fedora) usually expect kdump to work out of
>> the box i.e. no manual password input or custom crashkernel value is
>> needed. And it doesn't make sense to derivate the keys again in kdump
>> kernel which seems to be redundant work.
>>
>> This patch set addresses the above issues by making the LUKS volume keys
>> persistent for kdump kernel with the help of cryptsetup's new APIs
>> (--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
>> the kdump copies of LUKS volume keys,
>>
>>  1. After the 1st kernel loads the initramfs during boot, systemd
>>     use an user-input passphrase to de-crypt the LUKS volume keys
>>     or TPM-sealed key and then save the volume keys to specified keyring
>>     (using the --link-vk-to-keyring API) and the key will expire within
>>     specified time.
>>
>>  2. A user space tool (kdump initramfs loader like kdump-utils) create
>>     key items inside /sys/kernel/config/crash_dm_crypt_keys to inform
>>     the 1st kernel which keys are needed.
>>
>>  3. When the kdump initramfs is loaded by the kexec_file_load
>>     syscall, the 1st kernel will iterate created key items, save the
>>     keys to kdump reserved memory.
>>
>>  4. When the 1st kernel crashes and the kdump initramfs is booted, the
>>     kdump initramfs asks the kdump kernel to create a user key using the
>>     key stored in kdump reserved memory by writing yes to
>>     /sys/kernel/crash_dm_crypt_keys/restore. Then the LUKS encrypted
>>     device is unlocked with libcryptsetup's --volume-key-keyring API.
>>
>>  5. The system gets rebooted to the 1st kernel after dumping vmcore to
>>     the LUKS encrypted device is finished
>>
>> After libcryptsetup saving the LUKS volume keys to specified keyring,
>> whoever takes this should be responsible for the safety of these copies
>> of keys. The keys will be saved in the memory area exclusively reserved
>> for kdump where even the 1st kernel has no direct access. And further
>> more, two additional protections are added,
>>  - save the copy randomly in kdump reserved memory as suggested by Jan
>>  - clear the _PAGE_PRESENT flag of the page that stores the copy as
>>    suggested by Pingfan
>>
>> This patch set only supports x86. There will be patches to support other
>> architectures once this patch set gets merged.
>
>This v8 looks good to me, thanks for the great effort, Coiby.
>
>Acked-by: Baoquan He <bhe@redhat.com>

Great, thanks for reviewing and acknowledging the patch set!

-- 
Best regards,
Coiby



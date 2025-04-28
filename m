Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7AAC369D5
	for <kexec@archiver.kernel.org>; Mon, 28 Apr 2025 23:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nC8wEoAvBMDnCVdB9E0Cl9u64xxkb600baj4x1WNt20=; b=nxP73q8OhMqUOagGlCfqkxkkm9
	TNHMaLiyZAvX4uIWCBm1oXEKd4TZu3c4pq/VR3ovVRe6B5u7swDNBIi1lhWH+kniH3dzqPAD4+8pT
	d2ev27FVMSPkQuEnwlQ13zWeRmPsmMbOhXtjCFQmvoxJMzAWZ08JDWOWiSdZvLvNrfhOiIEa5bpyl
	DWKzA1vZghw5NNvkg46H04Lw/0u6AAiyn0KzotFOlSY89/wu/M9NdvJW71ZZ/Cfj8yAzCMPCHEMEQ
	yzSpqsyc8PqKQ5HBxasFCqCiiSGDB84n1P4vbTtmCU6Xx/vHAWQkVzq1m2Sm7pDhf3wvW99bP+Mf8
	wWGJpefQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9YLr-00000007qi6-39ey;
	Mon, 28 Apr 2025 23:57:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9YL6-00000007qdU-1XbO
	for kexec@lists.infradead.org;
	Mon, 28 Apr 2025 23:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745884602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nC8wEoAvBMDnCVdB9E0Cl9u64xxkb600baj4x1WNt20=;
	b=HJnPqGn41eU03CRJVaJGtifsSAo3mql/VvIcnUtjUl7oepZdTbn8yGQ/+FxXUSYlzYE5RK
	++0a4g9C8ircu9jZ5Z/HTUlfAoXCAvcth/1paCs5E8gOpOw5iWY4gPfYFQskurHQBHKMBz
	ia4dN+u2DYTxLzig4usqZadZP6oeTEQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-nG97oS4cPfqQ8nUIRyFlIg-1; Mon, 28 Apr 2025 19:56:38 -0400
X-MC-Unique: nG97oS4cPfqQ8nUIRyFlIg-1
X-Mimecast-MFC-AGG-ID: nG97oS4cPfqQ8nUIRyFlIg_1745884598
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b16f5365310so2747062a12.1
        for <kexec@lists.infradead.org>; Mon, 28 Apr 2025 16:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745884597; x=1746489397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nC8wEoAvBMDnCVdB9E0Cl9u64xxkb600baj4x1WNt20=;
        b=Wr/gGUHuP+CsUPR5e9VNpqknS5jGg51mxCFBN8g2HdcJO2Mv8gm/GBABKoMEVj9NA4
         D/tsxbji4F9PGc4iE9snrJmMVtwTnNOW6fmLyAIjiPdte+nm2oTXN9F59xdEtTbY9Y+i
         EL+mvxt83gIyWTiHVEOEC+NwhRjyQouPyb56KJojJhMTWLi+LE3CLdDi6285DuHoPQmh
         vv61iyiNgSpBq/TD6+o4TSzMhBoJo7NMtCJReoLWoOoe70Noyu5pS+/8ouzXsfBK2u9O
         qIhb7UoPMSCMEuXL5+lly4YRkFphBaa1U+Jbz6CgO4T/OulBeMoRhEpQTOEPO5ollpLX
         X6Tw==
X-Gm-Message-State: AOJu0Yx9fu68YxndXf/W3ekcUz5tmPJWsPZlZLbhdahTSh+LbSOPiERV
	aldUzZAq1q7gYqJ/kFAkZOgPSnt2nm7U+/6woN3sKiRMY0LPgzMKBGZoOHNysJiijc/xG8R9IJD
	BSHdOTaXjqycGd2izerTGX1DBl7cS/A6JGLUz/w8jIfDlD3hTrOrQTqyaHg==
X-Gm-Gg: ASbGnctyrh7gCrfPlo+fQtWBeYkUcCHhXwSuk52/s3o1BNq3TWoL4y1cEhDEyG3lmtF
	KHfnlaPNILiExkbncE534uEENpqXlWw492YTnm1o0m8ydBvrSJJ3FdG7lUGXRXY/BUEdHXo6GvW
	jUHLYmsEqv1oPCBFnLXJbvv0+wsu5DckLJD0X8Q85sBQrGVA15IAeJ9t9NEV/Ph8HQCwygAkklG
	Z86D7phvNeu+M+Km6UagVDSLsjwD7I3d+nTP4/CB1RKE9yx9XZWgiu3sBm18KpOFSFAuu6mRJIx
	cG0=
X-Received: by 2002:a17:90b:3904:b0:2fe:afbc:cd53 with SMTP id 98e67ed59e1d1-30a0139955cmr15666250a91.28.1745884597571;
        Mon, 28 Apr 2025 16:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXYHJu32UCMU9q3ksTNNOz1eBFKdMwctBBfhis727qqAv334CgB0oWraCRM9zqjQSJxvBi+A==
X-Received: by 2002:a17:90b:3904:b0:2fe:afbc:cd53 with SMTP id 98e67ed59e1d1-30a0139955cmr15666225a91.28.1745884597197;
        Mon, 28 Apr 2025 16:56:37 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef099963sm9718949a91.29.2025.04.28.16.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 16:56:36 -0700 (PDT)
Date: Tue, 29 Apr 2025 07:56:13 +0800
From: Coiby Xu <coxu@redhat.com>
To: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <sruvxazchu4tnawh7dlz73x5x3iwaqmi5ii33onguu5ozfv4lz@ebecdymmljwa>
References: <20250207080818.129165-1-coxu@redhat.com>
 <kofi6m743pg6hrahjx3vj7efairnpiq5pqmgql2cwg6lnz2cmw@ntdymi2egzro>
 <ywhl4n5d4oa44a2nzu26sjdgs6k5xwdwidtmdfsik6v533rvuz@bnu3azjvzioa>
 <2eil2djxcxf2fbpjsipbghpo5hldufnyi76ai4in2n6dq7yh7u@knunrool6qh7>
MIME-Version: 1.0
In-Reply-To: <2eil2djxcxf2fbpjsipbghpo5hldufnyi76ai4in2n6dq7yh7u@knunrool6qh7>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3faul8BGDbVD9V9sgSK23O-HRSHtB_yMV_7wKnBKQPo_1745884598
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_165644_480268_622FF6B4 
X-CRM114-Status: GOOD (  33.11  )
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

On Mon, Apr 28, 2025 at 08:40:44PM +0200, Arnaud Lefebvre wrote:
>On Mon, Apr 28, 2025 at 05:02:23PM +0800, Coiby Xu wrote:
>>On Thu, Apr 24, 2025 at 02:08:55AM +0200, Arnaud Lefebvre wrote:
>>>On Fri, Feb 07, 2025 at 04:08:08PM +0800, Coiby Xu wrote:
>>>>LUKS is the standard for Linux disk encryption, widely adopted by users,
>>>>and in some cases, such as Confidential VMs, it is a requirement. With
>>>>kdump enabled, when the first kernel crashes, the system can boot into
>>>>the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore)
>>>>to a specified target. However, there are two challenges when dumping
>>>>vmcore to a LUKS-encrypted device:
>>>>
>>>>- Kdump kernel may not be able to decrypt the LUKS partition. For some
>>>>machines, a system administrator may not have a chance to enter the
>>>>password to decrypt the device in kdump initramfs after the 1st kernel
>>>>crashes; For cloud confidential VMs, depending on the policy the
>>>>kdump kernel may not be able to unseal the keys with TPM and the
>>>>console virtual keyboard is untrusted.
>>>>
>>>>- LUKS2 by default use the memory-hard Argon2 key derivation function
>>>>which is quite memory-consuming compared to the limited memory reserved
>>>>for kdump. Take Fedora example, by default, only 256M is reserved for
>>>>systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>>>>to be reserved for kdump. Note if the memory reserved for kdump can't
>>>>be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>>>>1st kernel.
>>>>
>>>>Besides users (at least for Fedora) usually expect kdump to work out of
>>>>the box i.e. no manual password input or custom crashkernel value is
>>>>needed. And it doesn't make sense to derivate the keys again in kdump
>>>>kernel which seems to be redundant work.
>>>>
>>>>This patch set addresses the above issues by making the LUKS volume keys
>>>>persistent for kdump kernel with the help of cryptsetup's new APIs
>>>>(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
>>>>the kdump copies of LUKS volume keys,
>>>>
>>>>1. After the 1st kernel loads the initramfs during boot, systemd
>>>> use an user-input passphrase to de-crypt the LUKS volume keys
>>>> or TPM-sealed key and then save the volume keys to specified keyring
>>>> (using the --link-vk-to-keyring API) and the key will expire within
>>>> specified time.
>>>>
>>>>2. A user space tool (kdump initramfs loader like kdump-utils) create
>>>> key items inside /sys/kernel/config/crash_dm_crypt_keys to inform
>>>> the 1st kernel which keys are needed.
>>>>
>>>>3. When the kdump initramfs is loaded by the kexec_file_load
>>>> syscall, the 1st kernel will iterate created key items, save the
>>>> keys to kdump reserved memory.
>>>>
>>>>4. When the 1st kernel crashes and the kdump initramfs is booted, the
>>>> kdump initramfs asks the kdump kernel to create a user key using the
>>>> key stored in kdump reserved memory by writing yes to
>>>> /sys/kernel/crash_dm_crypt_keys/restore. Then the LUKS encrypted
>>>> device is unlocked with libcryptsetup's --volume-key-keyring API.
>>>>
>>>>5. The system gets rebooted to the 1st kernel after dumping vmcore to
>>>> the LUKS encrypted device is finished
>>>>
>>>>After libcryptsetup saving the LUKS volume keys to specified keyring,
>>>>whoever takes this should be responsible for the safety of these copies
>>>>of keys. The keys will be saved in the memory area exclusively reserved
>>>>for kdump where even the 1st kernel has no direct access. And further
>>>>more, two additional protections are added,
>>>>- save the copy randomly in kdump reserved memory as suggested by Jan
>>>>- clear the _PAGE_PRESENT flag of the page that stores the copy as
>>>>suggested by Pingfan
>>>>
>>>>This patch set only supports x86. There will be patches to support other
>>>>architectures once this patch set gets merged.
>>>>
>>>
>>>I'm not sure what's the problem here but I can reliably trigger a kernel
>>>panic on a qemu VM + custom kernel (compiled from
>>>bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b + your patches).
>>
>>Hi Arnaud,
>>
>>Thanks for testing the patches, finding this issue and also sharing the
>>details to reproduce it!
>>
>
>Hello,
>
>You're welcome, thanks to you for this patch series!
>
>>>
>>>When I configure the crash configfs and call kexec in a systemd service
>>>using ExecStart=, the panic occurs when I start the service:
>>>
>>>~ # cat /etc/systemd/system/my-kexec.service
>>>[Unit]
>>>Description=kexec loading for the crash capture kernel
>>>
>>>[Service]
>>>Type=oneshot
>>>ExecStart=/usr/bin/mkdir /sys/kernel/config/crash_dm_crypt_keys/mykey
>>>ExecStart=/usr/bin/echo cryptsetup:mykey >/sys/kernel/config/crash_dm_crypt_keys/mykey/description
>>>ExecStart=/usr/host/bin/kexec --debug --load-panic /linux-hv --initrd /crash-initrd
>>>KeyringMode=shared
>>
>>Can you try putting the above commands into a script e.g.
>>/usr/local/bin/my-kexec.sh and then using
>>ExecStart=/usr/local/bin/my-kexec.sh
>>so I can be more sure that I've reproduced your issue?
>>
>
>I believe that's what I wrote at the end of my previous message
>(see below the panic trace). It works fine using a script like that.
>
>Did you miss it or is there a difference with what you're asking?

Oh, I missed it, thanks for the reminder! Now I'm sure I have reproduced
the issue and understood how the problem happens.  This is because
systemd will ignore the bash redirection ">" as it doesn't invoke bash
to run ExecStart. So you will see systemd logs as follows, 
   warning: ignoring excess arguments, starting with with ‘>/sys/kernel/config/...

So a key configfs item is created but the key description fails to be
set. Unfortunately, the kernel doesn't check if the key description is
null and crashes when trying to copy it. I'll send a new version of
patches to resolve this issue, thanks!

>
> [...]
>>>Kernel panic - not syncing: Fatal exception
>>>Kernel Offset: disabled
>>>
>>>
>>>Calling a script that does the same thing works fine and loads the keys
>>>correctly:
>>>
>>>[Service]
>>>ExecStart=/root/kexec.sh
>>>
>>>~ # cat /root/kexec.sh
>>>#!/bin/bash
>>>
>>>mkdir /sys/kernel/config/crash_dm_crypt_keys/mykey
>>>echo cryptsetup:mykey > /sys/kernel/config/crash_dm_crypt_keys/mykey/description
>>>/usr/host/bin/kexec --debug --load-panic /linux-hv --initrd /crash-initrd
>>>
>>>If that's any help, my crypttab:
>>>
>>>~ # cat /etc/crypttab
>>>root UUID=8001fca4-2e54-48e9-9235-031c19fc6e36 none luks,link-volume-key=@u::%logon:cryptsetup:mykey
>>>
>>>If you can't reproduce, I can help track this. Just let me know if you need
>>>any help.
>>>
>>
>>-- 
>>Best regards,
>>Coiby
>>
>

-- 
Best regards,
Coiby



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593F0C47422
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UaQ6JFeSrLJ24Kqyy7Wzjrrnb9MTGR3kucJu/7ZiXU=; b=YfG1hI85odQ7jgyo+6Wik1gQFS
	0L5+En9kY/YXlG/3ezkCxgRuM0uGBjC9mAQCl69G+Xzf2g42Kgef8viww1yA/M7xtmgrgHGm1XcLE
	nYjf8yeVWIbVhJCDl+YiWq34tOrEMbu02UjvRhsWwozrWR5D0gZzAgdaT6xVPW9u7TxEUrRBq+/aN
	X2jbnOTONJDUOUQk4SW2Z4T4KRrnTsrdVA1htPfMfPFQ7QQUeuJVGP4XniuxzPP2d131pK/8TtNjk
	YDEN5aZC5vF9ieGeah5MZ27iWN8awEvFdOGVkeamMfptXLYnuLoHt9kMO4Q6ofUJ906BTARF0uhd0
	UYtEAvMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ0cE-00Ejvv-1S;
	Wed, 17 Jan 2024 07:45:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ0cB-00EjrG-08
	for kexec@lists.infradead.org;
	Wed, 17 Jan 2024 07:45:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705477524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zQRlhXHXvsZ9EW9ID9S6e0YBzlBTE1L+rSpAnIyeWDk=;
	b=IIePp6gfymXUCRsZWGHD4rbgMAoZ4lBbQ2r8VM+yu767ovqoWRwkIUtyhz0iGQKaYVWjho
	ANMVhLM2thrirWhIYs0i3qJZ8KmJW2qrcsq3yorh7lNj0FoXr0ee5xCb2E7mDGJdMKvgNp
	YjVyKuGObnUGPtvVg+s7yh+43lavXYk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-SvJeuHf6PfmbpUb2qZkE-A-1; Wed, 17 Jan 2024 02:45:16 -0500
X-MC-Unique: SvJeuHf6PfmbpUb2qZkE-A-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d9b050e9a8so13510823b3a.1
        for <kexec@lists.infradead.org>; Tue, 16 Jan 2024 23:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477515; x=1706082315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQRlhXHXvsZ9EW9ID9S6e0YBzlBTE1L+rSpAnIyeWDk=;
        b=F1cIbE72mPNjWfDdtAjnoJuwgkBwU/0wv/INp7R9PmfaX95K3eEeSJkJAxJjrQqEL/
         +gwilznCyhj4/ImiAK/XbTgVGjM/DvrKiQ3Ihv93C9OQYSFCE+9fYsY0eBByJKgFztye
         mZ4vb0zfv2k2lQaVb8JS6sfACztv3HnehY+AuMijRZEo2t+GzAyQcUUk+G5uAH3jpYmX
         PUjuoyqw3ghRB2t5HeGKlY3Ot4NEXhsXchz7up1TGhNNhaNEG8SeeXrjPC0JCTmU53Fx
         7ssOoOGk8mZsSC8/s3eeIJNrCQrK2rK+UpU4mqb9u/C53BXms23lXRGHS839Ipnvevw5
         EzRg==
X-Gm-Message-State: AOJu0YyT23Xe8BrZSAzBck0byGCWQmF1r9DV+2S1vpVJGqoPGs9tN7A2
	vViYTG0IIhnpqHNfnpflWl4QijR+l+9jsQmbQpjKQq8SqwVVquJmjjsHCpDN0G+I0I2W1HCOdDm
	8yY+2XR+9K8oXB+VyqT6edICAHcYw
X-Received: by 2002:a05:6a00:8c7:b0:6d9:9126:cab5 with SMTP id s7-20020a056a0008c700b006d99126cab5mr11556302pfu.57.1705477515219;
        Tue, 16 Jan 2024 23:45:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGcH2MWUG40J/v2AJAZDVhtAU4GRwWSH/jgWPbD8wsqM8XRIdzMPaD3wvgm9yUXrndNlaftg==
X-Received: by 2002:a05:6a00:8c7:b0:6d9:9126:cab5 with SMTP id s7-20020a056a0008c700b006d99126cab5mr11556283pfu.57.1705477514814;
        Tue, 16 Jan 2024 23:45:14 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y14-20020a056a00190e00b006d9a0902937sm791572pfi.149.2024.01.16.23.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 23:45:14 -0800 (PST)
Date: Wed, 17 Jan 2024 15:38:13 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ondrej Kozina <okozina@redhat.com>
Cc: kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: Re: [PATCH v2 0/5] Support kdump with LUKS encryption by reusing
 LUKS volume key
Message-ID: <qsioibxdey2cbxkpyv2gjg6a77votsg6ld2jp7ocvbiezaylxt@me3kgvu24vbs>
References: <20240110071522.1308935-1-coxu@redhat.com>
 <1edc32f2-858b-4afa-a883-2632be6d909e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1edc32f2-858b-4afa-a883-2632be6d909e@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_234535_151471_A905287E 
X-CRM114-Status: GOOD (  23.78  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, Jan 16, 2024 at 11:37:10AM +0100, Ondrej Kozina wrote:
>Hi Coiby,

Hi Ondrej,

>
>I've started working on a patchset for systemd utility. I have one 
>question/suggestion:
>
>On 10/01/2024 08:15, Coiby Xu wrote:
>>LUKS is the standard for Linux disk encryption. Many users choose LUKS
>>and in some use cases like Confidential VM it's mandated. With kdump
>>enabled, when the 1st kernel crashes, the system could boot into the
>>kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
>>specified target. Currently, when dumping vmcore to a LUKS
>>encrypted device, there are two problems,
>>
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes; For cloud confidential VMs, depending on the policy the
>>    kdump kernel may not be able to unseal the key with TPM and the
>>    console virtual keyboard is untrusted
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump. Take Fedora example, by default, only 256M is reserved for
>>    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>>    to be reserved for kdump. Note if the memory reserved for kdump can't
>>    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>>    1st kernel.
>>Besides users (at least for Fedora) usually expect kdump to work out of
>>the box i.e. no manual password input is needed. And it doesn't make
>>sense to derivate the key again in kdump kernel which seems to be
>>redundant work.
>>
>>This patch set addresses the above issues by reusing the LUKS volume key
>>in kdump kernel with the help of cryptsetup's new APIs
>>(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
>>this kdump copy of LUKS volume key,
>>
>>  1. After the 1st kernel loads the initramfs during boot, systemd
>>     use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
>>     volume key and then save the volume key to specified keyring
>>     (using the --link-vk-to-keyring API) and the key will expire within
>>     specified time.
>>
>>  2.  A user space tool (kdump initramfs builder) writes the key description to
>>     /sys/kernel/crash_dm_crypt_key to inform the 1st kernel to save a
>>     temporary copy of the volume key while building the kdump initramfs
>
>So this volume key copy cached by systemd utility in 1st kernel does 
>not have to be readable from userspace.
>
>>
>>  3. The kexec_file_load syscall saves the temporary copy of the volume
>>     key to kdump reserved memory and wipe the copy.
>>
>>  4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
>>     initramfs asks the kdump kernel to create a user key using the
>>     key stored in kdump reserved memory by writing the key
>>     description to /sys/kernel/crash_dm_crypt_key. Then the LUKS
>>     encrypted devide is unlocked with libcryptsetup's
>>     --volume-key-keyring API.
>
>Unlike here where it has to readable from uspace so that libcryptsetup 
>can verify the volume key.
>
>Is it correct?
>O.

Oh, my assumed --link-vk-to-keyring only support user key which must be
wrong. So yes, you are absolutely correct that "volume key copy cached
by systemd utility in 1st kernel does not have to be readable from
userspace". Thanks for the suggestion!


-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CF0C369C2
	for <kexec@archiver.kernel.org>; Mon, 28 Apr 2025 03:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbo+2a9JBJRZ/sxLnfgVH6LOGHNdpN/py6v/3sMtqqk=; b=NhyppKt+FokL7XJ056yqlHG8go
	JeM4x89r8wDe5w6kTQYeKiVbhAjjjNGe/azfIFpDZLwayF72rYdlVWzjvKm3IWKw10JvC8EI+YAI/
	AVN4OdKoInWJbHn5SBFkospVFHkJFLzALmoV3MOds/cjr0OMIMHHKxILU8xHVBU+bPGGtrV/fdYh0
	A6WzNRWYEboOhDBRRuTs84UkyavGXnxCbQbRKInJ6wm2UjPmCk5SU5jw9MjCb1nM4EMX5J9bf/ZW1
	oXK2TbTksMk1QtunNSWMRYF13/HF6pkYN8CvU/D9Q7nTkU7exneUZJEa/0tt+EDbfd3wSDCFMFQqZ
	3VEQ8Obg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9FWE-00000004SlD-2XTz;
	Mon, 28 Apr 2025 03:50:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9FW7-00000004Skp-1Gud
	for kexec@lists.infradead.org;
	Mon, 28 Apr 2025 03:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745812249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jbo+2a9JBJRZ/sxLnfgVH6LOGHNdpN/py6v/3sMtqqk=;
	b=aoZRFsH83ZWlaSp++SF7KQj/dNLcA0JXrYhY7HB61xrNHnw8QJLgHIiW/N2cIVuQTkdljh
	n7K//HKFmr9o64sr5J+cHKMr0VNX5vqyPq29M9UUuQVdDC2fE2JPbRHfZg6+y+lonQh1pQ
	FlSiyl+TcL00Vz2HiH8BcTnMYBq4+A0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-zdEirLUaP4G6m78HF2DlAA-1; Sun, 27 Apr 2025 23:50:47 -0400
X-MC-Unique: zdEirLUaP4G6m78HF2DlAA-1
X-Mimecast-MFC-AGG-ID: zdEirLUaP4G6m78HF2DlAA_1745812246
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a960f9cso32006475ad.0
        for <kexec@lists.infradead.org>; Sun, 27 Apr 2025 20:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745812246; x=1746417046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbo+2a9JBJRZ/sxLnfgVH6LOGHNdpN/py6v/3sMtqqk=;
        b=GVgNuDhVZhQJSV6MEK88elANTx7J94opD94pLz50wepM/B1dR8MoubUvpne1lj6MM5
         svm5ulpdrnzuSvXc2yJGaVE978Sg417OtkeK7IOQuO7v3vFO2M9/iPx7f2IRJzGYtf0U
         64cR5hN/xtCLHBsYYXZa40XCfwI0hkqi1q9kWq4QryoYqT0ABHZRkIHDJlo/empxmFLo
         9u+iACwjWuk8hdJq8jdCZjSgKMbGG2HsNlJrmyJqbXJvshET8nIisC/w7JFfT73TDmrD
         v7RhtdhD1d0Gv8fXIodTIwx5k9scSWT6J2wAjR7CWWDBDl+ZacFKxoEdAlLKCMrDqs2T
         0sLA==
X-Forwarded-Encrypted: i=1; AJvYcCVwRAhUal8vYnhwcywI7sXdq1rXVG9cIAGJilXctrEtoYx/kK9JCJ9OWm2cfgUVw/Equil4Bg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyP2Acqga/hdqe+moLcOPOnkGCevObeq6KdRGxMJOEVnl51M+gJ
	u88EGndvL+GHQPWS9+1b+q3vx111kpz6SmPmxDlROlLTjqTsJWtTtwxVrF2xwH2Q1F0k6SSAk23
	Ix9FiDpd6ZIa/a5KTi3BGVBUJ4iV6+RsMYQKMrbGndVFHuuWNkEUedWeFWw==
X-Gm-Gg: ASbGnctRhDRO6Z45y5Ft24hQfMmjw8CAHIEyHf+UREJoA/NhCszPa5FOGnN9nmE0vdQ
	MLFGsASnr1HVRn1OsGVk0RTXJ18KUyNsYEJ/9ALZaGjxFqnJEeMmi1d6jXvlyaRAxYFwpzawRi1
	U6CZLkuKs8PEyvO8CVPguVj+2OlKMwwkxYrX1ymo/TqvYS5uHgf9ObLbNs/1+B0bDNeVkvWegcS
	I70Ytt5YwoNRPkhvIC1lVNVeazT/323yzgGsWsnxPM2nnWptlsgQ5AlzXGE9YCFm3ZeVolU6ClV
	nVg=
X-Received: by 2002:a17:902:ea07:b0:224:e33:889b with SMTP id d9443c01a7336-22dc6a02897mr129450795ad.12.1745812246499;
        Sun, 27 Apr 2025 20:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVFYsPlT2IQH/8g/Ppb2JU1Bp7a0oc6sqVCGjUPDTj65f4oD4rCO7sbjZ9q3vvWinALN4nhw==
X-Received: by 2002:a17:902:ea07:b0:224:e33:889b with SMTP id d9443c01a7336-22dc6a02897mr129450525ad.12.1745812246140;
        Sun, 27 Apr 2025 20:50:46 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbc0c6sm71732915ad.81.2025.04.27.20.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 20:50:45 -0700 (PDT)
Date: Mon, 28 Apr 2025 11:48:25 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>, 
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
References: <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 94zq4014lF0j8XLTKTK8JNoYKLxaHuvte9UcYKjizRE_1745812246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_205051_442961_5FA9B2D6 
X-CRM114-Status: GOOD (  24.11  )
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

On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
>On 04/09/25 at 11:40am, Mimi Zohar wrote:
>> On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
>......snip..
>> > Thanks for confirming. I will consider how to fix it accordingly. Maybe
>> > after Steven's patches are merged. That would be great if the buffer
>> > allocating and storing can be skiped for kdump in Steven's patch. While
>> > I am worried that could disrupt the progress of Steven's patches.
>>
>> Agreed, let's get Steven's patch set upstreamed and then make the kdump
>> exceptions.
>>
>> - "ima: kexec: move IMA log copy from kexec load to execute" looks like it isn't
>> copying the IMA measurement list records (kexec_post_load), but the memory for
>> the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).
>>
>> - Do you really want to totally disable IMA for kdump or would disabling IMA-
>> measurement be sufficient?  Remember there's already an option to disable IMA-
>> appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to continue
>> to work.  Meaning based on policy the integrity of files - executables, kernel
>> image, etc - could still be verified.
>>
>> Without IMA-measurement:
>> - No adding records to the IMA measurement list
>> - No IMA measurement list pseudo securityfs files
>> - No extending the TPM
>>
>> With IMA-appraisal:
>> - Integrity verification of files based on keys, keyrings
>> - Loading keys

Thanks for listing the impacts of disabling IMA measurement or
appraisal! 

kdump builds and loads its own initramfs as a cpio archive. After a
kernel crashes, the loaded initramfs will save the crashed kernel's
memory (vmcore) to specified location and then it will reboot the system
immediately. Since kdump merely copy files from existing fs into its
initramfs, I think at least majority of users don't need IMA for kdump.
In fact, currently IMA-appraisal doesn't work for kdump because cpio
doesn't support xattr. As for the issue of not properly updating the
security xattrs, I think in most of cases disabling IMA-appraisal in
kdump won't cause the trouble. If the vmcore is saved to a remote fs, the
local fs won't even be touched. If the vmcore is saved to local fs and
the appraisal rules cover the saved vmcore and the created logs files,
we only need to update the xattr file of three files. So from the
perspective of kdump, it's good to disable IMA for kdump to save memory.
Of course we can't rule out the possibility some users may want to need
IMA in kdump. So a flexible solution like providing a knob to allow
users to enable IMA in kdump will be the ideal solution.

Btw, recently, a colleague reminds me of an issue that the system hangs
because systemd fails to load incorrect /etc/ima/ima-policy. Of course,
we should ask users to verify the policy beforehand. But it's still
possible the booting process may be stopped by a strict, albeit
syntax-correct policy and users can't log into the system to fix the
policy. Do you think a knob to disable IMA is needed to address these
cases or is there a better solution?

>
>Currently, Kdump has no demand to do integrity verification based on
>keys, keyrings, except of Coiby's LUKS support in kdump:
>
>[PATCH v8 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
>https://lore.kernel.org/all/20250207080818.129165-1-coxu@redhat.com/T/#u
>
>I have talked to Coiby, he will do some investigations to see if loading
>keys related to IMA or IMA-appraisal functionality is related to LUKS
>support in kdump because the LUKS support in kdump also needs
>store/restore keys/keyrings between normal kernel and kdump kernel.

Thanks for reminding me about kdump LUKS support. IMA will create
keyring like .ima for loading keys and other components can still create
their own keyrings or use existing keyrings. And I can confirm kdump
LUKS support won't be affected. 

-- 
Best regards,
Coiby



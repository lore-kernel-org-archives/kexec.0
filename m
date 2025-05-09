Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0984BC3ABBC
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 06:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+to1I211iC3afEaRgF5+2vQotsbE1LgjowPA3s1xo8=; b=d6mASj4zq2OG3Ur/XAS/7fbJTB
	Iy4bqOyTp4Vwm8lLeeB9SnAwkD0Oo1/GKxflyXQGs3tX31sD0TgEyOal1fTIpYBYeDXy1CpkRXWQf
	2xStLPOg2sL6PkMHEy0QK2iIod2jiiIgOtZaqO9hrpjwkX0hI1YuqVfPvHykK7CyINegmLC6MFIpF
	RAw+W1+elkDOXspFsucR4EEwK5aiEEc6wjCE/nYfjUI8VP1m/Pw0ytT+HOpMN4vOWRb/4BlfpUTqv
	245JjmVhggg4lOa4ULCNz1irgrRtoUqUCeJWNyoqhI1Xu14TWEiocTQ2cU2z4WMGoCPEJmyZ5v4W9
	XSiPH5Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDGmi-00000002ZIo-1mCp;
	Fri, 09 May 2025 06:00:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDGmg-00000002ZHg-03vK
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 06:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746770431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+to1I211iC3afEaRgF5+2vQotsbE1LgjowPA3s1xo8=;
	b=MAutdXiTsQYjbJKAYWY0EeouRkff2pgKfPhC+yRPJOtkZMlDCIQPllL7EOlogrF8Qp7pbl
	RMO7dBSI3nrm8pEJC3xgdGmbWB3b9aJ6VVPc02PbNV2m72ttUb470+PA2okBk8cEbh0xCO
	t2wTGTue8ewIiIkn/U1lcs+Cl+4f5pM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-q8ugbGJtOoWFkEIEBZdspQ-1; Fri, 09 May 2025 02:00:29 -0400
X-MC-Unique: q8ugbGJtOoWFkEIEBZdspQ-1
X-Mimecast-MFC-AGG-ID: q8ugbGJtOoWFkEIEBZdspQ_1746770429
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b19226b5f7dso1411271a12.0
        for <kexec@lists.infradead.org>; Thu, 08 May 2025 23:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746770429; x=1747375229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+to1I211iC3afEaRgF5+2vQotsbE1LgjowPA3s1xo8=;
        b=Et09Vr6xS9Bh+sYcs7E5CUXBA2+0tD+YrOakx3p+SqQOAkzgm0Vyw40w1CQLtqcQ50
         U/KB8OggBKchfNnEJdviCpyZbtNrz5N/hVpJuCP1IdoHdroR3OWCKoRQKM20KhH5R5zv
         22TtzvdHKb6FErYQChqMIId9bI89HGG7uxhE3lEH3+tsLxwLe4z/xNPlLs9VvPDNV/At
         4ZPtp8dOI6utY1SOO0YYmoXNcttH+s4OhhR9SgPytKx9ygB9cIyzCDXW4KJKjo6DSKe6
         naK1/jD2y2rwJMfLgkNK8LAtJ9+Cuk/1IDGsd4qJZJhc7+WWSwx+o/Jpk654bYiA8dvZ
         fFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV9QoAVSkLK/iQCkSIJ32bQv500YZ8F/+d9mNZtTFDSE0rbXappWOD3Ls4cF1jjm1UcSCbvA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmoeIlZFQPlmWOXk4DMZ9KTVwUdKjjICap7AXP3PG+K21NnNIU
	tQtKtIFcnvGsY6j65YSnUiPqXl+WBqU4w225jwGJGute5sDf8UJVB9C78eIQhe7kG9w++tqzaOM
	9ypjMZkjR91JSDC0DH2WMPbDtLnbd4eyvZhgpL1j+zFSz33wVGBfxO4dDyw==
X-Gm-Gg: ASbGncu0NOEAgAapCs8Rw3FcknWZ4vV0D2bLntFTIViU2O5uqy4B7veN+9aKFEeK+ti
	d58bc79ZNnPK2ftrPGLaXXZvOMljRK0jYYLY55DPaEqLYPAre7osVVobLSEwVNFy+iOYoYRt7CR
	6bwwbXQdqfGGY5hFny4U/K1Ou/BDCrhk6Sv1JX2fkbCr9+h+VvGpBx2OnARAORkZzgj8SU7umF1
	SWmVYvOIAgKYcPYYWtw4TrchPD7mMPQ7y3CJ5xQMv3Yfxo0UoMq/8zrNzvQFbX83oE3Gc6KTVWr
	GN8=
X-Received: by 2002:a05:6a21:b8b:b0:1f3:1ba1:266a with SMTP id adf61e73a8af0-215ab2e72b6mr2947516637.0.1746770428680;
        Thu, 08 May 2025 23:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUdYKYbaeIT7SaXV2OeE2x2TbifmrjM8mSWIwSJL/AtvMzlyxWFF0/of7HSQd5+A1u/6HKyg==
X-Received: by 2002:a05:6a21:b8b:b0:1f3:1ba1:266a with SMTP id adf61e73a8af0-215ab2e72b6mr2947477637.0.1746770428239;
        Thu, 08 May 2025 23:00:28 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423770447asm1008438b3a.32.2025.05.08.23.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 23:00:27 -0700 (PDT)
Date: Fri, 9 May 2025 13:59:44 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, chenste@linux.microsoft.com, 
	RuiRui Yang <ruyang@redhat.com>, linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <qvv3tniawgb3rvqeuxzckj25xxkcr2tqbwnji5gmdg4x3ahdha@52hwfd36ttf7>
References: <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
 <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: diksX7WewRa75JVhTNts3AZgI4zcflRJH_PSWe2Gw4k_1746770429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_230034_143708_9B335693 
X-CRM114-Status: GOOD (  40.80  )
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

On Tue, Apr 29, 2025 at 07:39:17AM -0400, Mimi Zohar wrote:
>On Mon, 2025-04-28 at 11:48 +0800, Coiby Xu wrote:
>> On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
>> > On 04/09/25 at 11:40am, Mimi Zohar wrote:
>> > > On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
>> > ......snip..
>> > > > Thanks for confirming. I will consider how to fix it accordingly. Maybe
>> > > > after Steven's patches are merged. That would be great if the buffer
>> > > > allocating and storing can be skiped for kdump in Steven's patch. While
>> > > > I am worried that could disrupt the progress of Steven's patches.
>> > >
>> > > Agreed, let's get Steven's patch set upstreamed and then make the kdump
>> > > exceptions.
>> > >
>> > > - "ima: kexec: move IMA log copy from kexec load to execute" looks like it
>> > > isn't
>> > > copying the IMA measurement list records (kexec_post_load), but the memory for
>> > > the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).
>> > >
>> > > - Do you really want to totally disable IMA for kdump or would disabling IMA-
>> > > measurement be sufficient?  Remember there's already an option to disable IMA-
>> > > appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to
>> > > continue
>> > > to work.  Meaning based on policy the integrity of files - executables, kernel
>> > > image, etc - could still be verified.
>> > >
>> > > Without IMA-measurement:
>> > > - No adding records to the IMA measurement list
>> > > - No IMA measurement list pseudo securityfs files
>> > > - No extending the TPM
>> > >
>> > > With IMA-appraisal:
>> > > - Integrity verification of files based on keys, keyrings
>> > > - Loading keys
>>
>> Thanks for listing the impacts of disabling IMA measurement or
>> appraisal!
>>
>> kdump builds and loads its own initramfs as a cpio archive. After a
>> kernel crashes, the loaded initramfs will save the crashed kernel's
>> memory (vmcore) to specified location and then it will reboot the system
>> immediately. Since kdump merely copy files from existing fs into its
>> initramfs, I think at least majority of users don't need IMA for kdump.
>
>That's fine.
>
>> In fact, currently IMA-appraisal doesn't work for kdump because cpio
>> doesn't support xattr.
>
>Although CPIO doesn't support xattrs, tmpfs supports xattrs.

Thanks for pointing it out! I thought tmpfs doesn't support xattrs
because ima_policy=tcb excludes TMPFS_MAGIC. There are still many
interesting questions for me to explore. For example, I don't understand
how 1st kernel's initramfs is shown as ramfs (which doesn't support
xattrs) but kdump intiramfs without the squashfs module is shown as
tmpfs.

>I'm aware that some
>store the security xattr information in a file and write it out as xattrs.

If the built initramfs as a CPIO file doesn't carry xattrs, the loaded
initramfs still doesn't have xattrs. I just found the initramfs could
opt to use squashfs or erofs which supports xattrs but currently it's
hardcoded to disable xattrs. For example, recently the dracut erorfs
module also follows squashfs to disable xattrs [1]. So in the near
future, I don't expect xattrs to be supported in kdump.

[1] https://github.com/dracut-ng/dracut-ng/pull

>
>> As for the issue of not properly updating the
>> security xattrs, I think in most of cases disabling IMA-appraisal in
>> kdump won't cause the trouble. If the vmcore is saved to a remote fs, the
>> local fs won't even be touched. If the vmcore is saved to local fs and
>> the appraisal rules cover the saved vmcore and the created logs files,
>> we only need to update the xattr file of three files. So from the
>> perspective of kdump, it's good to disable IMA for kdump to save memory.
>
>Remember my original concerns weren't about disabling IMA for kdump, but about not
>limiting disabling IMA to just kdump.

Thanks for reminding me about that! Baoquan will post a patch to only
disable IMA for kdump so we won't need to worry about these concerns:)

>
>> Of course we can't rule out the possibility some users may want to need
>> IMA in kdump. So a flexible solution like providing a knob to allow
>> users to enable IMA in kdump will be the ideal solution.
>
>Agreed
>
>>
>> Btw, recently, a colleague reminds me of an issue that the system hangs
>> because systemd fails to load incorrect /etc/ima/ima-policy. Of course,
>> we should ask users to verify the policy beforehand. But it's still
>> possible the booting process may be stopped by a strict, albeit
>> syntax-correct policy and users can't log into the system to fix the
>> policy. Do you think a knob to disable IMA is needed to address these
>> cases or is there a better solution?
>
>Agreed a new policy should always be tested, before attempting to load it on boot.
>However there are situations when even a tested policy fails.  Commonly this occurs
>when attempting to load an IMA policy based on IMA features that don't exist in an
>older kernel.  This can normally be resolved by booting into the newer kernel and
>"fixing" the policy.  Instead of disabling IMA, I would allow specifying on the boot
>command line an alternate IMA policy (e.g. ima-policy.backup-version) to be loaded
>as fallback.

Thanks for letting me know the case where an IMA policy may fails
because of an older kernel. I'll start a new thread to discuss how to
fix an booting failure issue since it can be decoupled from this patch.
Previously you reminded me that re-enabling IMA will require re-fixing
security.ima. Then I realize that changing IMA policy will also require
such re-fixing otherwise booting failure may also occur if it involves a
critical component. So I'll also ask your advice for this matter in the
new thread as well.

-- 
Best regards,
Coiby



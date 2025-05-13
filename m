Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A1EC3ABCB
	for <kexec@archiver.kernel.org>; Tue, 13 May 2025 00:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c3AmHeJBYgl39ErgKXbHLkXnjMZ6a1n74+nQIVaSb1g=; b=Ukj1VWxwddGg4Y6eFm8KcqpOch
	jzLjgjuygQbDDp9hQBDcL68sBnRbE1jJbXchnJQEu66Qyvx6Xok63u20IkKt/+WwCT9Vp3kXEG/BT
	65fZ53LGnsCoGdfn0LPfs5rwjBmqZZkSnr604s0suscknKha5DTXP+1lW6FqS+xeqvUB069dsilj/
	D6tfubO+D60tqa257mszno9kZ57Li00MubV0antqkd7pMnc7hnxbcqsIR+6CCSYrForkJ759vtJW+
	go38kC4Wzycc+FXfdgzmN84YWZBhc2zI1hqwE7I0Jdiefw9j1bJnBTkAD0QxxCOLendJhZaNQnPK0
	n37JDCew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEdJ2-0000000AyfD-11zC;
	Tue, 13 May 2025 00:15:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEdIz-0000000Ayer-0SLS
	for kexec@lists.infradead.org;
	Tue, 13 May 2025 00:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747095330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3AmHeJBYgl39ErgKXbHLkXnjMZ6a1n74+nQIVaSb1g=;
	b=dOtg7blPsOAxWbWyyG+vL1JI0nJSkjYsVatHjq/tOJXrX1P2NV6ehl9cSkHz1HUGoUb3e4
	wIYo1FKT0U9QFBSGHQXaHi0L37QZSJO5nDicZqYk+XoNubFpFFvP1ctPAdHsc9/w035do1
	FzYtYOTqLvlBsHm6BloXfBTiEPctF0Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-tDumk8cxOEyDADr-O0HiEw-1; Mon, 12 May 2025 20:15:29 -0400
X-MC-Unique: tDumk8cxOEyDADr-O0HiEw-1
X-Mimecast-MFC-AGG-ID: tDumk8cxOEyDADr-O0HiEw_1747095328
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30c1a269a12so7165601a91.0
        for <kexec@lists.infradead.org>; Mon, 12 May 2025 17:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747095328; x=1747700128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3AmHeJBYgl39ErgKXbHLkXnjMZ6a1n74+nQIVaSb1g=;
        b=d6h55H/n3kdm7WR8A/FM+Lgmml1wfECtZ9mt7rC2KH3dTTQbqfh8NrAkcp17e99YVT
         oWiK/iB5GB99XcY5nriMqD75n6VH9ESdFCA7c0tkuhBXNTWKjTUMscHe6boEus/95wI1
         WoJSiGCxGPKn8LRup2GiPi+8si8osYmqurS2Z8UX1xzc9WfYuIWtYeCLUxfOeb/NJ/pY
         TOUZa1VwuyQcD2mjtN5MW8cqEdOYL2rlcXH/xd/XDWQ2milwwWZVanfFB3ucHK6iGvJd
         PXXcSyfD3m142WYGd0miB/AFmvc8V3PfbMhViHjhOrOLDVoXG+j1u9XoEW3X2aXTRdCD
         T92g==
X-Forwarded-Encrypted: i=1; AJvYcCUFOLKtl7GuOJfxEHDtJ2DSMgyrTZDbT4qadqQw5SZlpEiwkp2jI2uLea+1660BMFtlvoK9MQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxPIYpmaivEfFycdS4J5Ul+SM5w2h+A8qZY/3TE74jWx1lttG+5
	hEu871SJouP1eFmgPCV/wmJi6raZDmwuMzrYMhbho7luRiKiP66HfD9bKM1QbqLTaOprMigZdWO
	1UQH0Vy+WQ8daym6gXWztzEEx8FHBOEIWrbkJDIxICAV42Uwlpgi9r4DE8A==
X-Gm-Gg: ASbGncte0H5/aB6sO5sqy9T/OJ9wsbzE2BIjej1LrG5v44wYmR8cVH9qPjN74jnpw8a
	tyNZqLpG7qfD0xSDhOu+dckaS1FSsgt8G52LjedHUF2AIOKWZ+fpLxwjleIv2jxroGvOP1i85ew
	mrSlXu/9YgNoWof+MgudidbBJq2Bc/bw7Bj0MCBIlzekgJsYEvvl/SU0+EwWBgOwjGsgiGiWPMf
	ojvZGiPJmJsv74ywO5oF4AjFk4xEsWwWgWq0f6D9NcU8O5jZ4DKLnVI82BQGBX9Vu5GU1gG6npa
	nhk=
X-Received: by 2002:a17:90b:4ecd:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-30c3cefb9f7mr23828363a91.8.1747095328095;
        Mon, 12 May 2025 17:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFgE3g0PPo1j1o8bvsk61ZcmWZ5XqEMc4KrEKTJX4oJNqWAAOyuTc+O4Fr7Hx4Xjy+6nxPOw==
X-Received: by 2002:a17:90b:4ecd:b0:2ee:c291:765a with SMTP id 98e67ed59e1d1-30c3cefb9f7mr23828319a91.8.1747095327642;
        Mon, 12 May 2025 17:15:27 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c394a2467sm7395698a91.0.2025.05.12.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:15:27 -0700 (PDT)
Date: Tue, 13 May 2025 08:14:00 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Baoquan He <bhe@redhat.com>, 
	chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <s56ljuvqmrcy5gzjbrfbowq6gel7u4jjqtgyitvcbjgoiaahex@5kezecpurctk>
References: <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
 <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
 <qvv3tniawgb3rvqeuxzckj25xxkcr2tqbwnji5gmdg4x3ahdha@52hwfd36ttf7>
 <00d282d0cf06c3ac208ab9edfddedda1c9a5a77b.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <00d282d0cf06c3ac208ab9edfddedda1c9a5a77b.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AThZGLP-5BMgIitar3GcMuee0BRxxdHk82L7IhKufO8_1747095328
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_171533_222714_2E048F09 
X-CRM114-Status: GOOD (  36.93  )
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

On Fri, May 09, 2025 at 09:03:11AM -0400, Mimi Zohar wrote:
>[Cc'ing Roberto]
>
>On Fri, 2025-05-09 at 13:59 +0800, Coiby Xu wrote:
>> On Tue, Apr 29, 2025 at 07:39:17AM -0400, Mimi Zohar wrote:
>> > On Mon, 2025-04-28 at 11:48 +0800, Coiby Xu wrote:
>> > > On Wed, Apr 16, 2025 at 11:22:52AM +0800, Baoquan He wrote:
>> > > > On 04/09/25 at 11:40am, Mimi Zohar wrote:
>> > > > > On Wed, 2025-04-09 at 10:42 +0800, Baoquan He wrote:
>> > > > ......snip..
>> > > > > > Thanks for confirming. I will consider how to fix it accordingly. Maybe
>> > > > > > after Steven's patches are merged. That would be great if the buffer
>> > > > > > allocating and storing can be skiped for kdump in Steven's patch. While
>> > > > > > I am worried that could disrupt the progress of Steven's patches.
>> > > > >
>> > > > > Agreed, let's get Steven's patch set upstreamed and then make the kdump
>> > > > > exceptions.
>> > > > >
>> > > > > - "ima: kexec: move IMA log copy from kexec load to execute" looks like it
>> > > > > isn't
>> > > > > copying the IMA measurement list records (kexec_post_load), but the memory
>> > > > > for
>> > > > > the IMA measurement list is being allocated (ima_alloc_kexec_file_buf).
>> > > > >
>> > > > > - Do you really want to totally disable IMA for kdump or would disabling
>> > > > > IMA-
>> > > > > measurement be sufficient?  Remember there's already an option to disable
>> > > > > IMA-
>> > > > > appraisal.  Disabling just IMA-measurement would allow IMA-appraisal to
>> > > > > continue
>> > > > > to work.  Meaning based on policy the integrity of files - executables,
>> > > > > kernel
>> > > > > image, etc - could still be verified.
>> > > > >
>> > > > > Without IMA-measurement:
>> > > > > - No adding records to the IMA measurement list
>> > > > > - No IMA measurement list pseudo securityfs files
>> > > > > - No extending the TPM
>> > > > >
>> > > > > With IMA-appraisal:
>> > > > > - Integrity verification of files based on keys, keyrings
>> > > > > - Loading keys
>> > >
>> > > Thanks for listing the impacts of disabling IMA measurement or
>> > > appraisal!
>> > >
>> > > kdump builds and loads its own initramfs as a cpio archive. After a
>> > > kernel crashes, the loaded initramfs will save the crashed kernel's
>> > > memory (vmcore) to specified location and then it will reboot the system
>> > > immediately. Since kdump merely copy files from existing fs into its
>> > > initramfs, I think at least majority of users don't need IMA for kdump.
>> >
>> > That's fine.
>> >
>> > > In fact, currently IMA-appraisal doesn't work for kdump because cpio
>> > > doesn't support xattr.
>> >
>> > Although CPIO doesn't support xattrs, tmpfs supports xattrs.
>>
>> Thanks for pointing it out! I thought tmpfs doesn't support xattrs
>> because ima_policy=tcb excludes TMPFS_MAGIC. There are still many
>> interesting questions for me to explore. For example, I don't understand
>> how 1st kernel's initramfs is shown as ramfs (which doesn't support
>> xattrs) but kdump intiramfs without the squashfs module is shown as
>> tmpfs.
>
>Try adding "rootfstype=tmpfs" to the boot command line.  For a detailed explanation,
>take a look at commit 21528c69a0d8 ("rootfs: Fix support for rootfstype= when root=
>is given").

Thanks for pointing me to the above commit! I'll check it.

>
>>
>> > I'm aware that some
>> > store the security xattr information in a file and write it out as xattrs.
>>
>> If the built initramfs as a CPIO file doesn't carry xattrs, the loaded
>> initramfs still doesn't have xattrs. I just found the initramfs could
>> opt to use squashfs or erofs which supports xattrs but currently it's
>> hardcoded to disable xattrs. For example, recently the dracut erorfs
>> module also follows squashfs to disable xattrs [1]. So in the near
>> future, I don't expect xattrs to be supported in kdump.
>>
>> [1] https://github.com/dracut-ng/dracut-ng/pull

Sorry, I didn't notice the link is incomplete. It should be

[1] https://github.com/dracut-ng/dracut-ng/pull/1296

>
>Right, so the issue isn't the initramfs root filesystem, but CPIO.  Either CPIO
>would need to be extended, which multiple people have attempted to do, or the xattrs
>could be stored in a file and written out to the initramfs root filesystem.  In fact
>Roberto's last attempts at adding CPIO xattr support did something like that.
>
>https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/

Thanks for introducing Roberto's work to me!

>
>Mimi
>

-- 
Best regards,
Coiby



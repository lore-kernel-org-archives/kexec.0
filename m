Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026E2C77B7E
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PFYwYImbXkLNK2H6ohzMinO2tm0Bfd/IhiDp7Yjl2os=; b=HRa703gcHfMDhL
	L770VqWCFHLUwONzAwJkRkPmtPuL/Q1ijGPFHaYsroeH+Mr305vdJfWgKBHxn2aC6zmy1bhYRVH9J
	gTks7DS0IqnzuKaOvwWVdQOo46ydaFFLfE2vDViZth4/W4oQBsdUxI+4zkVqHXM0aiaAXz6xJMym/
	ug9SHFc56tVhYcW0kkujgH0UVW+zFKkbvNPgNVW6B9Zib4anA07zpjW/c9ErTLQfTBGgRqdooiCka
	5aPhphLikfAZ2bEaAs+e8wO86RapvTdnutkW1wxEE2uHbxwblBLjwbBFOEEqknrB0O3NwzBlE0uFZ
	fg3E/Nd+0BS1vEKbWTmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ci9-002Lz6-1R;
	Thu, 01 Jun 2023 07:27:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4ci6-002LxQ-1E
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 07:27:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685604421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y+y6DPvpxnpxkpq797HbPrufS4IN8CiXfOsCDPk430k=;
	b=B6MpoeSTlhh3ZqzYDvCQsoY3LZRAyQRQHiv7fqthJV+mMcntt5ZYcKNzGXMyLsq5LYYuAi
	/3v1MZE40B29jSlqSDpjlk78KY6uieP/QxedKUA1VjusMVLJitlxkA6MUj1KPinYabDvo/
	J/0BB25YN63oVljrJ1HbXDDP/+83vzg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-ND-1Kjx_MLyJqO0UhRVQMg-1; Thu, 01 Jun 2023 03:24:50 -0400
X-MC-Unique: ND-1Kjx_MLyJqO0UhRVQMg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53fa6346e9dso149029a12.2
        for <kexec@lists.infradead.org>; Thu, 01 Jun 2023 00:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685604288; x=1688196288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+y6DPvpxnpxkpq797HbPrufS4IN8CiXfOsCDPk430k=;
        b=Z3OzOWGtm15aLWcbhgLjsq9hcVshquF9RxfL3WhiEnEmcJLoliFryfJwh0NzUwCKIA
         jeWd9xSbuIEEYux5zrFb+o+X7liC3e8NNPRiLoT+fqcbh7xLIl+zjEcBFaE/OYkQshy+
         /LeApz4Jr/QG3Yld+UvyTSIHMqRqsoYysYV3oqiRqoTQwxwJwPZF8x8WTdsHydR27dgo
         b9GeNoEbnNB1L+tQ35QS+3vZVOXf5JdTbRSth1Jn7BJrlj6J0AFc9q6HJLwZ9nyCNitm
         AiOfZzgvk/Ma9mFHwGdeO04gjflDBq8/58wokUyRXWqGfJVx3Zkc5JLk4tse7wptYiv2
         bC2w==
X-Gm-Message-State: AC+VfDzk1bpkqNVFbLx6oeSNm3eXSoTtq1ZpJKsne6FTeue7C60nKj9S
	fW1ch5VFiIy/ff89TSaS9q4A5SrgYD1u71xTyRCzEQ+86s8YMqS71jZiXzW+yjBugAGDlUX2cet
	0VKiFbcb3WgLeLu37jKIBakKilZafFr3nIsQQd6iyo78DRuyr9IpnOqx0kheySa5HdwJfIFQ9ic
	bkNrgD
X-Received: by 2002:a05:6a20:918a:b0:111:1bd6:270b with SMTP id v10-20020a056a20918a00b001111bd6270bmr7164918pzd.7.1685604288519;
        Thu, 01 Jun 2023 00:24:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4FwTp/apIBasezyeJmFOSYq4Ca4y8dV0yy9NTwJ6MxPZcviNaRDT2lbI/v4rJt4YzOfO8RGw==
X-Received: by 2002:a05:6a20:918a:b0:111:1bd6:270b with SMTP id v10-20020a056a20918a00b001111bd6270bmr7164894pzd.7.1685604287964;
        Thu, 01 Jun 2023 00:24:47 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p21-20020a170902ead500b001aad4be4503sm2700512pld.2.2023.06.01.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 00:24:47 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
Date: Thu,  1 Jun 2023 15:24:39 +0800
Message-Id: <20230601072444.2033855-1-coxu@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_002702_493670_E8FDCB50 
X-CRM114-Status: GOOD (  29.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

v1
 - "Put the luks key handling related to crash_dump out into a separate
   file kernel/crash_dump_luks.c" [Baoquan]
 - Put the generic luks handling code before the x86 specific code to
   make it easier for other arches to follow suit [Baoquan]
 - Use phys_to_virt instead of "pfn -> page -> vaddr" [Dave Hansen]
 - Drop the RFC prefix [Dave Young]
 - Rebase the code onto latest Linus tree (6.4.0-rc4)

RFC v2
 - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
   dm-crypt 
   - to save a kdump copy of the LUKS volume key in 1st kernel
   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
 - save the kdump copy of LUKS volume key randomly [Jan]
 - mark the kdump copy inaccessible [Pingfan]
 - Miscellaneous
   - explain when operations related to the LUKS volume key happen [Jan]
   - s/master key/volume key/g
   - use crash_ instead of kexec_ as function prefix
   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash

LUKS is the standard for Linux disk encryption. Many users choose LUKS
and in some use cases like Confidential VM it's mandated. With kdump
enabled, when the 1st kernel crashes, the system could boot into the
kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
specified target. Currently, when dumping vmcore to a LUKS
encrypted device, there are two problems,

 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes; For cloud confidential VMs, the kdump kernel can't unseal
   the key with TPM.

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump. Note if the memory reserved for kdump can't
   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
   1st kernel. 
 
Besides users (at least for Fedora) usually expect kdump to work out of
the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the key again in kdump kernel which seems to be
redundant work.

Based on Milan's feedback [1] on Kairui's ideas to support kdump with
LUKS encryption, this patch set addresses the above issues by reusing
the LUKS volume key in kdump kernel and here is the life cycle of this
kdump copy of LUKS volume key,

 1. After the 1st kernel loads the initramfs during boot, systemd
    asks for a passphrase from the user and uses it to de-crypt the LUKS
    volume key

 2. After the 1st kernel saving the volume key as a logon key,
    libcrytpsetup notifies the kernel to read this logon key and store a
    temporary copy by writing the key description to
    /sys/kernel/crash_luks_volume_key

 3. After switching to the real root fs, kdump.serivce is started and it 
    loads the kdump kernel using the kexec_file_load syscall

 4. The kexec_file_load syscall saves the temporary copy of the volume
    key to kdump reserved memory and wipe the copy.

 5. When the 1st kernel crashes and kdump kernel is booted,
    libcryptsetup asks the kdump kernel to add a logon key using
    the volume key stored in kdump reserved memory by writing the key
    description to /sys/kernel/crash_luks_volume_key

 6. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

Note the kdump copy of LUKS volume key never leaves the kernel space and
is saved in the memory area exclusively reserved for kdump where even
the 1st kernel has no direct access. 

Milan's major concern [2] on previous version is "storing the encryption
key to yet another place are creating another attack vector". To further
secure this copy, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

If there is no further security concern with this approach or any other
concern, I will drop the following assumptions,
  - only x86 is supported
  - there is only one LUKS device for the system

to extend the support to other architectures including POWER, ARM and
s390x and address the case of multiple LUKS devices. Any feedback will be 
appreciated, thanks!

For a proof of concept, I've patched cryptsetup [3] in a quick-and-dirty
way to support a new option "--kdump-kernel-master-key"
and hacked systemd [4]. It works for Fedora 37.

[1] https://yhbt.net/lore/all/e5abd089-3398-fdb4-7991-0019be434b79@gmail.com/
[2] https://lwn.net/ml/linux-kernel/c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com/
[3] https://gitlab.com/coxu/cryptsetup/-/commit/750a46d933fac82e0c994b5c41de40a0b8cac647
[4] https://github.com/coiby/systemd/tree/reuse_kdump_master_key

Coiby Xu (5):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: save the LUKS volume key temporarily
  crash_dump: retrieve LUKS volume key in kdump kernel
  x86/crash: pass the LUKS volume key to kdump kernel
  x86/crash: make the page that stores the LUKS volume key inaccessible

 arch/x86/include/asm/crash.h       |   1 +
 arch/x86/kernel/crash.c            |  47 ++++++-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  14 ++
 include/linux/crash_core.h         |   2 +
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/Makefile                    |   2 +-
 kernel/crash_dump_luks.c           | 202 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 +++
 kernel/ksysfs.c                    |  19 +++
 11 files changed, 315 insertions(+), 2 deletions(-)
 create mode 100644 kernel/crash_dump_luks.c

-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

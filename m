Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50F6C10F15
	for <kexec@archiver.kernel.org>; Thu, 25 Apr 2024 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SA4vCZa8WpY8SMKeWzAmVXY3IeWW6QSBkGmzMr3whos=; b=3ck0bkeA3Kv0tb
	3VtRwtpAijWoxp5jwVBYKNge6vImpiR/GAr9TCF7ZgNrmqASBC308aB+fClUuNd0tJAvnhH7AGtSa
	hMr1I5YRw++AFMCstSw6of2He3Po3OVs1tuM8XxHKAOj7uwyjRE/1iM88CQyu54ou7FMirTG9vPVm
	MnH55PZM4JGkJmql18pQq+PfDW1DFoIVjmW+NKIXaJLSBh1eAcGyPChWNtIFBkBm3gdCcCdis9LR9
	NtC9uS0juxumxPvDw5EDUUXaZWCOltUByDNqKEsJFf8Tm9tvMulJsL+3Tb4zPQ4fZNxtu/cYXzmTJ
	tW5rj6q3zBEtVB/ypW/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvyC-00000007ka4-3Yp9;
	Thu, 25 Apr 2024 10:04:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzvy8-00000007kYJ-0gio
	for kexec@lists.infradead.org;
	Thu, 25 Apr 2024 10:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3mBgtuiCKBzoVzYLU6P6zbBW8ejOibsGMiGGBrCvDE4=;
	b=e9Ag5GyVVIIyiNgulVt/Q511VEf0qLe88h+XNV9TSnyxJJblBK4iuvMHicSKTcXQMyzdD0
	SwyMtj3Yx8BmDC0NNJWwxIB3ATQG7OHEceG1ya1ku879WvzcBaJ4tbETDJshNX7Z9dNByh
	kWS84vlxp3wrNjuvzrtwwjhUnBaL+lY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-WjEgx6s4MlCa-ynkOPapFw-1; Thu, 25 Apr 2024 06:04:40 -0400
X-MC-Unique: WjEgx6s4MlCa-ynkOPapFw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ae9176aad8so1056208a91.2
        for <kexec@lists.infradead.org>; Thu, 25 Apr 2024 03:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039478; x=1714644278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mBgtuiCKBzoVzYLU6P6zbBW8ejOibsGMiGGBrCvDE4=;
        b=BfPuPc+xghvPN+rDhjOird53KRUkptWVE7/6Nnf5OUz0qtwcAizQPwif0+QxqLfUgI
         i8br0LV2LFqOQfTRHjVtO+Wyst5n+BcyBRo4eE5SS7fsnY1L7xUxdacfSAzNXnTIim3X
         tNRj3Hqh17NCkbfUprQPtFFx/v+CkJHf8iyrds7P6WN+y0scqPy3ROOewnzBTUvBrPI4
         LaPRzDC0F5jjr5Kjl5iHCyqG4VfjJZRpnu6+ln166Wv+Z4gd42auGaHv7f8gNdinBm6U
         JeUojvJ44glutKFg7mhZ+XrDMzS6tWWXtRk8dPaZQblXKy8wRuo9LZVaIpbMUuzMdzHs
         Gv1Q==
X-Gm-Message-State: AOJu0YwaL5RdOPy+Pi9CSbu0LLK84Az8C5VOhNu/TkdulpAuZLeJwNrE
	R2vu6gSsMoRKAJQwKi4zIULq8jXCY5MJXckvynNeHITYNwA5aaBxev25r9bIz1ZUYTnzEdk78oj
	tmC0m5Z/nbQkHime82yu1lWOpQ9G2bzhOj1KyeTdUiAzMtjNwKJFYC/1S3WhbUGIU7icDICcxWv
	eFu7shknRV4a/1jpaInqB3Z3e+d6wYeLtZfgnrPjvdYg==
X-Received: by 2002:a17:90b:364d:b0:2af:5c36:b2f2 with SMTP id nh13-20020a17090b364d00b002af5c36b2f2mr3556668pjb.4.1714039478315;
        Thu, 25 Apr 2024 03:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVDx426qsql+BWbtnG8FmXe2oLr4J6joMt/VULjm8R8veF+8DYtvh44vWQwrBuqmwFeSiPzQ==
X-Received: by 2002:a17:90b:364d:b0:2af:5c36:b2f2 with SMTP id nh13-20020a17090b364d00b002af5c36b2f2mr3556612pjb.4.1714039477308;
        Thu, 25 Apr 2024 03:04:37 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sv14-20020a17090b538e00b002ab3bffb765sm12619473pjb.32.2024.04.25.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:36 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
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
Subject: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
Date: Thu, 25 Apr 2024 18:04:24 +0800
Message-ID: <20240425100434.198925-1-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_030444_390092_3D08A3F9 
X-CRM114-Status: GOOD (  27.31  )
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

LUKS is the standard for Linux disk encryption. Many users choose LUKS
and in some use cases like Confidential VM it's mandated. With kdump
enabled, when the 1st kernel crashes, the system could boot into the
kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
specified target. Currently, when dumping vmcore to a LUKS
encrypted device, there are two problems,

 - Kdump kernel may not be able to decrypt the LUKS partition. For some
   machines, a system administrator may not have a chance to enter the
   password to decrypt the device in kdump initramfs after the 1st kernel
   crashes; For cloud confidential VMs, depending on the policy the
   kdump kernel may not be able to unseal the keys with TPM and the
   console virtual keyboard is untrusted.

 - LUKS2 by default use the memory-hard Argon2 key derivation function
   which is quite memory-consuming compared to the limited memory reserved
   for kdump. Take Fedora example, by default, only 256M is reserved for
   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
   to be reserved for kdump. Note if the memory reserved for kdump can't
   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
   1st kernel.

Besides users (at least for Fedora) usually expect kdump to work out of
the box i.e. no manual password input is needed. And it doesn't make
sense to derivate the keys again in kdump kernel which seems to be
redundant work.

This patch set addresses the above issues by make the LUKS volume keys
persistent for kdump kernel with the help of cryptsetup's new APIs
(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
this kdump copy of LUKS volume keys,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
    volume keys and then save the volume keys to specified keyring
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2. A user space tool (kdump initramfs builder) writes a key description to
    /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
    key while building the kdump initramfs

 3. The kexec_file_load syscall read the volume keys by recored key
    descriptions and then save them key to kdump reserved memory and wipe the
    copy.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
    initramfs asks the kdump kernel to create a user key using the key stored in
    kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
    the LUKS encrypted devide is unlocked with libcryptsetup's
    --volume-key-keyring API.

 5. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

After libcryptsetup saving the LUKS volume keys to specified keyring,
whoever takes this should be responsible for the safety of these copies
of keys. The keys will be saved in the memory area exclusively reserved
for kdump where even the 1st kernel has no direct access. And further
more, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

This patch set only supports x86. There will be patches to support other
architectures once this patch set gets merged.

v3
 - Support CPU/memory hot-plugging [Baoquan]
 - Don't save the keys temporarily to simplify the implementation [Baoquan] 
 - Support multiple LUKS encrypted volumes
 - Read logon key instead of user key to improve security [Ondrej]
 - A kernel config option CRASH_DM_CRYPT for this feature (disabled by default)
 - Fix warnings found by kernel test robot
 - Rebase the code onto 6.9.0-rc5+

v2
 - work together with libscryptsetup's --link-vk-to-keyring/--volume-key-keyring APIs [Milan and Ondrej]
 - add the case where console virtual keyboard is untrusted for confidential VM
 - use dm_crypt_key instead of LUKS volume key [Milan and Eric]
 - fix some code format issues
 - don't move "struct kexec_segment" declaration
 - Rebase the code onto latest Linus tree (6.7.0)

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

Coiby Xu (7):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: make dm crypt keys persist for the kdump kernel
  crash_dump: store dm keys in kdump reserved memory
  crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
  crash_dump: retrieve dm crypt keys in kdump kernel
  x86/crash: pass dm crypt keys to kdump kernel
  x86/crash: make the page that stores the dm crypt keys inaccessible

 arch/x86/kernel/crash.c            |  15 +-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  21 ++
 include/linux/crash_core.h         |   9 +-
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/Kconfig.kexec               |   8 +
 kernel/Makefile                    |   1 +
 kernel/crash_dump_dm_crypt.c       | 319 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 ++
 kernel/ksysfs.c                    |  22 ++
 11 files changed, 423 insertions(+), 2 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

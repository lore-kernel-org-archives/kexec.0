Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C96C02180
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 06:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EZ3Ti6PG4e4Lst6sfiafoj9LhuC07KGWd6noDAYoUzY=; b=qB07JbUVhUEW/VpQjkI3HN2ObE
	/sROMWbdeAMqvWIl07BYC1IUBC1uC12XIb9Tql6F6NtpfbQVynGuxNVYJfYN1KH7mT8k4/ipvK8U4
	OC7zwcED7txjw7ytvdOZgIIqjay2Kb1G6sVhlPaPUMOT/oBCmPv5okfPBBXV65h/QWsFzJ4Twlddg
	KPcwZvC5SXLi9Gxq+FVZ9bPlN2gW+5T8ceafPvUYaLOIEK+cHMQCOiem1pT+vuJxICJX56FTE+Kp3
	jLVUkRHeO++Mm82b6kssNWKBAz3A2fzoJE4nk/JqomJaNExn8x5CEHS8q8oX3QE92cyj8VVgg4jld
	oSunTJFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJpu-0000000DzUh-2OVz;
	Thu, 16 Jan 2025 06:58:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJpp-0000000DzUH-34ID
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 06:58:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737010711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZ3Ti6PG4e4Lst6sfiafoj9LhuC07KGWd6noDAYoUzY=;
	b=aOA0Mv8/2dllacHpo1IU5uTE6DsmgIfUsGaGnsQe5pm5Kh8I6PNZ3an2h44qlducf7/Yp/
	4UrdfJX8F9VNorPsV7Oo0f3oYCcYPCgkOfbeHZWt/aT6rdtRzvv9ZF63e8Je5FOqcbKgcx
	DVsjkvPVnoHEGBZNTj6t5h2t7rCW2Pc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-GFMpOOUoPXCn3B5IWySnwg-1; Thu, 16 Jan 2025 01:58:30 -0500
X-MC-Unique: GFMpOOUoPXCn3B5IWySnwg-1
X-Mimecast-MFC-AGG-ID: GFMpOOUoPXCn3B5IWySnwg
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so2353286a91.0
        for <kexec@lists.infradead.org>; Wed, 15 Jan 2025 22:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737010709; x=1737615509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZ3Ti6PG4e4Lst6sfiafoj9LhuC07KGWd6noDAYoUzY=;
        b=AmQG04uYRkOTJy0s9zDqjOPi61VHukP+uvCFGShpIXr8SzTE3+Psi/0xCr5eeI+jdX
         65Vg29D+O3hszrEP1/7PAcre0XP+Wn3x2M9ywq8ENtAq93s1cL+a32c/NXnYOVMGpxD5
         Rg/kIjAB4S5OY+IHYNodBMMchYFtnVmGwVBp0pBf6haVdWT6NF6hUQCnSfH1mfaRBVYf
         bEojPy76z6iC9fOCJx9NqbSCkR11AuvwCire9jn6QK1aoZFKxzBYjUO6zF5Y5kegEjGe
         2FGQnt6j1QIhPtRD9d9FATGFrs0rnfejg6AHKycA2lxNh72isuTQFuyhanvwEe0pb/iv
         B1Uw==
X-Gm-Message-State: AOJu0YzuKoiBdfxdNprPxt18G7jK9Gx4a4HEPrihzOj7PXsY2gJdY41n
	v1/FsZKyCj3HkPq1u6UajiE0Ue5k0p2VQYsriGxz0XAdT9COhSF633PGT9fftEy+ICmZuv8xtMv
	MpZnAX+8DEMmOcQYg2wquqd3KOxn+GMuZIevYiuI3iI2mJt5D7a/jfehFhpmu4FdAHh80HMAGpe
	op4B7vqU5X/k3S2AJPhunFBVt59lHmt6fhNKj3hH4=
X-Gm-Gg: ASbGncuBHRv4x3TSNJlqZ8J3C3+sSNJmR514FJAtQXQlrwGbYRcUOhb2mIun47Y/TJo
	H9fU1eZOGJ1p0RBoI3ShF52dCmW4qLnkxe9W4IUeQeD0fikMx0Me1PG6MK9NZClqtmcNu1ZQrxh
	D4eK4yHdU978LUI1ZHpS+XGaM6B36TMWeMMhIolQ9eq9J2M9aNC3EW7yGLdYpYohGp2AMugP2gL
	gJiE2a4FJ52u1bR4ZqBN/oZ39At0vM6A4qrbLccAk4FUHis
X-Received: by 2002:a17:90b:1f92:b0:2ee:9d49:3aef with SMTP id 98e67ed59e1d1-2f548f61fdamr38629341a91.23.1737010708754;
        Wed, 15 Jan 2025 22:58:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVRbJi0kMHAX51Wjw3KAYWUmqHdBx4bFKKtigRVyWCgeP+ELx0Ka95IKdQlLayVvugRK3c4A==
X-Received: by 2002:a17:90b:1f92:b0:2ee:9d49:3aef with SMTP id 98e67ed59e1d1-2f548f61fdamr38629305a91.23.1737010708340;
        Wed, 15 Jan 2025 22:58:28 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c1cd61fsm2766522a91.27.2025.01.15.22.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 22:58:27 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v7 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
Date: Thu, 16 Jan 2025 14:58:15 +0800
Message-ID: <20250116065825.1041558-1-coxu@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NSJtLvU4-xFat0ru2YE1ixxLWWG5IhovuWJHULocJB0_1737010709
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_225833_855507_7B7AAADE 
X-CRM114-Status: GOOD (  33.01  )
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

LUKS is the standard for Linux disk encryption, widely adopted by users,
and in some cases, such as Confidential VMs, it is a requirement. With 
kdump enabled, when the first kernel crashes, the system can boot into
the kdump/crash kernel to dump the memory image (i.e., /proc/vmcore) 
to a specified target. However, there are two challenges when dumping
vmcore to a LUKS-encrypted device:

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
the box i.e. no manual password input or custom crashkernel value is
needed. And it doesn't make sense to derivate the keys again in kdump
kernel which seems to be redundant work.

This patch set addresses the above issues by making the LUKS volume keys
persistent for kdump kernel with the help of cryptsetup's new APIs
(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
the kdump copies of LUKS volume keys,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase to de-crypt the LUKS volume keys
    or TPM-sealed key and then save the volume keys to specified keyring
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2. A user space tool (kdump initramfs loader like kdump-utils) create
    key items inside /sys/kernel/config/crash_dm_crypt_keys to inform
    the 1st kernel which keys are needed.

 3. When the kdump initramfs is loaded by the kexec_file_load
    syscall, the 1st kernel will iterate created key items, save the
    keys to kdump reserved memory.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the
    kdump initramfs asks the kdump kernel to create a user key using the
    key stored in kdump reserved memory by writing yes to
    /sys/kernel/crash_dm_crypt_keys/restore. Then the LUKS encrypted
    device is unlocked with libcryptsetup's --volume-key-keyring API.

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

v7
 - Baoquan
   - differentiate between failing to get dm crypt keys and no dm crypt keys
   - add code comments, change function name and etc. to improve code readability
 - add documentation for configfs API [Dave]
 - fix building error found by kernel test robot

v6
 - Baoquan
   - support AMD SEV
   - drop uncessary keys_header_size
   - improve commit message of [PATCH 4/7]
 
 - Greg
   - switch to configfs
   - move ifdef from .c to .h files and rework kexec_random_start
   - use tab instead of space for appended code comment
 
 - Process key description in a more flexible way to address problems
   found by Ondrej
 - improve cover letter
 - fix an compilation error as found by kernel test robot 

v5
 - Baoquan
   - limit the feature of placing kexec_buf randomly to kdump (CONFIG_CRASH_DUMP)
   - add documentation for added sysfs API 
   - allow to re-send init command to support the case of user switching to
     a different LUKS-encrypted target
   - make CONFIG_CRASH_DM_CRYPT depends on CONFIG_DM_CRYPT
   - check if the number of keys exceed KEY_NUM_MAX
   - rename (struct keys_header).key_count as (struct keys_header).total_keys
     to improve code readability
   - improve commit message
   - fix the failure of calling crash_exclude_mem_range (there is a split
     of mem_range)
   - use ret instead of r as return code
 
 - Greg
   - add documentation for added sysfs API 
   - avoid spamming kernel logs 
   - fix a buffer overflow issue
   - keep the state enums synced up with the string values
   - use sysfs_emit other than sprintf
   - explain KEY_NUM_MAX and KEY_SIZE_MAX
   - s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL/g
   - improve code readability
 
 - Rebase onto latest Linus tree


v4
- rebase onto latest Linus tree so Baoquan can apply the patches for
  code review
- fix kernel test robot warnings

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
  crash_dump: store dm crypt keys in kdump reserved memory
  crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
  crash_dump: retrieve dm crypt keys in kdump kernel
  x86/crash: pass dm crypt keys to kdump kernel
  x86/crash: make the page that stores the dm crypt keys inaccessible

 Documentation/admin-guide/kdump/kdump.rst |  32 ++
 arch/x86/kernel/crash.c                   |  26 +-
 arch/x86/kernel/kexec-bzimage64.c         |  11 +
 arch/x86/kernel/machine_kexec_64.c        |  22 ++
 include/linux/crash_core.h                |   7 +-
 include/linux/crash_dump.h                |   2 +
 include/linux/kexec.h                     |  34 ++
 kernel/Kconfig.kexec                      |  10 +
 kernel/Makefile                           |   1 +
 kernel/crash_dump_dm_crypt.c              | 459 ++++++++++++++++++++++
 kernel/kexec_file.c                       |   3 +
 11 files changed, 604 insertions(+), 3 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c


base-commit: be548645527a131a097fdc884b7fca40c8b86231
-- 
2.47.1



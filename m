Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC63C27C55
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OIY8KhJ9dBGwYoFecU7I450Q/Yt0vxqdychtJMQEUkY=; b=CVVOWqtg2/vX01
	MUSVncHKpkKsGCabXKYxlG2H2Wqtie1F+C4mL3TRU2GSrRmBwu3PDRsvptk/1Ymo+wfUu1wt8Nxpy
	+2wLYexI7EtSl+E2PcZ+0PYR1dWS6GrYEIcM6o66SMCBBcZ53U2aS/+YKUjW4ZEJTRGA/2NIe570k
	GEIufd44gVzMX2NlJZoQRliiTZlRDLynzPvbsk6ayfjmFwOQQ8ZaQfweqjWS/EwPBi2el49UCsiuu
	K+Wy6WZHymgD5+mBK0s3B2pz2ZyUa/o6M34PJXeXX1U/4t1JIBiEvehnoTUYf1Y0O/ei391G4Fil5
	usTMg3JrOvVZlfEbFT0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYg2-0000000DuQR-3sCi;
	Fri, 07 Jun 2024 12:26:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYfz-0000000DuOj-2Pmj
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Ye7TUlWGVwaoRmGXVybvrJOftk1EN7ZAVdp3Qc0L94=;
	b=gEbjmagri8RWdLfRNvpm9q6XAdSSYybkEJozag6DnE8kzh/XMwuf54XN+P9VRpLhH5AEVX
	/1T01TwgrvfxYXdx+aD2JmpAqAlh5TVmvGKdmq9LmmIZFQZ1m1oIqALPOfCI/GXXJI6twg
	RTLnGqiV4jJwZ5odSkaOppcSMXyxlC8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-CI_YYbUZOvmsANyXVHaZ3A-1; Fri, 07 Jun 2024 08:26:32 -0400
X-MC-Unique: CI_YYbUZOvmsANyXVHaZ3A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c1aefa2d9bso1987124a91.2
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763189; x=1718367989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ye7TUlWGVwaoRmGXVybvrJOftk1EN7ZAVdp3Qc0L94=;
        b=Mdy5PtxlJ28bPsewgSxzGgEGlMoTNV6oYGSXlhOMogAvrd/oJ03rLsnlnjg5h83G41
         ySVakHf09lO2DPo89OPe5MsAGkQQIk3evi9PYNlR7siFnPzBXGDiuviXs/Wh6Y7xv852
         uj+/xZtzNxtNZ5M6Izuu2N/D/bhBNRm57UB9wwGSiPAWvoHD7ZxROUO/5dQ6r/xWBqeU
         QJo6afOMsbJDgPaQ5JE5Cm62i/1uls6UMlqHgaluhF4njtE9EwI3tuaPzra7mc/pcxNV
         iSAA+25pmlbO8nArfJswrMhkkTv+Kq98i77QVYu9o00PYPKrLAp1uNuZkDOYV4zKh5Mg
         8gFA==
X-Gm-Message-State: AOJu0YycEfvLeClun5cEChgtactHjvdMcohsB4iWOPuQ+EfXJlAzM8yj
	kyOnXtYSF/cMQhixLDLCd8gInrb2FI7CkroZwoBV9ZDd54OJnjNa0xYgPusWdPw//TDKYDW9NYl
	5H6fQx9NUYoewvtgc+50WqHiqnWCun60gfR0V6lprr+N7TMR6P6WLDXBka/JPeHQtU6gjTqVi4Z
	3KXSNsgD/Cs26WZGMYP+5T7kDCxqtZACTD/U0BbhA6tQ==
X-Received: by 2002:a17:90b:2390:b0:2c2:8900:5099 with SMTP id 98e67ed59e1d1-2c2bcaf9544mr2355453a91.24.1717763188826;
        Fri, 07 Jun 2024 05:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz8w8DwShh8ATwO6szbxdFLkZKG8V46MbQm3km4mnZIlza1s/Cm0/qJLC7E0A9H69oWv+0jA==
X-Received: by 2002:a17:90b:2390:b0:2c2:8900:5099 with SMTP id 98e67ed59e1d1-2c2bcaf9544mr2355404a91.24.1717763187819;
        Fri, 07 Jun 2024 05:26:27 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c21e281sm3495463a91.18.2024.06.07.05.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:26:27 -0700 (PDT)
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
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing LUKS volume keys
Date: Fri,  7 Jun 2024 20:26:10 +0800
Message-ID: <20240607122622.167228-1-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052635_882426_081BBB01 
X-CRM114-Status: GOOD (  31.52  )
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

 3. The kexec_file_load syscall read the volume keys by recorded key
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

v5
 - Baoquan
   - limit the feature of placing kexec_buf randomly to kdump (CONFIG_CRASH_DUMP)
   - add documentation for added sysfs API 
   - allow to re-send init command to support the case of user switching to
     a different LUKS-encrypted target
   - make CONFIG_CRASH_DM_CRYPT depends on CONFIG_DM_CRYPT
   - check if the number of keys exceed KEY_NUM_MAX
   - rename (struct keys_header).key_count as (struct
     keys_header).total_keys to improve code readiblity
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

 Documentation/ABI/testing/crash_dm_crypt_keys |  35 ++
 arch/x86/kernel/crash.c                       |  20 +-
 arch/x86/kernel/kexec-bzimage64.c             |   7 +
 arch/x86/kernel/machine_kexec_64.c            |  22 ++
 include/linux/crash_core.h                    |   9 +-
 include/linux/crash_dump.h                    |   2 +
 include/linux/kexec.h                         |   8 +
 kernel/Kconfig.kexec                          |   9 +
 kernel/Makefile                               |   1 +
 kernel/crash_dump_dm_crypt.c                  | 338 ++++++++++++++++++
 kernel/kexec_file.c                           |  21 ++
 kernel/ksysfs.c                               |  24 ++
 12 files changed, 493 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/crash_dm_crypt_keys
 create mode 100644 kernel/crash_dump_dm_crypt.c


base-commit: 8a92980606e3585d72d510a03b59906e96755b8a
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

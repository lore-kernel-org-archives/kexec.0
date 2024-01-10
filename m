Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9DDC47073
	for <kexec@archiver.kernel.org>; Wed, 10 Jan 2024 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=n0cUUd7D2QGyRHf7mtg7WKIzdU2d23vuu4IyYF/+qkQ=; b=1iwmCSvuAozJE5
	70dLGEo46ibw7wPpY0cEH9bgVmVvHG9mt2oI2RSe2nE8eQb46olgwM1+SVceG/e1d/L5FWtmHv4qP
	l6RxNMbsFsNBOGMFoY+Eyhlj0y3UdOZb5fi34sq5H4QJjnO1ayQqzlne2kkSC4655iUHYClUjIyJX
	NQBzGETaZ6Y0VJuARUQbDdv8Hi8YFYnqm6QhV9tw1NBEyP482XH10+6XrZsE+oTajE7x1Hg/Z5nF7
	62fU0szsgSxlImi0ogkitDYIgibHWRekslrnpMzIlHuf0MQiRcPa1hR+cyKVppSpjiYTAeZpxm+/J
	JpvE0WEJIHhtETNU5cOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSr4-00AaZP-15;
	Wed, 10 Jan 2024 07:18:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNSr0-00AaYB-2m
	for kexec@lists.infradead.org;
	Wed, 10 Jan 2024 07:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704871102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kTt5OI9QpO/BOpHgZl5opubNaUnNqKIIbtwHk4ms4Vs=;
	b=iBwRsMMZfJwudjeK12IoHifpb/G4JINXOy/Eu1JetakytL039uWnS9RotqOr2kPL2+ZF+B
	pCh0MNc0vLiMkx022XPXv2YwLT/G/MilO8p03ilSI9hBBJ7Q8MTXk0D2/Sys9R38xjMx3Q
	h8KCoEnqvK11TLdFp3MR5wSiy3yGRLA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-nHgvp-mZMeKBTl3_W6f6pQ-1; Wed, 10 Jan 2024 02:15:27 -0500
X-MC-Unique: nHgvp-mZMeKBTl3_W6f6pQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bd36b9fd9dso2891866b6e.2
        for <kexec@lists.infradead.org>; Tue, 09 Jan 2024 23:15:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704870926; x=1705475726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTt5OI9QpO/BOpHgZl5opubNaUnNqKIIbtwHk4ms4Vs=;
        b=pUEnsNEndWUVHXS7hXGkX8KZ4Gv3oEIMr3QPpxJwYg9UOl4CoY+aXjPLaEkRvOWGVQ
         gG+OhZIKZCgWnaS9U0h7U0WF9Bu+wDxZGZUP1iLH9EaXU/h6RFdkEDedMBsuI76ZqNL8
         nVJAXbLBf6qpTcU122U2/sx/x7fM6eDR9dIFMw7Bf4z3Dp6pgHGbuEOXIA/7bimLYC+/
         y3bdpCq2JNbWyXKCKa8CUcDbRg2W8Fz+lU2JVg9+UJ1SOphcF7imWbN+WWvsHxk4xR6A
         Abiry8tumBivcc6QpQYLcy8VU7cF8Gkkq6iSqcoMP4aXpoJ5vewTR7qSR4iLQ2KZwJva
         86RA==
X-Gm-Message-State: AOJu0YzykyBm3FpE9k4gBph7EaxTXIjv7jLh+pt3AJrHNUW1IEF0nndI
	rpegwkVcg+xH1DjfG5Lq8uE4eEqqesp4rFgHK6KSrssaOZcMSSwpwjiJ2K6FbMaKjEXHBef87A0
	wJB1zfQARIKfwXUGna2WoG7rW23f2hf/o1TxU7A4FPQz8uoz4vlSHIXZ8X9J/uIz575ewHNnb6I
	cc5ctZ0JLQQPNIYoc=
X-Received: by 2002:a05:6808:171c:b0:3bb:bd15:828f with SMTP id bc28-20020a056808171c00b003bbbd15828fmr708216oib.104.1704870925980;
        Tue, 09 Jan 2024 23:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcnf4K76GZhVdOd3OzWp6ce6KrNoWyMXwOawD6ZNkjJ1VBAeSHwpohfDcE3bBbnY3sxQM9PA==
X-Received: by 2002:a05:6808:171c:b0:3bb:bd15:828f with SMTP id bc28-20020a056808171c00b003bbbd15828fmr708190oib.104.1704870925574;
        Tue, 09 Jan 2024 23:15:25 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a24-20020a62d418000000b006d70b0d4639sm2897467pfh.107.2024.01.09.23.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 23:15:25 -0800 (PST)
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
Subject: [PATCH v2 0/5] Support kdump with LUKS encryption by reusing LUKS volume key
Date: Wed, 10 Jan 2024 15:15:15 +0800
Message-ID: <20240110071522.1308935-1-coxu@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_231822_973100_A571147D 
X-CRM114-Status: GOOD (  25.38  )
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
   kdump kernel may not be able to unseal the key with TPM and the
   console virtual keyboard is untrusted

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

This patch set addresses the above issues by reusing the LUKS volume key
in kdump kernel with the help of cryptsetup's new APIs
(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
this kdump copy of LUKS volume key,

 1. After the 1st kernel loads the initramfs during boot, systemd
    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
    volume key and then save the volume key to specified keyring 
    (using the --link-vk-to-keyring API) and the key will expire within
    specified time.

 2.  A user space tool (kdump initramfs builder) writes the key description to
    /sys/kernel/crash_dm_crypt_key to inform the 1st kernel to save a
    temporary copy of the volume key while building the kdump initramfs

 3. The kexec_file_load syscall saves the temporary copy of the volume
    key to kdump reserved memory and wipe the copy.

 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
    initramfs asks the kdump kernel to create a user key using the
    key stored in kdump reserved memory by writing the key
    description to /sys/kernel/crash_dm_crypt_key. Then the LUKS
    encrypted devide is unlocked with libcryptsetup's
    --volume-key-keyring API.

 5. The system gets rebooted to the 1st kernel after dumping vmcore to
    the LUKS encrypted device is finished

After libcryptsetup saving the LUKS volume key to specified keyring,
whoever takes this should be responsible for the safety of this copy
of key. This key will be saved in the memory area exclusively reserved
for kdump where even the 1st kernel has no direct access. And further
more, two additional protections are added,
 - save the copy randomly in kdump reserved memory as suggested by Jan
 - clear the _PAGE_PRESENT flag of the page that stores the copy as
   suggested by Pingfan

This patch set only supports x86. There will be patches to support other
architectures once this patch set gets merged.

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


Coiby Xu (5):
  kexec_file: allow to place kexec_buf randomly
  crash_dump: save the dm crypt key temporarily
  crash_dump: retrieve dm crypt key in kdump kernel
  x86/crash: pass the dm crypt key to kdump kernel
  x86/crash: make the page that stores the dm crypt key inaccessible

 arch/x86/kernel/crash.c            |  15 +-
 arch/x86/kernel/kexec-bzimage64.c  |   7 +
 arch/x86/kernel/machine_kexec_64.c |  18 +++
 include/linux/crash_core.h         |   7 +-
 include/linux/crash_dump.h         |   2 +
 include/linux/kexec.h              |   6 +
 kernel/Makefile                    |   2 +-
 kernel/crash_dump_dm_crypt.c       | 234 +++++++++++++++++++++++++++++
 kernel/kexec_file.c                |  15 ++
 kernel/ksysfs.c                    |  23 ++-
 10 files changed, 324 insertions(+), 5 deletions(-)
 create mode 100644 kernel/crash_dump_dm_crypt.c

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

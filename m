Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7F3C27C53
	for <kexec@archiver.kernel.org>; Sat,  8 Jun 2024 01:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MUoU0IZSAuKQLwgARkTz0d5vZDkLfMVGVIcTobBEzns=; b=zBhM4DPjRmOK488Bh5yicG/+ma
	ZGCywLMHtv2mKP9dIL7jQ7Cxew/eUgp7O03XDn0zaBZRwGpXnCZCOiynGF4Ly0dLfSY0NAqw9LF9I
	PjGO3OASgcC1QaqAbP5WzS76fCfKatqiHhDS7GcCHqmYLMdHWFWKe6UnTsoC30ftpM3IpEIbCbzt/
	FTY6FfPMpFGIk52/dhR3usN4Wc+L9Bj+Zmm+WpwBIKHTZcXJ7Q25ESl3FawF92yKOeolYQkrcb2K1
	S15D+T0KsMDSSV/+75D2ZEpeA/gmvWPy625MVM1cNNOVLQMU8ckaWyCat4rgvvADifbNesNqsnM1O
	L64cF6Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFkvu-0000000GDBK-0kiU;
	Sat, 08 Jun 2024 01:31:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFkvr-0000000GDAp-14Re
	for kexec@lists.infradead.org;
	Sat, 08 Jun 2024 01:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717810305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Il+x7mPxkybxlGmp96omLuhvnPqHbzJs6J/7vrJ884=;
	b=A2P2V+GYgflQt5XyVE4MHaHFdVoHI3WHTGHnvGogjOYqI+bxzTiJmrkYSLYa3vMNYwdq/0
	bl8yglHEmHTUT32OdcMvRYrE30vocGEA0KXg2XLtYfrnv3UD8iX8ODUD2agBu6yBbkAXad
	uCc96eYAyDs8mnexhNUqrd/XetbApdY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-u2dRL_DVPUuN8PZ-2ae6aQ-1; Fri, 07 Jun 2024 21:30:38 -0400
X-MC-Unique: u2dRL_DVPUuN8PZ-2ae6aQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-704231a9953so358084b3a.0
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 18:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717810237; x=1718415037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Il+x7mPxkybxlGmp96omLuhvnPqHbzJs6J/7vrJ884=;
        b=ok2eHug4g79AV73b1Tuco3aoy2F+0LsnkaltKUrFhaQRAyXLyG8Eytgz7j5cH9I5Nw
         tnIuOlB4PybUUuOkLHWMQru4gSfoQzN/kIZH5pcpgPUQQ7z4tR5Op3bxjitp+FwiZ6CX
         AceCxvDT5SqruHG9qf52gmQnzCanBECPnUT+FtyNbUOLyyBAEfU2cSEqo55Rto8F4ZCv
         R96kwjE69PMJmQcLhcoB4ck53yC0fC1xb1kM1ZOiLQdCxr/83H3s4SrDtvGVcxnoANPK
         WkKhjNxnBdZxpSXVvNckklZoFw2CeG5rs+IRkLBlI2AtIE4Pufsxm1TMeVzuFriiBm9u
         ZVRQ==
X-Gm-Message-State: AOJu0YwwikNs19U2M0kX3a4wq7bWLDt1YlztbbB6r5597abJ7X04JLqV
	VJQhKYGOh9Ph+8Wifhd4rLUnGJcoSVE3Wj2VQmlzvt/9BrpM6kjbcTxNWP/bFOD7HcYmE8lU0Gq
	+nAAJaWdf9PKROBibszSkmBAO9IpEFIB1wLF1f3QYsCnZ9qogbRmpZzea23inH9OzDATrh1W0eG
	bEjaOBWAr+/9Q3UbriU4fSAMN4u1Ld3mFmzsYJai/C5ZnL
X-Received: by 2002:a05:6a00:2e9c:b0:6ea:bf1c:9dfd with SMTP id d2e1a72fcca58-7040c737a8bmr4548049b3a.27.1717810235943;
        Fri, 07 Jun 2024 18:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf18qDxBKvh63AOJgteBoZ+l1rs1vBq/RxFyokdqBxSXDxTeJ/VWO2OgmN/pBacP7VyFcMzA==
X-Received: by 2002:a05:6a00:2e9c:b0:6ea:bf1c:9dfd with SMTP id d2e1a72fcca58-7040c737a8bmr4548005b3a.27.1717810235042;
        Fri, 07 Jun 2024 18:30:35 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70423a7f217sm251223b3a.206.2024.06.07.18.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 18:30:34 -0700 (PDT)
Date: Sat, 8 Jun 2024 09:26:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <26jkoqavu54xo4ctbpxfibhdlbc5kezu2kkyl5fbb7r6oizvo4@cmq5yaeszfqq>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_183147_383590_20DF02F3 
X-CRM114-Status: GOOD (  41.19  )
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

The subject prefix should be "[PATCH v5 0/7]". I'm sorry if it causes
any confusion.

On Fri, Jun 07, 2024 at 08:26:10PM +0800, Coiby Xu wrote:
>LUKS is the standard for Linux disk encryption. Many users choose LUKS
>and in some use cases like Confidential VM it's mandated. With kdump
>enabled, when the 1st kernel crashes, the system could boot into the
>kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
>specified target. Currently, when dumping vmcore to a LUKS
>encrypted device, there are two problems,
>
> - Kdump kernel may not be able to decrypt the LUKS partition. For some
>   machines, a system administrator may not have a chance to enter the
>   password to decrypt the device in kdump initramfs after the 1st kernel
>   crashes; For cloud confidential VMs, depending on the policy the
>   kdump kernel may not be able to unseal the keys with TPM and the
>   console virtual keyboard is untrusted.
>
> - LUKS2 by default use the memory-hard Argon2 key derivation function
>   which is quite memory-consuming compared to the limited memory reserved
>   for kdump. Take Fedora example, by default, only 256M is reserved for
>   systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>   to be reserved for kdump. Note if the memory reserved for kdump can't
>   be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>   1st kernel.
>
>Besides users (at least for Fedora) usually expect kdump to work out of
>the box i.e. no manual password input is needed. And it doesn't make
>sense to derivate the keys again in kdump kernel which seems to be
>redundant work.
>
>This patch set addresses the above issues by make the LUKS volume keys
>persistent for kdump kernel with the help of cryptsetup's new APIs
>(--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
>this kdump copy of LUKS volume keys,
>
> 1. After the 1st kernel loads the initramfs during boot, systemd
>    use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
>    volume keys and then save the volume keys to specified keyring
>    (using the --link-vk-to-keyring API) and the key will expire within
>    specified time.
>
> 2. A user space tool (kdump initramfs builder) writes a key description to
>    /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
>    key while building the kdump initramfs
>
> 3. The kexec_file_load syscall read the volume keys by recorded key
>    descriptions and then save them key to kdump reserved memory and wipe the
>    copy.
>
> 4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
>    initramfs asks the kdump kernel to create a user key using the key stored in
>    kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
>    the LUKS encrypted devide is unlocked with libcryptsetup's
>    --volume-key-keyring API.
>
> 5. The system gets rebooted to the 1st kernel after dumping vmcore to
>    the LUKS encrypted device is finished
>
>After libcryptsetup saving the LUKS volume keys to specified keyring,
>whoever takes this should be responsible for the safety of these copies
>of keys. The keys will be saved in the memory area exclusively reserved
>for kdump where even the 1st kernel has no direct access. And further
>more, two additional protections are added,
> - save the copy randomly in kdump reserved memory as suggested by Jan
> - clear the _PAGE_PRESENT flag of the page that stores the copy as
>   suggested by Pingfan
>
>This patch set only supports x86. There will be patches to support other
>architectures once this patch set gets merged.
>
>v5
> - Baoquan
>   - limit the feature of placing kexec_buf randomly to kdump (CONFIG_CRASH_DUMP)
>   - add documentation for added sysfs API
>   - allow to re-send init command to support the case of user switching to
>     a different LUKS-encrypted target
>   - make CONFIG_CRASH_DM_CRYPT depends on CONFIG_DM_CRYPT
>   - check if the number of keys exceed KEY_NUM_MAX
>   - rename (struct keys_header).key_count as (struct
>     keys_header).total_keys to improve code readiblity
>   - improve commit message
>   - fix the failure of calling crash_exclude_mem_range (there is a split
>     of mem_range)
>   - use ret instead of r as return code
>
> - Greg
>   - add documentation for added sysfs API
>   - avoid spamming kernel logs
>   - fix a buffer overflow issue
>   - keep the state enums synced up with the string values
>   - use sysfs_emit other than sprintf
>   - explain KEY_NUM_MAX and KEY_SIZE_MAX
>   - s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL/g
>   - improve code readability
>
> - Rebase onto latest Linus tree
>
>
>v4
>- rebase onto latest Linus tree so Baoquan can apply the patches for
>  code review
>- fix kernel test robot warnings
>
>v3
> - Support CPU/memory hot-plugging [Baoquan]
> - Don't save the keys temporarily to simplify the implementation [Baoquan]
> - Support multiple LUKS encrypted volumes
> - Read logon key instead of user key to improve security [Ondrej]
> - A kernel config option CRASH_DM_CRYPT for this feature (disabled by default)
> - Fix warnings found by kernel test robot
> - Rebase the code onto 6.9.0-rc5+
>
>v2
> - work together with libscryptsetup's --link-vk-to-keyring/--volume-key-keyring APIs [Milan and Ondrej]
> - add the case where console virtual keyboard is untrusted for confidential VM
> - use dm_crypt_key instead of LUKS volume key [Milan and Eric]
> - fix some code format issues
> - don't move "struct kexec_segment" declaration
> - Rebase the code onto latest Linus tree (6.7.0)
>
>v1
> - "Put the luks key handling related to crash_dump out into a separate
>   file kernel/crash_dump_luks.c" [Baoquan]
> - Put the generic luks handling code before the x86 specific code to
>   make it easier for other arches to follow suit [Baoquan]
> - Use phys_to_virt instead of "pfn -> page -> vaddr" [Dave Hansen]
> - Drop the RFC prefix [Dave Young]
> - Rebase the code onto latest Linus tree (6.4.0-rc4)
>
>RFC v2
> - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
>   dm-crypt
>   - to save a kdump copy of the LUKS volume key in 1st kernel
>   - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
>   - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
> - save the kdump copy of LUKS volume key randomly [Jan]
> - mark the kdump copy inaccessible [Pingfan]
> - Miscellaneous
>   - explain when operations related to the LUKS volume key happen [Jan]
>   - s/master key/volume key/g
>   - use crash_ instead of kexec_ as function prefix
>   - fix commit subject prefixes e.g. "x86, kdump" to x86/crash
>
>Coiby Xu (7):
>  kexec_file: allow to place kexec_buf randomly
>  crash_dump: make dm crypt keys persist for the kdump kernel
>  crash_dump: store dm crypt keys in kdump reserved memory
>  crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
>  crash_dump: retrieve dm crypt keys in kdump kernel
>  x86/crash: pass dm crypt keys to kdump kernel
>  x86/crash: make the page that stores the dm crypt keys inaccessible
>
> Documentation/ABI/testing/crash_dm_crypt_keys |  35 ++
> arch/x86/kernel/crash.c                       |  20 +-
> arch/x86/kernel/kexec-bzimage64.c             |   7 +
> arch/x86/kernel/machine_kexec_64.c            |  22 ++
> include/linux/crash_core.h                    |   9 +-
> include/linux/crash_dump.h                    |   2 +
> include/linux/kexec.h                         |   8 +
> kernel/Kconfig.kexec                          |   9 +
> kernel/Makefile                               |   1 +
> kernel/crash_dump_dm_crypt.c                  | 338 ++++++++++++++++++
> kernel/kexec_file.c                           |  21 ++
> kernel/ksysfs.c                               |  24 ++
> 12 files changed, 493 insertions(+), 3 deletions(-)
> create mode 100644 Documentation/ABI/testing/crash_dm_crypt_keys
> create mode 100644 kernel/crash_dump_dm_crypt.c
>
>
>base-commit: 8a92980606e3585d72d510a03b59906e96755b8a
>-- 
>2.45.1
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

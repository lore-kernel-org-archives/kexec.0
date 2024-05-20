Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C817C04FFE
	for <kexec@archiver.kernel.org>; Mon, 20 May 2024 06:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JckilLAwUnKJ7FZiSTwn8RZ6yIjw/jK2Ft7iMvHCNyI=; b=uJbOiJ98OOruqH
	ORcLnc5wjOk4OW1033R4CkPrPEQ2lfu8QrcF5TMKiV1iRSzQPHpS+RDiFIYNpRzsJodo09/Q88R7x
	PCDV+tmeeX4OKxVbF+lnubgT+8myXlaua13uoLSbbJvAs0NWGBYqawYS22ImPKVEBYJ6nZLO0doyX
	APAECSaYxRUNmHeLcSR1fWfWG7XDo1OgCqqJAID4GkLOC3g5baaiiLwG3mJJnTtrFeNIRr5JVVGHo
	DEX3c1F0Hu8z0hYQJN4XROE3JjfWXRAEX1vF3Uiz8lIYWvQEAHAw/aD1x3Y1agI2MBzA+/3m6X/r9
	fhYxZe2EfjaPgcgSOXAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8wLo-0000000DdvH-2vTa;
	Mon, 20 May 2024 06:18:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8wLl-0000000DduX-1xBA
	for kexec@lists.infradead.org;
	Mon, 20 May 2024 06:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716185900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ2GR7SV9RD28GqslUqCsxs5zlzRlJz11VNrDpNsX50=;
	b=IEl2Iji/D5SD3tgr0otXbQe3uuUAjVzvlasprvlvOaiDd8YK+t+xn4omAm4/qZ6I1kii4P
	IOfPO5Bnf6mMh0WMg0gyX6TPH1izxJvrmio/OzI1hIPuXVv0+6ajYi4s89VX7i/IDhlIKJ
	K6P64f0ZnLWbOvR2LLjZ7dhEkjdbiuM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-5FgW4QNPP4SCeJn3N9n1DQ-1; Mon,
 20 May 2024 02:18:14 -0400
X-MC-Unique: 5FgW4QNPP4SCeJn3N9n1DQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 279321C008B5;
	Mon, 20 May 2024 06:18:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C8FF491032;
	Mon, 20 May 2024 06:18:12 +0000 (UTC)
Date: Mon, 20 May 2024 14:18:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240519_231821_611824_693E3ACC 
X-CRM114-Status: GOOD (  41.79  )
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

Please don't add dm-devel@redhat.com in the public list because it's a
internal mailing list or aliase. And I got error when replying.

On 04/25/24 at 06:04pm, Coiby Xu wrote:
> LUKS is the standard for Linux disk encryption. Many users choose LUKS
> and in some use cases like Confidential VM it's mandated. With kdump
> enabled, when the 1st kernel crashes, the system could boot into the
> kdump/crash kernel and dump the memory image i.e. /proc/vmcore to a
> specified target. Currently, when dumping vmcore to a LUKS
> encrypted device, there are two problems,
> 
>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>    machines, a system administrator may not have a chance to enter the
>    password to decrypt the device in kdump initramfs after the 1st kernel
>    crashes; For cloud confidential VMs, depending on the policy the
>    kdump kernel may not be able to unseal the keys with TPM and the
>    console virtual keyboard is untrusted.
> 
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserved
>    for kdump. Take Fedora example, by default, only 256M is reserved for
>    systems having memory between 4G-64G. With LUKS enabled, ~1300M needs
>    to be reserved for kdump. Note if the memory reserved for kdump can't
>    be used by 1st kernel i.e. an user sees ~1300M memory missing in the
>    1st kernel.
> 
> Besides users (at least for Fedora) usually expect kdump to work out of
> the box i.e. no manual password input is needed. And it doesn't make
> sense to derivate the keys again in kdump kernel which seems to be
> redundant work.
> 
> This patch set addresses the above issues by make the LUKS volume keys
> persistent for kdump kernel with the help of cryptsetup's new APIs
> (--link-vk-to-keyring/--volume-key-keyring). Here is the life cycle of
> this kdump copy of LUKS volume keys,
> 
>  1. After the 1st kernel loads the initramfs during boot, systemd
>     use an user-input passphrase or TPM-sealed key to de-crypt the LUKS
>     volume keys and then save the volume keys to specified keyring
>     (using the --link-vk-to-keyring API) and the key will expire within
>     specified time.
> 
>  2. A user space tool (kdump initramfs builder) writes a key description to
>     /sys/kernel/crash_dm_crypt_keys to inform the 1st kernel to record the
>     key while building the kdump initramfs
> 
>  3. The kexec_file_load syscall read the volume keys by recored key
>     descriptions and then save them key to kdump reserved memory and wipe the
>     copy.
> 
>  4. When the 1st kernel crashes and the kdump initramfs is booted, the kdump
>     initramfs asks the kdump kernel to create a user key using the key stored in
>     kdump reserved memory by writing to to /sys/kernel/crash_dm_crypt_keys. Then
>     the LUKS encrypted devide is unlocked with libcryptsetup's
>     --volume-key-keyring API.
> 
>  5. The system gets rebooted to the 1st kernel after dumping vmcore to
>     the LUKS encrypted device is finished
> 
> After libcryptsetup saving the LUKS volume keys to specified keyring,
> whoever takes this should be responsible for the safety of these copies
> of keys. The keys will be saved in the memory area exclusively reserved
> for kdump where even the 1st kernel has no direct access. And further
> more, two additional protections are added,
>  - save the copy randomly in kdump reserved memory as suggested by Jan
>  - clear the _PAGE_PRESENT flag of the page that stores the copy as
>    suggested by Pingfan
> 
> This patch set only supports x86. There will be patches to support other
> architectures once this patch set gets merged.
> 
> v3
>  - Support CPU/memory hot-plugging [Baoquan]
>  - Don't save the keys temporarily to simplify the implementation [Baoquan] 
>  - Support multiple LUKS encrypted volumes
>  - Read logon key instead of user key to improve security [Ondrej]
>  - A kernel config option CRASH_DM_CRYPT for this feature (disabled by default)
>  - Fix warnings found by kernel test robot
>  - Rebase the code onto 6.9.0-rc5+
> 
> v2
>  - work together with libscryptsetup's --link-vk-to-keyring/--volume-key-keyring APIs [Milan and Ondrej]
>  - add the case where console virtual keyboard is untrusted for confidential VM
>  - use dm_crypt_key instead of LUKS volume key [Milan and Eric]
>  - fix some code format issues
>  - don't move "struct kexec_segment" declaration
>  - Rebase the code onto latest Linus tree (6.7.0)
> 
> v1
>  - "Put the luks key handling related to crash_dump out into a separate
>    file kernel/crash_dump_luks.c" [Baoquan]
>  - Put the generic luks handling code before the x86 specific code to
>    make it easier for other arches to follow suit [Baoquan]
>  - Use phys_to_virt instead of "pfn -> page -> vaddr" [Dave Hansen]
>  - Drop the RFC prefix [Dave Young]
>  - Rebase the code onto latest Linus tree (6.4.0-rc4)
> 
> RFC v2
>  - libcryptsetup interacts with the kernel via sysfs instead of "hacking"
>    dm-crypt
>    - to save a kdump copy of the LUKS volume key in 1st kernel
>    - to add a logon key using the copy for libcryptsetup in kdump kernel [Milan]
>    - to avoid the incorrect usage of LUKS master key in dm-crypt [Milan]
>  - save the kdump copy of LUKS volume key randomly [Jan]
>  - mark the kdump copy inaccessible [Pingfan]
>  - Miscellaneous
>    - explain when operations related to the LUKS volume key happen [Jan]
>    - s/master key/volume key/g
>    - use crash_ instead of kexec_ as function prefix
>    - fix commit subject prefixes e.g. "x86, kdump" to x86/crash
> 
> Coiby Xu (7):
>   kexec_file: allow to place kexec_buf randomly
>   crash_dump: make dm crypt keys persist for the kdump kernel
>   crash_dump: store dm keys in kdump reserved memory
>   crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
>   crash_dump: retrieve dm crypt keys in kdump kernel
>   x86/crash: pass dm crypt keys to kdump kernel
>   x86/crash: make the page that stores the dm crypt keys inaccessible
> 
>  arch/x86/kernel/crash.c            |  15 +-
>  arch/x86/kernel/kexec-bzimage64.c  |   7 +
>  arch/x86/kernel/machine_kexec_64.c |  21 ++
>  include/linux/crash_core.h         |   9 +-
>  include/linux/crash_dump.h         |   2 +
>  include/linux/kexec.h              |   6 +
>  kernel/Kconfig.kexec               |   8 +
>  kernel/Makefile                    |   1 +
>  kernel/crash_dump_dm_crypt.c       | 319 +++++++++++++++++++++++++++++
>  kernel/kexec_file.c                |  15 ++
>  kernel/ksysfs.c                    |  22 ++
>  11 files changed, 423 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> -- 
> 2.44.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

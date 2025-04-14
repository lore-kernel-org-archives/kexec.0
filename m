Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BB0C3601E
	for <kexec@archiver.kernel.org>; Mon, 14 Apr 2025 05:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZP9chJpPnIdDVNS2TKXrDys/VCOvlIPfDsKkgbXxcE=; b=RkgQFNHfdxqF4yVRLJgVAok5I0
	QV5BpaNeU+oCZ1yoCrGRW1XY7G6jUYRAcOYwKhNmFNOvBOKcadtc2QPQKp215y5ewUoutUxu/9Ofn
	BHF27+ENltHLeRz9vdJsJWqFaPvibmlSvuNdLys8W6iXGAqiQJVAeDyi1ZuwQ69VIigzpgcFrylHB
	EqX7N8Cv+pSwpODdqHu6Zzj/pBHKs7il7X2lEsI2Eahw5y9m2UEDk4S+86lWu9N1rPkj5tAJrQ/BL
	JBVqctQE+iSAf+Oy+XFEudcRSKFDxCXouPLzsIg4mM9VB86hhos3u6PYcCeS+abbqB27N1VzBRFx2
	cye6ZoPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Cdr-00000000jIW-0T0M;
	Mon, 14 Apr 2025 05:45:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Ccb-00000000j9K-2zYa
	for kexec@lists.infradead.org;
	Mon, 14 Apr 2025 05:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744609478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZP9chJpPnIdDVNS2TKXrDys/VCOvlIPfDsKkgbXxcE=;
	b=EdTBPJiQSOkEQcifQbZkypG79fuH0nbPsXKpU4+csRdlHX+cu6mqC2RfX6RIGSgnTDLa71
	ExPHvmKUQEb2du5e4DQmbp6r2judqKhEiXMRPSXsQiJYrzh+IuiT6vmxp3khS3dYvpLQlz
	TOKEK5Zd5iJMxlfkSkl5Sj58xTigQD0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-iEhSOb4kNaaXaWqwlf9Bnw-1; Mon,
 14 Apr 2025 01:44:34 -0400
X-MC-Unique: iEhSOb4kNaaXaWqwlf9Bnw-1
X-Mimecast-MFC-AGG-ID: iEhSOb4kNaaXaWqwlf9Bnw_1744609473
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4AE01955BC6;
	Mon, 14 Apr 2025 05:44:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A8B619560AD;
	Mon, 14 Apr 2025 05:44:28 +0000 (UTC)
Date: Mon, 14 Apr 2025 13:44:23 +0800
From: Baoquan He <bhe@redhat.com>
To: x86@kernel.org, akpm@linux-foundation.org, Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v8 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <Z/ygt1q27NF+/2BM@MiWiFi-R3L-srv>
References: <20250207080818.129165-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207080818.129165-1-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_224441_831852_30E399B4 
X-CRM114-Status: GOOD (  27.86  )
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

Hi X86 maintainers, Andrew,

On 02/07/25 at 04:08pm, Coiby Xu wrote:
......snip...
> This patch set only supports x86. There will be patches to support other
> architectures once this patch set gets merged.

who can help pick this patchset? It has been under many rounds of
reviewing, now it's ready for merging from kdump reviewers' side.
Or any comments or concern for further work?

Thanks
Baoquan

> 
> v8
>  - improve documentation [Randy]
>  - rebase onto 6.14.0-rc1
> 
> v7
>  - Baoquan
>    - differentiate between failing to get dm crypt keys and no dm crypt keys
>    - add code comments, change function name and etc. to improve code readability
>  - add documentation for configfs API [Dave]
>  - fix building error found by kernel test robot
> 
> v6
>  - Baoquan
>    - support AMD SEV
>    - drop uncessary keys_header_size
>    - improve commit message of [PATCH 4/7]
>  
>  - Greg
>    - switch to configfs
>    - move ifdef from .c to .h files and rework kexec_random_start
>    - use tab instead of space for appended code comment
>  
>  - Process key description in a more flexible way to address problems
>    found by Ondrej
>  - improve cover letter
>  - fix an compilation error as found by kernel test robot 
> 
> v5
>  - Baoquan
>    - limit the feature of placing kexec_buf randomly to kdump (CONFIG_CRASH_DUMP)
>    - add documentation for added sysfs API 
>    - allow to re-send init command to support the case of user switching to
>      a different LUKS-encrypted target
>    - make CONFIG_CRASH_DM_CRYPT depends on CONFIG_DM_CRYPT
>    - check if the number of keys exceed KEY_NUM_MAX
>    - rename (struct keys_header).key_count as (struct keys_header).total_keys
>      to improve code readability
>    - improve commit message
>    - fix the failure of calling crash_exclude_mem_range (there is a split
>      of mem_range)
>    - use ret instead of r as return code
>  
>  - Greg
>    - add documentation for added sysfs API 
>    - avoid spamming kernel logs 
>    - fix a buffer overflow issue
>    - keep the state enums synced up with the string values
>    - use sysfs_emit other than sprintf
>    - explain KEY_NUM_MAX and KEY_SIZE_MAX
>    - s/EXPORT_SYMBOL_GPL/EXPORT_SYMBOL/g
>    - improve code readability
>  
>  - Rebase onto latest Linus tree
> 
> 
> v4
> - rebase onto latest Linus tree so Baoquan can apply the patches for
>   code review
> - fix kernel test robot warnings
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
> 
> Coiby Xu (7):
>   kexec_file: allow to place kexec_buf randomly
>   crash_dump: make dm crypt keys persist for the kdump kernel
>   crash_dump: store dm crypt keys in kdump reserved memory
>   crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging
>   crash_dump: retrieve dm crypt keys in kdump kernel
>   x86/crash: pass dm crypt keys to kdump kernel
>   x86/crash: make the page that stores the dm crypt keys inaccessible
> 
>  Documentation/admin-guide/kdump/kdump.rst |  32 ++
>  arch/x86/kernel/crash.c                   |  26 +-
>  arch/x86/kernel/kexec-bzimage64.c         |  11 +
>  arch/x86/kernel/machine_kexec_64.c        |  22 ++
>  include/linux/crash_core.h                |   7 +-
>  include/linux/crash_dump.h                |   2 +
>  include/linux/kexec.h                     |  34 ++
>  kernel/Kconfig.kexec                      |  10 +
>  kernel/Makefile                           |   1 +
>  kernel/crash_dump_dm_crypt.c              | 459 ++++++++++++++++++++++
>  kernel/kexec_file.c                       |   3 +
>  11 files changed, 604 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/crash_dump_dm_crypt.c
> 
> 
> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
> -- 
> 2.48.1
> 



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC765C54E68
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=k/bA2W5Zs64ZlaJ1JlnJZo6eywP62LXgIejcdu6PJYI=; b=o4oARgkb9QscKt
	yeQ1GAMiqzcnNJaKUVSCLZ9smBIA6SsonLYTvfgCKVDoODD6S3GHmzIG5V7mFi+aMP3WLI+IRae8T
	1bzqXlUOG4mkInjtSfhYizacZTMWVutIl8VNljrAZdtq94yUI5cff2HBqaMmcIboH/QqhAIU0PFpC
	RYvUguX0m9AiT9Q1bSiQJky/JzjzPNQ0MAG5qjna1k7zL+r0O/YCg1HauTZZfjwNVs2h9pf5VjB5y
	ViWAzj+SCIuIoxzwTNPN+ANOwJJEzmS76eKeKZrwtTz/SpKgazGLYcRqhyYsv8KcF9lN/bgHKzjBX
	FIqjtexk093PUyCSz7wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFij-00000002e6m-2NIM;
	Thu, 21 Mar 2024 10:32:25 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFic-00000002e4r-1Eir
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 10:32:23 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 15607371E2;
	Thu, 21 Mar 2024 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711017135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=13vteFedUUVxmufczNCJawD0Yk2W50hvquAptpr/jQdyWZOYeAqlC0MpFRhw1IpkUeODzT
	K2N/TlaRC0RlTaFoRQseXMP2ks1QpDyGWtQra7BjlDlaixO4JDtAtjtKSouZfLXuXNBiu1
	HJmMb006uq1wCHGs9BsTJYO3+RwuTCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711017135;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=5nukl2HmVzOfMk837ThsumTolA/lj5Ise4JXlAup5LV5lBQ8YLoMRHnPBcmYl0tfwG5pZ0
	ib1gLy6kKHoe8tAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711017134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=HOjINw6mcHqRfq650Ub2UWbtVR51MEEZLOXc18FA4XJp6hEzgSWW/NpiiEL7YTAIX7wPnD
	CuYcMdZSQi61Ixbg0apHOIJ62IGzR3SnIzPMSU9G6SmN7i0jqEK4u9lJkMOd7IZL33Vpz+
	6+4ZxVu3GHX3li3ISz28mbp7vVvkLfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711017134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnetYEamxYncT4FyPau+ZNn1O61ZG25GO69+cy3P2YE=;
	b=YOZ1e2cYbsbiJxDynT6FYsJKv93I+fyipycrdT6O/Uk1fGX6AyH6lTd1Exelc9v+H8WeAb
	XjFOk3KROLRWz2AQ==
Date: Thu, 21 Mar 2024 11:32:14 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Dave Young <dyoung@redhat.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"Huang, Kai" <kai.huang@intel.com>
Subject: Re: [PATCH V2] x86/kexec: do not update E820 kexec table for
 setup_data
Message-ID: <ZfwMribQCTKWSO9l@dwarf.suse.cz>
References: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zfv8iCL6CT2JqLIC@darkstar.users.ipa.redhat.com>
X-Spamd-Result: default: False [-4.20 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.10)[-0.508];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_033218_841887_AFFE0D91 
X-CRM114-Status: GOOD (  24.42  )
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

Hi,

On Thu, Mar 21, 2024 at 05:23:20PM +0800, Dave Young wrote:
> crashkernel reservation failed on a Thinkpad t440s laptop recently. 
> Actually the memblock reservation succeeded, but later insert_resource()
> failed.
> 
> Test steps:
> kexec load -> /* make sure add crashkernel param eg. crashkernel=160M */
>     kexec reboot -> 
>         dmesg|grep "crashkernel reserved";
>             crashkernel memory range like below reserved successfully:
>             0x00000000d0000000 - 0x00000000da000000
>         But no such "Crash kernel" region in /proc/iomem
> 
> The background story is like below:
> 
> Currently E820 code reserves setup_data regions for both the current
> kernel and the kexec kernel, and it inserts them into the resources list.
> Before the kexec kernel reboots nobody passes the old setup_data, and
> kexec only passes fresh SETUP_EFI and SETUP_IMA if needed.  Thus the old
> setup data memory is not used at all.
> 
> Due to old kernel updates the kexec e820 table as well so kexec kernel
> sees them as E820_TYPE_RESERVED_KERN regions, and later the old setup_data
> regions are inserted into resources list in the kexec kernel by
> e820__reserve_resources().
> 
> Note, due to no setup_data is passed in for those old regions they are not
> early reserved (by function early_reserve_memory), and the crashkernel
> memblock reservation will just treat them as usable memory and it could
> reserve the crashkernel region which overlaps with the old setup_data
> regions. And just like the bug I noticed here, kdump insert_resource
> failed because e820__reserve_resources has added the overlapped chunks
> in /proc/iomem already.

wouldn't this be caused by
4a693ce65b186fddc1a73621bd6f941e6e3eca21 ("kdump: defer the
insertion of crashkernel resources")?

Before that the crashkernel resources were inserted from
arch_reserve_crashkernel() which is called before
e820__reserve_resources().

The semantics of E820_TYPE_RESERVED_KERN wrt kexec quite
inconsistent. It's treated as E820_TYPE_RAM by
e820__memblock_setup() and e820_type_to_iomem_type().

The problem we're seeing here is the result of the former.
e820__memblock_setup() will add the E820_TYPE_RESERVED_KERN
region to the memblock, merging with the neighbouring memblocks,
allowing crashkernel region to span across the originally
reserved area.

e820_type_to_iomem_type() treating E820_TYPE_RESERVED_KERN as
E820_TYPE_RAM will make the E820_TYPE_RESERVED_KERN appear as
system ram in /proc/iomem. If the old kexec_load (not
kexec_file_load) syscall is used, the userspace kexec utility
will construct the e820 table based on the contents of
/proc/iomem and the kexec kernel will see the
E820_TYPE_RESERVED_KERN range as E820_TYPE_RAM.  When
kexec_file_load is used the E820_TYPE_RESERVED_KERN type is
propagated to the kexec kernel by bzImage64_load() /
setup_e820_entries().


> Index: linux/arch/x86/kernel/e820.c
> ===================================================================
> --- linux.orig/arch/x86/kernel/e820.c
> +++ linux/arch/x86/kernel/e820.c
> @@ -1015,16 +1015,6 @@ void __init e820__reserve_setup_data(voi
>  		pa_next = data->next;
>  
>  		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -
> -		/*
> -		 * SETUP_EFI and SETUP_IMA are supplied by kexec and do not need
> -		 * to be reserved.
> -		 */
> -		if (data->type != SETUP_EFI && data->type != SETUP_IMA)
> -			e820__range_update_kexec(pa_data,
> -						 sizeof(*data) + data->len,
> -						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
> -

Your tree is missing this recent commit:
7fd817c906503b6813ea3b41f5fdf4192449a707 ("x86/e820: Don't
reserve SETUP_RNG_SEED in e820").

Wouldn't this fix [/paper over] your problem as well? I.e., isn't
SETUP_RNG_SEED the setup_data item that's causing your problem?

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

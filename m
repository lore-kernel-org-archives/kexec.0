Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC60CDB466
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 00:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izUkSbDfmlQNOHn67gDt4QYFdqixnFjivdkPID2enxk=; b=rTzfqydAIoUKskS769uvabbjRl
	ybeE2t9Ph0+WNXUl5YgpCB3XrTMCYEXba3uJ/rGWJMfZouJxUJ7/5al3RdR7ykWO3CzulZ30I5usL
	HuA7SZn90P3doo8rFGzCsfCutpwHopPgR8xedmQMMwrEplK3wc2huSXYTClapoNf+rsDNidNRHS3S
	rCZd2KglLTmMi1sE4wQye17kE4VFgmuxZobup2iZAh1/y4pyPy0k1Nbc0ejr51Rg8i6Y8L8zUrMpW
	KUIWTap6zSv6SKdxE/bOmJwf1XJxxdgemjvRfaInuU0SZVXk77Jv9AMWUofw7XeeeqhPNOzcXtxYe
	4GViQiTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboYZ-00000005U36-4BL1;
	Tue, 23 Jun 2026 00:00:00 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wboYV-00000005U1y-2LZg
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 23:59:58 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1384ebe7a10so4399027c88.1
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 16:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782172795; cv=none;
        d=google.com; s=arc-20240605;
        b=FbilOYGo719Sb1eJe/dQ9K388aMj7nJcmgCOhM3vFQd4ELlUEjqgBrxfsLXE7wJOAx
         +M4mPN40bIs9gkiMSKxhcY6r7IdVVg8J5KxJZZk4BCINtu5o8sSErgbmanjIepsaSF2B
         n76GAw14zjihGvEzkbWYTwMstyoXiS8p3oHrFoYrbu1jtslGqva0jbjewNdFNYsPE0Jc
         zwXJ/dLfK5HD+PmwkrVdycvNWnK8+nclBceN7ftSvsNCA8y4E0Bryo9OmzMKvcinesDR
         BBXh56piacZwVpCqnp5zboNwEC/KuK0Nka9CC80tEv2N7dqQM0CH4xaIFy/pislHq5Hl
         Pyrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=izUkSbDfmlQNOHn67gDt4QYFdqixnFjivdkPID2enxk=;
        fh=RY4ggQ53qNe06byfZitvNmYWpQCwgbvg0zotXYHjnhw=;
        b=KtIo27It7+J2t2ckq5QtmOa/Lm/2kZX7PtAbiuU8XI6NyCX02yU2A918VThW5bCgcP
         nzmoQ8sLc9+ApGOI+JLmJDOBGsCMl4GOWgywzo+asZJA9r6LMtfjfTVpD1Bn8CFOgOrn
         fDwAS5zb31pXJTu4Z716hdL0eJmYXz0GihIDW36KrWEZ2ei6SxoXO5twGY4vHpDVkEbA
         /lkMZ6fDoX6idxFCGO2SBrnvAI+2HKOd3WnzGqHowNF5ZYRqhRKKUyjD461OnkXXtFih
         nba32dVBCkStEd4OkKJxMgrUfwFR29ElC3vsaMmDXp1TXIzPS4mMN144GnpQlfw3p2/t
         ycnQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782172795; x=1782777595; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=izUkSbDfmlQNOHn67gDt4QYFdqixnFjivdkPID2enxk=;
        b=SjG3Oc3iou0frbsyOhODYGJZr0zL7TiwE4QPkzh6422HagpQ+PlcXvDNf8/8u/Qctu
         01hZ5YN+LPwxnS3tolEGOFQcsIZSrTgNyo3vCz9VcUAaVK/VMy8H1bCvNAlea4F3QAm9
         RowPqiRPBVeCl1EszB1hLDPK1AgpN6F/SYVzEwn+euna/tTvT4Yamk5lWYXn/xNTlnjM
         aux0lpBCSzPbPeCqPkGYcWgPg7P0VspYyrMxpH5dHAY4SRe+pfYXJTPNOLdO2xdjyfQz
         Wk1vOP7glXWA5cTWtDS/M0bWG4rFbAhSFgIg/kCbZvbR9JBlcPrs88sEOsW3qb0jOSYm
         IE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172795; x=1782777595;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izUkSbDfmlQNOHn67gDt4QYFdqixnFjivdkPID2enxk=;
        b=LMCP0P++E5mhVFlRL6iiYSjYTuJVZ8VfPga0kbwCD+X40EczS6hfbi2PJVKe1pN8hw
         mK+uKRmYWEqKSft9iWkTeEjs8TVYrzCdXLRkmWBKWeJCLhn7xXBTS5iboB9V5d1LY3J3
         2HXwrSmC9GMWnYnyM0g9AblqBQewpwQJPQMNbGv3Hoi0rPkSwCpd1YjX1tovSOT1DVtc
         4CxJ7m7/xBeKD6gb4teKpuLeXU/goFye4KBS8wnWwY18cHEmSckYXD2eSV5d1O6rNt6M
         oZmmwYMaCwftfWZDDMg84pSp9MFELiDUschYV+XTV6CCi+eNxq2krGb+KJf1al8YRGB4
         0i8w==
X-Forwarded-Encrypted: i=1; AFNElJ/XT9FsOYHDqHOLp98QF60bgeHYB11xKrHbOCDX/YboQjeTlbhDGGshulcKIO7+xXTqiQHYtQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8nM6hbZfFjOJEnJULoScejuXQ28b0ag4/WbQ5ZvtOLItBJVhU
	Yw9gd7Xo27ETLE2uz8qyTRpds6kOfpOw6PAXIuIN6xoImApJTOA5jexDNGVem12cpCzjmgmwPni
	L/zTGp0I33QH+2wPguW1iP/bz/5slPFS3eLy72bwG
X-Gm-Gg: AfdE7cnjtuQOwJT+4QgSX1fksd142Arq71CASoHcIigYZ2Nyj8R0pbW8KoTPZSERX1s
	cMZQ44GWz2P5lPTwK0nUUsmOzSdM6POo6l/6pRBlbjV93tgiLFY7ybnvglNdl6Q6rfFlXGdqEm4
	GeuA4Yj/33npNLwxyPqI9gZxTI5ld7EAV85VC8qCd0PMlUyJxT4cxWODuALQCWyLwoyPbYFHgFa
	/fzeIctFd6YkFG3b3j6jeCtv1+fvxZwbNL/5ZbOPq8N4YPaUNclonLat0O22p9zwH/oK925qrdo
	TLo/65KEozMDVhQ35LLMpJGVgrpvsc9LP7fpXsrzrP2NkPAZ1zSRXnw9x5g=
X-Received: by 2002:a05:7022:239f:b0:12d:de3e:52c1 with SMTP id
 a92af1059eb24-139c5e2d27fmr426595c88.37.1782172793679; Mon, 22 Jun 2026
 16:59:53 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:59:52 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:59:52 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com>
References: <cover.1780676742.git.tarunsahu@google.com> <20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:59:52 -0700
X-Gm-Features: AVVi8CfrDtA5h9OoS52m-5SKtGCl3rj7KRQFOYRYPcz5rppoei0C-yt2tsDCGII
Message-ID: <CAEvNRgGharGxs9s_ow0Z4iiQ9PCzdghch-4Fk6UMjiPP9tX-5g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/10] kvm: Prepare core VM structs and helpers for
 LUO support
To: Tarun Sahu <tarunsahu@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_165955_607439_9239525A 
X-CRM114-Status: GOOD (  33.17  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> Introduce core infrastructure to support VM preservation with LUO.
>
> First two changes are just refactoring, no functional change, third
> change introduces a new member in struct kvm.
> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
> - Add a public kvm_create_vm_file() helper wrapping kvm_create_vm()
>   and anon_inode_getfile() to provide a unified VM file creation API.
> - Track a weak reference to the backing file in struct kvm under
>   CONFIG_LIVEUPDATE_GUEST_MEMFD to enable reverse file resolution
>   without circular lifetime dependencies.
>

Given the above, I think this should be separate patches.

> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kvm_host.h | 14 +++++++
>  virt/kvm/kvm_main.c      | 79 +++++++++++++++++++++++++++++-----------
>  virt/kvm/kvm_mm.h        |  3 ++
>  3 files changed, 75 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4c14aee1fb06..9111a28637af 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -874,6 +874,18 @@ struct kvm {
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>  	/* Protected by slots_lock (for writes) and RCU (for reads) */
>  	struct xarray mem_attr_array;
> +#endif
> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
> +	/*
> +	 * Weak reference to the VFS file backing this KVM instance. Stored
> +	 * without incrementing the file refcount to prevent a circular lifetime
> +	 * dependency (since file->private_data already pins this struct kvm).
> +	 * Used exclusively to resolve the file pointer back from struct kvm.
> +	 *
> +	 * Written/cleared via rcu_assign_pointer() and read locklessly under
> +	 * RCU (e.g. via get_file_active() to prevent ABA races).
> +	 */
> +	struct file *vm_file;
>  #endif

We didn't really talk about this during the calls, but it seems weird to
preserve a vm_file with pretty much nothing other than the vm type. The
entire VM is re-created, which means it could potentially be a
completely different VM?

In some sense it's more flexible since the guest_memfd can be restored
with some completely different VM, but it seems like it could introduce
other issues.

I think other KVM folks would probably have more thoughts here.

>  	char stats_id[KVM_STATS_NAME_SIZE];
>  };
> @@ -1074,7 +1086,9 @@ void kvm_get_kvm(struct kvm *kvm);
>  bool kvm_get_kvm_safe(struct kvm *kvm);
>  void kvm_put_kvm(struct kvm *kvm);
>  bool file_is_kvm(struct file *file);
> +struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
>  void kvm_put_kvm_no_destroy(struct kvm *kvm);
> +void kvm_uevent_notify_vm_create(struct kvm *kvm);
>
>  static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
>  {
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 89489996fbc1..65f0c5fb353e 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -67,9 +67,6 @@
>  #include <linux/kvm_dirty_ring.h>
>
>
> -/* Worst case buffer size needed for holding an integer. */
> -#define ITOA_MAX_LEN 12
> -
>  MODULE_AUTHOR("Qumranet");
>  MODULE_DESCRIPTION("Kernel-based Virtual Machine (KVM) Hypervisor");
>  MODULE_LICENSE("GPL");
> @@ -1349,6 +1346,19 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
>  {
>  	struct kvm *kvm = filp->private_data;
>
> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
> +	/*
> +	 * Clear the weak reference of the vm file.
> +	 * In case vm file is closed by userspace, but kvm still has
> +	 * other users like vCPUs, clearing this pointer ensures
> +	 * that we don't have a dangling pointer to a closed file.
> +	 *
> +	 * Cleared via rcu_assign_pointer() to ensure proper memory visibility
> +	 * for concurrent lockless readers under RCU.
> +	 */
> +	rcu_assign_pointer(kvm->vm_file, NULL);
> +#endif
> +
>  	kvm_irqfd_release(kvm);
>
>  	kvm_put_kvm(kvm);
> @@ -5476,11 +5486,47 @@ bool file_is_kvm(struct file *file)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
>
> +struct file *kvm_create_vm_file(unsigned long type, const char *fdname)
> +{
> +	struct kvm *kvm = kvm_create_vm(type, fdname);
> +	struct file *file;
> +
> +	if (IS_ERR(kvm))
> +		return ERR_CAST(kvm);
> +
> +	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
> +	if (IS_ERR(file)) {
> +		kvm_put_kvm(kvm);
> +		return file;
> +	}
> +
> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
> +	/*
> +	 * Weak reference to the file (without get_file()) to prevent a circular
> +	 * dependency. Safe because the file's release path clears this pointer
> +	 * and drops its reference to the VM.
> +	 *
> +	 * Written via rcu_assign_pointer() because the pointer can be read
> +	 * locklessly under RCU (e.g., in kvm_gmem_luo_preserve() via
> +	 * get_file_active() to prevent lockless ABA races).
> +	 */
> +	rcu_assign_pointer(kvm->vm_file, file);
> +#endif
> +
> +	/*
> +	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
> +	 * already set, with ->release() being kvm_vm_release().  In error
> +	 * cases it will be called by the final fput(file) and will take
> +	 * care of doing kvm_put_kvm(kvm).
> +	 */
> +
> +	return file;
> +}
> +
>  static int kvm_dev_ioctl_create_vm(unsigned long type)
>  {
>  	char fdname[ITOA_MAX_LEN + 1];
>  	int r, fd;
> -	struct kvm *kvm;
>  	struct file *file;
>
>  	fd = get_unused_fd_flags(O_CLOEXEC);
> @@ -5489,31 +5535,17 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
>
>  	snprintf(fdname, sizeof(fdname), "%d", fd);
>
> -	kvm = kvm_create_vm(type, fdname);
> -	if (IS_ERR(kvm)) {
> -		r = PTR_ERR(kvm);
> -		goto put_fd;
> -	}
> -
> -	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
> +	file = kvm_create_vm_file(type, fdname);
>  	if (IS_ERR(file)) {
>  		r = PTR_ERR(file);
> -		goto put_kvm;
> +		goto put_fd;
>  	}
>
> -	/*
> -	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
> -	 * already set, with ->release() being kvm_vm_release().  In error
> -	 * cases it will be called by the final fput(file) and will take
> -	 * care of doing kvm_put_kvm(kvm).
> -	 */
> -	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, file->private_data);

Notifying with file->private_data threw me off... I would rather inline
the rcu_assign_pointer() in this function and have this line read
notify(..., kvm) like before.

>
>  	fd_install(fd, file);
>  	return fd;
>
> -put_kvm:
> -	kvm_put_kvm(kvm);
>  put_fd:
>  	put_unused_fd(fd);
>  	return r;
> @@ -6341,6 +6373,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>  	kfree(env);
>  }
>
> +void kvm_uevent_notify_vm_create(struct kvm *kvm)
> +{
> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
> +}
> +
>  static void kvm_init_debug(void)
>  {
>  	const struct file_operations *fops;
> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
> index 9fcc5d5b7f8d..7aa1d65c3d46 100644
> --- a/virt/kvm/kvm_mm.h
> +++ b/virt/kvm/kvm_mm.h
> @@ -3,6 +3,9 @@
>  #ifndef __KVM_MM_H__
>  #define __KVM_MM_H__ 1
>
> +/* Worst case buffer size needed for holding an integer as a string. */
> +#define ITOA_MAX_LEN 12
> +
>  /*
>   * Architectures can choose whether to use an rwlock or spinlock
>   * for the mmu_lock.  These macros, for use in common code
> --
> 2.54.0.1032.g2f8565e1d1-goog


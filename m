Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743F2CDB46F
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1Bny3807BZgTs2uePjipxUsmHzpP562txJFNUNSguI=; b=0e66Jdw/4RFQ7qIxQZmSN/qCQ3
	8GBcMIBR6vOvMDi5q3+6GRWvff37ubYjyowWsJLHLrkPs+tdxRt+DgT0zzjjMPm6ajIIBpYxwREao
	1AdkbDnqWZ0j8x4qy4YW03e0LXgUVyQyxPkVCzLWBFVApOzCl+cFXDlSb+qWcs6PvF6aO12VKcv9u
	9Y4FY30yXbdxVqJue54SWgFuLLYmptFDtQ5pz6xcQIq1HKKNG3kjP7b5SyGU2PdKH8nqeNzA2d24S
	y2QQ6XPoSqG/bzJpFWae8sP5yqU7O9TAFW0lvtxSP9iWXYYsr1nXbYA3RY98pk8fOrgputuw9cO6t
	/VQJZApQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc37z-00000006Xgd-0sbB;
	Tue, 23 Jun 2026 15:33:31 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc37x-00000006XgG-0nz6
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 15:33:30 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-69790cf5e04so3805274a12.1
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782228807; x=1782833607; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1Bny3807BZgTs2uePjipxUsmHzpP562txJFNUNSguI=;
        b=Ok/an32Imh/w8j3nFyIiO7RKy+IEoeuicA5p80hdYzTUILWS2WTTD5Ieudjo5T1SHK
         t+y+7UpiRt719evR0OhOTo2KHbGbBgw+rgqmfbQn+Xrl/6GBdmSpM15XJGmzx7D/AmyC
         K95NCS5yb11+QrO8YIVhrjbjFzGdxTAsABoWs+zvULjwyMaj9tzo91F5r2EpRW1X2DIc
         ppS18Rpxw23jCf5AUhgobDX4d+UEZWtR9My0142rNHyn1HOLWCcR7jrLGKXz2a8frA+8
         8jg8OIOcuz7rGLQ7VCOWqMABw0uZWzFh3UEk/TuQ5wfcBCoELitccqoogO3LFrW/xVxu
         uBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228807; x=1782833607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1Bny3807BZgTs2uePjipxUsmHzpP562txJFNUNSguI=;
        b=YDTY5mXFoOMn004QmXqQ71IDK6k7HCSAsRfy/KIJyhqBQWb9bQe777aFph9uVPEMZY
         oKYapchW/5CMqWHov6nwkxq+n9nPyH8Oloogoldp6agrc/2GewZSpdI9HSgcH9FbpOj/
         p2176799x1dQ22mtAWUGY+WaXxZ4fb8bsHHIQT/IKoxGTJ2eevGnqp1NOuy98eg2tfMq
         Mh5qUx84MQeKvfy1GdK/8S10d0f9C3LV5HtJBjXA5GLW8hHDCrHZ1ILSg32AOaTOvrm2
         SOiwFspjATST0dqpGLz42+kZdX4uFVn5HlKlIkytNwHSwE8r9beGv9/R9dRsateg62EW
         ZvKg==
X-Forwarded-Encrypted: i=1; AFNElJ/Aadkqq5znbezzWuRqrxSa0Wulvsf/X+FLZWbJXTkxgVK6Y2/RAu47xtkQgpBz0cWBZkb1KA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw5ic0hFoXKrHyfmIUISbYmQ9omj1MPeXx+0kQSLpeeMr4UBIz3
	vz4YROFJhRIFZ2theQlUr3x74A+5jOeIVKBtXfs3WEDYow1z5iLNB3UqdHXyqrE/8H6w+SQGfh9
	xitUdMNNeq/V99hHLag==
X-Received: from edgd28-n1.prod.google.com ([2002:a05:6402:a51c:10b0:695:d3d9:5811])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5253:b0:697:96c2:b591 with SMTP id 4fb4d7f45d1cf-69796c2c000mr5685499a12.11.1782228806744;
 Tue, 23 Jun 2026 08:33:26 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:33:26 +0000
In-Reply-To: <CAEvNRgGharGxs9s_ow0Z4iiQ9PCzdghch-4Fk6UMjiPP9tX-5g@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com>
 <CAEvNRgGharGxs9s_ow0Z4iiQ9PCzdghch-4Fk6UMjiPP9tX-5g@mail.gmail.com>
Message-ID: <9huzo6h1mfuh.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 03/10] kvm: Prepare core VM structs and helpers for
 LUO support
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
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
X-CRM114-CacheID: sfid-20260623_083329_278177_E91FDAF9 
X-CRM114-Status: GOOD (  31.89  )
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

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> Introduce core infrastructure to support VM preservation with LUO.
>>
>> First two changes are just refactoring, no functional change, third
>> change introduces a new member in struct kvm.
>> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
>> - Add a public kvm_create_vm_file() helper wrapping kvm_create_vm()
>>   and anon_inode_getfile() to provide a unified VM file creation API.
>> - Track a weak reference to the backing file in struct kvm under
>>   CONFIG_LIVEUPDATE_GUEST_MEMFD to enable reverse file resolution
>>   without circular lifetime dependencies.
>>
>
> Given the above, I think this should be separate patches.
>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/linux/kvm_host.h | 14 +++++++
>>  virt/kvm/kvm_main.c      | 79 +++++++++++++++++++++++++++++-----------
>>  virt/kvm/kvm_mm.h        |  3 ++
>>  3 files changed, 75 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 4c14aee1fb06..9111a28637af 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -874,6 +874,18 @@ struct kvm {
>>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>>  	/* Protected by slots_lock (for writes) and RCU (for reads) */
>>  	struct xarray mem_attr_array;
>> +#endif
>> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
>> +	/*
>> +	 * Weak reference to the VFS file backing this KVM instance. Stored
>> +	 * without incrementing the file refcount to prevent a circular lifetime
>> +	 * dependency (since file->private_data already pins this struct kvm).
>> +	 * Used exclusively to resolve the file pointer back from struct kvm.
>> +	 *
>> +	 * Written/cleared via rcu_assign_pointer() and read locklessly under
>> +	 * RCU (e.g. via get_file_active() to prevent ABA races).
>> +	 */
>> +	struct file *vm_file;
>>  #endif
>
> We didn't really talk about this during the calls, but it seems weird to
> preserve a vm_file with pretty much nothing other than the vm type. The
> entire VM is re-created, which means it could potentially be a
> completely different VM?
>
> In some sense it's more flexible since the guest_memfd can be restored
> with some completely different VM, but it seems like it could introduce
> other issues.
>
> I think other KVM folks would probably have more thoughts here.
>
>>  	char stats_id[KVM_STATS_NAME_SIZE];
>>  };
>> @@ -1074,7 +1086,9 @@ void kvm_get_kvm(struct kvm *kvm);
>>  bool kvm_get_kvm_safe(struct kvm *kvm);
>>  void kvm_put_kvm(struct kvm *kvm);
>>  bool file_is_kvm(struct file *file);
>> +struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
>>  void kvm_put_kvm_no_destroy(struct kvm *kvm);
>> +void kvm_uevent_notify_vm_create(struct kvm *kvm);
>>
>>  static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
>>  {
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 89489996fbc1..65f0c5fb353e 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -67,9 +67,6 @@
>>  #include <linux/kvm_dirty_ring.h>
>>
>>
>> -/* Worst case buffer size needed for holding an integer. */
>> -#define ITOA_MAX_LEN 12
>> -
>>  MODULE_AUTHOR("Qumranet");
>>  MODULE_DESCRIPTION("Kernel-based Virtual Machine (KVM) Hypervisor");
>>  MODULE_LICENSE("GPL");
>> @@ -1349,6 +1346,19 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
>>  {
>>  	struct kvm *kvm = filp->private_data;
>>
>> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
>> +	/*
>> +	 * Clear the weak reference of the vm file.
>> +	 * In case vm file is closed by userspace, but kvm still has
>> +	 * other users like vCPUs, clearing this pointer ensures
>> +	 * that we don't have a dangling pointer to a closed file.
>> +	 *
>> +	 * Cleared via rcu_assign_pointer() to ensure proper memory visibility
>> +	 * for concurrent lockless readers under RCU.
>> +	 */
>> +	rcu_assign_pointer(kvm->vm_file, NULL);
>> +#endif
>> +
>>  	kvm_irqfd_release(kvm);
>>
>>  	kvm_put_kvm(kvm);
>> @@ -5476,11 +5486,47 @@ bool file_is_kvm(struct file *file)
>>  }
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
>>
>> +struct file *kvm_create_vm_file(unsigned long type, const char *fdname)
>> +{
>> +	struct kvm *kvm = kvm_create_vm(type, fdname);
>> +	struct file *file;
>> +
>> +	if (IS_ERR(kvm))
>> +		return ERR_CAST(kvm);
>> +
>> +	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
>> +	if (IS_ERR(file)) {
>> +		kvm_put_kvm(kvm);
>> +		return file;
>> +	}
>> +
>> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
>> +	/*
>> +	 * Weak reference to the file (without get_file()) to prevent a circular
>> +	 * dependency. Safe because the file's release path clears this pointer
>> +	 * and drops its reference to the VM.
>> +	 *
>> +	 * Written via rcu_assign_pointer() because the pointer can be read
>> +	 * locklessly under RCU (e.g., in kvm_gmem_luo_preserve() via
>> +	 * get_file_active() to prevent lockless ABA races).
>> +	 */
>> +	rcu_assign_pointer(kvm->vm_file, file);
>> +#endif
>> +
>> +	/*
>> +	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
>> +	 * already set, with ->release() being kvm_vm_release().  In error
>> +	 * cases it will be called by the final fput(file) and will take
>> +	 * care of doing kvm_put_kvm(kvm).
>> +	 */
>> +
>> +	return file;
>> +}
>> +
>>  static int kvm_dev_ioctl_create_vm(unsigned long type)
>>  {
>>  	char fdname[ITOA_MAX_LEN + 1];
>>  	int r, fd;
>> -	struct kvm *kvm;
>>  	struct file *file;
>>
>>  	fd = get_unused_fd_flags(O_CLOEXEC);
>> @@ -5489,31 +5535,17 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
>>
>>  	snprintf(fdname, sizeof(fdname), "%d", fd);
>>
>> -	kvm = kvm_create_vm(type, fdname);
>> -	if (IS_ERR(kvm)) {
>> -		r = PTR_ERR(kvm);
>> -		goto put_fd;
>> -	}
>> -
>> -	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
>> +	file = kvm_create_vm_file(type, fdname);
>>  	if (IS_ERR(file)) {
>>  		r = PTR_ERR(file);
>> -		goto put_kvm;
>> +		goto put_fd;
>>  	}
>>
>> -	/*
>> -	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
>> -	 * already set, with ->release() being kvm_vm_release().  In error
>> -	 * cases it will be called by the final fput(file) and will take
>> -	 * care of doing kvm_put_kvm(kvm).
>> -	 */
>> -	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, file->private_data);
>
> Notifying with file->private_data threw me off... I would rather inline
> the rcu_assign_pointer() in this function and have this line read
> notify(..., kvm) like before.

Yes, I will update it to:

     struct kvm *kvm;
     ...
     kvm = file->private_data;
     notify (..., kvm);

About rcu_assign_pointer, I am not sure, IIUC. that only set the
kvm->vm_file pointer, which does not have any relation with
file->private_data. And keeping the rcu_assign_pointer(kvm->vm_file,
file) at the current place (inside kvm_create_vm_file) logically makes
sense. because, kvm_create_vm_file creates the struct kvm and vm_file,
So, all the relation variables should get updated there.

>
>>
>>  	fd_install(fd, file);
>>  	return fd;
>>
>> -put_kvm:
>> -	kvm_put_kvm(kvm);
>>  put_fd:
>>  	put_unused_fd(fd);
>>  	return r;
>> @@ -6341,6 +6373,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>>  	kfree(env);
>>  }
>>
>> +void kvm_uevent_notify_vm_create(struct kvm *kvm)
>> +{
>> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>> +}
>> +
>>  static void kvm_init_debug(void)
>>  {
>>  	const struct file_operations *fops;
>> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
>> index 9fcc5d5b7f8d..7aa1d65c3d46 100644
>> --- a/virt/kvm/kvm_mm.h
>> +++ b/virt/kvm/kvm_mm.h
>> @@ -3,6 +3,9 @@
>>  #ifndef __KVM_MM_H__
>>  #define __KVM_MM_H__ 1
>>
>> +/* Worst case buffer size needed for holding an integer as a string. */
>> +#define ITOA_MAX_LEN 12
>> +
>>  /*
>>   * Architectures can choose whether to use an rwlock or spinlock
>>   * for the mmu_lock.  These macros, for use in common code
>> --
>> 2.54.0.1032.g2f8565e1d1-goog


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B702C433EF
	for <kexec@archiver.kernel.org>; Thu, 21 Jul 2022 02:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wa7MATXWO+hgEwZD2CLTd1b1RutKyQ0CQPyKaUyC+WE=; b=IAR3GntO2+vL//
	tPEMYlTcpTiQQs6AB1ZkzIddXQaae8akPM8Xnwe8UJqvodEA39UnNlDf3qmgcV+/iY0F95R6CSM1w
	+dceTAwOS8LjB7DtqcmP3zDlr+m202Id+9M2LnYtM4mIWATyiElGY3+kz2NDndnkY6CxtVVpTjIbh
	p017QCzApo5r8NE4jfTITnshmFOoGX15t9ZxGN3zVUJ/qenMOOxF8wBCMdZWCg3+wsnZ9UqII8nvU
	ZSVM7vYHXsM4JlaWElReTwdy4lI51uHCvSudszGu/E914S4rra0U/Los0esNUXHvr+U26g9UW51+X
	iByeWgXr3QUSWJaxP3/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEMGM-00FJxO-Qm; Thu, 21 Jul 2022 02:50:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEMG6-00FJih-Me
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 02:49:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658371789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6hDKYquK0RWOwBXuZpsj17I8aU98q+WZfO0MGTd+kY=;
	b=d1m74V6TqYOjc8DCqfuSRwIaBmbEwPJYkVrGDalmqItVBKqv7r+R1yW6nKPbVbR8hU7Dv+
	q9hi3uAfd71UlTb0f0i2KvH8q9/FJ1BO8k60sRMbXDIY3R0XHHCPoS43UPPZ+cclJCRD3i
	i1s0BQkIUoUkXaZCSrbgXFpswBwuCRU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-EMGYVkNqPvCnoluoS9oQAw-1; Wed, 20 Jul 2022 22:49:46 -0400
X-MC-Unique: EMGYVkNqPvCnoluoS9oQAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21EB885A585;
	Thu, 21 Jul 2022 02:49:45 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EE2FD2166B26;
	Thu, 21 Jul 2022 02:49:43 +0000 (UTC)
Date: Thu, 21 Jul 2022 10:49:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Slark Xiao <slark_xiao@163.com>
Cc: corbet@lwn.net, vgoyal@redhat.com, dyoung@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, william.gray@linaro.org, dhowells@redhat.com,
	peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com, tglx@linutronix.de,
	bigeasy@linutronix.de, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <Yti+xEJIWeTSqD8n@MiWiFi-R3L-srv>
References: <20220721015605.20651-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220721015605.20651-1-slark_xiao@163.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_194950_877493_D8A334EC 
X-CRM114-Status: GOOD (  35.04  )
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

On 07/21/22 at 09:56am, Slark Xiao wrote:
> Fix typo in the comment

Better tell what's fixed to save reviewers' time:

Fix typo 'the the' in several places of document.

Other then this nitpick, looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: Add all .rst changes in Documents into 1 single patch
> ---
>  Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
>  Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
>  Documentation/core-api/cpu_hotplug.rst            | 2 +-
>  Documentation/driver-api/isa.rst                  | 2 +-
>  Documentation/filesystems/caching/backend-api.rst | 2 +-
>  Documentation/locking/seqlock.rst                 | 2 +-
>  Documentation/sphinx/cdomain.py                   | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> index 8419019b6a88..6726f439958c 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -200,7 +200,7 @@ prb
>  
>  A pointer to the printk ringbuffer (struct printk_ringbuffer). This
>  may be pointing to the static boot ringbuffer or the dynamically
> -allocated ringbuffer, depending on when the the core dump occurred.
> +allocated ringbuffer, depending on when the core dump occurred.
>  Used by user-space tools to read the active kernel log buffer.
>  
>  printk_rb_static
> diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
> index cab9543017bf..8e5fe532c07e 100644
> --- a/Documentation/bpf/map_cgroup_storage.rst
> +++ b/Documentation/bpf/map_cgroup_storage.rst
> @@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_id`` or
>      };
>  
>  ``cgroup_inode_id`` is the inode id of the cgroup directory.
> -``attach_type`` is the the program's attach type.
> +``attach_type`` is the program's attach type.
>  
>  Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
>  When this key type is used, then all attach types of the particular cgroup and
> @@ -155,7 +155,7 @@ However, the BPF program can still only associate with one map of each type
>  ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
>  ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
>  
> -In all versions, userspace may use the the attach parameters of cgroup and
> +In all versions, userspace may use the attach parameters of cgroup and
>  attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
>  APIs to read or update the storage for a given attachment. For Linux 5.9
>  attach type shared storages, only the first value in the struct, cgroup inode
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index c6f4ba2fb32d..f75778d37488 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -560,7 +560,7 @@ available:
>    * cpuhp_state_remove_instance(state, node)
>    * cpuhp_state_remove_instance_nocalls(state, node)
>  
> -The arguments are the same as for the the cpuhp_state_add_instance*()
> +The arguments are the same as for the cpuhp_state_add_instance*()
>  variants above.
>  
>  The functions differ in the way how the installed callbacks are treated:
> diff --git a/Documentation/driver-api/isa.rst b/Documentation/driver-api/isa.rst
> index def4a7b690b5..3df1b1696524 100644
> --- a/Documentation/driver-api/isa.rst
> +++ b/Documentation/driver-api/isa.rst
> @@ -100,7 +100,7 @@ I believe platform_data is available for this, but if rather not, moving
>  the isa_driver pointer to the private struct isa_dev is ofcourse fine as
>  well.
>  
> -Then, if the the driver did not provide a .match, it matches. If it did,
> +Then, if the driver did not provide a .match, it matches. If it did,
>  the driver match() method is called to determine a match.
>  
>  If it did **not** match, dev->platform_data is reset to indicate this to
> diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
> index d7507becf674..3a199fc50828 100644
> --- a/Documentation/filesystems/caching/backend-api.rst
> +++ b/Documentation/filesystems/caching/backend-api.rst
> @@ -122,7 +122,7 @@ volumes, calling::
>  to tell fscache that a volume has been withdrawn.  This waits for all
>  outstanding accesses on the volume to complete before returning.
>  
> -When the the cache is completely withdrawn, fscache should be notified by
> +When the cache is completely withdrawn, fscache should be notified by
>  calling::
>  
>  	void fscache_relinquish_cache(struct fscache_cache *cache);
> diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
> index 64405e5da63e..bfda1a5fecad 100644
> --- a/Documentation/locking/seqlock.rst
> +++ b/Documentation/locking/seqlock.rst
> @@ -39,7 +39,7 @@ as the writer can invalidate a pointer that the reader is following.
>  Sequence counters (``seqcount_t``)
>  ==================================
>  
> -This is the the raw counting mechanism, which does not protect against
> +This is the raw counting mechanism, which does not protect against
>  multiple writers.  Write side critical sections must thus be serialized
>  by an external lock.
>  
> diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
> index ca8ac9e59ded..a7d1866e72ff 100644
> --- a/Documentation/sphinx/cdomain.py
> +++ b/Documentation/sphinx/cdomain.py
> @@ -151,7 +151,7 @@ class CObject(Base_CObject):
>      def handle_func_like_macro(self, sig, signode):
>          u"""Handles signatures of function-like macros.
>  
> -        If the objtype is 'function' and the the signature ``sig`` is a
> +        If the objtype is 'function' and the signature ``sig`` is a
>          function-like macro, the name of the macro is returned. Otherwise
>          ``False`` is returned.  """
>  
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

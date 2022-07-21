Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6058C433EF
	for <kexec@archiver.kernel.org>; Thu, 21 Jul 2022 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:References:
	In-Reply-To:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0KMgm43fcEKOxYsBt2C+9zqZvy7eUiLuf2eZI+5okpw=; b=b79AWeppYe45Z2
	c+0HdRtgB8SJuWIlgQVT8AOeeiOhmUyKBmd48dFkxtgKNonmrm2Jru/aZZOdXZ34PvK3pCmIzPIWC
	tPbKWWGI0eXbiSy/mKMNcry2vcnqfUAKvhHGbyBJFTBBYpeyWMlr+46SnGBcc08qjurneQnaETVcg
	goeez9ZZS0FaRKGw1lRNo/HbdZj8bCOe8DK84dSf1hDs4lIUW3U02E/V/SfPrs2vOrWfsMaP7qjK3
	GBi8meoV6wlIL+427pbGby0a9LTmW0yOBNNiNHcSiX1WpoZDxMQeSypT9YnFiUgMgACF8VwyKTTQI
	QhWOOtjxfbyN92bJIeVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEMZf-00FVCg-JU; Thu, 21 Jul 2022 03:10:03 +0000
Received: from m13114.mail.163.com ([220.181.13.114])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEMZb-00FV59-VD
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 03:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=uI0Gf
	q38zZFPLYaDZUJSppt5MdVIwb3DAWhs92WcF70=; b=bpClueia+kFMdQ38hrYB/
	gog51SE62ZWlY+3iRtVVZWqStr2ho05ANibDJyQTApqrcPEF0v5scm/Xfl1sv49h
	lf7Yfg7BQvAesKxN08WIWzLys2M7HCkn5TXMj6esi7eCIkfqXgSCRRvJMUsQ1nK0
	sFQq+4PQ81vdfTAZ1jpxiM=
Received: from slark_xiao$163.com ( [112.97.57.47] ) by
 ajax-webmail-wmsvr114 (Coremail) ; Thu, 21 Jul 2022 11:08:22 +0800 (CST)
X-Originating-IP: [112.97.57.47]
Date: Thu, 21 Jul 2022 11:08:22 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Baoquan He" <bhe@redhat.com>
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
Subject: Re:Re: [PATCH v2] docs: Fix typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Yti+xEJIWeTSqD8n@MiWiFi-R3L-srv>
References: <20220721015605.20651-1-slark_xiao@163.com>
 <Yti+xEJIWeTSqD8n@MiWiFi-R3L-srv>
MIME-Version: 1.0
Message-ID: <25e36ec1.12ce.1821eba4cab.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: csGowAC379Imw9hiposjAA--.58861W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiRxdFZFc7YwAkRwABsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_201000_544797_5D1C8D55 
X-CRM114-Status: GOOD (  21.47  )
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





At 2022-07-21 10:49:40, "Baoquan He" <bhe@redhat.com> wrote:
>On 07/21/22 at 09:56am, Slark Xiao wrote:
>> Fix typo in the comment
>
>Better tell what's fixed to save reviewers' time:
>
>Fix typo 'the the' in several places of document.
>
>Other then this nitpick, looks good to me.
>
>Reviewed-by: Baoquan He <bhe@redhat.com>
>
Thanks for your advice.
I will update it to  other commits later.

>> 
>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
>> ---
>> v2: Add all .rst changes in Documents into 1 single patch
>> ---
>>  Documentation/admin-guide/kdump/vmcoreinfo.rst    | 2 +-
>>  Documentation/bpf/map_cgroup_storage.rst          | 4 ++--
>>  Documentation/core-api/cpu_hotplug.rst            | 2 +-
>>  Documentation/driver-api/isa.rst                  | 2 +-
>>  Documentation/filesystems/caching/backend-api.rst | 2 +-
>>  Documentation/locking/seqlock.rst                 | 2 +-
>>  Documentation/sphinx/cdomain.py                   | 2 +-
>>  7 files changed, 8 insertions(+), 8 deletions(-)
>> 
>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> index 8419019b6a88..6726f439958c 100644
>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>> @@ -200,7 +200,7 @@ prb
>>  
>>  A pointer to the printk ringbuffer (struct printk_ringbuffer). This
>>  may be pointing to the static boot ringbuffer or the dynamically
>> -allocated ringbuffer, depending on when the the core dump occurred.
>> +allocated ringbuffer, depending on when the core dump occurred.
>>  Used by user-space tools to read the active kernel log buffer.
>>  
>>  printk_rb_static
>> diff --git a/Documentation/bpf/map_cgroup_storage.rst b/Documentation/bpf/map_cgroup_storage.rst
>> index cab9543017bf..8e5fe532c07e 100644
>> --- a/Documentation/bpf/map_cgroup_storage.rst
>> +++ b/Documentation/bpf/map_cgroup_storage.rst
>> @@ -31,7 +31,7 @@ The map uses key of type of either ``__u64 cgroup_inode_id`` or
>>      };
>>  
>>  ``cgroup_inode_id`` is the inode id of the cgroup directory.
>> -``attach_type`` is the the program's attach type.
>> +``attach_type`` is the program's attach type.
>>  
>>  Linux 5.9 added support for type ``__u64 cgroup_inode_id`` as the key type.
>>  When this key type is used, then all attach types of the particular cgroup and
>> @@ -155,7 +155,7 @@ However, the BPF program can still only associate with one map of each type
>>  ``BPF_MAP_TYPE_CGROUP_STORAGE`` or more than one
>>  ``BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE``.
>>  
>> -In all versions, userspace may use the the attach parameters of cgroup and
>> +In all versions, userspace may use the attach parameters of cgroup and
>>  attach type pair in ``struct bpf_cgroup_storage_key`` as the key to the BPF map
>>  APIs to read or update the storage for a given attachment. For Linux 5.9
>>  attach type shared storages, only the first value in the struct, cgroup inode
>> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
>> index c6f4ba2fb32d..f75778d37488 100644
>> --- a/Documentation/core-api/cpu_hotplug.rst
>> +++ b/Documentation/core-api/cpu_hotplug.rst
>> @@ -560,7 +560,7 @@ available:
>>    * cpuhp_state_remove_instance(state, node)
>>    * cpuhp_state_remove_instance_nocalls(state, node)
>>  
>> -The arguments are the same as for the the cpuhp_state_add_instance*()
>> +The arguments are the same as for the cpuhp_state_add_instance*()
>>  variants above.
>>  
>>  The functions differ in the way how the installed callbacks are treated:
>> diff --git a/Documentation/driver-api/isa.rst b/Documentation/driver-api/isa.rst
>> index def4a7b690b5..3df1b1696524 100644
>> --- a/Documentation/driver-api/isa.rst
>> +++ b/Documentation/driver-api/isa.rst
>> @@ -100,7 +100,7 @@ I believe platform_data is available for this, but if rather not, moving
>>  the isa_driver pointer to the private struct isa_dev is ofcourse fine as
>>  well.
>>  
>> -Then, if the the driver did not provide a .match, it matches. If it did,
>> +Then, if the driver did not provide a .match, it matches. If it did,
>>  the driver match() method is called to determine a match.
>>  
>>  If it did **not** match, dev->platform_data is reset to indicate this to
>> diff --git a/Documentation/filesystems/caching/backend-api.rst b/Documentation/filesystems/caching/backend-api.rst
>> index d7507becf674..3a199fc50828 100644
>> --- a/Documentation/filesystems/caching/backend-api.rst
>> +++ b/Documentation/filesystems/caching/backend-api.rst
>> @@ -122,7 +122,7 @@ volumes, calling::
>>  to tell fscache that a volume has been withdrawn.  This waits for all
>>  outstanding accesses on the volume to complete before returning.
>>  
>> -When the the cache is completely withdrawn, fscache should be notified by
>> +When the cache is completely withdrawn, fscache should be notified by
>>  calling::
>>  
>>  	void fscache_relinquish_cache(struct fscache_cache *cache);
>> diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
>> index 64405e5da63e..bfda1a5fecad 100644
>> --- a/Documentation/locking/seqlock.rst
>> +++ b/Documentation/locking/seqlock.rst
>> @@ -39,7 +39,7 @@ as the writer can invalidate a pointer that the reader is following.
>>  Sequence counters (``seqcount_t``)
>>  ==================================
>>  
>> -This is the the raw counting mechanism, which does not protect against
>> +This is the raw counting mechanism, which does not protect against
>>  multiple writers.  Write side critical sections must thus be serialized
>>  by an external lock.
>>  
>> diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
>> index ca8ac9e59ded..a7d1866e72ff 100644
>> --- a/Documentation/sphinx/cdomain.py
>> +++ b/Documentation/sphinx/cdomain.py
>> @@ -151,7 +151,7 @@ class CObject(Base_CObject):
>>      def handle_func_like_macro(self, sig, signode):
>>          u"""Handles signatures of function-like macros.
>>  
>> -        If the objtype is 'function' and the the signature ``sig`` is a
>> +        If the objtype is 'function' and the signature ``sig`` is a
>>          function-like macro, the name of the macro is returned. Otherwise
>>          ``False`` is returned.  """
>>  
>> -- 
>> 2.25.1
>> 
>> 
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

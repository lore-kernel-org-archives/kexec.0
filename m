Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CBDCA5FA1
	for <kexec@archiver.kernel.org>; Tue, 29 Sep 2026 00:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/y7v+SCp59Xm7LWoMBFV6n7GtotDVpeBZst7IFV6LyY=; b=EyYFd1uqikcs7IDG3F1vjwenG/
	vTe+mFUBJbke+3kn2Q5DDMcm+Agn+CX11GGkln+qCljzQaZDvh7NKZU96236HIYjayuCRhlcsPMy/
	mutoJ3n7IcPQ9VGn0xadJGQcsOfhj4s56eyOhxsZe8Nz53hTZBOaZhXK9fIeE7S5H9crN8D/UMBOd
	BnBpcUKVtNypKsn63LJY0PbHf0H2Ez8wgHL6h0eM33t49IFURxNsavEEgn9haOOTnSPYrE/Z+jwgo
	HCBzcW+oePR+yQeuZ7bZFhFjbsqZuZRv3ZSVDwdAqEfhAFR6Wp7npAUONPyFcv1AcwKZxU2scPqbs
	5UEH2peQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBLgm-00000001xvK-3ZIg;
	Tue, 29 Sep 2026 00:27:20 +0000
Received: from out-166.mta0.migadu.com ([2001:41d0:1004:224b::a6] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBLgj-00000001xub-3cGP
	for kexec@lists.infradead.org;
	Tue, 29 Sep 2026 00:27:20 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=bpMYWBp/sPJNiQHEYw1MOd5uAxCLyuUtVHzuC15+pHA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790641635; v=1; x=1791246435;
 b=M4U/OkMI2b8ylZ9gZAaoGSa5muprJ8ikog70F9ltHHBXhn1lBPHHEJ7gNE6p8zeqyvBu2qMY
 1yKuI5FCX9A1NPlDHOuCRVNgP95FGdwyPf8sb6WmMpHcCOlnQhihnbBX3hCbThtkCoEV9wTqObp
 9wJYL3/DP4qInZw4hpT2Vs68=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 27dc7108c083eaec;
	Tue, 29 Sep 2026 00:27:15 +0000
X-Mizu-Trace-ID: 27dc7108c083eaec
X-Migadu-Flow: FLOW_OUT
Message-ID: <a13c01e1-def0-4aa5-b54f-18e523082b29@linux.dev>
Date: Tue, 29 Sep 2026 08:25:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmcoreinfo: export SECTION_HAS_MEM_MAP
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, David Carlier <devnexen@gmail.com>,
 Tao Liu <ltao@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kexec@lists.infradead.org
References: <20260928-section_has_mem_map-v1-1-4129f6ba2838@kernel.org>
 <9c47dad9-2716-4ae0-b6e2-9e6b5c718859@linux.dev>
 <4a57b255-cb38-4e8e-908b-d32e55a1a326@kernel.org>
Content-Language: en-US, en-GB
From: Dave Young <ruirui.yang@linux.dev>
In-Reply-To: <4a57b255-cb38-4e8e-908b-d32e55a1a326@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_172718_643033_49AC8982 
X-CRM114-Status: GOOD (  18.38  )
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

On 9/28/26 7:42 PM, David Hildenbrand (Arm) wrote:
> On 9/28/26 12:23, Dave Young wrote:
>> On 9/28/26 4:48 PM, David Hildenbrand (Arm) wrote:
>>> The crash tool currently hardcodes SECTION_HAS_MEM_MAP, and makedumpfile
>>> needs similar information (although still relying on
>>> SECTION_MARKED_PRESENT, it should switch to SECTION_HAS_MEM_MAP).
>>>
>>> Let's just export the value instead, so tools that work on vmcoreinfo
>>> will not have to guess.
>>>
>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>> ---
>>> Result of the discussion in reply to "[PATCH v2 00/13] mm/sparse: remove
>>> SECTION_MARKED_PRESENT and further cleanups" [1]
>>>
>>> This patch can go in independently. It would be preferable if both
>>> go into the same kernel release ;)
>>>
>>> [1] https://lore.kernel.org/r/20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org 
>>> ---
>>>  kernel/vmcore_info.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
>>> index 5a417f8a922a..7833a36064a8 100644
>>> --- a/kernel/vmcore_info.c
>>> +++ b/kernel/vmcore_info.c
>>> @@ -182,6 +182,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>>>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
>>>  	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
>>> +	VMCOREINFO_NUMBER(SECTION_HAS_MEM_MAP);
>>>  	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
>>>  #endif
>>>  	VMCOREINFO_STRUCT_SIZE(page);
>>
>> Current crash code looks below:
>> #define SECTION_MARKED_PRESENT          (1UL<<0)
>> #define SECTION_HAS_MEM_MAP             (1UL<<1)
>> #define SECTION_IS_ONLINE               (1UL<<2)
>> #define SECTION_IS_EARLY                (1UL<<3)
>> #define SECTION_TAINT_ZONE_DEVICE       (1UL<<4)
>> #define SECTION_MAP_LAST_BIT            (1UL<<5)
>> #define SECTION_MAP_MASK                (~(SECTION_MAP_LAST_BIT-1))
>>
>>
>> And it does not match the kernel for below chunk with ifdef
>> #ifdef CONFIG_ZONE_DEVICE
>>         SECTION_TAINT_ZONE_DEVICE_BIT,
>> #endif
>> #ifdef CONFIG_SPARSEMEM_VMEMMAP_PREINIT
>>         SECTION_IS_VMEMMAP_PREINIT_BIT,
>> #endif
>>
>> The last bit could be wrong in crash.  So all numbers should be exported in vmcoreinfo.
>>
>> Thoughts?
> 
> You know the crash code best, so likely ... it's time one of the crash people
> takes over this patch?

Rethinking about it I'm hesitating to add many more to vmcoreinfo although it is reasonable,  about the #ifdef things, there are other places other than mm, crash can not depend on the /proc/config.gz which is not reliable in the old kernel memory, maybe it will be helpful to export another elf note for old kernel's kconfig.  So I'd like to support to use your patch for the time being as the first bit is always needed and leave the remaining concerns a follow up item.

Thanks
Dave


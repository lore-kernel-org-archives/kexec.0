Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D69C433FE
	for <kexec@archiver.kernel.org>; Wed, 26 Oct 2022 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=noX8ICgu68xcucADUI+3TGM0kstNdhwkqCA/92/3Whg=; b=S1ZWvN5f1PCgjZ
	MMnAuoNViHpeCBYRIak56lkLAhOP1At+oJOn9oTQzYG7iitDTw8K4Uyvuhlh8hh0h0TNd5k2aGyk9
	DdAMsDN7CrGcMkDLreCca3n6yADE1vgJM47dXjbNGT72eD9Sq8QKBs6SRyDg9c07jt/h24zGAET2I
	uwb5t4xggPWKB4XdPXGFYNQw/Oq85KPHUVQhmHrK8fBMpIlCFBehZIVlySZAxIgVB6CqgZciJonoU
	+b+y0E8WWApxyjLeeVonJwq7wr5QNsbsgPts1Z7+U8BfBU9owVjax1oGHYxZMcgBG7oXvS9Uc+P+o
	0N/7UmtDIhjxpXypfVkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onhhZ-009jIh-L0; Wed, 26 Oct 2022 14:48:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onhhV-009jGk-1t
	for kexec@lists.infradead.org; Wed, 26 Oct 2022 14:48:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666795690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=waNXQeIHAKPovVRiEc+x+REE+g4+Bdakw7JoCJaSBPA=;
	b=a+cbGGQjF0aRPjdSshTKzf6F+UoPcRNlLqSUMzbyu/wZkf0P/CJT92s/Lczh3cno018EVM
	ONZlUIWlBKnljrVCilTSqXV1HzXcFxVm7ZFMooi08xpgeHTx7rq57FXWkEDX9S7Gnvyjao
	PQzQu3LajdQ5WTUr0gzBYveXpRWW6uY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-PXZwuAI1MSSxNwq7DZMmyQ-1; Wed, 26 Oct 2022 10:48:06 -0400
X-MC-Unique: PXZwuAI1MSSxNwq7DZMmyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7C86101A54E;
	Wed, 26 Oct 2022 14:48:05 +0000 (UTC)
Received: from localhost (ovpn-12-35.pek2.redhat.com [10.72.12.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AE1B239DB3;
	Wed, 26 Oct 2022 14:48:04 +0000 (UTC)
Date: Wed, 26 Oct 2022 22:48:01 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>, david@redhat.com
Cc: Eric DeVolder <eric.devolder@oracle.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org,
	sourabhjain@linux.ibm.com, linux-mm@kvack.org
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
References: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1e7Hw0PRDI9NxU9@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_074813_197972_6BA72777 
X-CRM114-Status: GOOD (  36.81  )
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

On 10/25/22 at 12:31pm, Borislav Petkov wrote:
> On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
> > The concern to range number mainly is on Virt guest systems.
> 
> And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
> real machine?

Well, currently, mem hotpug is an important feature on virt system to
dynamically increase/shrink memory on the system. If only emulating real
machine, it won't be different than bare metal system.

IIRC, the ballon driver or virtio-mem feature can add memory board, e.g
1G, block size is 128M, 8 blocks added. When shrinking this 1G memory
later, it will take best effort way to hot remove memory. Means if any
memory block is occupied, it will be kept there. Finally we could only
remove every second blocks, 4 blocks altogether. Then the left
un-removed blocks will produce 4 separate memory regions. Like this, a
virt guest could have many memory regions in kernel after memory
being added/removed.

If I am wrong, Please correct me, David.

> 
> > On baremetal system, basically only very high end server support
> > memory hotplug. I ever visited customer's lab and saw one server,
> > it owns 8 slots, on each slot a box containing about 20 cpus and 2T
> > memory at most can be plugged in at one time. So people won't make too
> > many slots for hotplugging since it's too expensive.
> 
> There you have it - the persuading argument.
> 
> > I checked user space kexec code, the maximum memory range number is
> > honored to x86_64 because of a HPE SGI system. After that, nobody
> > complains about it. Please see below user space kexec-tools commit in
> > https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> > 
> > The memory ranges may be not all made by different DIMM slots, could be
> > firmware reservatoin, e.g efi/BIOS diggged out physical memory,
> 			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I don't know what that means.
> 
> If it is firmware crap, you want to exclude that from kdump anyway.

Yes, now assume we have a HPE SGI system and it has memory hotplug
capacity. The system itself has already got memory regions more than
1024. Then when we hot add extra memory board, we want to include the
newly added memory regions into elfcorehdr so that it will be dumped out
in kdump kernel.

That's why I earlier suggested 2048 for number of memory regions.

> 
> > Now CONFIG_NR_CPUS has the maximum number as 8192. And user space
> > kexec-tools has maximum memory range number as 2048. We can take
> > the current 8192 + 2048  = 10K as default value conservatively. Or
> > take 8192 + 2048 * 2 = 12K which has two times of maximum memory range
> > bumber in kexec-tools. What do you think?
> 
> I still think that we should stick to reality and support what is
> possible not what is potentially and theoretically there.

Yes, agree. We should try to get a number which satisfies needs in
reality.

For Kconfig CRASH_MAX_MEMORY_RANGES in this patch, I have three items to
suggest:

1) the name is not good, it doesn't reflect the fact that it's the
number of program headers of elfcorehdr which includes the cpu note 
numbers and memory region numers.

2) default cpu number, I suggest 512 or 1024. The biggest number I
ever saw in reality is 384. On virt system, it won't be too big. Below
is abstracted from arch/x86/Kconfig. A smaller one is also OK, we can
enlarge it when people really have a super machine and run into the
problem.

   config NR_CPUS_DEFAULT
           int
           depends on X86_64
           default 8192 if  MAXSMP
           default   64 if  SMP
           default    1 if !SMP

3) For memory regions, I would suggest 2048. Likewise, smaller value is
also fine, we can enlarge it when a real system run into this.

I made a draft here for reference, with my undertanding. Please feel
free to change it.

+config CRASH_ELF_CORE_PHDRS_NUM
+       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+       int
+       default 3072
+	help
+         For the kexec_file_load path, specify the default number of
+         phdr for the vmcore. E.g the memory regions represented by the
+         'System RAM' entries in /proc/iomem, the cpu notes of each
+         present cpu stored in /sys/devices/system/cpu/cpuX/crash_notes.

Thanks


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

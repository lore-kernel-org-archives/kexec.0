Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B4AC3DA59
	for <kexec@archiver.kernel.org>; Tue, 16 Jul 2024 06:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BUSyHiUVjlXEwHEvORzRACSQ9fpzBdRXf6naHwOGg9E=; b=4uELO7rsQ9MAg/
	cgPMnpf3S2cDisZWLiylcKf5IPQ7BWVOLBEHeFYwhGoe7lL8rZFrkWAaZNXNUvQzdEOYUEwHKGI9S
	+M6iFrYywXpybsFfwtt8HcgwnMoTIZFngBY4cyuQBJdSwdp929KhBSCOgRAIXrazyt8jUEd8iKEYQ
	aHxPI318agpFk1apmjx9rpgQnACNzISeIrD+dcj8IdNjQuLJ0jAFXG4AiCGd/XbFoAgAfKauRSuJt
	W7MgxtudfnDrS/6OhV8t60RNGjyoCt9nmalKHLjhR5MEEzLvnILWoAIu10CojvGUO3LDjXACPxAWz
	3Abwngq+zP+q4dxDIKpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTbaZ-00000009SOI-0aBX;
	Tue, 16 Jul 2024 06:23:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTbaW-00000009SNg-2YIC
	for kexec@lists.infradead.org;
	Tue, 16 Jul 2024 06:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721110979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqKn77J468u2b1ZYWnF9Bn5NYZUmxmPmv9PF18q3/+M=;
	b=Gd70By+WgL+NCdwLe+SsW43mTiWg/oiD2HP4ll52wQV2NNrdstaQHY4rSlinNAfBUj0qXm
	JvVpBtZgHeUf8l7UsOW84S1kfZe73viTebNfDB3PcQZO+Jd4apna0HXgB4TZ+xBSU4TdBz
	vx1+X90Q4CCgI3uVjqqKaKwDUNilmck=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-JfpIj8o0NGGlNF0_rU1jwA-1; Tue,
 16 Jul 2024 02:22:53 -0400
X-MC-Unique: JfpIj8o0NGGlNF0_rU1jwA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 949221955D44;
	Tue, 16 Jul 2024 06:22:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 873E21955F40;
	Tue, 16 Jul 2024 06:22:42 +0000 (UTC)
Date: Tue, 16 Jul 2024 14:22:38 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	austindh.kim@gmail.com, rmk+kernel@armlinux.org.uk,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Message-ID: <ZpYRrsSLd2ZpUyff@MiWiFi-R3L-srv>
References: <20240713014808.1689915-1-ruanjinjie@huawei.com>
 <ZpU2rJ1aKyqlu8IN@MiWiFi-R3L-srv>
 <ff8d5b8c-088c-9e05-53b2-f86335a18b8f@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff8d5b8c-088c-9e05-53b2-f86335a18b8f@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240715_232300_746611_8CBEF0D6 
X-CRM114-Status: GOOD (  34.63  )
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

On 07/16/24 at 11:44am, Jinjie Ruan wrote:
> 
> 
> On 2024/7/15 22:48, Baoquan He wrote:
> > On 07/13/24 at 09:48am, Jinjie Ruan wrote:
> >> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
> >> as below:
> >> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
> >>
> >> And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
> >> is also ok as below:
> >> 	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)
> >>
> >> The cause is that the crash_size is parsed and printed with "unsigned long
> >> long" data type which is 8 bytes but allocated used with "phys_addr_t"
> >> which is 4 bytes in memblock_phys_alloc_range().
> >>
> >> Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
> >> input size.
> > 
> > I am not sure if this is a good idea. Shouldn't we handle this in
> > arch_reserve_crashkernel() to check the system RAM size?
> > 
> > With this patch, if you specify crashkernel=4352M (namely 4G+256M) in
> > kernel cmdline, then you will reserve 256M crashkernel in system, don't
> > you think that is confusing?
> 
> You are right!
> 
> In the case you mentioned, it can still allocate 256M successfully, but
> the log shows 4352M successfully allocated, which is not taken into
> account by this patch.
> 
> And handle this in arch_reserve_crashkernel() is a good idea, which will
>  bypass all these corner case, I'll do it next version.
> 
> > 
> > By the way, I am considering changing code to apply generic crashkernel
> > reservation to 32bit system. Maybe below draft code can prevent
> > crashkernel=,high from being parsed successfully on 32bit system.
> > 
> > What do you think?
> 
> I agree with you, I've thought about passing in a parameter in the
> generic interface whether high is supported or not to implement it,
> which is so incompatible. An architecture-defined macro to filter out
> parsing of "high" fundamentally avoid using the generic interface to
> allocate memory in "high" for the architecture that does not support
> "high". The below code do prevent "crashkernel=,high" from being parsed
> successfully on 32bit system.
> 
> But if it is to support 32 bit system to use generic crash memory
> reserve interface, reserve_crashkernel_generic() needs more modification
> , as it may try to allocate memory at high.

You are right. Below change may be able to fix that. 

And I have been thinking if one case need be taken off in which the
first attempt was for high memory, then fall back to low memory. Surely,
this is not related to the 32bit crashkernel reservation.

By the way, do you figure out these issues from code reading and qemu
testing, or there's need for deploying kdump on 32bit system, e.g i386
or arm32? Just curious.

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..ac087ba442cd 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -414,7 +414,8 @@ void __init reserve_crashkernel_generic(char *cmdline,
 			search_end = CRASH_ADDR_HIGH_MAX;
 			search_base = CRASH_ADDR_LOW_MAX;
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
+			if (search_base != search_end)
+				goto retry;
 		}
 
 		/*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0718DC43334
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 01:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:References:
	In-Reply-To:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hLwwgMtmsbvAgcsKNBXostVcNQ2U9Ml/hNKB/DRf3io=; b=yV9+31Cz9Yip5a
	P6K3rs1uXBFcAu/NWWEuyosb24b5wYu0rf/2fnfTSGa7OZLCkM4zJ3L7WiItuwOFI5MYIMSLs4rZe
	9I3Fub3DvY8BaexvDRmE88T21NwF9gWPyW7Qtv3xmC2Y8RPDRnDY7N/aLbrc7lN4tq9YOPoreDhwO
	5yy8H3zsGw9MwBne0Leo/A0dgmtGPLHYUP4viZbmbXKY7/M2TCUQqtzgZ3Plln7VJt5fwsXDSN8gt
	2VysF5Ep8Wd4yrA7c6lDRRjFj//QRnAWuDycm6ZlqTjAEU3i3hQOyXcXwcPTYsCoLIZGKEaEp5rXw
	deFU0h63uSMvl/MVt/rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG91K-006azX-53; Tue, 26 Jul 2022 01:05:58 +0000
Received: from m1364.mail.163.com ([220.181.13.64])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG91G-006ayQ-DN
	for kexec@lists.infradead.org; Tue, 26 Jul 2022 01:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=tMZKv
	nr2S+LpKBN6CdOAA5vEXQTONGrH6lqsAQ5uMb0=; b=buoXR/OwW8IiEHFyqxW9O
	ZeSuFtQOewz4Rcn6AEWCVmuHl8X6xC+5+vOXBw9uy05+AmaJHM0q5lCvl2ZeR8Iy
	zlEP+Hk3MpUXLUNCTEt/TILpDCKkHT6lb/gVj3r5gQLnEDK2phDYyVBczYdMiZgw
	MLyQhf4wXZi1010u33ujdY=
Received: from slark_xiao$163.com ( [223.104.68.106] ) by
 ajax-webmail-wmsvr64 (Coremail) ; Tue, 26 Jul 2022 09:04:41 +0800 (CST)
X-Originating-IP: [223.104.68.106]
Date: Tue, 26 Jul 2022 09:04:41 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Baoquan He" <bhe@redhat.com>
Cc: "David Howells" <dhowells@redhat.com>, corbet@lwn.net, vgoyal@redhat.com, 
	dyoung@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, william.gray@linaro.org, 
	peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	longman@redhat.com, boqun.feng@gmail.com, tglx@linutronix.de, 
	bigeasy@linutronix.de, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re:Re: [PATCH v2] docs: Fix typo in comment
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
 <20220721015605.20651-1-slark_xiao@163.com>
 <2778505.1658746506@warthog.procyon.org.uk>
 <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
MIME-Version: 1.0
Message-ID: <55d366e4.486.1823808de32.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMGowAD3Ei+pPd9i1g8sAA--.42687W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdRZJZGBbEenN+gACs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_180555_243581_DB86DF43 
X-CRM114-Status: UNSURE (   7.02  )
X-CRM114-Notice: Please train this message.
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

















At 2022-07-25 21:32:04, "Baoquan He" <bhe@redhat.com> wrote:
>On 07/25/22 at 11:55am, David Howells wrote:
>> Baoquan He <bhe@redhat.com> wrote:
>> 
>> > sed -i "s/the the /the /g" `git grep -l "the the "`
>> 
>> You might want to clarify the first "the" with a preceding boundary marker.
>> There are some English words ending in "the" that can be used as verbs, though
>> I'm not sure you'd find any of them here - clothe for example.
>
>Right. I plan to split this big one into patches corresponding to
>different component as Jonathan suggested, and will consider how to mark
>the first 'the' as you suggested, and wrap Slark's pathces which
>includes typo fix of "then the".
>
>Thanks
>Baoquan

Actually I have committed all changes which were listed in your previous list.
I committed it one by one and checked if any other typo is included.
If possible, you can try other double typo issue like "and and " or "or or" or something else.


Thanks
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

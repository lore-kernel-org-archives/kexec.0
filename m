Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918BEC25B76
	for <kexec@archiver.kernel.org>; Sat,  1 Jun 2024 23:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JglcvYUskdkoXVI+RKyfqlfdxvs3uD4v3nqRp5Ky+cM=; b=iqPVk9VUqOGpLg
	L7ac4txT16fctIWI/C9ylPe+xxKuIGn9v5VxLHk0z/+AhjrPTL/NfQCNgWVjRsLpSFVEQ68/yNGeg
	9csoMSbg9QnmxCkDhjVK57VoIZA27aSdLTRQnnocIcBi3K5skic26HLWx3TJzksA90cqfQ+2jDlEP
	+hrzEU7hD6/8W9muulfLEUvc0HUYyyqg7/lSBOxGuaizhVzFKunlGq8IY6ln4y7Z9HBwk+nwKasX5
	U7Be1myKegKNPEi0zS8yPkWE4yMH9AklLk6ps505MANGVVTbHLGYrRZmA7cf16VAQc7oZZTGM4l3z
	Z+lXnYXCl+2Ja0t9BpYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDYXm-0000000DSXj-2Ayp;
	Sat, 01 Jun 2024 23:53:50 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDYXg-0000000DSW0-0Duv
	for kexec@lists.infradead.org;
	Sat, 01 Jun 2024 23:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1717286009;
	bh=S0HZKZXPDUjdP/Zns/yrz/j18B42GMOAvW6WjeLGr9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XOsu+NzjKw6hkPSAxzYY5P1qryMR9uKglPbB5M7Z8yb1/eq9Hw7GDE7IajTVj1VLi
	 /1IZ8aZWg7YEeVtZF9eskihotOlDgftU/A4xjwE9jLSsOUQfTtp8qFy6tJ6RDaBs3V
	 LG8kwlPnlWWG5RR892O9hR8YNTPd7B/8Lwr90bmZWK6qRoUYm3ECheG0s/9uLEcJEm
	 Dc7dFlqGIg4fgf0exWQK571xzZtFW4jgtBoXdqER45aW5hJ4tqFBD8dfFXE9ZVCuCc
	 6uu1AZM55ZzfcG9mLG3hlq23q2Bpr33bTBAgrvT3CFnZgBAF4aSvuAuyE3aKwHaqxz
	 +YWV2cszZ89/w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VsGyw5Pl2z4x32;
	Sun,  2 Jun 2024 09:53:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org,
 sourabhjain@linux.ibm.com, bhe@redhat.com
Subject: Re: Please add powerpc topic/kdump-hotplug branch to linux-next
In-Reply-To: <20240424074023.43932cca@canb.auug.org.au>
References: <87bk60ji79.fsf@mail.lhotse>
 <20240424074023.43932cca@canb.auug.org.au>
Date: Sun, 02 Jun 2024 09:53:27 +1000
Message-ID: <87mso42pag.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240601_165344_281133_5267A6E8 
X-CRM114-Status: GOOD (  10.69  )
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

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi Michael,
>
> On Tue, 23 Apr 2024 23:56:42 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
> \> Can you please add the topic/kdump-hotplug branch of the powerpc tree to
>> linux-next. It contains a series that touches generic kexec code as well
>> as x86 and powerpc code.
>> 
>> The hope is to have to get it merged for v6.10, so it should go along
>> with the powerpc next branch in the merge order.
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kdump-hotplug
>
> Added from today.

This branch has now been merged and can be dropped from linux-next,
thanks.

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

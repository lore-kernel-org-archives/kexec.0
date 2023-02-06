Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCE5C61DA4
	for <kexec@archiver.kernel.org>; Mon,  6 Feb 2023 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VRtBnvj+JEgQU/ATZnSf7Qhv+ujvypXL6feHW0G5scE=; b=GZAwDIr3bq4/qu
	rpSFSsTM7l9tQoOo4WiQLKBCiPzh+eQZmg1QrA2MaGwLTwGh3rjzeegG0JP3/aBWwr5zIS95Uwj/6
	gH1htIhyvdD8ZfzKkEYZ3p3fgJ6zeEGoKeV9gpgi8VujIZYmpGzr2V1V8aIU68vW6t0V3+J58BljQ
	ZmT1w09wVOhUq2DznuMeBUSmSSO8npEmU5jpPTzxaH5jWSVRzmFJrppAgu4IQgQXBw0LoPi7R5J3+
	21ygzZoRH53Vrxl4Fik4vgxs/IZKPSZfQ6PMNPyOn1WUZRElT+m9sJ/crR5cEft8rA5DkLjKzSvYn
	NRuYM9Gnx6ZI22WEOJvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOxf6-007qRI-6f; Mon, 06 Feb 2023 09:19:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pOxf2-007qQL-Vf
	for kexec@lists.infradead.org; Mon, 06 Feb 2023 09:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675675179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzse2s/pMYe7+aMOJ/uRlyHIbRacx1yD1nsaUm9BLPo=;
	b=bHIVaR9HXcnMA8XrO5qD3NzpFI1TmYywRccJCXW42F7rjbV4Mr3poNrOLrql2UEh2gMGSN
	klX/FAWTM5aWQpeApg2AG5WdzO010l5inU6lGd+NMVVpz0lt0QQghSCzxR2iyhGGokN1dW
	UXVg68ut4ySEkBfGjUitNWprdLbtPhQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-iCiKDmYxMse9XZiPkfht4A-1; Mon, 06 Feb 2023 04:19:37 -0500
X-MC-Unique: iCiKDmYxMse9XZiPkfht4A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A45BE1C068C1;
	Mon,  6 Feb 2023 09:19:37 +0000 (UTC)
Received: from localhost (ovpn-12-71.pek2.redhat.com [10.72.12.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE30F492B21;
	Mon,  6 Feb 2023 09:19:36 +0000 (UTC)
Date: Mon, 6 Feb 2023 17:19:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Yishen Miao <mys721tx@gmail.com>
Cc: kexec@lists.infradead.org
Subject: Re: Unified Kernel Image Support
Message-ID: <Y+DGJfYEJpbee/bM@MiWiFi-R3L-srv>
References: <5D04A23B-9A82-4186-AFA8-7E3A0FBBDF86@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5D04A23B-9A82-4186-AFA8-7E3A0FBBDF86@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_011941_117267_126F3F4B 
X-CRM114-Status: GOOD (  13.28  )
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

On 02/03/23 at 10:46pm, Yishen Miao wrote:
> Hello all,
> 
> I am experimenting kexec on my box. It uses systemd-boot as the bootloader and boots from a unified kernel image (objcopy'ed cmdline, kernel, initrdramfs, and microcode updates). As of kexec-tools 2.0.25 and systemd 252.5, when I rum systemctl kexec, it returns the following:
> 
> 
> # sudo systemctl kexec
> Running /usr/bin/kexec --load "/efi/EFI/Linux/ArchLinux-linux.efi" --append "root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"(null)
> Cannot determine the file type of /efi/EFI/Linux/ArchLinux-linux.efi
> 
> It seems that systemctl successfully identified the UKI from systemd-boot, however, kexec could not recognize it.
> 
> Are there any plans to add UKI support to kexec? Your response is greatly appreciated!

My colleageus mentioned UKI recently. We have plan to support it, while
haven't started to work on that.

I have a testing machine at hand right now, just finished teseting
upstream patches. If you have the detailed steps about how to make UKI,
privately or publicly, I can try it now, and see what we can do.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

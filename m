Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA24C433FE
	for <kexec@archiver.kernel.org>; Sat,  5 Nov 2022 03:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fNZIuc7dS8HDot9ysYxxbFsZTMOI3IbSrwn+g9Gn+6s=; b=QT3kFWZKtGMb9B
	9sCUm4v0+Fbb6ssV04pwCExhxhjxViEKE+aos0C8au/oouPgKPElXjOZqB9Ov8eCHgMEfJmSh623q
	tzygjMRbRAR3GBSlhz9RI5cW98vwx4fma9rVcJPpXt5p4B4yk3wIxrk/sjLckVabdHLkxCDSSEdhA
	4QlGnUZxME9eAmQ+hAROZl/RBRLUYrYswBEGr4qUauap+5wxqLlrL4CreZTdU0ivOYdS45AFvmQGU
	JE26GykPtq9WN6WRKu66mqiSV2oJTBk7J6jM1vpal9yRtEv4Z3lFga56sq3mVMXiIGHXqslgL4uzw
	CvZWJz4lo5fYgyKA8S5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or9aO-005nE8-19; Sat, 05 Nov 2022 03:11:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or9aH-005nCO-K0
	for kexec@lists.infradead.org; Sat, 05 Nov 2022 03:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667617858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcIXO4xBoz7ofsfZUzi32Ktqyk3fNvPNgMvPPVFXeew=;
	b=RScImFDvY7qXHdpe0eQQxZagiNBXqGU2FVxfENmHndpSA1sjclxPchhyOM8zVCzzwbwJaI
	RleboOVVSZrI45vMOPbYnHeebqsE5CWmhEoSPsSN4W9doVW78GrJGOjIM7llBLG5ykGOFc
	8lksqvcFN7NnyGrcXPcY4eiwUJMpEBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-I_GDZKzgOcSc_30tL8XqZw-1; Fri, 04 Nov 2022 23:10:53 -0400
X-MC-Unique: I_GDZKzgOcSc_30tL8XqZw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0719B8039A5;
	Sat,  5 Nov 2022 03:10:53 +0000 (UTC)
Received: from localhost (ovpn-13-134.pek2.redhat.com [10.72.13.134])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 384342166B26;
	Sat,  5 Nov 2022 03:10:49 +0000 (UTC)
Date: Sat, 5 Nov 2022 11:10:46 +0800
From: Baoquan He <bhe@redhat.com>
To: ns@tfwno.gf, dyoung@redhat.com
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org
Subject: Re: Bug: kexec on Lenovo ThinkPad T480 disables EFI mode
Message-ID: <Y2XUNive2KMwTjUF@MiWiFi-R3L-srv>
References: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3acf1cc7a974cb4fb9b77b39311c6714@tfwno.gf>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_201101_754864_00C5B6F3 
X-CRM114-Status: GOOD (  32.74  )
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

Add Dave to CC

On 10/28/22 at 01:02pm, ns@tfwno.gf wrote:
> Greetings,
> 
> I've been hitting a bug on my Lenovo ThinkPad T480 where kexecing will
> cause EFI mode (if that's the right term for it) to be unconditionally
> disabled, even when not using the --noefi option to kexec.
> 
> What I mean by "EFI mode" being disabled, more than just EFI runtime
> services, is that basically nothing about the system's EFI is visible
> post-kexec. Normally you have a message like this in dmesg when the
> system is booted in EFI mode:
> 
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi: SMBIOS=0x7f98a000 ACPI=0x7fb7e000 ACPI 2.0=0x7fb7e014
> MEMATTR=0x7ec63018
> (obviously not the real firmware of the machine I'm talking about, but I
> can also send that if it would be of any help)
> 
> No such message pops up in my dmesg as a result of this bug, & this
> causes some fallout like being unable to find the system's DMI
> information:
> 
> <6>[    0.000000] DMI not present or invalid.
> 
> The efivarfs module also fails to load with -ENODEV.
> 
> I've tried also booting with efi=runtime explicitly but it doesn't
> change anything. The kernel still does not print the name of the EFI
> firmware, DMI is still missing, & efivarfs still fails to load.
> 
> I've been using the kexec_load syscall for all these tests, if it's
> important.
> 
> Also, to make it very clear, all this only ever happens post-kexec. When
> booting straight from UEFI (with the EFI stub), all the aforementioned
> stuff that fails works perfectly fine (i.e. name of firmware is printed,
> DMI is properly found, & efivarfs loads & mounts just fine).
> 
> This is reproducible with a vanilla 6.1-rc2 kernel. I've been trying to
> bisect it, but it seems like it goes pretty far back. I've got vanilla
> mainline kernel builds dating back to 5.17 that have the exact same
> issue. It might be worth noting that during this testing, I made sure
> the version of the kernel being kexeced & the kernel kexecing were the
> same version. It may not have been a problem in older kernels, but that
> would be difficult to test for me (a pretty important driver for this
> machine was only merged during v5.17-rc4). So it may not have been a
> regression & just a hidden problem since time immemorial.
> 
> I am willing to test any patches I may get to further debug or fix
> this issue, preferably based on the current state of torvalds/linux.git.
> I can build & test kernels quite a few times per day.
> 
> I can also send any important materials (kernel config, dmesg, firmware
> information, so on & so forth) on request. I'll also just mention I'm
> using kexec-tools 2.0.24 upfront, if it matters.
> 
> Regards,
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

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835F3C05027
	for <kexec@archiver.kernel.org>; Mon,  6 Feb 2023 16:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DZW6CmG7B9T90FCDv18wEkHWDWxPUZ+IhM2bozNHwu4=; b=J7k3hlKGQFoVF8
	pSotOgy7oswolW4e3bCDhfEu3t4kccUIlWKMXm7kAkExK2brn0Hu4yNWv1zhxaM6wE9rkjmtYUYhl
	PE3rPLgfuyi3HkKb2hfhEgQ1v3UqnLUTwzazukyXNjfzF61b4v+lkuuFjbPDZCIn/bu0z05LYECfg
	D/EWjum0HBZa2y0jVpvP+70rdGXRy+Xj6h6g2KgAJVoDjnWdK3/PrpnKQXwp07t3/KTIR3RD5Uafq
	QqRxDbwdHIaiJEPfshcUs8FpHMUr5ekO9R948SQFvqtTtkSR0KSiTCbP/UFL/0fyHH4JdC3ldZ1vR
	6V3P7EAGy95PBfZbxHTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP4Sc-009LXY-5X; Mon, 06 Feb 2023 16:35:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP4SY-009LWy-TC
	for kexec@lists.infradead.org; Mon, 06 Feb 2023 16:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675701312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKesWNMFUT8Ys09hJ2+jMLyT/G7+G2KzR6sNkFwn9Ww=;
	b=Qp/Vox2DU94mfcIj+OF53jAESkjN8vtgrweKFLI02fJTPRCDj5sAbpo2FWrp0NMZo5OKoV
	sOeNDJIo6ZG3yFV6lRbQ4PaaPx4nOMId4BbWJppLARmNu3lgw4Ec/8AiQ8ub3+ixu3Jt/i
	0TnhTiKyOBqq9jgp9k05jONu+VEW2yU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-EHxC4IvaOV2kwJAi82DVTA-1; Mon, 06 Feb 2023 11:33:23 -0500
X-MC-Unique: EHxC4IvaOV2kwJAi82DVTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A0D285A588;
	Mon,  6 Feb 2023 16:33:23 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.194.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB0D840398A0;
	Mon,  6 Feb 2023 16:33:22 +0000 (UTC)
Date: Mon, 6 Feb 2023 17:33:20 +0100
From: Philipp Rudo <prudo@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Yishen Miao <mys721tx@gmail.com>, kexec@lists.infradead.org
Subject: Re: Unified Kernel Image Support
Message-ID: <20230206173320.103a9d21@rotkaeppchen>
In-Reply-To: <Y+DGJfYEJpbee/bM@MiWiFi-R3L-srv>
References: <5D04A23B-9A82-4186-AFA8-7E3A0FBBDF86@gmail.com>
	<Y+DGJfYEJpbee/bM@MiWiFi-R3L-srv>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_083515_072407_D4664F0D 
X-CRM114-Status: GOOD (  26.45  )
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

Hi,

On Mon, 6 Feb 2023 17:19:33 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 02/03/23 at 10:46pm, Yishen Miao wrote:
> > Hello all,
> > 
> > I am experimenting kexec on my box. It uses systemd-boot as the bootloader and boots from a unified kernel image (objcopy'ed cmdline, kernel, initrdramfs, and microcode updates). As of kexec-tools 2.0.25 and systemd 252.5, when I rum systemctl kexec, it returns the following:
> > 
> > 
> > # sudo systemctl kexec
> > Running /usr/bin/kexec --load "/efi/EFI/Linux/ArchLinux-linux.efi" --append "root=UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"(null)
> > Cannot determine the file type of /efi/EFI/Linux/ArchLinux-linux.efi
> > 
> > It seems that systemctl successfully identified the UKI from systemd-boot, however, kexec could not recognize it.
> > 
> > Are there any plans to add UKI support to kexec? Your response is greatly appreciated!  
> 
> My colleageus mentioned UKI recently. We have plan to support it, while
> haven't started to work on that.

I've looked into UKI recently. In order to provide some base support
one should only need to teach kexec_file_load the new file format [1].
However that still leaves two fundamental issues which limit the
usefulness of that support.

1) The way I understand it the initrd contained in the UKI is only a
stub that is supposed to read further "modules" from disk which
together form the initrd needed for the given hardware/system
configuration. The problem is that the kexec_file_load syscall only
accepts one fd for the kernel and one fd for the initrd. So to support
multiple modules we would either need to introduce a new syscall or
define a uABI that allows to pass multiple initrds via this one fd.
Either way it's a new user interface and should be designed with care.

2) As the kernel command line is part of the UKI and is protected by
the signature it cannot be changed by users. So to support kdump with a
UKI a distro would need to find one crashkernel= parameter that works
for all users which is impossible. Thus before kdump can be supported
with UKI there needs to be a  mechanism in place that allows users to
edit the command line. Others have the same problem. There is an open
issue on github [2] to add this support.

So all in all I believe there will be kexec support for UKI but I don't
see it to come anytime soon.

Thanks
Philipp

[1] ...and kexec-tools if you like to support kexec_load. But as the
main use case for UKI is together with Secure Boot I don't think that's
necessary.

[2] https://github.com/systemd/systemd/issues/24539

> I have a testing machine at hand right now, just finished teseting
> upstream patches. If you have the detailed steps about how to make UKI,
> privately or publicly, I can try it now, and see what we can do.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

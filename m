Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE52C433EF
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 02:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CxKs54ESOArXRGL17DSsMIIBl3R2Wqr5hLdTqpldQpY=; b=iGFz2Tag+XYGYw
	y2YlIEFyrXadH8dONP57UDwOdFutp5dhP5Y2gxMqk2W4OMBjluM5Mk5zpfofQUjqPggGIIOPUWfW7
	OE2H1V0sBmPHnFQJ7qTCwsS9uc8GB+yc8WiO4iFp1ipPJNzzOcjXhOFISZFuYJB1oucZJiSvtNT3H
	5i2v1/7gME6KjxXnn5rmJHthnLknf5oyHQpTQ8yLq9LfK8wxsi5iqrU9eXhlYvj8R1WeRyL+xXWZO
	3WO4mweoS4AvGwPbzJqfzhby1Y7yMKDAfyKGptDyfbWjI2jFklPuXi2FwX1vwZ4C833pnazFN9lPb
	qXSHtXPE73rbBMUZyWIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Bwu-003eUb-IZ; Mon, 04 Jul 2022 02:36:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Bwr-003eRR-9h
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 02:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656902186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1FJ6cqRuF8dBXv9KcZczCA6imIHUu41nOlrwT+WJ0s=;
	b=DumGiiXWuHxiJcxBICHtVo03K4sSvRrpuyOriDgaCVT32x/EMopRbGwa0tfEG0l2CbVzoY
	ktOCNzIXFoHstInzQcCKde8RORhTuzuLahbl2BuTdMJfariG1Afe58zvMfdzCUhx2m+/ZS
	SAVvv0j4U1XJNvR3uQ1DMfYpL9+LrCg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-FYcXjujqMAeLRZl34AbSJQ-1; Sun, 03 Jul 2022 22:36:22 -0400
X-MC-Unique: FYcXjujqMAeLRZl34AbSJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A3B485A581;
	Mon,  4 Jul 2022 02:36:22 +0000 (UTC)
Received: from localhost (ovpn-13-121.pek2.redhat.com [10.72.13.121])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5646C1415308;
	Mon,  4 Jul 2022 02:36:19 +0000 (UTC)
Date: Mon, 4 Jul 2022 10:36:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Jonathan McDowell <noodles@fb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v7] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <YsJSIIsCnjoL+ObY@MiWiFi-R3L-srv>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <YqcRuQFq5fg1XhB/@noodles-fedora.dhcp.thefacebook.com>
 <YqtMf9ivGR8Rkl8u@noodles-fedora.dhcp.thefacebook.com>
 <Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_193629_537091_D88E9BF5 
X-CRM114-Status: GOOD (  17.60  )
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

On 06/30/22 at 08:36am, Jonathan McDowell wrote:
> On kexec file load, the Integrity Measurement Architecture (IMA)
> subsystem may verify the IMA signature of the kernel and initramfs, and
> measure it. The command line parameters passed to the kernel in the
> kexec call may also be measured by IMA.
> 
> A remote attestation service can verify a TPM quote based on the TPM
> event log, the IMA measurement list and the TPM PCR data. This can
> be achieved only if the IMA measurement log is carried over from the
> current kernel to the next kernel across the kexec call.
> 
> PowerPC and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.
> 
> (Mimi, Baoquan, I haven't included your reviewed-bys because this has
>  changed the section annotations to __init and Boris reasonably enough
>  wants to make sure IMA folk are happy before taking this update.)
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> Link: https://lore.kernel.org/r/YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57993EDE99E
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MMukqMzyBDFHmj46ENiFKuaKNU/MKyI0Ct73/QgvCvY=; b=Bcs6pADrYzBfUT
	D5hq9l+kr7CiIM0YDuUESuS14pG0dhhxO8rzU9cr/vZUi/0ORgXMbb0nF66xx1Dr1K+fMR+W8axCo
	f0TFrDyBXQrcaVmKB/K6WwZZStjbbSSOrR6DfdVGL///DRNRLVUUafEp4YjIoCABQtYZOAP/tYcoy
	SA+gk4TD9XKCPQJ0JN353Nb4ubZ+fp+OgJOYILHKk7w2AmZzmIAGMssVYlWbcpFoHMaXsyECPqG+W
	66Xnm5uL1n0sQ2V1sN9oh9IKpFjAQDDdP1YNZXEQMpMAG7makueLjzwCWpid2ca1SNPtyuasTJS5A
	tRaw9Idz2De1nGdbfmcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgii4-007q3q-1J;
	Thu, 14 Sep 2023 09:32:28 +0000
Received: from gardel.0pointer.net ([2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgii1-007q33-0m
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 09:32:27 +0000
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id 1A4E2E801F5;
	Thu, 14 Sep 2023 11:32:21 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id A2B45160258; Thu, 14 Sep 2023 11:32:20 +0200 (CEST)
Date: Thu, 14 Sep 2023 11:32:20 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Philipp Rudo <prudo@redhat.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
	dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
	bluca@debian.org
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <ZQLTJFb3S/xn5CWo@gardel-login>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230913160045.40d377f9@rotkaeppchen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_023225_451232_A11E3AD3 
X-CRM114-Status: GOOD (  25.80  )
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

On Mi, 13.09.23 16:00, Philipp Rudo (prudo@redhat.com) wrote:

> For example there are two definitions for the UKI which contradict each other.
> The dedicated one [1] you have cited earlier and the one in the BLS for type #2
> entries [2]. In [1] the .linux and .initrd sections are mandatory and the
> .osrel and .cmdline sections are optional while in [2] it is the other way
> round. Which definition should the kernel follow?
>
> Furthermore, I absolutely don't understand how the spec should be read. All
> the spec does is defining some file formats. There is no word about which
> component in the boot chain is supposed to handle them and what exactly this
> component is supposed to do with it. But that is crucial if we want to add UKI
> support for kexec as the kexec systemcall will replace the stub. So we need to
> know what tasks the stub is supposed to perform. Currently this is only some
> implementation detail of the systemd-stub [3] that can change any moment and I
> strongly oppose to base any uapi on it.
>
> In the end the only benefit this series brings is to extend the signature
> checking on the whole UKI except of just the kernel image. Everything else can
> also be done in user space. Compared to the problems described above this is a
> very small gain for me.
>
> Until the spec got fixed I don't see a chance to add UKI support for kexec.

So that spec is initially just a generalization of what
systemd-stub/systemd-boot/ukify does. The descrepancies between the
cited specs mostly come from the that generalization. If you want to
enumerate kernels and order them the ".osrel" stuff for example is
necessary, hence the boot loader spec really wants it. If you don't
care about the boot loader spec though and just want to register the
kernel UKI PE directly in BootXXX efi vars for example, then there's
no need to include .osrel. That all said we should certainly make the
two specs align better, and clarify the situation. Suggestions/patches
more than welcome.

Ultimately, I think a spec written as description with a single
implementation in mind (i.e. systemd) is a generally a bad spec. Hence
if kexec in the Linux kernel wants to add support for it, that'd be
great but I'd see that as an opportunity to adjust the spec to the
needs of the Linux kernel in this area, so that it reflects well more
than just one backend implementation.

Hence, seeing the spec as set in stone and as inherently low quality
is the wrong way to see it I am sure. Instead, the goal here is to
adjust the spec to make it work really nicely for *both* systemd and
the kernel.

Lennart

--
Lennart Poettering, Berlin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

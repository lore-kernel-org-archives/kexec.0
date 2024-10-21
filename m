Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A496BD15DB8
	for <kexec@archiver.kernel.org>; Mon, 21 Oct 2024 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ivWdrupDmH+q4xW4ZQIvzBcQ/8ymSrH4AWAjMcadg+4=; b=1pMhdHE/hbhMkc
	pWA752A/YT4AW/XhB3YDB0xx77R1RLqJ6lKyOMyS1whIWCm/zvfeIdJdGdfYIQ5Gv8c+fVs86xoiU
	+mzqFqa5tr7GkZNwnCn7uvA+EJq8zoldYca6hZ6Dse1VwEWcw9OtvkqCLdHasLnCa/2s+rROiuVm7
	cjut01RsEzBZbNRenMIuSgr+EKE+X5pvGaLPtvATiftYeyTuEyLFggjWHP9GnZCQwkWvPJHGsl5tx
	3IvJw1QNP9QgfTqprBk6TZs8AvYXdDv+1MFaC+bvQ0Wa30NHxvLMkuZkhxxOiNLKdSJyca7C0Z5b1
	QB/79D6qgpEPJ6hKTzGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2vDn-00000007wjU-1IK4;
	Mon, 21 Oct 2024 16:25:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2vDj-00000007wiw-3rBK
	for kexec@lists.infradead.org;
	Mon, 21 Oct 2024 16:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729527925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWZY1d5rj67pjJtFTwRmzBPKLPBY5rJNOQ78xLhz5Nk=;
	b=NxqzekYrqyFHzQAyaShX/8/KAP7ie0rldg2/3/COdIycEXRgs1BHddURcit4cKaLTGwdvB
	EGJZPBaOAIlcy+y+saxqDg3E0xO4uRDvfqOX0waqw/nG4rDV1iBknhJjlWp5ViiLMkUsn+
	SUTeDJahoEe7MHaLPIFH4Se7CNMgz5o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-S2qCC0USMw-cBPmN6H2DxA-1; Mon,
 21 Oct 2024 12:25:22 -0400
X-MC-Unique: S2qCC0USMw-cBPmN6H2DxA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B4A11945CBB;
	Mon, 21 Oct 2024 16:25:17 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.226.92])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56ABB1955BC5;
	Mon, 21 Oct 2024 16:25:09 +0000 (UTC)
Date: Mon, 21 Oct 2024 18:25:06 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Ard Biesheuvel
 <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Lennart Poettering
 <mzxreary@0pointer.de>, kexec@lists.infradead.org
Subject: Re: [PATCHv2 0/3] kexec: Add support for UKI format kernel
Message-ID: <20241021182506.37b16102@rotkaeppchen>
In-Reply-To: <20241016113418.22568-1-piliu@redhat.com>
References: <20241016113418.22568-1-piliu@redhat.com>
Organization: Red Hat inc.
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_092528_084874_34358E16 
X-CRM114-Status: GOOD (  24.85  )
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

Hi Pingfan,
Hi Simon,

I know I'm a little bit too late, but I finally had time to take a
look. All in all the series looks fine to me. But I have two questions.

1) Is there a reason why you don't enable the UKI for x86 as well? The
way I see it patch 1 and 2 cover x86 as well. So you only should need a
patch similar to patch 3. Or am I missing something?

2) Would it make sense to "reuse" the mechanism you introduced for the
initrd for the command line as well. I.e. if it's a UKI with a .cmdline
section and the user didn't provide any of the --command-line,
--reuse-cmdline, etc. then use the command line from the UKI.

Thanks
Philipp

On Wed, 16 Oct 2024 19:34:12 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> As a UEFI PE format kernel image becomes more popular, there is a need
> for kexec to reboot those kinds of images.
> 
> After the introduction of the UKI (another PE), at present, there are
> three competitive methods to support that goal, but all of them have
> pros and cons.[1] It seems that none of them can be accepted in the near
> future.  Therefore, we are resorting to the user space kexec-tools to
> parse the UKI format for the time being.
> 
> By parsing the UKI, systemd-stub is stepped around and PCM will not affect
> the boot up of the second system.
> 
> [1]: https://github.com/rhkdump/kexec_uefi/blob/main/overview.md#the-competitive-solutions
> 
> Cc: Simon Horman <horms@kernel.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jan Hendrik Farr <kernel@jfarr.cc>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: kexec@lists.infradead.org
> ---
> v1 -> v2:
> Add include/pe.h in makefile to fix 'make dist'
> Rename default_initrd_fd to implicit_initrd_fd
> 
> 
> Pingfan Liu (3):
>   kexec: Introduce implicit_initrd_fd to pass internal initrd
>     information
>   kexec: Introduce UKI image parser
>   arm64: Support UKI image format
> 
>  include/Makefile                     |   1 +
>  include/pe.h                         | 104 +++++++++++++++++++++++
>  kexec/Makefile                       |   1 +
>  kexec/arch/arm64/kexec-arm64.c       |   1 +
>  kexec/arch/arm64/kexec-image-arm64.c |   3 +-
>  kexec/arch/x86_64/kexec-bzImage64.c  |   3 +-
>  kexec/kexec-uki.c                    | 122 +++++++++++++++++++++++++++
>  kexec/kexec.c                        |   2 +
>  kexec/kexec.h                        |   5 ++
>  9 files changed, 240 insertions(+), 2 deletions(-)
>  create mode 100644 include/pe.h
>  create mode 100644 kexec/kexec-uki.c
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EDCCA0EC7
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 01:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0B5bWaecfni5a3GjhQbjkj/U1a+qDJbJ1ZESFDgd+6k=; b=oPirkmsBr/BHgQ
	8lFrDApnOIWJ1cXSS/BspzOJ6axgQ1sHttJr5tNVI9iZg70s/QYUTW6VhU6onAe3NgrXBcsnhYY7g
	Wy0voIpn0FNQzKsZG8Qd+DLy/TBJJF6hxSy/g9UIEpNmsilObz0gJskuevRjFYHOJkcX0GvEDCUg9
	v2f1jRKRQBXQOfydC48HSgBOnDODfiUkSTCI5Y8tw367SmJok4tO+wPzkGJB53FbXsSkFEgQulLPH
	5ouunTFjJUsHDSXaySllHKASMVMnEjjzmKCsGsCc4C96WMe9QFV+1v+1lhBj02+3VJ5T5Zd5cB+gY
	PH3sWqsa7pNhDwszqABg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfroS-001hwa-0A;
	Tue, 12 Sep 2023 01:03:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfroP-001hvf-0M
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 01:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694480604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LndbGk9Tq34zPmQVev5k5AT8KIrme9LRtl6RtbBDZn0=;
	b=Dw6Oi8Ot8ze34ntYaWQkH9Ne30WAi2OOEvJxeAelEWV254BWUkBh7rBs/ERNWwo5c+67D4
	N3+S3Rmv6HnGqlukLwM/vF6a6hUsD9yJkXRhQeoEZoWgRZnci0Nqnt7Igr+KwH1aCFBPAP
	NNuYv7KP/XefdxfDMm4BEn+9VoY/Bb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-GpelxvecNu62UxAy92gbag-1; Mon, 11 Sep 2023 21:03:21 -0400
X-MC-Unique: GpelxvecNu62UxAy92gbag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66B788A437D;
	Tue, 12 Sep 2023 01:03:20 +0000 (UTC)
Received: from localhost (unknown [10.72.112.25])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D2E44407D;
	Tue, 12 Sep 2023 01:03:19 +0000 (UTC)
Date: Tue, 12 Sep 2023 09:03:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	tglx@linutronix.de, dhowells@redhat.com, vgoyal@redhat.com,
	keyrings@vger.kernel.org, akpm@linux-foundation.org,
	bhelgaas@google.com, bluca@debian.org, lennart@poettering.net,
	prudo@redhat.com
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <ZP+41JvEFjsnEG19@MiWiFi-R3L-srv>
References: <20230911052535.335770-1-kernel@jfarr.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230911052535.335770-1-kernel@jfarr.cc>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_180329_239952_46C1E22E 
X-CRM114-Status: GOOD (  21.05  )
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

Add Philipp to CC as he is also investigating UKI

On 09/11/23 at 07:25am, Jan Hendrik Farr wrote:
> Hello,
> 
> this patch (v2) implements UKI support for kexec_file_load. It will require
> support in the kexec-tools userspace utility. For testing purposes the
> following can be used: https://github.com/Cydox/kexec-test/
> 
> Creating UKIs for testing can be done with ukify (included in systemd),
> sbctl, and mkinitcpio, etc.

This is awesome work, Jan, thanks.

By the way, could you provide detailed steps about how to test this
patchset so that people interested can give it a shot?

> 
> There has been discussion on this topic in an issue on GitHub that is linked
> below for reference.
> 
> Changes for v2:
> - .cmdline section is now optional
> - moving pefile_parse_binary is now in a separate commit for clarity
> - parse_pefile.c is now in /lib instead of arch/x86/kernel (not sure if
>   this is the best location, but it definetly shouldn't have been in an
>   architecture specific location)
> - parse_pefile.h is now in include/kernel instead of architecture
>   specific location
> - if initrd or cmdline is manually supplied EPERM is returned instead of
>   being silently ignored
> - formatting tweaks
> 
> 
> Some links:
> - Related discussion: https://github.com/systemd/systemd/issues/28538
> - Documentation of UKIs: https://uapi-group.org/specifications/specs/unified_kernel_image/
> 
> Jan Hendrik Farr (2):
>   move pefile_parse_binary to its own file
>   x86/kexec: UKI support
> 
>  arch/x86/include/asm/kexec-uki.h       |   7 ++
>  arch/x86/kernel/Makefile               |   1 +
>  arch/x86/kernel/kexec-uki.c            | 126 +++++++++++++++++++++++++
>  arch/x86/kernel/machine_kexec_64.c     |   2 +
>  crypto/asymmetric_keys/mscode_parser.c |   2 +-
>  crypto/asymmetric_keys/verify_pefile.c | 110 +++------------------
>  crypto/asymmetric_keys/verify_pefile.h |  16 ----
>  include/linux/parse_pefile.h           |  32 +++++++
>  lib/Makefile                           |   3 +
>  lib/parse_pefile.c                     | 109 +++++++++++++++++++++
>  10 files changed, 292 insertions(+), 116 deletions(-)
>  create mode 100644 arch/x86/include/asm/kexec-uki.h
>  create mode 100644 arch/x86/kernel/kexec-uki.c
>  create mode 100644 include/linux/parse_pefile.h
>  create mode 100644 lib/parse_pefile.c
> 
> -- 
> 2.40.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

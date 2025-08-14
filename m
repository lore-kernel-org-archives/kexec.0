Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CCCCA0EE0
	for <kexec@archiver.kernel.org>; Thu, 14 Aug 2025 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8lmfqcZ52puICOqfYpqD3N/QRVedlIIDloCFgvva9KY=; b=t5N4QLYTPS9kX5dJ60xQrUEil1
	PFpatmDhO3CTTaqbC7KJEOzwoOa3wjPQiSfYVtvxM9ns5MTFqau1PqGIjmDn+61zbUOc3MJVbPxGP
	uNbodTmumz33VnMDetlBMHnZNt/olDJSTJhKfuRGJK6vNsPzy2/BzfCZYPAAK86fvt4ugmhJGk/yY
	4KAH2ddw6EEryCH/wr1GgkVWd0MN0spdeezwnWz4jKX8ur8uhGW5KGkw6BcaORibeAeGof5yDYmAE
	56k8BfD7PXiCFp1t87WHoGvcFMYOiYQDlnoJfev3+B/6x7U09C0k7H3mcyYqche7eAhYDAcYkLxpZ
	cL9SxuVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umNsl-0000000FbBl-0V2q;
	Thu, 14 Aug 2025 02:39:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umNsf-0000000FbBJ-2KrL
	for kexec@lists.infradead.org;
	Thu, 14 Aug 2025 02:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755139191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8lmfqcZ52puICOqfYpqD3N/QRVedlIIDloCFgvva9KY=;
	b=Gmfnu4b3o5dMTsYJ8EvkNSzJrdBK7mT3E//5mGn7zUzVlTz8xrMbCb31X/n82Vpgs0+V0j
	lVil2wudzNln1lP6WS/VUNpnhm/MOhmplA5eVFOIlKNRygYDerNngp6bk45gL2t7iGwTpk
	oZauKflhiEPzqi3sHiys2BtVsmRoSVc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-8oGBpyq0OiSQ-YizA1p2zA-1; Wed,
 13 Aug 2025 22:39:47 -0400
X-MC-Unique: 8oGBpyq0OiSQ-YizA1p2zA-1
X-Mimecast-MFC-AGG-ID: 8oGBpyq0OiSQ-YizA1p2zA_1755139184
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A590618003FD;
	Thu, 14 Aug 2025 02:39:43 +0000 (UTC)
Received: from localhost (unknown [10.72.112.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67FF71800446;
	Thu, 14 Aug 2025 02:39:41 +0000 (UTC)
Date: Thu, 14 Aug 2025 10:39:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Brian Mak <makb@juniper.net>
Cc: Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: Carry forward the boot DTB on kexec
Message-ID: <aJ1MaPVWZCp0qpU2@MiWiFi-R3L-srv>
References: <20250805211527.122367-1-makb@juniper.net>
 <9B71EC74-D1F4-4F7D-837A-A43E53CEBB89@juniper.net>
 <CALu+AoQnXfYtuKQxVKK32sC4D98Y+Yn30TjTr2xmXhZcHe0x=A@mail.gmail.com>
 <A402BEF1-EB1A-48F0-997F-502429AAD92E@juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A402BEF1-EB1A-48F0-997F-502429AAD92E@juniper.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_193953_668937_A223528B 
X-CRM114-Status: GOOD (  30.00  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 08/13/25 at 07:24pm, Brian Mak wrote:
> On Aug 12, 2025, at 8:54 PM, Dave Young <dyoung@redhat.com> wrote:
> 
> > Hi, The #ifdef CONFIG_* which can be replaced by #if defined(), but I
> > do not have a strong opinion.  other than that do you have kexec-tools
> > patch ready? It would be better to provide a link so that people can
> > try and test it.
> 
> Hi Dave,
> 
> Thanks for looking at this! The #ifdef CONFIG_* is used, as it matches
> the style of other ifdefs in this file. I'd like to keep it as-is for
> consistency.
> 
> I do have a prototype kexec-tools patch ready for testing. The changes
> can be found at this repo:
> 
> https://github.com/makb-juniper/kexec-tools.git
> 
> I've also placed the diff below.

Thanks, I will apply your patch and take a test.

Usually, Andrew will merge kexec/kdump patch if the patch is OK to him.
I will add comment if I have concern. Otherwise, I don't want Andrew to
bother to add my ACK.

> 
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index 9b17578..8419b23 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -124,6 +124,8 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
>  #define KEXEC_FILE_ON_CRASH	0x00000002
>  #define KEXEC_FILE_NO_INITRAMFS	0x00000004
>  #define KEXEC_FILE_DEBUG	0x00000008
> +#define KEXEC_FILE_NO_CMA	0x00000010
> +#define KEXEC_FILE_FORCE_DTB	0x00000020
>  
>  /* These values match the ELF architecture values. 
>   * Unless there is a good reason that should continue to be the case.
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 6bf12d7..0e13b6b 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1102,6 +1102,7 @@ void usage(void)
>  	       " --hotplug            Do in-kernel update of kexec segments on CPU/Memory\n"
>  	       "                      hot add/remove events, avoiding the need to reload\n"
>  	       "                      kdump kernel on online/offline events.\n"
> +	       " --force-dtb          Carry over the current boot's device tree blob (x86 only).\n"
>  	       " -d, --debug          Enable debugging to help spot a failure.\n"
>  	       " -S, --status         Return 1 if the type (by default crash) is loaded,\n"
>  	       "                      0 if not.\n"
> @@ -1640,6 +1641,9 @@ int main(int argc, char *argv[])
>  		case OPT_HOTPLUG:
>  			do_hotplug = 1;
>  			break;
> +		case OPT_FORCE_DTB:
> +			kexec_file_flags |= KEXEC_FILE_FORCE_DTB;
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index a2e19c4..2235aa2 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -235,7 +235,8 @@ extern int file_types;
>  #define OPT_LOAD_LIVE_UPDATE	263
>  #define OPT_EXEC_LIVE_UPDATE	264
>  #define OPT_HOTPLUG		        265
> -#define OPT_MAX		266
> +#define OPT_FORCE_DTB		266
> +#define OPT_MAX		267
>  #define KEXEC_OPTIONS \
>  	{ "help",		0, 0, OPT_HELP }, \
>  	{ "version",		0, 0, OPT_VERSION }, \
> @@ -263,6 +264,7 @@ extern int file_types;
>  	{ "status",		0, 0, OPT_STATUS }, \
>  	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
>  	{ "hotplug",		    0, 0, OPT_HOTPLUG }, \
> +	{ "force-dtb",          0, 0, OPT_FORCE_DTB }, \
>  
>  #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
>  
> 
> base-commit: daa29443819d3045338792b5ba950ed90e79d7a5
> -- 
> 2.25.1
> 



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B693EC36011
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19WP4WFqsV7qujfoRGQmqqeN7h9hu1fjTeGwGJQZMdQ=; b=YlHHxcL/xouIREhXl/LgjPDj3M
	YBZcVXDf0mcdOInPIcTWhAHqrPhdBdeMV2y7/NN7adC7lwBbE2fY72F6bN+QOGqcMfePs8i9a0ouR
	tVvcFrPthVNgZncN83fUIspQ3GWQxlv47TsajCdvQp5DwJSqe6Ya3ar2caJ2NUhnrK7r0z7D6dMEA
	DZVGOqXh2JFNZNDK74aFR20opBADPmD4VurhYKRTMt86rcwr0Wl2hA69su3z8fJznY3ruTqrKWUKq
	kn3cufSRzTxyfBUGZFdhxoxY8SZ7gXVCg6bam4rZk3Ld5k1b1RkX2oQec7jCcwk2ytNK3KRFxFrq1
	8XK2yZ4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTv-0000000B65v-1swl;
	Thu, 27 Mar 2025 13:41:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twyEj-0000000519e-3JjZ
	for kexec@lists.infradead.org;
	Tue, 25 Mar 2025 06:58:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742885889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19WP4WFqsV7qujfoRGQmqqeN7h9hu1fjTeGwGJQZMdQ=;
	b=C1IOs/DdBAdkXROszvTCRZTeLgZ112IYC71DWZZXvo6nk//XkoKpNhjTNlNb/B0zzKO2HB
	Ak75Tj9UktMjiGcKYUz1TqYVIXJNIVfUtTC+Vt7OiZVDqyQTSJYkNGokmjyXv9BLf0HfqR
	ZWnP+G2XAR1zHfXS40J96ahNQ8wVTV4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-qE_0gAprMS2WIAV1lbNLxA-1; Tue,
 25 Mar 2025 02:58:04 -0400
X-MC-Unique: qE_0gAprMS2WIAV1lbNLxA-1
X-Mimecast-MFC-AGG-ID: qE_0gAprMS2WIAV1lbNLxA_1742885880
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E98ED18DBA01;
	Tue, 25 Mar 2025 06:57:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.60])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E607180B48C;
	Tue, 25 Mar 2025 06:57:54 +0000 (UTC)
Date: Tue, 25 Mar 2025 14:57:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, rppt@kernel.org,
	mark.rutland@arm.com, pbonzini@redhat.com,
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org,
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
Message-ID: <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com>
 <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_235809_893980_21CCF2A4 
X-CRM114-Status: GOOD (  26.25  )
X-Mailman-Approved-At: Thu, 27 Mar 2025 06:41:08 -0700
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

On 03/24/25 at 12:18pm, Dave Young wrote:
> On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > We have all generic code in place now to support Kexec with KHO. This
> > patch adds a config option that depends on architecture support to
> > enable KHO support.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  kernel/Kconfig.kexec | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 4d111f871951..57db99e758a8 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -95,6 +95,21 @@ config KEXEC_JUMP
> >           Jump between original kernel and kexeced kernel and invoke
> >           code in physical address mode via KEXEC
> >
> > +config KEXEC_HANDOVER
> > +       bool "kexec handover"
> > +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
> > +       select MEMBLOCK_KHO_SCRATCH
> > +       select KEXEC_FILE
> > +       select DEBUG_FS
> > +       select LIBFDT
> > +       select CMA
> > +       select XXHASH
> > +       help
> > +         Allow kexec to hand over state across kernels by generating and
> > +         passing additional metadata to the target kernel. This is useful
> > +         to keep data or state alive across the kexec. For this to work,
> > +         both source and target kernels need to have this option enabled.
> > +
> 
> Have you tested kdump?  In my mind there are two issues,  one is with
> CMA enabled, it could cause kdump crashkernel memory reservation
> failures more often due to the fragmented low memory.  Secondly,  in

kho scracth memorys are reserved much later than crashkernel, we may not
need to worry about it.
====================
start_kernel()
  ......
  -->setup_arch(&command_line);
     -->arch_reserve_crashkernel();
  ......
  -->mm_core_init();
     -->kho_memory_init();

> kdump kernel dump the crazy scratch memory in vmcore is not very
> meaningful.  Otherwise I suspect this is not tested under kdump.  If
> so please disable this option for kdump.

Yeah, it's not meaningful to dump out scratch memorys into vmcore. We
may need to dig them out from eflcorehdr. While it's an optimization,
kho scratch is not big relative to the entire system memory. It can be
done in later stage. My personal opinion.



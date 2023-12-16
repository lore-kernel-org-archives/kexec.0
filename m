Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB03AC41535
	for <kexec@archiver.kernel.org>; Sat, 16 Dec 2023 09:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=la52W2UOhGn53YjHzytZ8iIr8aEZp7gwUemj6mf0EKY=; b=bnMOFHor3dtyS2
	8zhs5TAoczrRy1pDPs5217wA8MA9cSp5aXOAwJhIuhXJEtUgJKzen4johEKixewL4+qmRs9RP7ART
	kwOiYrzQ0mqUuQM3Xkv0Vi1eL6vdNzIJ8HHRPJUfnrKCailRwZM2ABvB3cuCT27O2Kh+ZVW/fM7qD
	fQnkiqNZFBt6HHU8UNPvcT1Di7MMQqEyctsts9kPF/Bg0s8tbNYFe3zZ7mcm+fDe2yzx4j3/0Zbjc
	dMBc0Q6dTAwcgqkRCzesqmsC0bY5PSOQ/PPVW8NELa7G9CPlzjQumP7+MRmI1ZUhOzz9gJZEG8Isn
	a1g2VDKDTEaRpl6nMQtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rERAs-005lgR-2B;
	Sat, 16 Dec 2023 09:41:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rERAp-005lfu-1G
	for kexec@lists.infradead.org;
	Sat, 16 Dec 2023 09:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702719690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zk7LvFfboIPffETRNsovWRXYjUEBnLT/jZU6MklCwCQ=;
	b=Wu3t1Yoa9g8xxflTozerIUKoGNSUpIgJ9w4XsQNL9Mz0rHDKwFs8iMPEnZ9sPWif7D/3lj
	wGGgRA4LRQfBF38spN+eHpZuZAjTcFCy6axvxKMcJ7VbzzKaj0CUWKgUIR3nOqc5dCpPDz
	x5348IYlLl/aneq/yRxxC6Izb2ozPEg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-gtpd6LQmODyQsQz_mT5V-A-1; Sat,
 16 Dec 2023 04:41:26 -0500
X-MC-Unique: gtpd6LQmODyQsQz_mT5V-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF3A63C025C2;
	Sat, 16 Dec 2023 09:41:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8A51C060B1;
	Sat, 16 Dec 2023 09:41:24 +0000 (UTC)
Date: Sat, 16 Dec 2023 17:41:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v14 3/6] crash: add a new kexec flag for FDT update
Message-ID: <ZX1wwVlE85FcTxmV@MiWiFi-R3L-srv>
References: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
 <20231211083056.340404-4-sourabhjain@linux.ibm.com>
 <ZXu55ZXVSMeQDE/e@MiWiFi-R3L-srv>
 <7fe7b62f-d3fc-4035-96fe-1ab0e3e743c0@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <7fe7b62f-d3fc-4035-96fe-1ab0e3e743c0@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_014131_509552_01E18B31 
X-CRM114-Status: GOOD (  34.20  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 12/15/23 at 12:17pm, Sourabh Jain wrote:
...... =

> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 0f6ea35879ee..bcedb7625b1f 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -319,6 +319,7 @@ struct kimage {
> > >   #ifdef CONFIG_CRASH_HOTPLUG
> > >   	/* If set, allow changes to elfcorehdr of kexec_load'd image */
> > >   	unsigned int update_elfcorehdr:1;
> > > +	unsigned int update_fdt:1;
> > Can we unify this to one flag, e.g hotplug_update?
> > =

> > With this, on x86_64, we will skip the sha calculation for elfcorehdr.
> > On ppc, we will skip the sha calculation for elfcorehdr and fdt.
> Yeah, that's what I suggested to Eric. I can do that, but I see one
> problem with powerpc or other platforms that need to skip SHA
> for more kexec segments in addition to elfcorehdr.
> =

> `update_elfcorehdr` is set when the kexec tool sends the
> `KEXEC_UPDATE_ELFCOREHDR`
> flag to the kernel for the `kexec_load` system call.
> =

> Given that the kexec tool has already been updated to send the
> `KEXEC_UPDATE_ELFCOREHDR` flag only when elfcorehdr is skipped from
> SHA verification in generic code, now it would be tricky for architectures
> to
> determine whether kexec has skipped SHA verification for just elfcorehdr
> or all segments needed on the platform with the same flag.

In kexec-tools, it's judged by do_hotplug to skip the elfcorehdr
segment. I am wondering how you skip the fdt segment when calculating
and verifying sha, only saw the update_fdt mark.

About the existing KEXEC_UPDATE_ELFCOREHDR, we only rename the macro,
but still use the same value, could you think of what problem could be
caused between kernel and kexec-tools utility, the old and new version
compatibility?

If it's about the new header files installed on older kernel, we can
change it like below? Fortunately only one release, 6.6 passed.

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 3d5b3d757bed..df6a6505e267 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -13,7 +13,7 @@
 #define KEXEC_ON_CRASH         0x00000001
 #define KEXEC_PRESERVE_CONTEXT 0x00000002
-#define KEXEC_UPDATE_FDT       0x00000008
+#define KEXEC_CRASH_HOTPLUG_UPDATE 0x00000004
 #define KEXEC_UPDATE_ELFCOREHDR        0x00000004
 #define KEXEC_ARCH_MASK                0xffff0000
 =

 /*

With my understanding, the kexec flag should be indicating the action,
the mem/cpu hotplug, but not relating to any detail. Imagine later
another segment need be skipped on one ARCH again, then another flag
need be added, this sounds not reasonable.

> =

> Code snippet from the kexec tool:
> =

> main() {
> =A0=A0=A0 ...
> =A0=A0=A0 /* NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR coll=
ide */
> =A0=A0 =A0if (do_hotplug) {
> =A0=A0=A0 =A0=A0=A0 ...
> =

> =A0=A0 =A0=A0=A0=A0 /* Indicate to the kernel it is ok to modify the elfc=
orehdr */
> =A0=A0 =A0=A0=A0=A0 kexec_flags |=3D KEXEC_UPDATE_ELFCOREHDR;
> =A0=A0 =A0}
> =A0=A0=A0 ...
> }
> =

> Any suggestion how to handle this with just one kexec flag?
> =

> Thanks for the review.
> =

> Thanks,
> Sourabh Jain
> =

> > =

> > >   #endif
> > >   #ifdef ARCH_HAS_KIMAGE_ARCH
> > > @@ -396,9 +397,10 @@ bool kexec_load_permitted(int kexec_image_type);
> > >   /* List of defined/legal kexec flags */
> > >   #ifndef CONFIG_KEXEC_JUMP
> > > -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
> > > +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | K=
EXEC_UPDATE_FDT)
> > >   #else
> > > -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KE=
XEC_UPDATE_ELFCOREHDR)
> > > +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KE=
XEC_UPDATE_ELFCOREHDR | \
> > > +			KEXEC_UPDATE_FDT)
> > >   #endif
> > >   /* List of defined/legal kexec file flags */
> > > diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> > > index 01766dd839b0..3d5b3d757bed 100644
> > > --- a/include/uapi/linux/kexec.h
> > > +++ b/include/uapi/linux/kexec.h
> > > @@ -13,6 +13,7 @@
> > >   #define KEXEC_ON_CRASH		0x00000001
> > >   #define KEXEC_PRESERVE_CONTEXT	0x00000002
> > >   #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
> > > +#define KEXEC_UPDATE_FDT	0x00000008
> > >   #define KEXEC_ARCH_MASK		0xffff0000
> > >   /*
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index 8f35a5a42af8..97eb151cd931 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -132,6 +132,8 @@ static int do_kexec_load(unsigned long entry, uns=
igned long nr_segments,
> > >   #ifdef CONFIG_CRASH_HOTPLUG
> > >   	if (flags & KEXEC_UPDATE_ELFCOREHDR)
> > >   		image->update_elfcorehdr =3D 1;
> > > +	if (flags & KEXEC_UPDATE_FDT)
> > > +		image->update_fdt =3D 1;
> > >   #endif
> > >   	ret =3D machine_kexec_prepare(image);
> > > -- =

> > > 2.41.0
> > > =

> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

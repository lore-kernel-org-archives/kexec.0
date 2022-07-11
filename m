Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38784C43334
	for <kexec@archiver.kernel.org>; Mon, 11 Jul 2022 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ubnphvjdmObBLmjgc8jCdQrpRY6hfs3jHRDa7dnNlWk=; b=xPDcCaV61y1wkR
	RYw/msYX4tbaFXmNHBNfZqlTiMrqbjF7+jcFVwqr99KN0wzzsZbG0yqh0JB+KxN0lmzttwad7aZLt
	1hr7B8oOn2/eLsMOW/4D0IlY1GLg05vVueIo9QlqcF/tLpwebDrO/yA5Cb8O0Yx8nmQNBKb6U7INe
	BQAgLCBxuKuOqcRhFnfTpApQbh6ZFATfFXJZ1TStKeN0K8oMVGBil0nQq8UQpnbgtoj2WOqs7K5t+
	z5UKrESeRXZhZ1n3vBgev6tch5PMMXdWdB9CJ4MFHo8Wx/F2SHX7ZAM/cwyuZB7QCaLHpQkyk0POq
	imjlVKLrWU3NrNTktxkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAqAs-000QJo-Vs; Mon, 11 Jul 2022 09:57:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oAqAc-000Q9O-2h
	for kexec@lists.infradead.org; Mon, 11 Jul 2022 09:57:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657533454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4705b3O605hQms9a0r/rRAuyFE62gnfa/SJiHrJ15tU=;
	b=gYD/D9UWGmkbkeDKbqluHgq9Ly9t8TRh4EreiHjY5Z1M+VAGwr4Q5E625u62JwQa/6t2hq
	1l5mym3rskBTI9otsGyv0Sk/bhEfBEKDPzQdddFujmp3SafkBJFGCRy7ld0riRCYWjehbQ
	boz/QG8AVCO0zPT1B1QpYTVY/3ymYfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-V-cREPW3Nguxdxphd5LsrQ-1; Mon, 11 Jul 2022 05:57:30 -0400
X-MC-Unique: V-cREPW3Nguxdxphd5LsrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C048985A581;
	Mon, 11 Jul 2022 09:57:29 +0000 (UTC)
Received: from localhost (ovpn-12-204.pek2.redhat.com [10.72.12.204])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D4C0492CA4;
	Mon, 11 Jul 2022 09:57:28 +0000 (UTC)
Date: Mon, 11 Jul 2022 17:57:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v9 7/7] x86/crash: Add x86 crash hotplug support
Message-ID: <Ysv0BEMOmN/WnhVg@MiWiFi-R3L-srv>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
 <20220613224240.79400-8-eric.devolder@oracle.com>
 <94f5e036-770d-4ca5-c386-9a43e7333b43@linux.ibm.com>
 <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e96c42ee-7a14-3565-16cd-dbf7cf163c21@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_025738_250301_E0056C05 
X-CRM114-Status: GOOD (  38.06  )
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

On 07/07/22 at 07:55am, Eric DeVolder wrote:
> =

> =

> On 6/20/22 00:06, Sourabh Jain wrote:
> > Hello Eric,
> > =

> > On 14/06/22 04:12, Eric DeVolder wrote:
> > > For x86_64, when CPU or memory is hot un/plugged, the crash
> > > elfcorehdr, which describes the CPUs and memory in the system,
> > > must also be updated.
> > > =

> > > When loading the crash kernel via kexec_load or kexec_file_load,
> > > the elfcorehdr is identified at run time in
> > > crash_core:handle_hotplug_event().
> > > =

> > > To update the elfcorehdr for x86_64, a new elfcorehdr must be
> > > generated from the available CPUs and memory. The new elfcorehdr
> > > is prepared into a buffer, and then installed over the top of
> > > the existing elfcorehdr.
> > > =

> > > In the patch 'kexec: exclude elfcorehdr from the segment digest'
> > > the need to update purgatory due to the change in elfcorehdr was
> > > eliminated.=A0 As a result, no changes to purgatory or boot_params
> > > (as the elfcorehdr=3D kernel command line parameter pointer
> > > remains unchanged and correct) are needed, just elfcorehdr.
> > > =

> > > To accommodate a growing number of resources via hotplug, the
> > > elfcorehdr segment must be sufficiently large enough to accommodate
> > > changes, see the CRASH_MAX_MEMORY_RANGES configure item.
> > > =

> > > With this change, crash hotplug for kexec_file_load syscall
> > > is supported. The kexec_load is also supported, but also
> > > requires a corresponding change to userspace kexec-tools.
> > > =

> > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > > ---
> > > =A0 arch/x86/Kconfig=A0=A0=A0=A0=A0=A0=A0 |=A0 11 ++++
> > > =A0 arch/x86/kernel/crash.c | 116 +++++++++++++++++++++++++++++++++++=
+++++
> > > =A0 2 files changed, 127 insertions(+)
> > > =

> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 762a0b6ab8b6..e9eecff3b97d 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -2082,6 +2082,17 @@ config CRASH_DUMP
> > > =A0=A0=A0=A0=A0=A0=A0 (CONFIG_RELOCATABLE=3Dy).
> > > =A0=A0=A0=A0=A0=A0=A0 For more details see Documentation/admin-guide/=
kdump/kdump.rst
> > > +config CRASH_MAX_MEMORY_RANGES
> > > +=A0=A0=A0 depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEM=
ORY_HOTPLUG)
> > > +=A0=A0=A0 int
> > > +=A0=A0=A0 default 32768
> > > +=A0=A0=A0 help
> > > +=A0=A0=A0=A0=A0 For the kexec_file_load path, specify the maximum nu=
mber of
> > > +=A0=A0=A0=A0=A0 memory regions, eg. as represented by the 'System RA=
M' entries
> > > +=A0=A0=A0=A0=A0 in /proc/iomem, that the elfcorehdr buffer/segment c=
an accommodate.
> > > +=A0=A0=A0=A0=A0 This value is combined with NR_CPUS and multiplied b=
y Elf64_Phdr
> > > +=A0=A0=A0=A0=A0 size to determine the final buffer size.
> > > +
> > > =A0 config KEXEC_JUMP
> > > =A0=A0=A0=A0=A0 bool "kexec jump"
> > > =A0=A0=A0=A0=A0 depends on KEXEC && HIBERNATION
> > > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > > index 9db41cce8d97..b9cdf7a0d868 100644
> > > --- a/arch/x86/kernel/crash.c
> > > +++ b/arch/x86/kernel/crash.c
> > > @@ -25,6 +25,7 @@
> > > =A0 #include <linux/slab.h>
> > > =A0 #include <linux/vmalloc.h>
> > > =A0 #include <linux/memblock.h>
> > > +#include <linux/highmem.h>
> > > =A0 #include <asm/processor.h>
> > > =A0 #include <asm/hardirq.h>
> > > @@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
> > > =A0=A0=A0=A0=A0 image->elf_headers =3D kbuf.buffer;
> > > =A0=A0=A0=A0=A0 image->elf_headers_sz =3D kbuf.bufsz;
> > > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > > +=A0=A0=A0 /* Ensure elfcorehdr segment large enough for hotplug chan=
ges */
> > > +=A0=A0=A0 kbuf.memsz =3D (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_=
MEMORY_RANGES) * sizeof(Elf64_Phdr);
> > > +=A0=A0=A0 /* For marking as usable to crash kernel */
> > > +=A0=A0=A0 image->elf_headers_sz =3D kbuf.memsz;
> > > +=A0=A0=A0 /* Record the index of the elfcorehdr segment */
> > > +=A0=A0=A0 image->elfcorehdr_index =3D image->nr_segments;
> > > +=A0=A0=A0 image->elfcorehdr_index_valid =3D true;
> > > +#else
> > > =A0=A0=A0=A0=A0 kbuf.memsz =3D kbuf.bufsz;
> > > +#endif
> > > =A0=A0=A0=A0=A0 kbuf.buf_align =3D ELF_CORE_HEADER_ALIGN;
> > > =A0=A0=A0=A0=A0 kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> > > =A0=A0=A0=A0=A0 ret =3D kexec_add_buffer(&kbuf);
> > > @@ -413,3 +424,108 @@ int crash_load_segments(struct kimage *image)
> > > =A0=A0=A0=A0=A0 return ret;
> > > =A0 }
> > > =A0 #endif /* CONFIG_KEXEC_FILE */
> > > +
> > > +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> > > +int crash_hotplug_support(void) { return 1; }
> > > +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> > > +{
> > > +=A0=A0=A0 /*
> > > +=A0=A0=A0=A0 * NOTE: The addresses and sizes passed to this routine =
have
> > > +=A0=A0=A0=A0 * already been fully aligned on page boundaries. There =
is no
> > > +=A0=A0=A0=A0 * need for massaging the address or size.
> > > +=A0=A0=A0=A0 */
> > > +=A0=A0=A0 void *ptr =3D NULL;
> > > +
> > > +=A0=A0=A0 /* NOTE: requires arch_kexec_[un]protect_crashkres() for w=
rite access */
> > > +=A0=A0=A0 if (size > 0) {
> > > +=A0=A0=A0=A0=A0=A0=A0 struct page *page =3D pfn_to_page(paddr >> PAG=
E_SHIFT);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0 ptr =3D kmap(page);
> > > +=A0=A0=A0 }
> > > +
> > > +=A0=A0=A0 return ptr;
> > > +}
> > > +
> > > +void arch_unmap_crash_pages(void **ptr)
> > > +{
> > > +=A0=A0=A0 if (ptr) {
> > > +=A0=A0=A0=A0=A0=A0=A0 if (*ptr)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kunmap(*ptr);
> > > +=A0=A0=A0=A0=A0=A0=A0 *ptr =3D NULL;
> > > +=A0=A0=A0 }
> > > +}
> > =

> > Aren't arch will have build issue if arch_[un]map_crash_pages methods a=
re not defined?
> Sourabh,
> Yes, you are correct. I'll add __weak versions of each in crash_core.c in=
 the next patch.

Just a reminder, __weak is deprecated and has been cleaned up in
kernel/kexec*.c in below patch.

[PATCH 0/2] kexec: Drop __weak attributes from functions


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

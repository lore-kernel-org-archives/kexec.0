Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F318CC6FD1D
	for <kexec@archiver.kernel.org>; Fri, 17 Mar 2023 09:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YN3pzLP2eVRAoEfFaJE8koHAT7yugfxOLnzgRto9Rhw=; b=quFM+6vcRFg+iM
	C+6p2LzhZGg/2osP84qIiwUbqRRSDPWlZkF5WL7682j2Rw5JqQhKi8xpmM3BNWiTHC6zHDfs2GnGb
	iQzUCCHIT9RwEMQiJivgVU0GXE/2qMDlZibEHELY9lqb0n6YpuXhrr0SN6LnQ2TWjtIX9tGvbZrZF
	9U9/Tonh6HVISuJ5z5/Rb0F+Y3sp0M0dAha4PNGuYnG/a9cgcw801j+6eOLg0F1icakCk0baKXWlO
	1GKUZKxSMmlQmk1t25G/xYlCrEn8RedEvhrRtuuJse4UtUXvCgU2R5gjH3bvSzs5/WrTRKxi4pgmq
	BfWOuK8Ps+ZbcbbDYKhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pd6Pz-001jsk-30;
	Fri, 17 Mar 2023 09:30:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pd6Pw-001jrz-2i
	for kexec@lists.infradead.org;
	Fri, 17 Mar 2023 09:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679045431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YPCtklsU3EN6/UK6raeMaHzWYyPWwijivGCe480384=;
	b=KVcqN8ody7XdTg/Rr/vxpwJxm77qxKlmrc7cNbVjHQjULRzWUXekH5IW/u3yWIYXkzYBiU
	gyzwoSoEyNd2XHKuSA5vRIx2q1f9i8toAoUju5XglkQDUeFbQdn62JxNKS4BnaxuZwPYnw
	UQM+4D8eGwBNRRR324TcaI4pTqQ2poA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-0wcKsR7COJuusFPRlOWVug-1; Fri, 17 Mar 2023 05:30:27 -0400
X-MC-Unique: 0wcKsR7COJuusFPRlOWVug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 011DA811E7B;
	Fri, 17 Mar 2023 09:30:27 +0000 (UTC)
Received: from localhost (ovpn-12-67.pek2.redhat.com [10.72.12.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AB0140E960;
	Fri, 17 Mar 2023 09:30:25 +0000 (UTC)
Date: Fri, 17 Mar 2023 17:30:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBQzLxpLPcyhrDoF@MiWiFi-R3L-srv>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
 <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
 <cae43a11-b270-a5d6-7464-d92651c67c4a@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cae43a11-b270-a5d6-7464-d92651c67c4a@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230317_023033_868744_D43A4B0C 
X-CRM114-Status: GOOD (  28.70  )
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

On 03/16/23 at 10:47am, Eric DeVolder wrote:
> =

> =

> On 3/16/23 09:44, Eric DeVolder wrote:
> > =

> > =

> > On 3/16/23 05:11, Baoquan He wrote:
> > > On 03/06/23 at 11:22am, Eric DeVolder wrote:
> > > ......
> > > > +static void crash_handle_hotplug_event(unsigned int hp_action, uns=
igned int cpu)
> > > > +{
> > > > +=A0=A0=A0 /* Obtain lock while changing crash information */
> > > > +=A0=A0=A0 if (kexec_trylock()) {
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 /* Check kdump is loaded */
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (kexec_crash_image) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct kimage *image =3D kexec_c=
rash_image;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (hp_action =3D=3D KEXEC_CRASH=
_HP_ADD_CPU ||
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 hp_action =3D=3D KEX=
EC_CRASH_HP_REMOVE_CPU)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("hp_action =
%u, cpu %u\n", hp_action, cpu);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_debug("hp_action =
%u\n", hp_action);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * When the struct kimage is a=
llocated, the elfcorehdr_index
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * is set to -1. Find the segm=
ent containing the elfcorehdr,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * if not already found. This =
works for both the kexec_load
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * and kexec_file_load paths.
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (image->elfcorehdr_index < 0)=
 {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long mem;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned char *ptr;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int n;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (n =3D 0; n < im=
age->nr_segments; n++) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mem =3D =
image->segment[n].mem;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ptr =3D =
kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ptr)=
 {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 /* The segment containing elfcorehdr */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 if (memcmp(ptr, ELFMAG, SELFMAG) =3D=3D 0) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 image->elfcorehdr_index =3D (int)n;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 }
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 kunmap_local(ptr);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (image->elfcorehdr_index < 0)=
 {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("unable to lo=
cate elfcorehdr segment");
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Needed in order for the segme=
nts to be updated */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 arch_kexec_unprotect_crashkres();
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Differentiate between normal =
load and hotplug update */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 image->hp_action =3D hp_action;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Now invoke arch-specific upda=
te handler */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 arch_crash_handle_hotplug_event(=
image);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* No longer handling a hotplug =
event */
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 image->hp_action =3D KEXEC_CRASH=
_HP_NONE;
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 image->elfcorehdr_updated =3D tr=
ue;
> > > =

> > > It's good to initialize the image->hp_action here, however where do
> > > you check it? Do you plan to add some check somewhere?
> > =

> > Hi Baoquan,
> > The hp_action member is initialized to 0 in do_image_alloc_init(). I've
> > mapped KEXEC_CRASH_HP_NONE onto 0 on purpose.
> > =

> > But the use of image->hp_action =3D KEXEC_CRASH_HP_NONE is to actually
> > delineate that a hotplug event handling has completed. You can see
> > imae->hp_action set to hp_action to capture what the triggering event
> > was, as passed into this function.
> > =

> > I will go ahead and set image->hp_action =3D KEXEC_CRASH_HP_NONE; expli=
citly
> > in do_kimage_alloc_init(), as that is done for the other crash hotplug =
members.
> > =

> > Thanks!
> > eric
> =

> Baoquan, as you are currently working through v19, please let me know whe=
n I
> should put out v20 with this and Sourabh's feedback.
> Thanks,
> eric

The overall serial looks good to me other than the nitpicks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

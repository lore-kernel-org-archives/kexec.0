Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C9C433EF
	for <kexec@archiver.kernel.org>; Mon,  4 Jul 2022 07:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8Cq5ewGflxBdNE2D8lhc37ZLKNWHXzYirh5tS8JmvXY=; b=LsixADPukQ4LFs
	GMu6sXSLmksxIJWGIUhEPXgs+ipSr6X6006KtNgpEmPYPWNkn3wdaM5NVtee8qtJ029RHJ0p/+34e
	dq+feoIpDm4UKVmLzcZ5oo4BRch2KFI9YBEvzGNAZ0xihjichgUbmG4JHtoOdOcOsDo5EMMkx1zRl
	WpZnP5mbpptAKT21UJJS2leo9qnIXlqW8EtlDSeMOPKoiqnQMC0LRyrE6h5tBcmYvIGNFGHs9fmCK
	JNcfndxyyOJSYjlMEOAooNa8BqcSFOQJdDkMTxh2uNY+FHYkxdAG+qssYYnKNs98CU+QHz3RLaxit
	BpVhQdSMneh/cH3/e5Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8GOH-005fGt-RW; Mon, 04 Jul 2022 07:21:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8GOF-005fDi-6g
	for kexec@lists.infradead.org; Mon, 04 Jul 2022 07:21:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656919261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZvdib+oo3lvrA14EYB6RpofmfTNnpFnXxq1/Do0txY=;
	b=L1PjdtTT6/09KaG4gV0+1gx3dQtrQwC7TwMkZLLsKVbrhZRBnoxyIL0ryur5qMgycEIvIO
	wremFxIK+OIyoudooVpuLW43hv5n7WbeS3bP+Ez2i+13oL2Xpbvc6qL35Ny++0FgbZsn3I
	769JKMTKuSG2pViyckn30FYWQh3Qy1g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-IrVPfsluOF6LIO1wlbWkiw-1; Mon, 04 Jul 2022 03:19:06 -0400
X-MC-Unique: IrVPfsluOF6LIO1wlbWkiw-1
Received: by mail-wm1-f71.google.com with SMTP id n18-20020a05600c501200b003a050cc39a0so3679032wmr.7
        for <kexec@lists.infradead.org>; Mon, 04 Jul 2022 00:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZvdib+oo3lvrA14EYB6RpofmfTNnpFnXxq1/Do0txY=;
        b=yopYlyrMr8yw2CMLiTjSiRvocXLXm4NBJ1N5Vjq+Bx5N2LEhJW8Lw1OLs1lVlhD6A+
         4jalEKdLHxFBk3KHb7D91GIJuI7mEwiGqiiioywCTu6gcCf8i8DaEzBTE7jRvEHGnM/n
         vLfz45NbDikBtdFb0d6hrO3JgMoyeeQRDb1O1gqnXuFurqb/MlkL7dvrOFj4kKWYlPTo
         BMI2UZUkqNSxtNsY7atsHU2ImjcPm7xbocEnCHInAn1meX8gBl98W7VmQy6Lb8365Vw+
         m1RL8RTk0HfyxRwiSrfu+MtFl9f1rgh0j0yMHpRtzFyDV0degNz5YKnA9o0k6xuLrjxW
         8YQg==
X-Gm-Message-State: AJIora+vVQcY/4suBZKrEVGPeTWhcwgLSyXt+W4YPGh89BZ9IyPl6lzX
	DtJbdNK4s5AJDoL80gS1s49us8lTD2/wVAW7hFiXMNH108fTXttptqEdRTFpv6yUSUJvz5yzK/F
	VO08GSsa9KFj7Mm2T8nrT0lPw/RUXnUhuvG1r
X-Received: by 2002:a7b:cd08:0:b0:3a0:37f9:6e5d with SMTP id f8-20020a7bcd08000000b003a037f96e5dmr29297866wmj.167.1656919145686;
        Mon, 04 Jul 2022 00:19:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkdZbo2UPOn3erwRwVBiaO/vhxvuXgkMCqyD6lyQOAT9BAwU6xS4YUbV77VaB9q2ElZmkyOxqjB6Wsp4Bc8ZM=
X-Received: by 2002:a7b:cd08:0:b0:3a0:37f9:6e5d with SMTP id
 f8-20020a7bcd08000000b003a037f96e5dmr29297854wmj.167.1656919145478; Mon, 04
 Jul 2022 00:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com> <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org> <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
 <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com> <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
 <20220629005915.gieli3dbjzvjbk5i@black.fi.intel.com>
In-Reply-To: <20220629005915.gieli3dbjzvjbk5i@black.fi.intel.com>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 4 Jul 2022 15:18:54 +0800
Message-ID: <CALu+AoQdEGpecj1wm9U2MpKqPbN5UmFF6+w3JaJSvddeRwf0dw@mail.gmail.com>
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted memory
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Andi Kleen <ak@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Varad Gautam <varad.gautam@suse.com>, 
	Dario Faggioli <dfaggioli@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@redhat.com>, marcelo.cerri@canonical.com, tim.gardner@canonical.com, 
	khalid.elmously@canonical.com, philip.cox@canonical.com, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ruyang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_002103_372563_4D7AD327 
X-CRM114-Status: GOOD (  20.04  )
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

On Wed, 29 Jun 2022 at 08:59, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Tue, Jun 28, 2022 at 05:10:56PM -0700, Dave Hansen wrote:
> > On 6/28/22 16:51, Kirill A. Shutemov wrote:
> > > On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
> > >>> If there is some deep and fundamental why this can not be supported
> > >>> then it probably makes sense to put some code in the arch_kexec_load
> > >>> hook that verifies that deep and fundamental reason is present.
> > ...
> > > +   /*
> > > +    * TODO: Information on memory acceptance status has to be communicated
> > > +    * between kernel.
> > > +    */
> >
> > So, the deep and fundamental reason is... drum roll... you haven't
> > gotten around to implementing bitmap passing yet?!?!?   I have the
> > feeling that wasn't what Eric was looking for.
>
> The deep fundamental reason is that everything cannot be implemented and
> upstreamed at once.

If the only thing is to pass bitmap to kexec kernel, since you have
reserved the bitmap memory I guess it is straightforward to set the
kexec bootparams.unaccepted_memory as the old value.  Not sure if
there are problems when the decompress code accepts memory again
though.
for kernel kexec_file_load, refer to function setup_boot_parameters()
in arch/x86/kernel/kexec-bzimage64.c for kexec_file_load,
for kexec-tools kexec_load code refer to
setup_linux_system_parameters() kexec/arch/i386/x86-linux-setup.c

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

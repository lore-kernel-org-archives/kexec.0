Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D3C36012
	for <kexec@archiver.kernel.org>; Thu, 27 Mar 2025 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rzd5n04s6jxEJ+gCSK/dDhucMnvX+2uhB2qdLifXWko=; b=FNhaLBRM/lmQOOU6cHMpqfTuur
	ZGGqDJfJxKyjomNWlw3Vd/AO8QnlWv9YM0+Vp2n+iVBmqQyXUIr+zfCXYNf9qyDO5S0NbVwKKMu1N
	o5CWi3q9Z82ihDn2Upd2XxQ6HAx7NGVVNAmmLQMRD64sVTq2WaaVlZsvOgfv+vVQ6dPfxb1SrrGjU
	AA8XBDWq83hRLlzIxMNuJVgC/vO302zdHM9aj0ZGSHsns2xKlpg2/nuqK+9RrJemLxtWwe7nhAkU4
	grsvm/ifxx8SaeDfpfrLdgRi+e4vI2DS3/989eC3Dy0BgaxscsSq3d/JRGTcEn7pw1FeQVPE6Cvhk
	+COekycg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txnTq-0000000B5zC-2vs8;
	Thu, 27 Mar 2025 13:41:10 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twQg0-00000001cYw-0Je9
	for kexec@lists.infradead.org;
	Sun, 23 Mar 2025 19:08:05 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-223f3357064so46228265ad.3
        for <kexec@lists.infradead.org>; Sun, 23 Mar 2025 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742756883; x=1743361683; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzd5n04s6jxEJ+gCSK/dDhucMnvX+2uhB2qdLifXWko=;
        b=BmESLpUxP6eR5z1sOzfjjlvSqlrF1y3yxOqsfJUwfGoBYKJ0BeYgY2004A75qFPVqe
         9+cAs8TyTAm0MBdXJuCIxnJp+rL1GR9vf5nNT5dE5ff+5zI9tM/bTNYv/f+QhupE2cEg
         32IxNI7ypcm8PbeNKkdZIfuENROsByZCwmfFx6BYEtI9Of5giAp3u7SO1b723dLa01Zy
         YRTOf58wrCcDo5H/Wz3GpDkItRzgNZPJUOcw9Jsa4bzjRs9ZhqPOAG7L2qnvkg+bS7E6
         X3gLVC0mK8cjHdbnaQAWuLaQnAsYG+Fl7qQkpQkktVBJ0sqfwYbyPm7PY0VTcFKR2A0X
         PGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742756883; x=1743361683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzd5n04s6jxEJ+gCSK/dDhucMnvX+2uhB2qdLifXWko=;
        b=RbFZWL7bPikkInUq7xdHG8tOlA2LLUsOdclkYreMuYe9tOll+9+ufhFw9v+tdwbmY9
         hF9HY7LI29UkPw/tLRWkiIY7CzCNrnYoFU3/fejhz0MfqMkvdocpmod+tvSVpNZw82Ng
         +1nOrWQrhVnlNXk407F0dz3N2khNSCMLgumIH94OGTzWlsiZH6it8NNbi/4s7CoMVJSK
         UzVbkTG9tCFxiVFFdvKZi+cahbOCWrgvqR93Y7aHwH5m2jnwo3FAVA5TxAZiQfTgqJhs
         nPJNhew1I76YzSYHkCjyEp89q+upqoC9MT7K2ffgVDBWRGX1f0/+BOrU8319EhtfpdXw
         gK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUeIPX+XRwpMlVe5u6M0iTkjMK81aLvm2CHr3ZMnz9Qz2/z9SBD1eAhjAkag8Qb/AezIw26A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVxq6g8hjustWHpXMxBIEIpiaA3TEztARJwQJBew1Z6WUgz3wU
	dLCw44CEl8tWKw0o+AN4VWu7SAqSrp2Cil39HbVJg1/mjik4PpKexN1neXSHtIzxC4xJRBkIJyP
	JRS48Y+huySgopPImIw==
X-Google-Smtp-Source: AGHT+IGWzYSY0zabXCYcrGJkQenZmyCPMKhLyeRtNYw0Z+Vw+fyMnZoqvv9CAHyz7l26vGknvFW4powxBM9q/JtU
X-Received: from plri3.prod.google.com ([2002:a17:903:32c3:b0:220:e84e:350c])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:da82:b0:224:162:a3e0 with SMTP id d9443c01a7336-22780e2a37fmr150656275ad.49.1742756882709;
 Sun, 23 Mar 2025 12:08:02 -0700 (PDT)
Date: Sun, 23 Mar 2025 12:07:58 -0700
In-Reply-To: <20250321134629.GA252045@nvidia.com>
Mime-Version: 1.0
References: <20250321134629.GA252045@nvidia.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250323190758.743798-1-changyuanl@google.com>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
From: Changyuan Lyu <changyuanl@google.com>
To: jgg@nvidia.com
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, changyuanl@google.com, corbet@lwn.net, 
	dave.hansen@linux.intel.com, devicetree@vger.kernel.org, dwmw2@infradead.org, 
	ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, 
	kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, 
	robh+dt@kernel.org, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250323_120804_145089_6241B5F8 
X-CRM114-Status: GOOD (  38.74  )
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

On Fri, Mar 21, 2025 at 10:46:29 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Wed, Mar 19, 2025 at 06:55:44PM -0700, Changyuan Lyu wrote:
> > +/**
> > + * kho_preserve_folio - preserve a folio across KHO.
> > + * @folio: folio to preserve
> > + *
> > + * Records that the entire folio is preserved across KHO. The order
> > + * will be preserved as well.
> > + *
> > + * Return: 0 on success, error code on failure
> > + */
> > +int kho_preserve_folio(struct folio *folio)
> > +{
> > +	unsigned long pfn = folio_pfn(folio);
> > +	unsigned int order = folio_order(folio);
> > +	int err;
> > +
> > +	if (!kho_enable)
> > +		return -EOPNOTSUPP;
> > +
> > +	down_read(&kho_out.tree_lock);
> > +	if (kho_out.fdt) {
>
> What is the lock and fdt test for?

It is to avoid the competition between the following 2 operations,
- converting the hashtables and mem traker to FDT,
- adding new data to hashtable/mem tracker.
Please also see function kho_finalize() in the previous patch
"kexec: add Kexec HandOver (KHO) generation helpers" [1].

The function kho_finalize() iterates over all the hashtables and
the mem tracker. We want to make sure that during the iterations,
no new data is added to the hashtables and mem tracker.

Also if FDT is generated, the mem tracker then has been serialized
to linked pages, so we return -EBUSY to prevent more data from
being added to the mem tracker.

> I'm getting the feeling that probably kho_preserve_folio() and the
> like should accept some kind of
> 'struct kho_serialization *' and then we don't need this to prove we
> are within a valid serialization window. It could pass the pointer
> through the notifiers

If we use notifiers, callbacks have to be done serially.

> The global variables in this series are sort of ugly..
>
> We want this to be fast, so try hard to avoid a lock..

In most cases we only need read lock. Different KHO users can adding
data into their own subnodes in parallel.
We only need a write lock if
- 2 KHO users register subnodes to the KHO root node at the same time
- KHO root tree is about to be converted to FDT.

> > +void *kho_restore_phys(phys_addr_t phys, size_t size)
> > +{
> > +	unsigned long start_pfn, end_pfn, pfn;
> > +	void *va = __va(phys);
> > +
> > +	start_pfn = PFN_DOWN(phys);
> > +	end_pfn = PFN_UP(phys + size);
> > +
> > +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> > +		struct page *page = pfn_to_online_page(pfn);
> > +
> > +		if (!page)
> > +			return NULL;
> > +		kho_restore_page(page);
> > +	}
> > +
> > +	return va;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_restore_phys);
>
> What do you imagine this is used for? I'm not sure what value there is
> in returning a void *? How does the caller "free" this?

This function is also from Mike :)

I suppose some KHO users may still
preserve memory using memory ranges (instead of folio). In the restoring
stage they need a helper to setup the pages of reserved memory ranges.
A void * is returned so the KHO user can access the memory
contents through the virtual address.
I guess the caller can free the ranges by free_pages()?

It makes sense to return nothing and let caller to call `__va`
if they want. Then the function signature looks more symmetric to
`kho_preserve_phys`.

> > +#define KHOSER_PTR(type)          \
> > +	union {                   \
> > +		phys_addr_t phys; \
> > +		type ptr;         \
> > +	}
> > +#define KHOSER_STORE_PTR(dest, val)                 \
> > +	({                                          \
> > +		(dest).phys = virt_to_phys(val);    \
> > +		typecheck(typeof((dest).ptr), val); \
> > +	})
> > +#define KHOSER_LOAD_PTR(src) \
> > +	((src).phys ? (typeof((src).ptr))(phys_to_virt((src).phys)) : NULL)
>
> I had imagined these macros would be in a header and usably by drivers
> that also want to use structs to carry information.
>

OK I will move them to the header file in the next version.

> > [...]
> > @@ -829,6 +1305,10 @@ static __init int kho_init(void)
> >
> >  	kho_out.root.name = "";
>
> ?

Set the root node name to an empty string since fdt_begin_node
calls strlen on the node name.

It is equivalent to `err = fdt_begin_node(fdt, "")` in kho_serialize()
of Mike's V4 patch [2].

> >  	err = kho_add_string_prop(&kho_out.root, "compatible", "kho-v1");
> > +	err |= kho_add_prop(&kho_out.preserved_memory, "metadata",
> > +			    &kho_out.first_chunk_phys, sizeof(phys_addr_t));
>
> metedata doesn't fee like a great a better name..
>
> Please also document all the FDT schema thoroughly!
>
> There should be yaml files just like in the normal DT case defining
> all of this. This level of documentation and stability was one of the
> selling reasons why FDT is being used here!

YAML files were dropped because we think it may take a while for our
schema to be near stable. So we start from some simple plain text. We
can add some prop and node docs (that are considered stable at this point)
back to YAML in the next version.

[1] https://lore.kernel.org/all/20250320015551.2157511-8-changyuanl@google.com/
[2] https://lore.kernel.org/all/20250206132754.2596694-6-rppt@kernel.org/

Best,
Changyuan


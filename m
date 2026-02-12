Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B0AEE3683
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mH6HMzCnnYstaeTidXe1DsSu+97OrNLd0YJh3QZ6yOI=; b=tN1wHcCoSIb/PbVjrOCZnWd13V
	KP60xm6IQFpYTuZRifKErK7RjDhKSGcZQbBd+ISqcaBpD2pyJpE0PK4fhUrvjDPz+BuGW5PGxGsCP
	dI0fhHBOEpMZMY+fHrg1uySfEsi/rPKVsJi4ZGr60tpSkNqeUURkzqFqr+0GnuROrqLYs8WQFOmgh
	cCWLW6lDOaouEfoxobLecCodhHtYb2XHxRovTgFwr9n+0N2P6UKH+FQMrnDAjyijwVhZpZvU45UhY
	UJ4l0RSApiCCJb38Rwj/5Zvyy1bUayFRq20gx5ityc5VII39BbhW+1fwAx/2pNhwmIgz0Eb1rRpiw
	MTvTdDuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqWie-000000028Xs-0Ru7;
	Thu, 12 Feb 2026 13:26:56 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqWib-000000028XU-42bN
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 13:26:55 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-124a60cc9a1so7421c88.0
        for <kexec@lists.infradead.org>; Thu, 12 Feb 2026 05:26:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770902812; cv=none;
        d=google.com; s=arc-20240605;
        b=H55ofGwmv2FjJ2qu/lPALjsl0dKT8EtHleELhRQP6xR7yAJXjx77pA7JqjAkXy1DJE
         vBBE4R/Uap7eUiOsSKZGhKqUfSmi/0jaszO7qIc36wzgOsC93eqgmadJwMdKYL84L6c6
         aj9IV6oxLSI4fiJGhQietyfLLverQL3hF9YumYZXBpGMahjviHuwX5Y57wtW+6PJTUAO
         88AQ3vRA/UgRQY5mOflzWg2EV6R9JCTtcgBr8W9y9pp69DdXgBAqTM7hHe3EZ8T5JTaD
         Hzx6Z4Fn7PLhqS//dIkzKvJN77e9P7FmBeS7btRRZrLGUqsoMwngf9RcXddQLqtdgULq
         XEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mH6HMzCnnYstaeTidXe1DsSu+97OrNLd0YJh3QZ6yOI=;
        fh=2euZsMhmoTbvyKCvYiAsk3IDMHkfbPyKpcYEPJF6CP4=;
        b=L1qwXiXxsJVpRG5tfrVUYj4RJ7i6/OG8Dw82IbAclq7oVADSQxTZdX07DUAwOB6XLN
         u1SIMqj1I03ihg9Dly+k2jGIMZKplGeL85DZQIYjQQZllDwp1sfu3/LILHXc15t9OuXm
         GHatVkmJ+euSm5RG8/0oJ4IRy9UfUCUNm/MQlegyi1l6DbMNjX/s9C7ls6qWI0zqDQ/3
         zV0qPKpF854BnWUsfMvWNz1vLULad85KQbtnm6KHqVqN8XKWtBileUeSJpxT96KztfFF
         hksCvfEZoT/Y0JSBgvH62WUDy+UWSPMa5moVHkB1Gl0eTWBSE2bCkxImJwS99zXRcIIt
         oGUA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770902812; x=1771507612; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH6HMzCnnYstaeTidXe1DsSu+97OrNLd0YJh3QZ6yOI=;
        b=QMWysCdWL/ppeGgfeP1rgjduogEQrJ8e+jKmGnkP2opwYT48tFwXq7szZxXvl8LTV2
         WucPH5tsLnCYWbPx57mOOz2SCEGKCKT/RdHmlqQ+S6mLDtuV6rb7h3fNHVBg3uRFBG2L
         VNJoxRZsYyinVdDUiz1jhmqvOlcpSDvU4SgxHEK13UAhuAZWkChcSfgAx/1tgAee8PO5
         8XvRYbXoGJZFGSySd/Rx3ZNOYJYGIO54Gzekoa5pqFvxd7YnXUqPfGuOY2VDgGRmYhpZ
         V14MI2tzYvbm4Ps5TSBnIxMFWuwFroG7tiYjIbzomzXz9NsIX9L1mafrGWO9oc/XdXya
         ZC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770902812; x=1771507612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mH6HMzCnnYstaeTidXe1DsSu+97OrNLd0YJh3QZ6yOI=;
        b=MOQa89ngvjndTyMbBdRyXU2V23MND5Cu+X7XLYJxuTDBcS2qHtJfEBd3RWx5iM3oo/
         wgn9kzmhYJ6J7HLbkJNKXbJCjUJaL9d+0lv1dZ/auueMr6zfcD4Tn3jGjxrhLKYb393K
         UKS7/1l+8/l3rGbzoW75Odgla/xQR9cWXojoZzHaeOqRwKfobrZ12Kbb+5msACKxPyn3
         QMy+btL5RaVBh8Y+2XmbdoOkKHTGuLEZR7OTjClbKAz6IjqE1UiyZIxnls6zGoMwVXZs
         WbMMCygqier65zHUAcJxPSd4tlJy7FdQGMYnaAUDhgPvATdfFdv4uOhtRPWFTIPnjJkC
         4VeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdPSQsT9jRjLqIVtuUHwHK/V8ySSAQZ46Y/T2sdo0VaJOKfBCJpPQPY2RznmiFvD5r5ew/Ow==@lists.infradead.org
X-Gm-Message-State: AOJu0YxwGJO01TYuGdJA+4YPjKuOrc8b6IHi1ofUInlqUOwNBKrg7nme
	InzzAYkMI1ZtUz4y3OvzWmJhpwD7WpzA/CUV32xBWFA9VWkqGp/8KSmqxbaw1J4OHAX7JmLodvb
	z4IjDNCP4M+Ulca8NFeqGNDFkzpTLPqgQdw65wurB
X-Gm-Gg: AZuq6aL/sNJnrPzIQQ/iBvmKsMfapGInPXF4zsRc487n54RMjzOITxrKmvFPWER2mpE
	nSF0YOkihvHqRITdSYPaf7JWyQwoHneqPEDGjzCaNAHp2gbwiU1pK5nT/Gy9dujEaIlx2rmvzNY
	AC6OzCJyLHzSiOd9dmEVXwZMzRTvCGFbmsaQrcAWJFGTmht6mIaI7Zr5GePQu5tSCXE1uIL09M9
	IKktTV+ulpa4LRsorgr+ziSmvH3EUtdYLbvXmLGEvxfpaQ4o1S6t8BPHM41FnOxSJQqrmtpfT68
	5wjc3g==
X-Received: by 2002:a05:7022:f010:b0:11a:2c18:9e70 with SMTP id
 a92af1059eb24-12730399227mr72922c88.11.1770902811657; Thu, 12 Feb 2026
 05:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20260211173954.2091119-1-mclapinski@google.com> <CA+CK2bBfJDD5SPJqwCaGbaGZe9FncONMsck0QkOb8WwmDSh_Yg@mail.gmail.com>
In-Reply-To: <CA+CK2bBfJDD5SPJqwCaGbaGZe9FncONMsck0QkOb8WwmDSh_Yg@mail.gmail.com>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Thu, 12 Feb 2026 14:26:39 +0100
X-Gm-Features: AZwV_QhOqhvLMMA8tGW0jRKe07LrkYVDlJ3nPhGSH3DMS5ObxgL-4w4AxgPOk7k
Message-ID: <CAAi7L5d19R8ftDsvwJpoxjkx9YSVkBuANOAixk75P98KJU=r4g@mail.gmail.com>
Subject: Re: [PATCH v3] kho: add support for deferred struct page init
To: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Cc: Evangelos Petrongonas <epetron@amazon.de>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_052654_031836_31C3BB97 
X-CRM114-Status: GOOD (  17.37  )
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

On Wed, Feb 11, 2026 at 8:40=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Feb 11, 2026 at 12:40=E2=80=AFPM Michal Clapinski <mclapinski@goo=
gle.com> wrote:
> >
> > From: Evangelos Petrongonas <epetron@amazon.de>
> >
> > When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> > initialization is deferred to parallel kthreads that run later
> > in the boot process.
> >
> > During KHO restoration, deserialize_bitmap() writes metadata for
> > each preserved memory region. However, if the struct page has not been
> > initialized, this write targets uninitialized memory, potentially
> > leading to errors like:
> > BUG: unable to handle page fault for address: ...
> >
> > Fix this by introducing kho_get_preserved_page(),  which ensures
> > all struct pages in a preserved region are initialized by calling
> > init_deferred_page() which is a no-op when deferred init is disabled
> > or when the struct page is already initialized.
> >
>
> Co-developed-by: Michal Clapinski <mclapinski@google.com>
>
> > Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> > Signed-off-by: Michal Clapinski <mclapinski@google.com>
> > Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> > ---
> > v3:
> > - changed commit msg
> > - don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dn
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Hello Andrew,
could you please apply this with the added Co-developed-by tag?

Thanks,
Michal


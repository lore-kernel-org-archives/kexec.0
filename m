Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9148DD6E2D8
	for <kexec@archiver.kernel.org>; Thu, 18 Dec 2025 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GC3r3DONuA6YiYHbbshOdJ1QdT9pjrS4H1t+Tf2/8Dc=; b=jcsUsDDnRdpsehWleU2JLLXIC+
	c2r/jEIidz0Re3fbwrUZekh9i+OjrIo6iwvCz9LEewgFfc5zvQcMv49MV7+YTsaI0prbRXu6dCwd3
	4SmnlK1Tz15CBvXQR4PQ8hzPFTKvx9CAfKiw9xcMYRqK9HZof6R0i3KveVLl8DigH/FESgJmNy6Hc
	3YtSIZt5v7eil9+XanjYodLZXr6qcSbTUv0HdTAQ+KLPOv3Dhwbby6F72JfPcWuw+YUDl+II09hmK
	5OeDfm5uLiWEEi1PVMnaVWp7SqovLROTWJr7r+Q8vuK5PU3K3ezoOri8USUa+412V3BJq1E5H8GB9
	BmLMITbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWIhc-00000008zL3-3Qkg;
	Thu, 18 Dec 2025 18:26:16 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWIhX-00000008zKg-0dXM
	for kexec@lists.infradead.org;
	Thu, 18 Dec 2025 18:26:12 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-b7697e8b01aso164370866b.2
        for <kexec@lists.infradead.org>; Thu, 18 Dec 2025 10:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766082369; x=1766687169; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC3r3DONuA6YiYHbbshOdJ1QdT9pjrS4H1t+Tf2/8Dc=;
        b=X61QLPxvrpTadOArlZCnz6QA+qjeuZv5BpUr2torvNRQzNcgXIT69C/9LCeNB8eMRY
         DcopBj/midRiu9rsyCsLjACqFq5Y5YRpoC18YRS0oNXu0vlZOcvOqvt2+O2BNtj/daKW
         xikpBg2rXSCMeRC0Kaymz5Li9FHVW9NTM+47qGht5/GIyFAkuT73MlVBYpMiRtjO2N1S
         lpME/CMqcyIL0gjf+Dv+Mhd1A5KtbhbDSUhXqfP+mFFwlclEP1Ce36BVAT2jC6mceGnW
         +IeJQ9XcUCdWUqd7JPzcM5cqIXXTpF+JhSjRFshb4/crVMnVXkT1NlS72E6JtF+vm8rD
         VgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766082369; x=1766687169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GC3r3DONuA6YiYHbbshOdJ1QdT9pjrS4H1t+Tf2/8Dc=;
        b=hUILqQD5N3rBryab1RWdJIhpvK/eqSHCnPjtIPQonZ1ewYioatjzTnA6rGroUeOYN1
         QKEF6BvUkShjIYLyd9+hMu3sMQUnf+xCFJvxeR6uC21/HgqzieXiWC/Si69ckYz0cYHw
         wKDLbR51CYboIYgAykOr2sfdnL6KzkkPbAdAUNbBiyicFtqkV4u80ykGrGACSlIkd48M
         VK8B1c2ZBBYiNJR07T8W569Z8ojJKED6M9P6f3Jm6kcsIs3MedD2tqxoP8vQHIQCe1Ib
         viDb/mF6onOj+he9+2ZZraYDdM00N004F7+eibMmvh7HBZrm43gXbk05OBD9ylstf551
         bgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLb3hoEh3HfkoGz1gPrlzHRvllwXlLjvE3R6JRPZqo9PYKNKy8LDI65DKUup1oU8en7hchrA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzFHOVVKk4QUx4rhEpGABr/gfw+XQy+K/9DXTqsFp0U6NdzkVud
	eTXBJNJRdeGRbT5oTx3pp/B8Vof8PLZHdnyXx+Yc5oAuukdIVeTdEZK/dAgvHAzI592qquf3Q2U
	HDofXHmp+3MJVV+SGSQgMGmySBaCn72ioT12EIKT4Yw==
X-Gm-Gg: AY/fxX6i3rIBeAuFSY3Xx4VpNGMuxdimxloUZtxjJR07URdSTfAxbxTfF3Tx3sgQToQ
	SbCW2l+AGdTFDHJA2VPPECpVyIXDREKY3aEH4QES2pZq3aEPSfr8Givj72nF3V9M0LCnLdzCEyy
	IrGfuaqv66A9vb0lvtO7r3pOYKMRQcwzg2/kjM0DhjQtp2o0fK2w3+OEGePij1rmgI7m8ZNns3o
	rpsCnkg4JhjTFEeZw9oReKBToRTjuxSCI+6/vxuMQujnvquNNNAEphfOIZkTm1vGpL2ld+Vs8Ba
	nwwXBHmLlOaK39aXBvuuS/gh
X-Google-Smtp-Source: AGHT+IFh20zE9m6KKsAOG3M+Pqif8xuWAkUFhwAc91SRRrHGiKgAdsW/CjK47Vzc8ueDX+KUR1WPj1KgEP2GVUpEGTU=
X-Received: by 2002:a17:907:96a7:b0:b7a:1bde:a01c with SMTP id
 a640c23a62f3a-b8037218276mr24148166b.64.1766082368907; Thu, 18 Dec 2025
 10:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20251206230222.853493-1-pratyush@kernel.org> <20251206230222.853493-5-pratyush@kernel.org>
In-Reply-To: <20251206230222.853493-5-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 18 Dec 2025 13:25:32 -0500
X-Gm-Features: AQt7F2qAhKKkrVYXVy4sUEw468IovytUHMMiamVn3JrQ0uPWSbbBGhs6jJM9oIk
Message-ID: <CA+CK2bAV1y_LySjyj-wcn1cdSuVBdC+r+zQL7AQTY64nk3OxuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] liveupdate: flb: allow getting FLB data in
 early boot
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Alexander Graf <graf@amazon.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_102611_217620_D3F84B3F 
X-CRM114-Status: GOOD (  21.77  )
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

On Sat, Dec 6, 2025 at 6:03=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> To support hugepage preservation using LUO, the hugetlb subsystem needs
> to get liveupdate data when it allocates the hugepages to find out how
> many pages are coming from live update. This data is preserved via LUO
> FLB.
>
> Since gigantic hugepage allocations happen before LUO (and much of the
> rest of the system) is initialized, the usual
> liveupdate_flb_get_incoming() can not work.
>
> Add a read-only variant that fetches the FLB data but does not trigger
> its retrieve or do any locking or reference counting. It is the caller's
> responsibility to make sure there are no side effects of using this data
> to the proper retrieve call that would happen later.
>
> Refactor the logic to find the right FLB in the serialized data in a
> helper that can be used from both luo_flb_retrieve_one() (called from
> luo_flb_get_incoming()), and from luo_flb_get_incoming_early().
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  include/linux/liveupdate.h  |  6 ++++
>  kernel/liveupdate/luo_flb.c | 69 +++++++++++++++++++++++++++++--------
>  2 files changed, 60 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 78e8c529e4e7..39b429d2c62c 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -232,6 +232,7 @@ int liveupdate_unregister_flb(struct liveupdate_file_=
handler *fh,
>
>  int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp)=
;
>  int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp)=
;
> +int liveupdate_flb_incoming_early(struct liveupdate_flb *flb, u64 *datap=
);

Hi Pratyush,

[Follow-up from LPC discussion]

This patch is not needed, you can use liveupdate_flb_get_incoming()
directly in early boot. The main concern is that we take mutex in that
function, but that I think is safe. The might_sleep() has the proper
handling to be called early in boot, it has "system_state =3D=3D
SYSTEM_BOOTING" check to silence warning during boot.

Pasha


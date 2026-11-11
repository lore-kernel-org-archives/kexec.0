Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E78606A326
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 21:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KFOienYv;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YSxju37u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=btDrkYTYNJ0PoGfoU0vNHJPAv57DG39AtPHvIg5EYYI=; b=KFOienYvaLeegd
	sqFaYfYZrCPo9CpEw6IcMbWLzZ2Mse/uuGYhCWTUNxesndjCZI0x7RrB9eMy2sTOtgSp8DKL3PMV2
	j/uKQ32+/ddK1W8AGSvIfwKJPH7oT0KlUf5a3bqpH/vFyDXs5Z+NFYgHZpo1YTpDa6zIuksTF7LF2
	tFsGZn/7gORKVtM2RfxY7qIuvjTTkMxIUL4a7X3urnQvj1h6AsEFN0P2iC5JxzfUBAOSIkGmtc3xd
	YoCgUdwP2DgHOol2R4kSsMAVITO2uEeVgWhiyOVZ8HDX2ngrbZicTQgl7Dgd1UytLgFn6Illqz+6D
	eCa5/Aly2aZ7gns+werA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFYi-00000007iIU-3OOk;
	Wed, 11 Nov 2026 21:08:44 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFYg-00000007iI9-2f3K
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 21:08:43 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-9950a7530d9so1859128241.2
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 13:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794431321; x=1795036121; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=btDrkYTYNJ0PoGfoU0vNHJPAv57DG39AtPHvIg5EYYI=;
        b=YSxju37utKzQrSbHQKnYwl4TH9tdyYc89aRXnM+aCLghav3K764NVCmj3WUiMC1sKo
         w5N6fnYPKGebbdIlod67rcwBAk3u+HTMDgrKF7Jp2hexKrna57mYE9JySpnte+cMTMVc
         k5288HjmGvcfVLmwceSPSVCDUsUphxJePKpc4MeSYp9+lc9qd4r2cNpAEBwYJ/iJxcwK
         1pgoIehqB9dH4quWR6emHs1PUW9RTGwulHqA/jOcamSb9ehyM4/Uw10m5FqY1OFFNgEW
         Xe6oWHZ3OwPJXsQfjigUO6feLR0S6uj5nc10L0pkFgk1s5sbP93OcCId0ADEGVfcHeNW
         Wtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794431321; x=1795036121;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btDrkYTYNJ0PoGfoU0vNHJPAv57DG39AtPHvIg5EYYI=;
        b=d2IOHCjJRZubMUsHvR7kEAkNMIsxI+RMZjJ5h3f09156ZjvVWAQmIDNOmaIxvvzxJp
         SsmZ7jaBDm3bEWdHzfYqQYyvTiFQoNPH4yfTX87KkuA4viL9C/rdFgdGdnZZ8iSaf9PE
         WYelSu2JTfCcRzywodjU29b8vexsm2QY5GUBYGB6HvnPGhwQEYRSgNeQGLfr5vtws1ZX
         WmaidtDMpvAp43+XlN5ilOD/qSKItcbm8RZDRNZfzCKgA0y5Do200xvuAAf21p58gBKF
         2wWU0rU4UcXfpYVF6ccfsrGFdE7MvltwDi7m45EbT1KBtWfv5cQ3gxsf+usfwybpfqRW
         Q9OA==
X-Forwarded-Encrypted: i=1; AL+hErFKFmhZi1ESKuTAru/YujQ40icmmvvAQZJGyrpkDIoLKYHS4mhbeP6rcd1sBi6EsTtrJ0SwuA==@lists.infradead.org
X-Gm-Message-State: APuU4Z9UHZrzLxyj3Sap2QsAJtNNHF3SAXIlhUBspsWNlGHCEaZXhZpF
	fhhwx3LsM0NA7LSg0VCNzgqHrcQTZfG4DisSi4DKIwnIa4hR9vK+bWcRzFSntc7QBMc=
X-Gm-Gg: AYBFou11U5aZJW9ntC3nlqxFeu1+rRdk6ksfqC5noq6wLQQGmx23HQPPRP1aEGUaXMH
	DtbWtkReRs8s9WESfvaDSOUDzroRse32erYcUwmZGaz6H9ztw2VPbKuwVC4YoSXrauqo8ev8I2s
	Ho/pIHEBMfkwYTOsOD4HUXHi/s7ciBo6JfYR7opADiIZh60U8ciJNWy0pmdyxibCZEPSMzMQpeF
	lNwdMRq5xeE6b3R3g5oJZ912VDzQzDQdO7oKqQhPthV8ZRP5v2txcWYpOVbjcACM1huH32eO1P3
	GiaDX/MaS4157zhPQOi/Rn1QVkBxGHqlv/Tkh7Qz+Evc500l4Hbfmng2c5uGcQGLMjnBAwb83VA
	/d5L/A0OFeA2m4OEbjcFogFLlahaY6opf21ZijclQDcGFoA8xGxTPJjzxkjRGS9aIxH4EhXS3mz
	PfuD3+AoN5D0Zd5uBtG/dtPBPRJAe+j6JsVWwRPIrUDni1q2QRIoUtu1VJa6RAPjQ1wPeOYO3dM
	7bo+iCS/co6pcnctMQzEuryQ9/HSN8sawTwizjx0emuE+8DzePxhCTe/nkQeHR/vxOYks0kj0A2
	3SRXaeL9sZ7hr9jDIEa5ynzBgK4mx0RlBhPCxp5RJio/tlgwC6ODVEKFBVPtoOeRmN49ryWhWCz
	M4k5rO4bv8lBimk0hO357LbvYLS1C4/9c3OsYySHR9QUZCyIJyw==
X-Received: by 2002:a67:e7cc:0:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d50619786fmr1721867137.33.1794431320983;
        Wed, 11 Nov 2026 13:08:40 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302239188sm4464461137.2.2026.11.11.13.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 13:08:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 16:08:39 -0500
Message-Id: <DMSOTBXD71F7.1EJSHUFZLZH39@soleen.com>
Cc: <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
 <linux-mm@kvack.org>, <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>, <vipinsh@google.com>,
 <linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <dmatlack@google.com>,
 <kexec@lists.infradead.org>, <pratyush@kernel.org>,
 <rdunlap@infradead.org>, <graf@amazon.com>
Subject: Re: [PATCH v5 4/6] liveupdate: luo_flb: support incremental
 outgoing FLB publication
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Mike Rapoport" <rppt@kernel.org>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <20261105050053.3063001-5-pasha.tatashin@soleen.com>
 <179439592041.425130.7284974054491864276.b4-review@b4>
In-Reply-To: <179439592041.425130.7284974054491864276.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_130842_710747_5E58B14D 
X-CRM114-Status: GOOD (  27.73  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 6:18 AM EST, Mike Rapoport wrote:
> Hi,
>
>> When a session is published to KHO via luo_session_publish_one() ahead
>> of reboot, any FLBs that its preserved files depend on must already be
>> present in the outgoing KHO FLB array so the KHO tree remains
>> self-consistent.
>>=20
>> Currently, outgoing FLB metadata in luo_ser->flbs_pa is populated only
>> during reboot by luo_flb_serialize(), leaving luo_ser->flbs_pa empty
>> when sessions are published earlier.
>>=20
>> Publish outgoing FLBs from luo_session_publish_one() via
>> luo_file_publish_flbs() -> luo_flb_file_publish() ->
>> luo_flb_ser_publish_one(), and drop the now-redundant
>> luo_flb_serialize() pass from liveupdate_reboot(). For each published
>
> Oh, my :(
> Why do we care about exact long call sequence here?
>
>> file, luo_flb_ser_publish_one() either appends a new luo_flb_ser entry
>> with count =3D 1 using smp_store_release() on header_ser->count or
>> increments the existing entry's count in place, keeping the serialized
>> count equal to the exact number of published files in KHO without
>> including uncommitted sessions or transient
>> liveupdate_flb_get_outgoing() references.
>
> Got tired here, the prose needs a lot of human touch.
>
>> FLB publication is one-way and never needs to unpublish: before reboot
>> it runs only when a session is committed, and a committed session never
>> unpreserves its files, keeping private->outgoing.count >=3D 1 until
>> reboot so flb->ops->unpreserve() is never called on a published FLB.
>> If more FDs using an already-published FLB are preserved later,
>> flb->ops->preserve() is not called again; file handlers update the
>> shared live object via liveupdate_flb_get_outgoing(). Consequently, FLB
>> handlers must:
>> - return a stable root KHO handle in argp->data from .preserve() whose
>>   address does not change as FDs are added later;
>> - synchronize concurrent mutations to outgoing.obj with their own lock;
>> - support per-FD rollback when uncommitted sessions close without
>>   disturbing already-committed entries.
>>=20
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  kernel/liveupdate/luo_core.c     |  10 +--
>>  kernel/liveupdate/luo_file.c     |  16 +++++
>>  kernel/liveupdate/luo_flb.c      | 111 ++++++++++++++++++++-----------
>>  kernel/liveupdate/luo_internal.h |   3 +-
>>  kernel/liveupdate/luo_session.c  |   2 +
>>  5 files changed, 95 insertions(+), 47 deletions(-)
>>
>> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
>> index 1b2bda22902d2..9fef5161a1f3d 100644
>> --- a/kernel/liveupdate/luo_core.c
>> +++ b/kernel/liveupdate/luo_core.c
>> @@ -219,18 +219,10 @@ late_initcall(luo_late_startup);
>>   */
>>  int liveupdate_reboot(void)
>>  {
>> -	int err;
>> -
>>  	if (!liveupdate_enabled())
>>  		return 0;
>> =20
>> -	err =3D luo_session_serialize();
>> -	if (err)
>> -		return err;
>> -
>> -	luo_flb_serialize();
>> -
>> -	return 0;
>> +	return luo_session_serialize();
>
> I suppose the wall of text above describes why you change this.

Yes, FLBs are now serialized as each session is serialized, so the separate=
 luo_flb_serialize() pass in liveupdate_reboot() goes away. I will make tha=
t clear and short in the commit message.

>
>>  }
>> =20
>>  /**
>> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>> index 988eb313a135f..611b9967a3a91 100644
>> --- a/kernel/liveupdate/luo_file.c
>> +++ b/kernel/liveupdate/luo_file.c
>> @@ -380,6 +380,22 @@ void luo_file_unpreserve_files(struct luo_file_set =
*file_set)
>>  	kho_block_set_destroy(&file_set->block_set);
>>  }
>> =20
>> +/**
>> + * luo_file_publish_flbs - Publish FLBs for all preserved files in a fi=
le_set.
>> + * @file_set: The file_set being published to the outgoing KHO subtree.
>> + *
>> + * Iterates through all preserved files in @file_set and ensures their
>> + * associated FLB metadata is published in the outgoing KHO FLB array b=
efore
>> + * the session itself becomes visible in KHO.
>> + */
>> +void luo_file_publish_flbs(struct luo_file_set *file_set)
>> +{
>> +	struct luo_file *luo_file;
>> +
>> +	list_for_each_entry(luo_file, &file_set->files_list, list)
>> +		luo_flb_file_publish(luo_file->fh);
>> +}
>> +
>>  static int luo_file_freeze_one(struct luo_file_set *file_set,
>>  			       struct luo_file *luo_file)
>>  {
>> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
>> index cd715a7c1d992..6cd87a9f8307d 100644
>> --- a/kernel/liveupdate/luo_flb.c
>> +++ b/kernel/liveupdate/luo_flb.c
>> @@ -34,6 +34,15 @@
>>   * This reference-counted approach ensures that shared state is saved e=
xactly
>>   * once and restored exactly once, regardless of how many files depend =
on it,
>>   * and that its lifecycle is correctly managed across the kexec transit=
ion.
>> + *
>> + * Serialization: Outgoing FLB metadata is published into the KHO FLB a=
rray
>> + * incrementally as sessions are published to KHO (when committed early=
 via
>> + * LIVEUPDATE_SESSION_FREEZE_COMMIT or during reboot). Because a commit=
ted
>> + * session never unpreserves its files, FLB publication is one-way: onc=
e
>> + * published, the FLB's .unpreserve() callback is never invoked and its=
 root
>> + * KHO handle from .preserve() remains immutable in KHO, while later se=
ssions
>> + * may still add or remove per-FD state in the shared live object under=
 the FLB
>> + * handler's own synchronization.
>>   */
>
>
>> =20
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> @@ -72,6 +81,13 @@ static struct luo_flb_global luo_flb_global =3D {
>>  	.list =3D LIST_HEAD_INIT(luo_flb_global.list),
>>  };
>> =20
>> +/*
>> + * Serializes updates to luo_flb_global.outgoing.header_ser and .ser[].
>> + * Lock hierarchy:
>> + *   luo_register_rwlock -> private->outgoing.lock -> luo_flb_ser_lock
>> + */
>> +static DEFINE_MUTEX(luo_flb_ser_lock);
>> +
>>  /*
>>   * struct luo_flb_link - Links an FLB definition to a file handler's in=
ternal
>>   * list of dependencies.
>> @@ -104,6 +120,36 @@ static struct luo_flb_private *luo_flb_get_private(=
struct liveupdate_flb *flb)
>>  	return private;
>>  }
>> =20
>> +static void luo_flb_ser_publish_one(const struct liveupdate_flb *flb, u=
64 data)
>> +{
>> +	struct luo_flb_header *fh =3D &luo_flb_global.outgoing;
>> +	u64 nr;
>> +
>> +	guard(mutex)(&luo_flb_ser_lock);
>> +	if (!fh->active)
>> +		return;
>> +
>> +	nr =3D fh->header_ser->count;
>> +	for (u64 i =3D 0; i < nr; i++) {
>> +		if (!strcmp(fh->ser[i].name, flb->compatible)) {
>> +			WRITE_ONCE(fh->ser[i].count, fh->ser[i].count + 1);
>
> An LLM says:
>
>   Why the WRITE_ONCE()? All writers hold luo_flb_ser_lock, and nobody rea=
ds
>   this before kexec.

Same kho-ro prep as in patch 2, will switch to fh->ser[i].count++ in v6=20
and move the concurrent reader bits to the kho-ro or luo-ro series.

>
>> +			return;
>> +		}
>> +	}
>> +
>> +	if (WARN_ON_ONCE(nr >=3D LUO_FLB_MAX))
>> +		return;
>> +
>> +	strscpy(fh->ser[nr].name, flb->compatible, sizeof(fh->ser[nr].name));
>> +	fh->ser[nr].data =3D data;
>> +	fh->ser[nr].count =3D 1;
>> +	/*
>> +	 * Ensure the serialized FLB entry is visible before exposing the
>> +	 * incremented count to concurrent KHO readers.
>> +	 */
>> +	smp_store_release(&fh->header_ser->count, nr + 1);
>
> An LLM says:
>
>   And this release store pairs with nothing.

ditto

--=20
Pasha



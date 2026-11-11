Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D45606A89F
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0NNxyzxH;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=jAuVe82X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zyPyNsXNnyLp0wiWkbZYu4vFk3ow/rtQP4zegoB1/BA=; b=0NNxyzxHsWD3o0
	4a+4/QPZ/O4rpU0qoCpiCzCW7KA0VGVK6RLT7VK6Xrd080+QJhh4XwdFsqE5U0/7ZHM2PcKo6Zft4
	JQhhelsatjN44u30hScZz48N9B6osqRZnxwBvtAPkLauFkc2rvCtOOai/9MUCD92nrUe52R335RyN
	r2cChGaPnqk1123YQRXfHYWs7KF0fWW2uptrOy5ywhgPejtC8Fr+XO3UJ98oXCpgr+tysGY+Y0P/2
	TC05Zm/7/JFmshhNxILdot7ID0AGrG2If4OtqSXLSg3NYGqyjiMdvzo664rCMpyB55hGCZEDdcww/
	cFPIQGYqBYXLe16kwtUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRAOQ-000000076Ov-2qGc;
	Wed, 11 Nov 2026 15:37:46 +0000
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRAON-000000076Nz-2kXU
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 15:37:45 +0000
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-9903fde8db8so876243241.2
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794411462; x=1795016262; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zyPyNsXNnyLp0wiWkbZYu4vFk3ow/rtQP4zegoB1/BA=;
        b=jAuVe82XNaMSbyp5hAGpHIwb5wB0BD3K9JlygzJc6BTIn7KOi8QvqpWquuN8h5cY1x
         Ymgw8UKDwfVWuIfMUoNFDk+6nNBVAeDAMNAvjIzwf9kCIhgO8Xp0k7PHIxBhcEk1+OpE
         o1NysS2Yt32U+XBN03tSIbjLBn1P8Z3kj0aahbaEL+w2x3z1tHINnE2g3qQMvz9BchZ7
         4WEyKZ2blMwGFMVO70o6kdMfDmY7D1MSV4Sfpls6H2mi1Y7PJcsWrUW9T7SAWggdeM56
         fRx9pvc92qWdpss2tBT6jBwQV2iYZ0GA2C5/NtyEDb1yHbD+75+py4pHDm82b//pF++p
         vGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411462; x=1795016262;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyPyNsXNnyLp0wiWkbZYu4vFk3ow/rtQP4zegoB1/BA=;
        b=kBpv/Mo52Ks4EFj2V8fnbCtnlDZ+p/PaowxHljDYtbkTvAvemP/+ilh7y0hzUZ2r2g
         8W1YJE6wwZhI+HT8mZZsX/9rHmI/LocSvnY1QX7/C+Q87a9x+EVGbPY3oOKC+3tRb8c4
         2UkQb4I+rlknQItBJa9UQYA5Pq5h+5vi+8fIW3rdOe5HCpfGVdW707YaKRYyUog3T4p0
         srXuvhNrIhohBBgjbKEnSoa5giJNHiLsj9W5n64qhKbw7oTgtRTeKL8vumWMGXXJafAl
         +ci9AlEdm3SE054MKg+n9YZz4jZ1FGXDtqvXYJptQocIGaWN+0+mvYhLR7/AZboAnS+A
         L/uA==
X-Forwarded-Encrypted: i=1; AL+hErHRP2ZpYLUoR5zU7ycQQcToo+HUXO1kfydkRyRLSL/3uDf4avdr1EVZuozuwymA9j1eCKhidg==@lists.infradead.org
X-Gm-Message-State: APuU4Z9iXfBelUOxkwG7yOLVsogtLzE7w4Hh2fP5MztAh4+J7U/VoQyS
	Bjs5kfrXIVhg5tBIImIwGq/IOWXGIWBd3PVopOgiCaiXrLgv6E2KZS8FbBQYTSnTaPY=
X-Gm-Gg: AYBFou1gTccqaKVZ2QO67afmA/0qptHmbvw8nQL8/Q45Oo/DspKp6MtyXuQNNOsyLrP
	A4zbb26ckNdwTZAXCF1Ibx5xHcBTGGyDQ9JHRH5ZuqEXAkGeG0NrBlckdmWuFlq/Sil4H4RVHPK
	S1+eAfRc9EGsssV3h4h5dOTXc9fMDo4svRavFwJ1itcuqkbBOliOBKeqHpURNMj/OyFyjeW6arf
	2QSIH8Ulc7IYefKZfbiaYRixVEAb/29pNKK7/Ndq0D71+qeb7SsiocGFC6mOs+ZZRdDHdjJ7N3h
	DMxJDl3RBiL1s0AjjkR9uIWlW3+OcLxzEl+/whTTxA8KhfDWFXkz+l8/3nGvCn6/Zhh4s39wt5f
	OSdt73cav5HOFffs9sOIfxssj3yMt2AoqJNuKX4A6NGi/5mATlv/Zwdsu7+xEev237iujPBaFcj
	eEcVbEe+VCtfrG8YbGxqH18ttuDMLFTsAk9E46rDg0B9Lsz+WcKtnSxPMb+8a+pWujdHtymuDb3
	n++tU2YUbk0rQ/oKH6OyENzfky7cW7boPJSxRjemoR0ZOjwuM79k2sSGG7UDYVVHED9MVm0fcwV
	joc1dT8MKYlFYXOPivENk0NMGwkx8THYpKC+JbRqVh8QSm23MDL98XxHl4P/OXDVH/P0uqCxFnP
	v3vt2+hygd0DVhVELV1fmjlpSt74+2ZyK
X-Received: by 2002:a05:6102:6f06:b0:7c3:9059:49c2 with SMTP id ada2fe7eead31-7d50609f040mr768713137.22.1794411461945;
        Wed, 11 Nov 2026 07:37:41 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023aeac7sm3957545137.9.2026.11.11.07.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 07:37:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 10:37:40 -0500
Message-Id: <DMSHRWYSS8FJ.2H4W2E388G00V@soleen.com>
Cc: <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>,
 <linux-mm@kvack.org>, <skhan@linuxfoundation.org>,
 <linux-doc@vger.kernel.org>, <vipinsh@google.com>,
 <linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <dmatlack@google.com>,
 <kexec@lists.infradead.org>, <pratyush@kernel.org>,
 <rdunlap@infradead.org>, <graf@amazon.com>
Subject: Re: [PATCH v5 3/6] liveupdate: luo: serialize sessions via
 per-session publish helper
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Mike Rapoport" <rppt@kernel.org>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
 <20261105050053.3063001-4-pasha.tatashin@soleen.com>
 <179439592040.425130.1571434550510654411.b4-review@b4>
In-Reply-To: <179439592040.425130.1571434550510654411.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_073743_718169_5880A31F 
X-CRM114-Status: GOOD (  21.58  )
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
>> With incremental kho_block publication in place, LUO sessions can be
>> published into sh->block_set individually as they are committed, rather
>> than rebuilding the entire session serialization chain during reboot.
>>=20
>> Currently, luo_session_serialize() resets *sh->sessions_pa and
>> serializes all outgoing sessions from scratch in a single pass at reboot
>> time.
>>=20
>> Introduce luo_session_publish_one() to append a session's
>> luo_session_ser entry via kho_block_set_it_append() and move the session
>> onto sh->published_list. Update luo_session_serialize() to freeze all
>> remaining unpublished sessions first (rolling back via
>> luo_session_unfreeze_one() on failure) and then publish them in a second
>> pass.
>>=20
>> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>  kernel/liveupdate/luo_session.c | 92 ++++++++++++++++++++++-----------
>>  1 file changed, 63 insertions(+), 29 deletions(-)
>>
>> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_ses=
sion.c
>> index 6dea359111818..caf0e85081e87 100644
>> --- a/kernel/liveupdate/luo_session.c
>> +++ b/kernel/liveupdate/luo_session.c
>> @@ -103,20 +103,30 @@
>>  static DECLARE_RWSEM(luo_session_serialize_rwsem);
>>  /**
>>   * struct luo_session_header - Header struct for managing LUO sessions.
>> - * @count:       The number of sessions currently tracked in the @list.
>> + * @count:       The number of sessions currently tracked in the header=
.
>> + * @published_count: The number of outgoing sessions currently publishe=
d in
>> + *                   @block_set.
>>   * @list:        The head of the linked list of `struct luo_session` in=
stances.
>
> Add "yet unpublished" to the description?

Yeap, will clarify list holds yet-unserialized sessions.

>> + * @published_list:  The head of the linked list of published outgoing
>> + *                   sessions, ordered identically to their entries in
>> + *                   @block_set.
>>   * @rwsem:       A read-write semaphore providing synchronized access t=
o the
>>   *               session list and other fields in this structure.
>>   * @block_set:   The set of serialization blocks.
>> + * @it:          Iterator tracking the next slot in @block_set for outg=
oing
>> + *               session serialization.
>>   * @sessions_pa: Points to the location of sessions_pa within struct lu=
o_ser.
>>   * @active:      Set to true when first initialized. If previous kernel=
 did not
>>   *               send session data, active stays false for incoming.
>>   */
>>  struct luo_session_header {
>>  	long count;
>> +	long published_count;
>>  	struct list_head list;
>> +	struct list_head published_list;
>>  	struct rw_semaphore rwsem;
>>  	struct kho_block_set block_set;
>> +	struct kho_block_set_it it;
>>  	u64 *sessions_pa;
>>  	bool active;
>>  };
>> @@ -134,12 +144,14 @@ struct luo_session_global {
>>  static struct luo_session_global luo_session_global =3D {
>>  	.incoming =3D {
>>  		.list =3D LIST_HEAD_INIT(luo_session_global.incoming.list),
>> +		.published_list =3D LIST_HEAD_INIT(luo_session_global.incoming.publis=
hed_list),
>>  		.rwsem =3D __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
>>  		.block_set =3D KHO_BLOCK_SET_INIT(luo_session_global.incoming.block_s=
et,
>>  						sizeof(struct luo_session_ser)),
>>  	},
>>  	.outgoing =3D {
>>  		.list =3D LIST_HEAD_INIT(luo_session_global.outgoing.list),
>> +		.published_list =3D LIST_HEAD_INIT(luo_session_global.outgoing.publis=
hed_list),
>>  		.rwsem =3D __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
>>  		.block_set =3D KHO_BLOCK_SET_INIT(luo_session_global.outgoing.block_s=
et,
>>  						sizeof(struct luo_session_ser)),
>> @@ -186,6 +198,10 @@ static int luo_session_insert(struct luo_session_he=
ader *sh,
>>  		if (!strncmp(it->name, session->name, sizeof(it->name)))
>>  			return -EEXIST;
>>  	}
>> +	list_for_each_entry(it, &sh->published_list, list) {
>> +		if (!strncmp(it->name, session->name, sizeof(it->name)))
>> +			return -EEXIST;
>> +	}
>> =20
>>  	/*
>>  	 * For outgoing we should make sure there is room in serialization arr=
ay
>> @@ -203,6 +219,42 @@ static int luo_session_insert(struct luo_session_he=
ader *sh,
>>  	return 0;
>>  }
>> =20
>> +static void luo_session_publish_one(struct luo_session *session)
>> +{
>> +	struct luo_session_header *sh =3D &luo_session_global.outgoing;
>> +	struct luo_session_ser entry =3D {};
>> +
>> +	lockdep_assert_held_write(&sh->rwsem);
>> +	lockdep_assert_held(&session->mutex);
>> +
>> +	if (!sh->active || !sh->sessions_pa)
>> +		return;
>> +
>> +	if (!sh->published_count)
>> +		kho_block_set_it_init(&sh->it, &sh->block_set);
>> +
>> +	strscpy(entry.name, session->name, sizeof(entry.name));
>> +	entry.file_set_ser.count =3D session->file_set.count;
>> +	entry.file_set_ser.files =3D
>> +		kho_block_set_head_pa(&session->file_set.block_set);
>> +
>> +	/* This should not fail normally as blocks were pre-allocated */
>> +	if (WARN_ON_ONCE(!kho_block_set_it_append(&sh->it, &entry)))
>> +		return;
>> +
>> +	if (!sh->published_count) {
>> +		/*
>> +		 * Ensure the first block header and entry are visible before
>> +		 * publishing sessions_pa to concurrent KHO readers.
>> +		 */
>> +		smp_store_release(sh->sessions_pa,
>> +				  kho_block_set_head_pa(&sh->block_set));
>> +	}
>
>
>> +
>> +	list_move_tail(&session->list, &sh->published_list);
>> +	sh->published_count++;
>> +}
>> +
>>  static void luo_session_remove(struct luo_session_header *sh,
>>  			       struct luo_session *session)
>>  {
>> @@ -636,50 +688,32 @@ int luo_session_deserialize(void)
>>  int luo_session_serialize(void)
>>  {
>>  	struct luo_session_header *sh =3D &luo_session_global.outgoing;
>> -	struct luo_session *session;
>> -	struct kho_block_set_it it;
>> +	struct luo_session *session, *tmp;
>>  	int err;
>> =20
>>  	down_write(&luo_session_serialize_rwsem);
>>  	down_write(&sh->rwsem);
>> -	*sh->sessions_pa =3D 0;
>> -
>> -	kho_block_set_it_init(&it, &sh->block_set);
>> =20
>>  	list_for_each_entry(session, &sh->list, list) {
>> -		struct luo_session_ser *ser =3D kho_block_set_it_reserve_entry(&it);
>> -
>> -		/* This should not fail normally as blocks were pre-allocated */
>> -		if (WARN_ON_ONCE(!ser)) {
>> -			err =3D -ENOSPC;
>> -			goto err_undo;
>> -		}
>> -
>>  		err =3D luo_session_freeze_one(session);
>>  		if (err) {
>> -			kho_block_set_it_prev(&it);
>> -			goto err_undo;
>> +			list_for_each_entry_continue_reverse(session, &sh->list, list)
>> +				luo_session_unfreeze_one(session);
>> +			goto err_unlock;
>
> Why goto err_ can do this?
> I really prefer to avoid error handling inside if (err) blocks whenever
> possible.

Makes sense, will move it.

>
>>  		}
>> +	}
>> =20
>> -		strscpy(ser->name, session->name, sizeof(ser->name));
>> -		ser->file_set_ser.count =3D session->file_set.count;
>> -		ser->file_set_ser.files =3D
>> -			kho_block_set_head_pa(&session->file_set.block_set);
>> +	list_for_each_entry_safe(session, tmp, &sh->list, list) {
>> +		mutex_lock(&session->mutex);
>> +		luo_session_publish_one(session);
>
> And running a loop of _publish() in _serialize() makes my bikeshedding
> argument stronger ;-)

+1, will fix it in v6.

--=20
Pasha



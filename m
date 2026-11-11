Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79956606A31C
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O947hqZi;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=C66Mztlk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0UsTtqPbFkPmIIllU2lnhMDYuxkEq5iJvf5QTXV3x/Q=; b=O947hqZiTZzKw3
	m/EbUsccXMOz8a0frTdf4G1ffNkVpPpHgvy7rqG7d0g5dxqoGRoe5lw9lVakdvlnm2HzI8L/OMSuQ
	NAVLp1xifnf5blSq7ERu26yJD2On8dXF2hL++XTwwQjG18zbg5tfDRRqLDU1LRC41dtvjxPWPCNnp
	L4E/7xqAPI0dNCkfOeZM8iTJoWxfx800FLerJpxXf6Pf/ddRLFlXShQNpl3mddAnJryx0ygNSF7yk
	u8+3XqtbqmIQCgTC+A/ZPL/270FQCla6PBwn3d5M8RvxAA3E9tFEB3WN2ZH3tIlGRrwBsAkyk6HKt
	UxPsMiJ8NrRhsOeyYTFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFzo-00000007pSt-47xX;
	Wed, 11 Nov 2026 21:36:44 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFzl-00000007pS4-3Mp0
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 21:36:43 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5eabf243d05so1216755e0c.2
        for <kexec@lists.infradead.org>; Wed, 11 Nov 2026 13:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794433001; x=1795037801; darn=lists.infradead.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0UsTtqPbFkPmIIllU2lnhMDYuxkEq5iJvf5QTXV3x/Q=;
        b=C66MztlkRVbCYh1GsaJOP/GbMxjZwQkesDQt9whOL+kdgU/q1LveLoX3hlPEeGrDOL
         2HvsTpR1rzpxmpHzaHd9E7EsOlGLFiN5nclGB6IS1I4Y1htSKikOZWsRKfulXylPTnqS
         4yggP80p0UYNBBL02Sv8wC9ny0ub/9Msuu6TqfviTl5mEC/oZPFzyqBvknBZg1QOnv74
         YT83Q7hHiDXaft7yGqsx86HlE8WCLrQ/Ar9W09hykC/tM9fYhvt/Q7u1GMvY40sQ+nLS
         sa3guJO4jxDChxxCjlH5+uU25Ofe/U/H5JUtflGQGAR+jboc+PmOlQ90nkDq2tJ+VgrO
         XhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794433001; x=1795037801;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0UsTtqPbFkPmIIllU2lnhMDYuxkEq5iJvf5QTXV3x/Q=;
        b=K2tsdwizGe04WYaCYWjs+p+41o7lHr817XfM1D89CtBnUbPozEF8laxHSmhoEgE0+e
         6ZXdf6LRVw6rbuE/I6QBx2yZR6AjCSxkJhMzs7qQCVZeK3Pw3g1wIgFYK9zWnJOen1yt
         k/MmQR4dBMPUSiJN0tlzHmT+vDV20E76aliVW6Gua5mzsdLuUyB1sSkHgXjDb6AzndRC
         YTnItHTYcKH3TFFyU60ijv0WVcSFH+QC0B4eayHKKjaREsod9Cl+Hba5/Erdz2TXBrkN
         j5WglO+9jscQgTDKD/hZKXQD8VqviKj32dynw76DWEBf/ZHhI8ywuBUSdgrRrQn8WbiE
         dcPg==
X-Forwarded-Encrypted: i=1; AL+hErEjWwfReURWeJ9l0s8vAPuGJ0xrD8snDh9JvYSdqbRZqWIL8kDxzD7o0qR8sesj9CoW5kGfRA==@lists.infradead.org
X-Gm-Message-State: APuU4Z/xO4J7Jz0ClwEejJC613g9hAlWSE1014x+LORjZw1fAL2opTig
	Py2lun8UFmsZLRmW/KPZXZA9LF2pozvg/AU7XX4x+qD39KIBA2yNDsLSrOpjpUOg5yA=
X-Gm-Gg: AYBFou3cgIzjqXWtMzBzsKmYN/bN10fwygwfSU1GcJ0WeX0fQTvBA7WINT5GrnGh36m
	+zCUSEHWNFuDiy8nhTIM3kQFujr8RBIEPL74Vurm+w3fxzOjgi6OXuXmayAxNdPbFwkhnLwIrYC
	9Pe6JOPD+NM9bl7dwSlUxwVqRPpOltvXlLpB2HmaroZuOn2hedfh+0kB4mgHyemH02Um4Ivs61h
	v9e0K7/0m82hejV+Ghv/fXNT/WyTjxLCAzaGUH7qbfzZ3bd2wAEeSmSk4yPLs8Ttyfxsp3S6yWP
	q2FRKyfgsvsYOUlL+nGCWBTfz2Konys1X6iS9NU3shi18Y+MA/UnuleCoZZUDZ/O3Il2R4SX0px
	Nfc5mNUwzEFyxwAtmSQRtokwlEEYs2MwRIQLsQ/ENpr+4YWBG0HKJr8k/8zeTUje535R22JAA66
	ERuJyKLgs32JwT+h74qi8mwS6FVf3gSCzLODc4tMpD+YolsUWW8OBX8rIt5fMeu470thYTJLIUU
	na8x8a4B46+1JHFWVbm/zoKAeHB0wX+IZKEPcRpc2pn02oZJGbqAJ70Eg+1qJTP89OwnPht5jkX
	HHhwdMiMe2RoA+mlxUNNLg9IUK/GMQXdsdoEZ6BRFT9HT6fFI85/UMFrPGSDvXXWBZurq3Yj0qU
	nd1KIZmRwafjVBRz3yX+ZTCHVQvoQ
X-Received: by 2002:a05:6122:c9f:b0:5ea:c084:6f19 with SMTP id 71dfb90a1353d-5ee1c3faebbmr1420493e0c.12.1794433000673;
        Wed, 11 Nov 2026 13:36:40 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5afeb2sm4730325e0c.9.2026.11.11.13.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 13:36:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 16:36:39 -0500
Message-Id: <DMSPERMRYZKQ.3DKQJXYDDFRS4@soleen.com>
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Chris Down"
 <chris@chrisdown.name>
Cc: <rppt@kernel.org>, <pratyush@kernel.org>, <graf@amazon.com>,
 <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
Subject: Re: [PATCH] kho: Prevent reuse of preserved pages after a
 reservation failure
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <avQUquBK6cO6tUUI@chrisdown.name>
 <179443248353.2329176.13720873996862751451.b4-review@b4>
In-Reply-To: <179443248353.2329176.13720873996862751451.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_133641_844149_79C57A78 
X-CRM114-Status: UNSURE (   7.81  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 4:28 PM EST, Pasha Tatashin wrote:
> On Tue, 10 Nov 2026 23:09:30 -0800, Chris Down <chris@chrisdown.name> wro=
te:
>> kho_preserved_memory_reserve() reserves each range of preserved memory
>> in memblock and marks it noinit, but ignores both return values. Either
>> can fail when memblock has to grow its reserved array and can't find
>> room, which at this point in boot it may only take from KHO bootmem.
>> The boot then goes on as if the range were reserved, and two things
>> can follow:
>>=20
>> [...]
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
^^^

I mixed up my review threads and replied to this one by mistake. I=20
intended to reply to: "kho: Reclaim the metadata page left reserved=20
after kexec". Regardless, we are still waiting for v2 on this patch, and=20
I will send a separate email regarding the other one.

--=20
Pasha



Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C701606A320
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xWeqKU5Y;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LT3Ve+nk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=g8kKfDytD/v7OOrYEkkTE88iqH3WPJ5eP+WcohkLFA8=; b=xWeqKU5YK6MqPM
	LgTN44JjLGlMPO0Axvh174mofXX8+jLloY0SXMLHJTQP2NRfmZgmecgCH3NoE7rrKaJs0POQFt8bL
	EUsc4ajkDCugfkzSn4xorDTkdmjVfQXX2a/aYYAKWOE4l0uwYmSiat46hjksNGWwsyn7QcBhkax+D
	XgYxqXvQnJNW7bzq+qTIbTbyztxxZy+fXt9tMBo/U4RHerAtGzPGY1iTVdkA5JJ3NUgWHC2BCGCTW
	FrFHNxFIocWsE76Vtjyj50Pp8VZ0cP1rHSC1HRAlpgIrLAu1PvZ680afdx3M+7atsmu4RAs83TzgJ
	PZIilkQl52oLou6dHsRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQr1I-00000004r8z-2CWm;
	Tue, 10 Nov 2026 18:56:36 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQr1D-00000004r8P-05pF
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 18:56:34 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-8b6b22be970so929942b3a.1
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794336990; x=1794941790; darn=lists.infradead.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g8kKfDytD/v7OOrYEkkTE88iqH3WPJ5eP+WcohkLFA8=;
        b=LT3Ve+nk6UWlgNlqvH4mvPNttZmvq9Kss9I8WoQ2blA8WGcUvPMcvXbQZVakGTc9K+
         l5VDGZ5lqeDxHPnEHfI/6KOFdQ6sIT/hzabJ/+yj+ME9nHWqgWX3+thmRq1CwwDmHNs0
         muxBpBpHih9sQ6DB/HLq6XbGybopcuJJ8nXT2Q/wCBc5HFmEMyTLU7UoN5vLl3YhZHWr
         fUZFh968C63jMw+IH7OCJF1e9VoRndC3UWKU3nBXL+jec0qUYUKagLN4eDwSEKPeAFY1
         QRjz3dsrz+FofKyltFMgQVteMzhnhAM1AIILQla9PCTMBDHj+pSqnHkvJXVUGtYBFXEL
         bAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336990; x=1794941790;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g8kKfDytD/v7OOrYEkkTE88iqH3WPJ5eP+WcohkLFA8=;
        b=lUHGExEFpxp98y+SHM1VvMOdnPpRZTHYAyaEP7H2bl1+H3MbU1UeCnvm/H4r4Y++oh
         xJdbt23sj0+oz+UiXov52cYVTeE4Omn/gZ69tYVE7l9l0u+lBL8XLBSpoO2Mronv1DHE
         +MJswJrDeixFEl8Xr1g8a7sVNzHSA3jWPoxK/Z2V0pZyZgOq2yOe+vA6MwLTglAqITSl
         TdNGiElOCIfCtsrky9980HKZCswVykpH877zkfLcIevTaD84fHoE2qQNaInNWZn8PW4o
         IaJtRQMtqSaRTqHWFPLEHDY9Cu9kUmwvC+HiIGP4VuaaXd2oMfBokHGuePDZwAiQldIU
         UdYw==
X-Forwarded-Encrypted: i=1; AL+hErEaYhj0U/RW5H2vYtWCKWhhIzzrZ4qgXFi6R6bbWz9lr4GN1slZvzA7YxIk4MegdsdffevhRg==@lists.infradead.org
X-Gm-Message-State: APuU4Z9z0JCWbpdudF2aj7jhD0SqQQagAKNSRWWxzVoH1Z2+knOi1tvf
	R6H2qOoQAcg5auMNfF4kfn2TAFbhwTGeIksU8Yg8bHqv+fuwsUZKvmMC3DYf+kD9MA==
X-Gm-Gg: AYBFou2piswca7GjZ8e3n9SLF3Vv2rANgaGCMZq/SieYyumy4+6ia1QnyXLrkBs7ncj
	ZMjF3oFDxLPXHjEkzGGOEk0bBXauv6AK1L4qmmP+WmXZ6+7MGjbIJBYDkT7cTBZola4O+ORXMy2
	hivDhSuwz3pQoA2i89722EsngdtKiDlV8PF4eHrsT3SF4Dc0NyqecnMEsx0E6lizbpI68UpwBQW
	y23C3FaMctlq0rJJPRaFLlj201nHGvuuOXzy3SqiCzRXsKCDSO2OZhKAX2/ygzFBBkTlXmgh6LV
	SQd1R/IxWwDHqE7ooreYaxbQwGeTYJdDPfDaTNLcJHSIJvJ7qQ0M1wW4EkoF5zJeHaTu5pEA3Ph
	0t59alu8+t94JLP+wDBe/jbUQs/kQMya6gd3j2j7/vpNFg4t5fPEcyC0wS7RBFeZxmDbVp0V/Vc
	XyXYYfUupJd7LXatOYA93E5MUKpaFSoE+0feDapLIkWV3nwUaYQii6Fee+QijSkzVP0+63gScn/
	jEwsc/Eea9fqaStmO89VqOS+p4bQpgaD4ILWqrhOLH7g/YG8zQNjWnUcut/gHfSs/LxOPlQAR87
	RjmwbGmB8ZFTtd7lHaDilfHZHorluxz5d+9qD0Fc8XkCW40+SoAAoUR5edJbSJsL
X-Received: by 2002:a05:6a00:2349:b0:89f:7a1b:2bf4 with SMTP id d2e1a72fcca58-8bc1b6feb8bmr5444b3a.16.1794336989281;
        Tue, 10 Nov 2026 10:56:29 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab21835fsm1302972b3a.42.2026.11.10.10.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 10:56:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 10:56:26 -0800
Message-Id: <DMRRDJZ8UQ2D.30SLE82GDTH48@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
Cc: "Christian Brauner" <brauner@kernel.org>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>, "Alexander Graf"
 <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "David Hildenbrand"
 <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport"
 <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>
Subject: Re: [PATCH v3 00/10] liveupdate: Preserve tmpfs files across Live
 Update
X-Mailer: aerc 0.21.0
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261105-sitzordnung-nahkampf-ausbleiben-6db911d0333e@brauner>
 <auy0ThryqW5nVx20@google.com> <2vxzbj7witb7.fsf@kernel.org>
In-Reply-To: <2vxzbj7witb7.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_105631_088714_1CD05007 
X-CRM114-Status: GOOD (  23.52  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 7:45 AM PST, Pratyush Yadav wrote:
> On Thu, Nov 05 2026, David Matlack wrote:
>> On 2026-11-05 04:42 PM, Christian Brauner wrote:
>>> The checks on the target are trivial: a writable fd to an empty shmem
>>> file with the inode lock held while you fill it. A tmpfs file can't be
>>> sealed, it only ever has F_SEAL_SEAL, so there's nothing to restore but
>>> contents and size anyway.
>>
>> Sounds good. The one other check I plan to add is rejecting a target
>> that LUO is already managing, e.g. a file that is preserved in an
>> outgoing session and whose size is frozen.
>
> I have been playing with this idea too, and I also stumbled onto this
> problem.
>
> You also need to make sure a preserve doesn't race with a retrieve.
> Since userspace has access to the file, it can do both at the same time.
> I think LUO should expose a "register file" function that registers the
> file in luo_preserved_files. This should be the very first thing
> retrieve does.

Agreed, that's what I have queued up for v4, which I'm hoping to send by
tomorrow.

LUO gets two new functions for .retrieve() callbacks:

 - liveupdate_claim_file() inserts the target into luo_preserved_files,
   and fails with -EBUSY if it's already there, e.g. because it's
   preserved in an outgoing session or was retrieved before.

 - liveupdate_unclaim_file() undoes it. If .retrieve() claimed the file
   it returns, LUO doesn't insert it again after the callback, and a
   callback that fails after claiming must unclaim.

On the preserve side, LUO inserts the file into luo_preserved_files
before calling the file handler .preserve(), so whichever of the two
inserts first wins and the other fails with -EBUSY.

> Also, today LUO core expects a fresh file from file handlers, so it
> always installs a FD to that file in the task. When doing the "retrieve
> into FD" thing, that will result in two FDs to the same file. While it
> isn't a strict problem, it seems kinda ugly from a uAPI prespective.
>
> Perhaps we should let retrieve signal to LUO core that "I already
> installed the file", or a "I have no file to install", or something
> similar?

Makes sense, I'll do that in v4. The file handler will tell LUO that it
restored into an existing fd, and LIVEUPDATE_SESSION_RETRIEVE_FD will
return that fd instead of installing a new one. Retrieving the token
again later still returns a new fd for the same file, like it does today
for any file that was already retrieved.


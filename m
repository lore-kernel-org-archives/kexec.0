Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DE606A31E
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1nxX0CcK;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SqY7+wjW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=thHuqHmooBy0uGsMcFJyj79jvgcNxfQof3z9Kg8ZrOQ=; b=1nxX0CcKolmLSD
	2R33TitXGR0s8UuilFvtasqe6JxuXd8OWZAoO2ayYhKaDtXIp3FGSuNqMALEq3hpKB4R72qUkLTdU
	gw+zITVt1m4jk3+Qre97uFPeihvggfkMFMGy+7VmXnuiagl2kqVDQDNFruiVPibRFYF/aJlzO3+w1
	A5TewHRdx107KhD7xhDmYDEyDpBlSftOF0j528d4pV57md+GhBHgvMwNimT4Y2lj8RmfW0FilwGNf
	cj7EWYq5n227v4s/SnwmFdpjCeUCo5eHxH5tGe/xDz1CXQFxEe8D9nqgRbSYDzdaQqTjUoevLMQuL
	LPqMVlq5OQHYxi8/VKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYkb-00000004TuG-16C9;
	Mon, 23 Nov 2026 18:26:49 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYkY-00000004Tth-1dH4
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 18:26:47 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2f066274caeso12684395ad.2
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795458405; x=1796063205; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=thHuqHmooBy0uGsMcFJyj79jvgcNxfQof3z9Kg8ZrOQ=;
        b=SqY7+wjWBgtUUOzY//+rFXkFqXgbNa4mzjjPbfM6h1JTwoEZ8u451GTze01XMP1lTf
         5ounKkmXj2YHSNK4HrOK14HR7krAdQ/2XewDE/nvTeIdE1IkoCrVnwHUI1UogFp0/nfo
         mQ9todLLsLNEfCMQN19cc6rRGn7At5dcAP+vL4O6/xO0gAnFRb/PVTMcto5C4cCjQJSh
         JnOfv7yzK03l74yI8ofZ3s2gDcg7sVxGesCAx1NXl8ozfsbrxt35W+5YAKG9dGlI+iyo
         XMmMeiL9PX6J1WkMNalX4IORy+GlOT7TsMIzb8l7rzkP57GpYoAuPvtim1yJQbttCVra
         J6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795458405; x=1796063205;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thHuqHmooBy0uGsMcFJyj79jvgcNxfQof3z9Kg8ZrOQ=;
        b=fc7tfdBhYWsgpynltLk87iTDAL2h1jaCwPSCwsbF9ne6dG6uwPm4N3yYN3ak9KHYJW
         bbiEYBpaVGW2+9aEJiwyS+hYF+KHhhXKn+JTeeUZRC94ANsDSCXEqqkHVsStDm+pzruz
         gQLwuayEnAakXHbm+sSpJ+ibxOZEzprN1h057hh8Hw7opF8qFt4QCPr6GUlXO0KdAIz4
         Ihd5I5+tdnmxr61TwNZsMk2Y70O//eYxmr5bI0J9YZMInN3w/TCd67x4SvEaEQr8Jhfm
         q/1igaq19kjWud5uLr7BafvcEIxvVdBA3HS0Qilpw+otKg/XfK0rjRbjFozgQYYPyKFe
         NgPQ==
X-Gm-Message-State: APuU4Z9olD+0nGyGuhTAeCm2Z4dQW16wdqhyk9xyGMhEt/GnsMmUDjly
	KvYRqn0LhUt3Sp2fybPkKWdiACFly/2QOALdMbz3LSCP2nM6bGartgCJzhxkbYoDRg==
X-Gm-Gg: AZFdTZfFbaNBI9jUfadTkdWjPxbX+vXFSowOG/jIWWyJOBR6z7utS0ldNHDlcwxI7Bf
	rxF1RMMiWNKpqNEvO3ocmrsG2Bt7m0JSjll507qQCfcY8YuiYtax1QTPbVmiROfPpfl/xvPTAfK
	g2EhhHBPpryXu8Uu7qcUnsIDd1wnM6Q5wHk4L2dnlsFm5WXdpoZTlNGxBxLhWSsOczb6V0koUJl
	JsXXV/TM1RA7iADgYdYuOoh8/66vz6xIpBDlRZznF0+Ju9QXxK+eGE2EHWogKIWAgYDIGQF59F4
	wMjgc3Nf0gt+X82ol0nXGbkQcVsqD4+MsLa1TUgkyc+HTuCthKnoC4X47gx7V8l2eMdtIYqlJlz
	fJW0ZDkgCTwPw6HjxbV2YRgS3C5M/+AaotqxJm592Z+08src8KRyivoT6sVmZx5Vx9HnDWghUG4
	00YQ6rGlsYtMW2Mv2NQlr9nYgxSjsuYsEJFz7bznWMm3qgdh42JqlVbRKtOsPYt9XsBDWvdFiz8
	pHnzR1yqSwoR4WfA3LX+u6wVTFjqamDfTl1iyLu+MLvHF9Cwk4aIHT/enb6NySotlwSvmhpIYZ3
	SAwLHKU6YT5tSmgF/OSzcQOXICXHmmprGjA9Ud3nFxWCmKlQpN3zB7ggrfEuJHyNqA==
X-Received: by 2002:a17:902:d542:b0:2e9:6790:212c with SMTP id d9443c01a7336-2f03f190776mr120496345ad.30.1795458405057;
        Mon, 23 Nov 2026 10:26:45 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f120282sm56755105ad.59.2026.11.23.10.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 10:26:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 10:26:43 -0800
Message-Id: <DN2SVVWX66U1.37JRVKARDRNYN@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-mm@kvack.org>, "Alexander Graf" <graf@amazon.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Christian Brauner" <brauner@kernel.org>, "David Hildenbrand"
 <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport"
 <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Vlastimil Babka" <vbabka@kernel.org>
Subject: Re: [PATCH v4 14/19] selftests/liveupdate: Test which tmpfs files
 can be preserved
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-15-dmatlack@google.com>
 <2vxzh5hb1sqo.fsf@kernel.org>
In-Reply-To: <2vxzh5hb1sqo.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_102646_429082_5B618C24 
X-CRM114-Status: GOOD (  11.81  )
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

On Fri Nov 20, 2026 at 6:29 AM PST, Pratyush Yadav wrote:
> On Wed, Nov 11 2026, David Matlack wrote:
[...]
>> +TEST_F(preserve_tmpfs, frozen_size)
>
> Nit: This test isn't really for "frozen size", it makes sure a preserved
> file behaves as we expect it to. So perhaps call it "preserved_ops" and
> update the comment?

Will do.

>> +	EXPECT_EQ(ftruncate(fd, page_size), -1);
>> +	EXPECT_EQ(errno, EPERM);
>> +	EXPECT_EQ(ftruncate(fd, 4 * page_size), -1);
>> +	EXPECT_EQ(errno, EPERM);
>> +	EXPECT_EQ(fallocate(fd, 0, 0, 4 * page_size), -1);
>> +	EXPECT_EQ(errno, EPERM);
>> +	EXPECT_EQ(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
>> +			    page_size), -1);
>> +	EXPECT_EQ(errno, EPERM);
>> +	EXPECT_EQ(pwrite(fd, "x", 1, 2 * page_size), -1);
>> +	EXPECT_EQ(errno, EPERM);
>
> Nit: Is there any point in matching the exact error code? Wouldn't
> checking for a failed syscall be enough?

The documentation that patch 11 adds to shmem_luo.c says these fail
with -EPERM, so I'd like the test to check that. But you have a point
for the other tests in this patch: the documentation only states the
permission rules for preserving a file, not the error codes, so in v5
those tests will just check that preserving fails.


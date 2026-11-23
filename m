Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4B606A32C
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=d2EgNVF/;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JbR77K2m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JF9DK5BWLD1MHzXf1P6k3Cfpg7JcJUIjQB9CILaEZzU=; b=d2EgNVF/F0ym+C
	EwkCx7jVd6aXBa9Ie91nLvE22kujQHLv4v89zVmVEoV+jAn2R2umccC5ZCAGTBi0Nea2eKyCNV/ID
	FfC7ZBnGasiOR8/vqoTjakew2B16JCMUloL8zteU2vq11A9IH5r/spGhGexS0XquV1dmF+6WvCjPz
	4HoI8ocvHG4b8Mnv/PWGXDgfu7H2jr2YBMUZoV8HymULa3QzA3ZLVbMTx722QjdsMvlMPGqVOjncn
	n6/ymEs3cYpgGeXIp7sUj9F0WSEFEjr0X/vdTOin0bpBIfnzCBoGDSwtGN0cKhBBBlWpp/bk5QqSN
	typl/yguMnGS7gBCx9zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYXy-00000004Seq-0T1N;
	Mon, 23 Nov 2026 18:13:46 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYXt-00000004SeM-3Ft9
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 18:13:43 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so1738490b3a.0
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795457621; x=1796062421; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JF9DK5BWLD1MHzXf1P6k3Cfpg7JcJUIjQB9CILaEZzU=;
        b=JbR77K2maUy6ArEpivzQNO9aHmCWuBRedTzL8xcYJxglRtRbSzJdTatsT3fUM91F8K
         sC4Vgln7mbGWfJaCW2nXgq3V0s2N6CxD79ZI9d+NvLqLgLHdL8wCogadIBmb7eVULJ7e
         rGk+DSmGPjVq4d1pK6dEP4SiYkZRlKOLFnv9iTxdh7bXh9++uFI3gpKzasMmf4yHT9yL
         dF1qEZEiQEZOj3Cl5KTBINDq6VGpnOzKMcL3tEXwMJrFxXnP3/rMfa2lW/tQcbgFRXuE
         oXEG5S+c0xwbChHZE2SAq7Rj+rnF86Kb3WvW0/Kd49KmzMdOSQHjD/3rbfnywLBSTXRW
         a6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457621; x=1796062421;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JF9DK5BWLD1MHzXf1P6k3Cfpg7JcJUIjQB9CILaEZzU=;
        b=ZSz80qrBkkI48b4Gt+3LC90Y6SoE0u02w7ohDiphNIG3iSuMPF84CJx8yLCJE1+6Bk
         0OWD7D2AoKcIUjYZ/QNc/LdwTkAVDrqkAGr9v5M0PPtMWWvxYLLS+kgwW/gmntgyu1uU
         SdgtdGsGHPHV09oEl6lGSd+RfBxsQq7rZ1zl5EVAoCRagvx708bEPxCttqiz0qM6bCwE
         a/+mrrZsGUJaTUc7VHPS+Qx3WuevyonCpu1aMaPbEyKtgTfkJUnU5y8TJdeAPzrSY1xY
         4YOeIizoO8poLPIhUNn6b+Vl6SdJ6jEqRVJrCQXJwgbhFFp82FiQR8HaD7tOdqOscxw1
         HaNg==
X-Gm-Message-State: APuU4Z8OLk1dwmepNrzVJm1cTGvyXccbBVhfWug4MbhfS0HlFJ1Bfig5
	TqaH6ytk1HRhaNLDomcrXffhkfy528eo4haHj1Io4W2JmxzxNb4s3HDQdMi7rKBR3w==
X-Gm-Gg: AZFdTZdAs2vmq0whhdS0/ZAUb0xeNFI182W/mktk+aJqFgwk2TMnmEWY00rqXhdVzrK
	sbdVH6umMYygatKjjlQ66O4hp4Kmgt6nTfi1rz/JSE4IEP7G7snc6h+Njt2HEjDSFKbRLWTPuQT
	k1pyRJfq/XoLeUSleeFHhQzIy7E64kUTJh9G43bQS7NC4ick0JCRCb1JPTLOffx2fSyAIfLN2yW
	fNRHQszAGeII9AyavO0OGhzP54iqxUCY5ZCYGocm5x6COiAwRKLmnSrqo8YIgLjD/2oR81nxIt/
	y6Q/BB9easnj7CnnIdrFvm0ud/008rnQpcoaAbeZKaSL8rx4H0EbijmV56Lr9xin7x+QDeIuOsz
	/DkzHg8PQ2SDDfS1qerLZWzO9KQWBkguBG70Eiv0CsMWODO9LxIdc+9rHrsTcfYpphlB9ZMFlNQ
	2k7az1oLUaAB8W6HgogG5YLooUSCQxPRffd7adkUHS0Lujnyz+8o8I793KbADwmjf0fhrn40jVq
	f7yAUMvqUHauqvatH2p6bzfrnaGExdaJB91Puc7nkoVbOrKerTmtx0fgI3l1MYpf+xsoQOixQhv
	qqWQn/N72XSaqvalb2Sw3o8xHHlw1LiDqd9tK6DSplNJCa+KusSblfcSM0tUijaK
X-Received: by 2002:a05:6a00:9084:b0:89e:9c7e:fd56 with SMTP id d2e1a72fcca58-8c87c768251mr11001006b3a.33.1795457620349;
        Mon, 23 Nov 2026 10:13:40 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c263sm5956386b3a.11.2026.11.23.10.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 10:13:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 10:13:37 -0800
Message-Id: <DN2SLUVNO0L5.3NUHFPC0J7QTG@google.com>
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
Subject: Re: [PATCH v4 07/19] liveupdate: Add helpers to track the files
 that LUO manages
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-8-dmatlack@google.com>
 <2vxzbj7j3ga2.fsf@kernel.org>
In-Reply-To: <2vxzbj7j3ga2.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_101341_818068_4CD3D065 
X-CRM114-Status: GOOD (  17.42  )
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
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 20, 2026 at 3:15 AM PST, Pratyush Yadav wrote:
> On Wed, Nov 11 2026, David Matlack wrote:
>> @@ -788,8 +797,7 @@ int luo_file_finish(struct luo_file_set *file_set)
>>  		luo_file_finish_one(file_set, luo_file);
>> =20
>>  		if (luo_file->file) {
>> -			xa_erase(&luo_preserved_files,
>> -				 luo_get_id(luo_file->fh, luo_file->file));
>> +			luo_untrack_file(luo_file->fh, luo_file->file);
>
> This looks dangerous.
>
> Since the previous patch set luo_file->file when xa_insert() failed,
> this will trigger in a failed retrieve. Except, the file was never
> tracked to begin with.
>
> While I don't see anything that actually breaks because of this today,
> I think it is a bug in the making.
>
> I think the below is a bit better. Although this change probably makes
> more sense in the previous patch, since that introduced the problem.
> This patch should just replace the xa_erase() with luo_untrack_file().
>
> 	if (luo_file->file)
> 		fput(luo_file->file);
>
> 	if (luo_file->retrieve_status > 0)
> 		luo_untrack_file(luo_file->fh, luo_file->file);

Good catch, I'll fix this in the previous patch in v5.

(But luo_untrack_file() needs to be called before fput() in case the
latter drops the last reference.)

So:

	if (luo_file->retrieve_status > 0)
		luo_untrack_file(luo_file->fh, luo_file->file);

	if (luo_file->file)
		fput(luo_file->file);


Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA3606A31A
	for <kexec@archiver.kernel.org>; Mon, 23 Nov 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K987IpYh;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dp952qeb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Jw8SilefRf5vO5k7eeVpHgnCi78conTEfmhaXVb/RAo=; b=K987IpYhi48sn3
	ecagCD1q+kQFvxKToTQtDA3DmJ+8syXcGMjfeilEZGDO2psDOsVKBz68VMWvrvjVf/YYW1+MBFVlC
	FunQ4q1ka5strm6ADmPRJrtcvgXW3U8D5pS2MVR0XV/mEW1l8NBxSE8aOg4egGUkE7b22J5Wn6LeJ
	2nIatB0eCUTeUecHut18Os4QZHH9rGuv96eAYUtovZKcCShHBE0NuVY/ibsNZu3j1tD4cWfEHMeQ6
	hrDu2hHCD4XbiY++rkshlyuUStsPkk1lgG331cAqAfOII/1oYWIvt52wuUykgU9kECVDFZ0XZ2Ggs
	RhI+qiV1HXn3O5vK7s4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYPu-00000004SHt-28Pk;
	Mon, 23 Nov 2026 18:05:26 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVYPi-00000004SH2-1A8A
	for kexec@lists.infradead.org;
	Mon, 23 Nov 2026 18:05:16 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2f020d0169eso16640435ad.0
        for <kexec@lists.infradead.org>; Mon, 23 Nov 2026 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795457113; x=1796061913; darn=lists.infradead.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jw8SilefRf5vO5k7eeVpHgnCi78conTEfmhaXVb/RAo=;
        b=dp952qebB/RATDfTHp9Mucq/EoQn2iQi8Q29CvY1sfXv+VMVsQP5iC781ijGmsR3vj
         54FDRt7Xrq6D1PmLkcBphfedXCZT7O/M9Msrws+Jcwt+FqEPZsX/KJm+B+AY++drWgr6
         YBgB2FwfIizyYCTFGTyVK2K87MbIp8k1uY6HmYOHhM+SjG//Hroid+AFmA4wnUhu+9ao
         VMisL3z4ss5nASlEXB5CXz+7AV1/NNQ95xY63iKxhob69GhkJcaseyWpCSFFHKt+IeAc
         K1ivlpznNGeElR3moIhNbCc5etO5hJBQXcetmo2tx34t6mUQfvBBQVVR9r3tPjDZXGyv
         +Ngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457113; x=1796061913;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jw8SilefRf5vO5k7eeVpHgnCi78conTEfmhaXVb/RAo=;
        b=ryQqTC699sVUlpmbKZVv+VB7MSBtVLQ7FiZhGCMph4G+Lgzu3z+9P3N1v62n4l0vnE
         1R6M7+ldwMZXtx6zRJp+Yq0POa6jzf92MP+e5cykUvNd4/gARy27BwKdYYlUAV4ZdJOB
         TdcTgmXZ1Hdf4yjT+NP1+ln1byQic5qZbd+o1EKgKgFQPp0SDmwzRLJUOW2Rr46fq30T
         s+SGJrIp8kf60piIA9+anLHf2oGITdJIHNyOoy7694EHHL850fRrqkZ+dsLzdyAijCAo
         MVmbiOdqq+mo15DBqWugPMI7CubmVm6M/2hGxlkrhioWU5lssEyCkLurpRW9mPCg0aUF
         aq7A==
X-Forwarded-Encrypted: i=1; AL+hErGaSDgdi6+eE8cX+6hFBq87zzdTbaFYRKKwaOHKaHHIsXPrbko5ar5lmUB03hDBaDMtFGEOdQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/AwTUURqPOlt7x6UMrmjZ634DpzXXQii4L8NQhdVK7zSORWBAU
	uUEblL8B+pfzOaeQrLHJm41dm5HkX7jz0WaSFF2opjgy7tDbTUf6NSG3uaBJKOUWFg==
X-Gm-Gg: AZFdTZdNa+Zq1EIgLddOfhoeJTescJDcRuKQK3TyAj+MTcvA9gIQMZmdsUyOOWCKRHV
	+9FY5lqaq2OV3mXm47gLN+bShOjN6DjE+VPMygOy1urspacgjCxECMEkBVe89wK1KbF1a253D0r
	l/ArWl+GWpcY2CF3Ms7Cs5Dn91SUDA8N1Zhux0fzCKA1CS9npz2g0lsdwkgCWvwEXfGKkOMFz6V
	q5q4/BbusZg9s2wcNQIFujpurQXcCECa6Pvs+J+7/pK4jRuPbMiL3m4CzyyotAYUE0ksGEX+64l
	eHs2C2SBSQf+sJpChAuGknke3afxVVNbmMOZLWmL+0uiks7bnYIR1DZVokFNoAai/9JrQJ+f9IU
	rXKS2IGKz1ZvpZ2gCQEHAvioFHOVlfXLxiwdCTTprwh6QWUGEpMOHnHLNbc7ZyMed/jTjoJpDz3
	OcGgZS0KPC6U4XiYrDWt0Ct2ZHCJNC0LoXi7iEHBmOf+VlXZodTBinMQCK9QagIXQObIUHWe9cn
	XMjMXSoygAfYAEcL/FO2c7IisoqWWTmNAohssLw6v7VTJ3PwQLzDfyaoJjwcIRC/JmBlhVMihu+
	P9O4dkTV2869sPyPFgpo2Qum5FbQtQCjcFCzsk8jsRL0y1gujJLaqMfbwWgxXSG6
X-Received: by 2002:a17:90b:1d4d:b0:3b4:ca86:8bc4 with SMTP id 98e67ed59e1d1-3b4ca868c1emr225054a91.46.1795457112373;
        Mon, 23 Nov 2026 10:05:12 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm18802720a91.8.2026.11.23.10.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 10:05:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 10:05:11 -0800
Message-Id: <DN2SFE0VTWYZ.30XIXLSZ0OQAQ@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Christian Brauner"
 <brauner@kernel.org>
Cc: "David Matlack" <dmatlack@google.com>, <kexec@lists.infradead.org>,
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
Subject: Re: [PATCH v4 08/19] liveupdate: Let file handlers retrieve into an
 existing file
X-Mailer: aerc 0.21.0
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-9-dmatlack@google.com>
 <20261120-gedulden-rausgeflogen-spruch-cea76174d5e2@brauner>
 <2vxz7bi73fby.fsf@kernel.org>
In-Reply-To: <2vxz7bi73fby.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_100515_325128_0C7CC498 
X-CRM114-Status: GOOD (  20.02  )
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

On Fri Nov 20, 2026 at 3:36 AM PST, Pratyush Yadav wrote:
> On Fri, Nov 20 2026, Christian Brauner wrote:
>
>> One thing: Please just install a new fd like for every other retrieve.
>> I think it's pretty meaningless to return the fd number the userspace
>> just passed to the ioctl.
>>
>> The fd number is also not useful as it's not tied to anything. The shmem
>> handler looks the fd up once and LUO keeps a reference to the struct
>> file:
>>
>> 	CLASS(fd, target)(arg->fd);
>> 	[...]
>> 	args->file =3D get_file(file);
>> 	args->fd =3D arg->fd;
>>
>> Which means, another thread can close() that fd or dup2() something else
>> over it before the ioctl returns and the fd you hand back refers to a
>> different file fucking over the caller (shared fdtable etc pp).
>>
>> That also gets rid of @fd in struct liveupdate_file_op_args and the
>> special case in luo_session_retrieve_fd(). And a retrieve into an
>> existing file then behaves exactly like retrieving the token again.
>
> I suggested this approach because I found it odd to return a FD that
> userspace already asked us to retrieve into. Any sane userspace would
> just end up closing one of the two. I didn't think of this race though.
> I reckon we could return -1 in the FD that LUO returns, and let
> userspace use the FD it already has to work around this. If userspace
> wants to close the FD in the meantime, that's their problem. They don't
> get the file they asked for.
>
> While I like this more, it's not a super strong preference. So if you
> still insist on having a new FD, that's fine too I suppose.

Thanks both. I'll go back to installing a new fd in v5, like for any
other retrieve.


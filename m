Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7F606A339
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=O5p9o72q;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=kgi7Ih1v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pXX75GaXTMr1qGEscquEidPOCC4V+kXbyCqTlbWwNJM=; b=O5p9o72qwUpwkP
	6sB+jvvN/fsuAB7Oiqcpd4kCoBtc8DZBL5O1vDcFl1tRWWkVg1prF+hmek+uCjNq/sHjcwknYIeq0
	MrQ3i3GI5ok2LfnfmW1/6u4TCO5kCXQyGDMcsdEfbg3egAWait8Ef+GwgMx1Dez4//Np49CfKuq41
	El0BcDJaJLIlzGUe2Ch7XdA35GnDBMDL35gRzzOJIwbJqU3KPx3QCkUf82CU3qjMRtDwSnnlJu/eu
	CJwdNV0fYCZVqsi79SymcH6GMVBMcgUmX6OKOsnJV/L8bRFlE/rpqsfI1k9aZWRn+KikoYG5fOyTB
	TxQ3ow4uJulnZWvxwUtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMAOS-00000007w6r-0rTn;
	Wed, 28 Oct 2026 20:37:08 +0000
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMAOQ-00000007w6D-0hOI
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 20:37:07 +0000
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso482518e0c.3
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793219825; x=1793824625; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pXX75GaXTMr1qGEscquEidPOCC4V+kXbyCqTlbWwNJM=;
        b=kgi7Ih1vnsXP0DOhon+NY5kmj4K77oZSh1kUyFHoNb+WfENtJVgrGvPPqpgHgV06D1
         CK8C9bWpiYmxbDLd/Tc1F6E4DSZ2T/ZbMvmH4G+40vObC2/a6pvjIJddpSc69JgvKOUR
         NHct70OYMJc5skxn5NBhsjQlUI8pKlyuo+N2lZHRICzzY1XG67CtBuHvJx5W9q6OOJV5
         tP2g3T/M8Uno4V9PZOBUF9xrB/HJqNfg2XRXV6YS8N8kAplI46Qayho6F8H0+HkSN/i+
         ONLlWCx3RK2u+C19NQ1yfczrJSWMulMdU03LiwnRFkXfk6BYfL7h1MIeV3FpiQpoJay2
         nB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219825; x=1793824625;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pXX75GaXTMr1qGEscquEidPOCC4V+kXbyCqTlbWwNJM=;
        b=p4hO6tk4HjuKkgYAEkTWx2vGL5GBDiTpWx1g33jwBDE41/vPU6Ubz+qf6GkM5oVvdP
         tu4d9mj1aFzYcN1HPEXjL2lbEShquOres8I1IObBbyuYMlZorruZy+hZ8iyYNSYJklVK
         +RHUn4MsRcLJHsXvFa+njf7u5Zdz8ctbGDM2t99l09jeq0+NoZWTB+6oKC9jNVeWC7VL
         rxk/a9SCRydp9cd3Vl1B+tKn9t/JFRu9Dnw+m/kGk9oDgUlUAQ+6rSID7cF1YwH69zsP
         oDEu2yfG094p+2tgYCU9ic26DezR65gPPoe7xENNtU2vxLBOiPTAkr/YU3W/vvJnsoKy
         KBRg==
X-Gm-Message-State: AFq9FYIux/9bGWbNOwifYDSvwibdvQCBAfzmCdA8o9O+8H9SF1hcUjOo
	Whsi+lh24Lyv0FSeERNLcS7mqMCqAPY4pfh2MghUzSv/Hpba13Hxis7rd587ls8D210=
X-Gm-Gg: AYBFou3XATrCzeokm7gmxNPEpPaxJcZ85m3ciYvaAP0pnxywxac8m7BMQXkjLnFNVdr
	iAgnw7nZc9CRBDCYIIZBHanOgu6onWJNqvFOfumqKRkEF4zckTw+D9ByzpjGQSrWeSyUssjh8m/
	WSvBQlfw7zfXU4+3XHpzIAYgzvnoqizb8WZjPqFMjAvYmWyena3G3TsUKgbHkgbTSyAVh0Q7PWs
	g39Vfl7QbcRbhcLDbddOp4JVe7x88O6wwDcvQOYbsLHK3Gqt/BniJ9jZU1hi9+RoryPiJ6kLOBM
	7XHo1g2lWEZodI/7N4Ej+rRBWnHqPwFnnDh6iKsZcNT7fswrbRFISo501mKNqOOhEUGcOHsbQd0
	/JRsFFoQjcdbyc7a6wmAwh2xb5a789AuQzK3tkcWFwCMLOVKsEb6cjMUjYlPCCQXQ9Y92Zb1lNL
	1OJ/Koii7YtDiU5gI332W8hAZobFLFUHFDKs+Wqo+Sh7kkh1nFF5CqDcepiRQ5X1RG/mC5QFzsK
	3ddjS9L6fISOY8eCFKXzVtcdrbB6DncIKp7fHuI2MfMq/KKmBraCEok1OSR2227R+nfgt0W4xaJ
	72MOFSIwbg9ueRYVmx9iQlG7PwvybltpI6c4s6c8/Uqvv+JO70aKtZXF17ko+5P0tt+5hO5Aqbv
	ppG1nTWV5EJ+TdmS0ezQI96KnhAeHvPbJLZIUgsgQogiYxBRRqLNp2U239sVOU3aXgw==
X-Received: by 2002:a05:6122:d17:b0:5dc:d0cb:7d74 with SMTP id 71dfb90a1353d-5ec4caa66c5mr1844102e0c.2.1793219825199;
        Wed, 28 Oct 2026 13:37:05 -0700 (PDT)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f931911sm3001789e0c.10.2026.10.28.13.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:37:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 05/10] liveupdate: Don't WARN if tracking a
 retrieved file fails
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mm@kvack.org, Alexander Graf <graf@amazon.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>
In-Reply-To: <20261022225035.377445-6-dmatlack@google.com>
References: <20261022225035.377445-1-dmatlack@google.com>
 <20261022225035.377445-6-dmatlack@google.com>
Date: Wed, 28 Oct 2026 16:36:59 -0400
Message-Id: <179321981903.1894369.6363169044837754945.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=856;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=9m6WB2manDNmHNkWWaupqwLfpyUxuStC4em+E8XaZ0M=;
 b=kA0DAAoBu3coTNtzet4ByyZiAGriXO2ivBwzasr17tc21/VkmA5BpaNy5weddLAF0Xq+WI3XQ
 IkCMwQAAQoAHRYhBEExqpPstG8a8H82Yrt3KEzbc3reBQJq4lztAAoJELt3KEzbc3rePOYP/2jt
 cPdYHQOGemXNJXRL59xPkeLyW7o1RN8hKWIyLuuP6Ug2pE2KyooLVMtwE8WNXTanREsAnV4iWbp
 18DhLZiTVBE5EkM6/8QNoxAZkBSDn4wK+ams5b+mlNPwywvyaEBEZ5fKKScmaNRUCAewpICwMLl
 6MMU6jooZU3sPMbiNKXJ4N2gI/L88JDIsa8rjkt77+VOWxdfj7cWe04yETLsWkQM10Hks9z7s9X
 ZOWlM1lzsqqXduBkm7t8oYWd3s3WaFw0ZhWD3Jv1SpMGSr1ClSSLecw81Ivne6/TsksTGXzubO7
 calTT+OWXI6Ax7nJh7l9RnbbkISeFgCF1AvY+QBFDjjZWEJTG7Nr0os9xXrFOrGET7jEoXdiT7C
 jarfhSDZOjpTla4/QTgYy5aknwkd6vMf+cTDxSZr0ncV/ztL67ng/SAo+XY2X+LJh8NaLiSyawU
 kESqNdn9F8zlYnkqd76MqKhhnynb2Kl39nk67LtMiZ67kERKg2TIvDyk4/+htE8bVfSCyWrbbza
 9rmcRPjKqVYqc0R782X+ScurAwX9FCOEeZ1pGnyfxpn+KWMPQHz5KhiszhkuX1NuJ3nRTt8rwYp
 TeWhBbAFasJNbFxFUn3xnNwQ/MPrJYtpe1iwAqpgdB5suJ6Wk564LOw8NLWPTuZy1U3/0vj/x6P
 YsuVI
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_133706_243293_0902A696 
X-CRM114-Status: GOOD (  12.63  )
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 22:50:30 +0000, David Matlack <dmatlack@google.com> wrote:
> Handle a failure to add a retrieved file to luo_preserved_files instead
> of triggering a WARN_ON(). xa_insert() can fail with -ENOMEM, and
> userspace can trigger that with LIVEUPDATE_SESSION_RETRIEVE_FD, so
> warning about it lets userspace crash systems with panic_on_warn.
> 
> The handler has already consumed the preserved state when this happens,
> so make the failure permanent. Keep the file until the file set is
> finished, like any other retrieved file, so that its resources are not
> released before then. Finishing the file set then erases the file from
> luo_preserved_files, which does nothing for a file that was never added.
> 
> [...]

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


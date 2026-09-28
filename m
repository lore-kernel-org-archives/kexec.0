Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AE60A2621
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VAC4qFWb;
	dkim=permerror header.d=jaseg.de header.i=@jaseg.de header.a=rsa-sha1 header.s=fm1 header.b=Xn2F/Bee;
	dkim=permerror header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha1 header.s=fm1 header.b=RmLDyIsj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uneboma/He5NY712qSn+vkKH9VLe/Cb1KqO8Cgbtg6s=; b=VAC4qFWbvpMt+ESiHCH8vPvSEW
	KH1zPaTPQ0YnjF+5o0DYE/jJBHjfFbUBVER23vVqXyLOTbEVext7gTZMADGhkE+5G9fUgHYDF7fYh
	l+51S2RlzE00sVdlga49Tw3E8DuiM0urrcBAg1TCE1mMd8mm9fPQe8pQZK3rHlhF97AM32Ue/a9pX
	K8MCPqxoYsmrE5S8dWjeHXF+TlQ+XZ0MOsAxChIK06bzsX4X9DLAls1h/OqaMugsGJDU0y5bfDPEP
	5Y5pEngR4kFJyzA2fzdU/qIAYh+C0Stc3debqkh/d+62NdLLg6dY9vOX/sb3vY6wrco+23U1OPsoX
	hm+aJpaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55y-0000000991t-3UkY;
	Tue, 20 Oct 2026 08:21:18 +0000
Received: from flow-a2-smtp.messagingengine.com ([103.168.172.137])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBF0m-000000018Re-0es4;
	Mon, 28 Sep 2026 17:19:33 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 3819B138050C;
	Mon, 28 Sep 2026 13:19:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 13:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790615971;
	 x=1790623171; bh=uneboma/He5NY712qSn+vkKH9VLe/Cb1KqO8Cgbtg6s=; b=
	Xn2F/Bee2z6el8igxd45eG5wNR3NTrKx7+cMDXdvBagHejvMQ3l2B7xoMDOi9tbv
	bmOai/bWCJXgQ+8FZ/MIddhy0zYXzhBbanH2mxuHc8QosuY4W8JiMP32EgCpQNkr
	Yus2uclL3ku6O7zRGgEK+MAuyQD0pQHCEF8swZb/H8O2HrPYlBbMwLvyqGZKS3Jl
	PusYIKbSPFOL110nj4ceQI78Y5dYwDs79Xo0zqWaxTkRteg6joLAhQ353UlE0Eij
	x7tE8hVpGVOWGn3LDMHxw6lYG1eA+Hb+3jlNebmsj6uRn+pqMxYqdXO1VbAQo3y1
	cvnEY6u9S6yjH6CE7K3ezg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790615971; x=
	1790623171; bh=uneboma/He5NY712qSn+vkKH9VLe/Cb1KqO8Cgbtg6s=; b=R
	mLDyIsjulzLIsTwhRMi0Y8pi3oNM/uK6t1tFueteHaAp2PQV6ZJnqI8MMbFXxLCP
	O8b6xvGyE3q1wE+kLOAVQ8ae5i+YEcumlA4iyJUZUQdIbNLhG+/laDPiLcjyEq7G
	OerP/50s2I/1C6OOeoEzFNgHc+ypOrPXoVlUA821ZWTYhy8B2iZDjovtwiEX03kl
	0hohRTpk0Wxmffqx4xEOPBHa+aBfXK9AmU6cdmLJPzVqbojT7MuftNBq6N9nbvA6
	XaxG1IpqYx9b0qbzz2Nd1Wi13Hf7pRY47+jT3T5kQbAAe1GYhcSsqKAf8379EyyV
	mVTNcl8tATt9OsqjzQDWA==
X-ME-Sender: <xms:oqG6akz_t_NO5OQBDb9ttMWsMnqn7AY4tbbx4GGKRtwzWbhB7JWHdA>
    <xme:oqG6artZp4tzP0Ns9p7PItzsybQZRH0NgokjY1zt8AnVEL37BJo9tEZGQmH56GOsF
    dT4vAkjW-zF0y8TtKilHSrGfujQK-i_QqsM8Bkc9Zqi2NkTDsUEVXY>
X-ME-Received: <xmr:oqG6aikTFlGCBNwtgNyl556uB9m9tUporo9_2rYIo-Q959DayGUzMck1qpmfLrJf>
X-ME-Proxy-Cause: dmFkZTE/22e7clbyNdHwn0HCBx+H3lsiFyo6QkPV6dpSn20/QyCOxtHNd7QTmx6b7eJ6RH
    b7MD0YK3xmhVFW7pHJl/jJiaLCtzwYaWJ6VBcJNMtYB/lM8rXCQqoyXJAKc1Q+3NTJHLRu
    Q+616RIwRjK3mn/tprgeZTxr9VaE0UGr12rr0RgYUziHPYN8WsIu22gnQm98Dq7NFgLEYb
    bOn/3mv6ye0r5zsmXTZhHlWNyOVRZl7FwJjAmuaSy3Z2MGyz8Xby78ZPjGLjvAF+o1XCsp
    YM5+7QijkJtemWRQaETyS2I23TsNHUOR4KF7C0sS19NgtEnCYopA0Qb1idGIqDD/y3bADx
    xRU4viQI6KJSw8q5mlwZtBEc0ssyEq5m2pBX9vtZm1x4BknR2LEptfHY85GS+fDNvix4gY
    7KSs25IBd7mTFsOBM4oeGwrKZn7tHV2mU6Lx2n9+HpPSJuxygANxQ52D2fB8CRAZY8xEJ7
    HjaT3/3gywZt0jGF/7GuvB9dQYMx/Z619uzsZwfJdJKFCLiVR/khsnerLC9mx1Xp6nLWCR
    6smPwWlZwgXj56Nw2D3J2DNcbksR+eBw4vu0EK753rWvj+zVGnaMQy+RoJcaZVWqasYsfx
    /5b4TjmoopI39a+8sRxSiX0DvGSb4mD5JElNjPTWLqifji1U4yiV+MKYODmA
X-ME-Proxy: <xmx:oqG6arittnioN3DLHsayzIWeuevkbgi_c00u8crZZkBOn3QJcTf6MQ>
    <xmx:oqG6agHtBatmdR3EF5qifCfYs_5Mo7wsCcsuqa9yb0eaowtZ88cfEA>
    <xmx:oqG6agOFv8Qri8cKFdDvtZDh0Vq8v7tJe4vSDLnoiH5j1TT3wsV6sw>
    <xmx:oqG6aj3m9rglGLVtkHKbdslitarg2WO4XrwWeHx7c7JjXpEKLlB5cA>
    <xmx:o6G6amD-XKs1zcTn4v0Jkglq701b2vCXV_LIcW5qh8psE-RWxjBqgIoH>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 13:19:16 -0400 (EDT)
From: =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
Date: Mon, 28 Sep 2026 19:17:52 +0200
Subject: [PATCH v3 04/12] arm64: Enable the crash memaction registry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260928-crash-memaction-upstream-20260921-v3-4-e511e9ee2329@jaseg.de>
References: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
In-Reply-To: <20260928-crash-memaction-upstream-20260921-v3-0-e511e9ee2329@jaseg.de>
To: Jonathan Corbet <corbet@lwn.net>,
  Shuah Khan <skhan@linuxfoundation.org>,
  Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>,
  Saravana Kannan <saravanak@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,  Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
  David Hildenbrand <david@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
  Brendan Jackman <brendan.jackman@linux.dev>,
  Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
  Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,  Mark Rutland <mark.rutland@arm.com>,
 Alasdair Kergon <agk@redhat.com>,  Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
  Benjamin Marzinski <bmarzins@redhat.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,
  "David S. Miller" <davem@davemloft.net>,
 Mimi Zohar <zohar@linux.ibm.com>,  David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,  Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
  James Bottomley <James.Bottomley@HansenPartnership.com>,
  "Liam R. Howlett" <liam@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,  Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,  Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>,  Lance Yang <lance.yang@linux.dev>,
  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
  Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
  Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
  Matthew Brost <matthew.brost@intel.com>,
  Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,
  Ying Huang <ying.huang@linux.alibaba.com>,
  Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
  Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 kexec@lists.infradead.org, driver-core@lists.linux.dev, linux-mm@kvack.org, 
 linux-arm-kernel@lists.infradead.org, dm-devel@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 =?utf-8?q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_101932_272900_49876156 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:06 -0700
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select ARCH_SUPPORTS_CRASH_MEMACTION on arm64.

Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
Assisted-by: Claude Opus 5 <noreply@anthropic.com>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 54c344d39830..4894a5cc11ac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1720,6 +1720,9 @@ config ARCH_SUPPORTS_KEXEC_HANDOVER
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_SUPPORTS_CRASH_MEMACTION
+	def_bool y
+
 config ARCH_DEFAULT_CRASH_DUMP
 	def_bool y
 

-- 
2.55.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE06CAC587
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 00:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQyP0GZJc1hFrxmU66hajulLthQQnuqIFSCA90Eid9s=; b=jjPlVIDGqlg8Qz4svdTmNZ9su5
	REKzGZ4xXt9koUVgqhuzWjtbs7DPc/Ja/eTo3iBtQUsugati8tifOi8HJd/JmpX95SuhIMJnRQb7/
	4T2x4U231JlXTS4Gux2M87YZOR/7LNG1QNWqIw8eKw/W1LaJaDfr7gyWKD3EqsIkQNhu110FKQakF
	CqoGCqy/QY6xC5Yz8eU5yt3f+2GulT+tHnkeTr6PGYrE7YQl0H3f0kMbK4ft3B3hqML3R7sOqZM4K
	XB5kElAh4IbCdzqmkEZjuaVLn0RObgLbnO+N0YGGOs/ZgdSNOa9dl13zwo/qs/zwCNhiI2SkDYD1l
	1Z2zM8gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw960-0000000BFyn-27OQ;
	Wed, 10 Sep 2025 00:54:00 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw95x-0000000BFyJ-36qy
	for kexec@lists.infradead.org;
	Wed, 10 Sep 2025 00:53:58 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-77251d7cca6so5276175b3a.3
        for <kexec@lists.infradead.org>; Tue, 09 Sep 2025 17:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757465637; x=1758070437; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQyP0GZJc1hFrxmU66hajulLthQQnuqIFSCA90Eid9s=;
        b=SkzH6uTBridvxhD6+vVr2fC2UWJQ+sWn+vR3K7Kj4U+9u9giul5vxrRNlwytOdZtS5
         lnkpDlRBU+Xad7POben+zt0Z5hXChT2H1rS0PLmz5jk2CGb4lGcCDbdGOexTp/abJy6W
         vr3nfMA6kIJxesGc+SYHPuVpqZ4avBE9uzaTmCW3IIALsGwYED9mw0MQ8BTi+Oc8sCBJ
         Zfjkpo1JVMdgQ/MoSpzWdOEMm7Ao8ECgqRxv6GPBnMlMLSLzdZMssjXUozWGzfoAF0Wu
         Hf0nBOjNPOPf32dZ3d+JgKqtbQa4Jaw56PpCYS20WnTF6AV6zg+dDUfzidi0jrDbBd1a
         u6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757465637; x=1758070437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQyP0GZJc1hFrxmU66hajulLthQQnuqIFSCA90Eid9s=;
        b=vA3hHu7XGtgS48fgesMD/yjUESzxScHPWisemmJtdScuN+9uZUPTLNbXdgxiP9GxcQ
         /E6JSFYKcN2kxSAqDamZ5PjcKNVHpL45fhidzmnJQ5C/4YnfAIlSiWWdSR9dZCMijI0F
         uBiPe2yaGQZBjxLhKWmkQTsU2lhY0V+PX/EH0yHiuklAIsHWg4470uALWImBz8TjcT0n
         vQwsMBstBq2XOrd5z3Q7T0eZYxZgGirT+BhgoAnZyKKxr7qGcan/WimHzwTZCad5Bt+G
         qBVhWHzK4+jBK2pHaQAwNn09cIKHvXBvV5RmizcrlGCOEyIeiH/qPoflEorLJ2LtJm0G
         Jtuw==
X-Forwarded-Encrypted: i=1; AJvYcCWVSEspPVUDbQ8cQ1CP4/7G1R8gSh8nv8mQrRlv+sg/7BK1iAeaIf2HUBnaI7+cJ4wIxEkTaw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzS5TzUCrGWbLuU2fWn4+dIMsA7CvRHtNYVf7+zstIDsbgAy+GN
	sJSdKAxqV4uFUlDmbOZ1CxGnNPpZO6IxRLwcsdIUlKbpcnzSM9txWO9Z
X-Gm-Gg: ASbGncuUb4nu7UaR3So8lh00xRpudlQb6l+Rh1pfHZB6+us8Mgl7MXp8dEqBmp82JPK
	4vrwD5d/QrsuFa6omZxihLMOP6BSmMn57cseoIHStaP9WxvWA1Jat5mxyrsxyw2Viv8fXDikzeq
	q/tMODGiGO4M/rrWe+ZRp2u+mCCE7Tp3+G4CMXdQOxpy0GTCKFfJMGlDDS7KWl6NvQjBn2t+ASw
	dZyv56ozCSrGwE2FJYZChusnnPOTC/+XCedwgl6hFBSymcK6GHybg9pprEAwwBJUlAefV+X6MK/
	ji+HlxEiZSNSkxAVJbuCKTJeyojicRyliX39/sXY6zRd7xgZ3SkGqjEA7xXoSatqANLD0wngUvW
	o0PUVrgruSWQUKW8fbwLrPuMU3pY/Hv/hm4Qc
X-Google-Smtp-Source: AGHT+IHAZHC7oAM8pJIFcJFqO6POsM5S1IybN/l0HMvF9MBkuhQT84W6uIqRsAsMv6iq7YsoCXx+4A==
X-Received: by 2002:a05:6a00:2ea8:b0:772:2fad:ff64 with SMTP id d2e1a72fcca58-7742dce028fmr18864649b3a.8.1757465636796;
        Tue, 09 Sep 2025 17:53:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662fea7fsm3210232b3a.103.2025.09.09.17.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:53:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E65E0420A809; Wed, 10 Sep 2025 07:53:51 +0700 (WIB)
Date: Wed, 10 Sep 2025 07:53:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Andrey Ryabinin <arbn@yandex-team.com>, linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 7/7] Documentation, kstate: Add KSTATE documentation
Message-ID: <aMDMHx1spjeETKK4@archie.me>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-8-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909201446.13138-8-arbn@yandex-team.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_175357_788583_AF1BD728 
X-CRM114-Status: GOOD (  17.61  )
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

On Tue, Sep 09, 2025 at 10:14:42PM +0200, Andrey Ryabinin wrote:
> +There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.

Escape the trailing underscore (i.e. KSTATE\_).

> +Addition of new field can be done as version dependent field by using _V form of
> +KSTATE_ macro:

Ditto.

> +Subsections
> +-----------
> +Another option is adding subsection to kstate_description. A subsection is
> +additional kstate_description which linked to the main one:
> +
> +struct kstate_description test_state_v2 = {
> +	.name = "test_v2",
> +	.id = KSTATE_TEST_ID_V2,
> +	.fields = (const struct kstate_field[]) {
> +		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
> +		KSTATE_END_OF_LIST()
> +	},
> +};
> +
> +struct kstate_description test_state = {
> +	......
> +	.subsections = (const struct kstate_description *[]){
> +		&test_state_v2,
> +		NULL
> +	},
> +};

Sphinx errors out on struct snippets like above:

Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/core-api/kstate.rst:17: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/core-api/kstate.rst:21: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:28: ERROR: Unexpected indentation. [docutils]
Documentation/core-api/kstate.rst:32: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:33: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:84: ERROR: Unexpected indentation. [docutils]
Documentation/core-api/kstate.rst:100: ERROR: Unexpected indentation. [docutils]
Documentation/core-api/kstate.rst:102: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:103: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/core-api/kstate.rst:106: CRITICAL: Unexpected section title or transition.

...... [docutils]

reStructuredText markup error!

I have to wrap them in literal code blocks:

---- >8 ----
diff --git a/Documentation/core-api/kstate.rst b/Documentation/core-api/kstate.rst
index 981ba162109c34..620d7c126c2038 100644
--- a/Documentation/core-api/kstate.rst
+++ b/Documentation/core-api/kstate.rst
@@ -11,16 +11,16 @@ kstate_description
 ------------------
 
 Most kernel's state is in structs and structs could be described by
-kstate_description. E.g.
+kstate_description. E.g.::
 
-struct kstate_test_data {
+  struct kstate_test_data {
 	int i;
 	unsigned long *p_ulong;
 	char s[10];
 	struct folio *folio;
-};
+  };
 
-struct kstate_description test_state = {
+  struct kstate_description test_state = {
 	.name = "test",
 	.version_id = 1,
 	.id = KSTATE_TEST_ID,
@@ -30,7 +30,7 @@ struct kstate_description test_state = {
 		KSTATE_FOLIO(folio, struct kstate_test_data),
 		KSTATE_END_OF_LIST()
 	},
-};
+  };
 
 Changing data structures
 ------------------------
@@ -55,7 +55,7 @@ There are two version fields:
 
 KSTATE is able to read versions from minimum_version_id to version_id.
 
-There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.
+There are _V forms of many KSTATE_ macros to load fields for version dependent fields, e.g.::
 
 	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
 
@@ -67,7 +67,7 @@ be loaded by any older kernel.
 Removing field
 --------------
 If field is no longer needed it could be marked deprecated using
-KSTATE_*_DEPRECATED macro and bumping ->version_id of kstate_description:
+KSTATE_*_DEPRECATED macro and bumping ->version_id of kstate_description::
 
 	KSTATE_BASE_TYPE_DEPRECATED(k, u16, 1),
 
@@ -80,7 +80,8 @@ Adding new field
 ----------------
 
 Addition of new field can be done as version dependent field by using _V form of
-KSTATE_ macro:
+KSTATE_ macro::
+
 	KSTATE_BASE_TYPE_V(i, struct kstate_test_data, int, 2),
 
 This indicates that 'test_state' only from version 2 and above have field '->i'.
@@ -91,24 +92,24 @@ understand the new V2 'test_state'.
 Subsections
 -----------
 Another option is adding subsection to kstate_description. A subsection is
-additional kstate_description which linked to the main one:
+additional kstate_description which linked to the main one::
 
-struct kstate_description test_state_v2 = {
+  struct kstate_description test_state_v2 = {
 	.name = "test_v2",
 	.id = KSTATE_TEST_ID_V2,
 	.fields = (const struct kstate_field[]) {
 		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
 		KSTATE_END_OF_LIST()
 	},
-};
+  };
 
-struct kstate_description test_state = {
+  struct kstate_description test_state = {
 	......
 	.subsections = (const struct kstate_description *[]){
 		&test_state_v2,
 		NULL
 	},
-};
+  };
 
 
 Subsection must have a unique ->id. If the receiving side finds a subsection

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


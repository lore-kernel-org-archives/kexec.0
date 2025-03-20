Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1EAC36006
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CoF70uKeI5oxzSiOPNjzHWGikLf7hCVkYp2xH2dZwr8=; b=cWAdVAyBnpSXVI/mYfdMx/LiAF
	BXVpT5bqKyRsvCNmDatLsRMkoMhey08uwF4CFtj3C9HPX84b/s/vLJWexig9UL1XbT+jPb96n4K/G
	MQD4tJ+rqhaGFQoSHQ0w6SCs9JAmqF6bS9VEi+2Rr9XBqV41qsGSZdezrfeT5wquETcdpBDAhopdb
	0n4LV5CPxefon4lnBmsLZjC8aOUJEt5LL4rkV5wFKoe1x4k6l2SSdsFITOakg4/8cXeLM+uAUgk6Y
	8LGyTDx+SqAUgd59M5xiKwYvOKKL0mSAiMK1L/D5s5K3jL+h3euQ4rROKsA+OD2HOqJaF3IWBnkrW
	JCby6x8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS8-0000000CUIg-1lZ8;
	Thu, 20 Mar 2025 15:05:00 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvH8w-0000000CQYJ-1eZN;
	Thu, 20 Mar 2025 14:45:11 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D2FF41067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742481904; bh=CoF70uKeI5oxzSiOPNjzHWGikLf7hCVkYp2xH2dZwr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=islBIcnPKt8uW5hA3T3PPSmSCAiYqTkWFBEgj6iGu0PWPhW3yjcXFHgamlCxP1MrS
	 /Lj+fUKxr5XHpTVprLUBgUismDvPS5CB5J1IUUz2odXEXKxobBdvyGKp74eASDg1b7
	 3NcoQjKXG2u/38NTpV85yQL2oGjhpBevYaOfsEqQNZYT3+llSNJ46De0it7L6QHik5
	 4OCNYQKMEJTCOOJW9yd4iQ9bGRG/5GewfSs/+M1vFeCmQII3N0M93VIhTR33fzTGT2
	 XjQTWkJpZniQrdJpagKpy1B+EeTb8h9XOtTFnPpNxPzbj/PPuetJF6/iR/xdwKAoCn
	 7GVrkwxcSB9Ag==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6D2FF41067;
	Thu, 20 Mar 2025 14:45:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
 anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
 benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com,
 mingo@redhat.com, jgowans@amazon.com, krzk@kernel.org, rppt@kernel.org,
 mark.rutland@arm.com, pbonzini@redhat.com, pasha.tatashin@soleen.com,
 hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de,
 robh+dt@kernel.org, robh@kernel.org, saravanak@google.com,
 skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de,
 thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Subject: Re: [PATCH v5 16/16] Documentation: add documentation for KHO
In-Reply-To: <20250320015551.2157511-17-changyuanl@google.com>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-17-changyuanl@google.com>
Date: Thu, 20 Mar 2025 08:45:03 -0600
Message-ID: <87wmcj69sg.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_074510_435993_9B98A961 
X-CRM114-Status: GOOD (  11.43  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

Changyuan Lyu <changyuanl@google.com> writes:

> From: Alexander Graf <graf@amazon.com>
>
> With KHO in place, let's add documentation that describes what it is and
> how to use it.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  25 ++++
>  Documentation/kho/concepts.rst                |  70 +++++++++++
>  Documentation/kho/fdt.rst                     |  62 +++++++++
>  Documentation/kho/index.rst                   |  14 +++
>  Documentation/kho/usage.rst                   | 118 ++++++++++++++++++
>  Documentation/subsystem-apis.rst              |   1 +
>  MAINTAINERS                                   |   1 +
>  7 files changed, 291 insertions(+)
>  create mode 100644 Documentation/kho/concepts.rst
>  create mode 100644 Documentation/kho/fdt.rst
>  create mode 100644 Documentation/kho/index.rst
>  create mode 100644 Documentation/kho/usage.rst

I will ask again: please let's not create another top-level docs
directory for this...?  It looks like it belongs in the admin guide to
me.

Thanks,

jon


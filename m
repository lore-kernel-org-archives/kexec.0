Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D58C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kd34Op0LaWoFOH4WICssdmvbz8+Oi+3sQS03uV22riM=; b=s7PnBY3nxi8yD5
	oDar137wksI/0ADC8JYEgyyANTSJWHEqb032pp4qIG8JM6oiFxmXCaxnnAD7xCysU8HgbizVP60gh
	VDQ9BlJmT/d3LOLbXlF8cJRKuzFXtUy5yYL/HibcV6GSi1bnr1q92v30LcGrcCyq70f2pBGB13aJO
	aggtf3B1+5n1cbggHP6P0DXZZsAWQ2MMBV3GCteWDqx0gPSeoWMAsKffB8uXF2sTkJjX7dFzyHDoN
	Nflq4Z3Bs5ZefyTl8w+Dg4DIJTrDc7wmDxE0bmCqTyQFRMlh0uIyIM4+r6Y2+Sd7SYjOCUDTVQJ2p
	+ket6MAP3BIDAraTNeuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDU5k-00FjcD-2H;
	Wed, 13 Dec 2023 18:36:20 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDU5i-00Fjbd-22;
	Wed, 13 Dec 2023 18:36:19 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id B38EB20B74C0;
	Wed, 13 Dec 2023 10:36:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B38EB20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702492576;
	bh=FSoND/Rio1BVDzv9hjpwr5UcJ+QwyY4n+ZrOMk4me1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFvtTxVsiFesSJ7FzNixa281/P48b0bCJxgm3CqQ6cDk6s6Skcl2acTUa8gUBEXES
	 tTYVpdre+532OpyaTWruMgobqgik30bvZ7aLrPx3eAdDHUG2SFi4aEiOKN+F7WeSwQ
	 1SA8Nb68mNFCR3UPRRDsdzlKrPWDm7wHEPPCAtI0=
Date: Wed, 13 Dec 2023 10:36:14 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/15] kexec: Add Kexec HandOver (KHO) generation helpers
Message-ID: <20231213183614.GA14669@skinsburskii.>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-4-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-4-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_103618_791387_A3EA3EBE 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Dec 13, 2023 at 12:04:40AM +0000, Alexander Graf wrote:
> +int register_kho_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&kho.chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_kho_notifier);
> +
> +int unregister_kho_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&kho.chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_kho_notifier);
> +
> +bool kho_is_active(void)
> +{
> +	return kho.active;
> +}
> +EXPORT_SYMBOL_GPL(kho_is_active);
> +

Why should these helpers be restricted to GPL code?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

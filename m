Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4965C021AA
	for <kexec@archiver.kernel.org>; Tue, 18 Feb 2025 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D8dZnOXFuROlbQzwYeFLYukaJG+WvfuqVEkJvIIiXE0=; b=l2CdkHNvOQ6NwvOYE0dnCwGNEG
	eZO3HF8rJg8ZLqhP/CLP845Yd+bAB6JmHkiWZq+HGLgKYzOIi7pn9QdLJH6A403hNGchlcUEQ4BDg
	NkP8MX+nbnpEjzNmTrXiBN/c1bkZOi6Q4mJ30nuYv+shFWqGA645GwPjotHIln06pgNgimPX8awmN
	r5e+byU6TzLgcj4KoY3HPrF1vhE/cgj9LO+1u2c8ra5FqzpRr2reFzMuGCQHFJHn4lECyZHw3X53G
	O3azFMnrE5r50BwbO/3i2j5L12XU4Eb+wbQYpLmU55unKfbEfJF4JKBFdRITl7ccZmINQWwFMQpYx
	u57Ad+3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkSW8-00000009OUb-0uQR;
	Tue, 18 Feb 2025 18:40:24 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkSNh-00000009Mii-0ICL
	for kexec@lists.infradead.org;
	Tue, 18 Feb 2025 18:31:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 62ED1A41544;
	Tue, 18 Feb 2025 18:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7B9C4CEE2;
	Tue, 18 Feb 2025 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903499;
	bh=D8dZnOXFuROlbQzwYeFLYukaJG+WvfuqVEkJvIIiXE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=swHEmBmkLDhgWpG8J9xtDug53hxv+cLGvgql5mbqbjMVdYxL171ydBGjcHgZg65vM
	 ScgU9qsNX0x+EH2MSPTX73WbmI6idcP7/P7chUgXDWCLAg0YbKxKWnPntjyKBRPyPk
	 a6TpVHWHzOhQO7MYM09GjiVGKOawqRxUYdakYLn/3Mdm4Ly42swWKkVykmjkT4gyIL
	 vnagzYQqFhuIBfWC55sOE9lrHil0TuiDAFnMt6d8UgV60AhBIA4fzahNln95FYrbCF
	 1ctSu0Eqq4myDYkci5fgeva8+JE2piB8g/tAw3ecjJeIZMDnuAyVjsPiWzguYuSb+7
	 cABMuN8Q3Vv+A==
Message-ID: <eaa0d608fb78d06caca26edc9a830cf1a02f9fb8.camel@kernel.org>
Subject: Re: [PATCH v12 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ross.philipson@oracle.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, 	jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, 	herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, 	ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, 	kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, 	trenchboot-devel@googlegroups.com
Date: Tue, 18 Feb 2025 20:31:35 +0200
In-Reply-To: <060ffc99-59e8-4b71-9e7d-daeb807332c3@oracle.com>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
	 <060ffc99-59e8-4b71-9e7d-daeb807332c3@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_103141_174162_CD8589BF 
X-CRM114-Status: GOOD (  11.64  )
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

On Tue, 2025-02-18 at 10:21 -0800, ross.philipson@oracle.com wrote:=20
> Hello folks,
>=20
> We posted the v12 version of our patch set in December of 2024 and we
> have not heard anything on it from the community. We believe we have=20
> reasonably addressed the issues as has been discussed on list. I
> realize=20
> there has been a lot going on with releases etc but I just wanted to=20
> send a bump that these patches are out there if anyone has time.

I don't know what happened but to be totally honest with you I missed
that version. Maybe it was holiday rush but yeah still I did not skip
it for that reason per se, just that it could very well explain the
silence (people tend to fast-forward more at the time, and then
mistakes easily happen).

I'm right now on holiday up until end of this month, and this will
require enough time that I unfortunately have to postpone the review
up until the first full week of the next Month, in order to do this
properly.

Still, apologies for ignoring this!

> Thank you,
> Ross Philipson

BR, Jarkko


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B85C5B56A
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 14:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jp0fqZFHF7mI1CqwrilSaNxFrVnfx5CxGflz/18MAoI=; b=r2leRfx2s5eyUlP/lDaLmyhTfE
	FrS4abNY1JOyt4HVqipgxbhDZKteM+f9aL+uiFwK6EjuzTuTs6Fz4ibYD/1HsFZ+KwDvHcdqGIb7a
	va6ndjhZcgpqmBUJg07VNsX5ybhYPKWedkO/8onsLl1uowMOldZXchR4absx7vDmV002c+PlVBMZf
	0LJoai0TjGOZAc2GjDYtZw4jWuCWbw3qnuo2PP/rTnjM4u38hkrXZ6bJhvFoQ8Fv8wo1ZOnlx7VQ1
	HEFYI27AouDWBQl1RXRaI2vfsGNQHBHrdCIcinPwHM0eJtutFF0Bv4VEaCzagGmOuPWm+rruCQGUM
	AoveV4nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnwW-0000000EGXu-2JjQ;
	Tue, 11 Aug 2026 14:59:04 +0000
Received: from flow-b6-smtp.messagingengine.com ([202.12.124.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtnwL-0000000EGW7-13RN
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 14:59:02 +0000
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id A40251300303;
	Tue, 11 Aug 2026 10:58:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 10:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786460327;
	 x=1786467527; bh=Jp0fqZFHF7mI1CqwrilSaNxFrVnfx5CxGflz/18MAoI=; b=
	RB8KNNN2uLPqYwPDPFFP1WLG/46050Id03CcYX5EuhJ0Og9/pHhIoU21hAm4eZSD
	qz5TMzt6KCMD4rEZIfjYO7yoLR6qxAgFQkTfNO3l4cJ1JhJEHft36jConhPMLxjh
	oiTzjlngYctfnfkrQ1CTNjhrK2/BbckG0EUv4Ix18/eaqgmfp7MVyH9PWplZlcLd
	WJt6/PxJDGZ0ACOMU/CzcczcrXkEJ5//oq5oigdbA+HjC/AZbEECfNcfmf2ulXc+
	YyeITKbD59t+Z+79sJ0JPBE4oHNkHc9Q7x43Zt69R7B/OTQy5UOnwO0mj/+u58fV
	+RbKX69psMu+YL2564+dWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786460327; x=
	1786467527; bh=Jp0fqZFHF7mI1CqwrilSaNxFrVnfx5CxGflz/18MAoI=; b=b
	zQTPJWaztfd5VsPiL8k/4fVV2EhfctfLSEykgNH+bCG2zpjDLchcSiFUoxNrIxI/
	DM/SA160y3vhtB44WmDu1ZCks+ttamqcrsuS+JrajTeh2xHn867U7HvnD+m6+V7e
	FsMl8Tdr9kWvgxYFVs3+1nJ5jp2WxMGKRu9LcjoZPvoBzDtZScbDsehdf3ejYVcz
	/xZuuaxYGc+0IwiIv42d83t1EuRjALHZt5kHAOPRd6hhnqyi92qKaesRZ3eewWZt
	SpKOYbfFw3hraVoHXCohXOC71cbhSXOztVmD6u8XkjIJy1/fuT1MuqnoeE+ARHKg
	O3Rrd5pCMiNJPQaSsq4xA==
X-ME-Sender: <xms:pjh7agnW2sbwu5eoERfEMBE-zpmtsQrp1Omlk6l1RhPODd_QgxWQ8w>
    <xme:pjh7ar9mZ77LYHw7W7agqhE2aKbq486ENGy9ba-L2Xj8VYzHU4aoT9B8-WTEOWzX4
    Mp6c4WIpGDqylWYl1f_t27_iqlpRswIUBa1lQNO57YAL4zWK7yd>
X-ME-Received: <xmr:pjh7aqeltHoxApSSZceXQsVS_pN3mPGIB6IGTd0s6mvxafnnGt7ogtO6rrf3HJUypxZ7e48iuQxUNa22MrRemxM>
X-ME-Proxy-Cause: dmFkZTEZzbQm8+MDadCcsfJIzUGhB297v8VJIjT5vjgHKW/Zy5NM7EP2B2afP7kXMI53Pi
    iMI0tkUZvFWWrvqRH/dnVoYK6W24oOJhenYKYhI5KO8Vx0oQHnpX2BCKf9Q6x7r1s+eUda
    qmBRp1DiByHgPICjaGVN0CeKyGl+imPlPIlFbGGt+r63vZTd+ceybvhTgBxHDfYC4j2HO6
    e2a73mnRuf9+fKjrvSWXh5b6K39H9mLcpSDP87bw4E9usEp5rE6R5L4CjPIF4057U/EdCT
    x/hnPYXUYRRJfF5FKi3p3YQQUSjG3LMuOm2yMOEqWH2+kvJyI94puOzYBkqL0qWxY1tsCu
    XuY/A4RbsLJ23UA1GTKWV87gFg1aDRlwH+b5xZpNz6cgw63Fki/lU1EEoWliJMHd8cpjgL
    6F7/iTtLRsz9MxFbw+NtkGT3bogoTABKQ+QM7gAdveEJyq10Ncd4TP2sXyzTFx40bp6GLf
    r2LKMNM1cvvfgU5v1JZzOM2IrTawvNjM3ZoaVtQ2mug9pdaX3O1zJgKgnBAsAWDheayKNE
    omfItp08clFcYViM4HjddhvNILTXLTb0lzDAyudfYzjpsT7o+MW5Z7ENFsJ3BZBY7uEV4w
    AxB2UAexilrYje+mEv186TdsruwEC6BTFXDG9+V4poscOK9owRxMxaqCVC3g
X-ME-Proxy: <xmx:pjh7al4tD6fMWdbRFemuNdQsTrYh2ofZP1k9vtGP06xgSwZc45mHpw>
    <xmx:pjh7au913xd5IzW3OT0m_37nTpXV-1ZHMD-UkjPGwO2FnFCHxp0gXg>
    <xmx:pjh7anzm3EGKn3fjDC041YQSZUs7weSvqHbAAguTeSIF8GLzrN_V7A>
    <xmx:pjh7atHn3Yj2xJCweAynTJuxrtdF0234e-Buy76u0341hVnT2WhiEg>
    <xmx:pzh7aneerQTuAXvQa5r2czyHrRm3rAecw4HwFoxCUCV0vCQYp7mAtUdB>
Feedback-ID: i60a14417:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 10:58:43 -0400 (EDT)
Message-ID: <018e58ef-c20b-4859-9dfa-bec1b4360a37@jaseg.de>
Date: Tue, 11 Aug 2026 16:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] security/keys: zeroize key payloads before kdump
To: Jarkko Sakkinen <jarkko@kernel.org>, David Howells <dhowells@redhat.com>
Cc: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He
 <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Coiby Xu <coxu@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 keyrings@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20260731154608.153258-5-linux@jaseg.de>
 <20260731154608.153258-1-linux@jaseg.de>
 <2259835.1785538211@warthog.procyon.org.uk> <annuus46w5SXmlsA@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <contact@jaseg.de>
In-Reply-To: <annuus46w5SXmlsA@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_075854_125749_01427EEA 
X-CRM114-Status: UNSURE (   8.77  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 8/10/26 17:31, Jarkko Sakkinen wrote:
> On Fri, Jul 31, 2026 at 11:50:11PM +0100, David Howells wrote:
>> I've no particular objection to this, though I'd prefer the name 'wipe' to
>> 'zeroize'.
> 
> LOL, I responded exactly same before reading your response :-)
> 
> So yeah, +1 to this.

Thank y'all on the naming feedback. I agree that's clearer and I'll post 
a v2 of this soon, and I'll rename it to CONFIG_CRASH_WIPE_SECRETS. I've 
had my head stuck too deep in government standards where they call this 
"zeroization" :)



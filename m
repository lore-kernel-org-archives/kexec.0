Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D589C55179
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52EZk8YPwTy+jG8rvfx/kfwJ0amdCbdlhZF4BPxa9n0=; b=3Y0k6xPZFDCDLmFgSsQ/6q3BKv
	I4DkZsCDlGJm0/Yp5DkUoa1jU61n1KQ81dOsKnrboq0KBlTw6m1WGJckmimheTKHZEGE7UVmFulon
	1Bf3KW7OLNtei7YikGAATn1sy/WBp+BntYvkCEd6rvlseFX3XDAZkV3aOMVOXV9+ElJcjLbuE3W01
	oMpaPeh57lH40adkYFlknDvEGVG+wTZ9B2rUHysLISb/vhy6JGMRdAdl2vV9KeJDVMJ3qtuLELaVM
	zsEwvVva8zqcdHLzXuH9Mmq8CVVwuqQxN9DNecd7EJpwm9aQza3+CWLtjYJaFS8k5ml1k3L3Ky+js
	+nuoqccg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqrN5-0000000Gz1g-0DiN;
	Mon, 03 Aug 2026 12:02:19 +0000
Received: from out-189.mta1.migadu.com ([95.215.58.189])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqrN2-0000000Gz0z-2vst
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 12:02:18 +0000
Message-ID: <d5513f7a-6a69-44ad-ab3a-095cba0d1cb8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785758532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52EZk8YPwTy+jG8rvfx/kfwJ0amdCbdlhZF4BPxa9n0=;
	b=EnouUtAwmdUyiYMkNZYeTEKz+AWGqvGLFPzrRg2VSPbHDC6HVF7FROS4eLHrg3gT8tooRk
	rig62DQPA5EaSsWXf6iA3G0v/XDaJ6BmV1oe49+5hzRGn2f3z2n2yirXt1Il6HlfYyxdck
	yb7BufJLbG3lqJtL+aY1dN0OwdZGnlw=
Date: Mon, 3 Aug 2026 20:00:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
To: David Howells <dhowells@redhat.com>
Cc: =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
 Baoquan He <baoquan.he@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Coiby Xu <coxu@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 keyrings@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 Tao Liu <ltao@redhat.com>
References: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
 <20260731154608.153258-1-linux@jaseg.de> <am38qk60mpVFuJRi@MiWiFi-R3L-srv>
 <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
 <2490025.1785751199@warthog.procyon.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dave Young <ruirui.yang@linux.dev>
In-Reply-To: <2490025.1785751199@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_050216_946192_731D53FC 
X-CRM114-Status: GOOD (  10.93  )
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

On 8/3/26 5:59 PM, David Howells wrote:
> Dave Young <ruirui.yang@linux.dev> wrote:
> 
>> Cleaning up secret data can be done with makedumpfile + eppic scripts (see
>> the manual of makedumpfile), or it is even possible to do so in kdump kernel
>> with Tao Liu's improvments for makedumpfile previously (I don't know the
>> status, probably dropped for the time being, but it is possible, cced him).
> 
> Does this represent a leak of the secrets?  Also do governmental
> standardisation bodies have opinions on what constitutes a leak?

It depends, for the crash case I'm not against to clear sensitive data, the
concern is to avoid extra complexity of logic pre-kdump.   Which
government?  Sorry I can not answer here.  

> 
> David
> 


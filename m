Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D23C0218A
	for <kexec@archiver.kernel.org>; Fri, 31 Jan 2025 01:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EweZ6dX4TOqLaZ7/jsdXd0hq7l0Zj/VRiZSC1hJuhCA=; b=tJ+4m+Es4LJ8FiwAGGqtUjguZy
	ZucRBKsEndpfI2725vO/tJYuE+WAX1jcTz2V799MxxZ+sp998A/uxDdiHv8MP21bw0de3Q7yJxZT6
	zpIP/Q6XIT/pbXWx8LQLeqeE4bXdpAKNA/lHiSHdmQDd8WQUWiaxf9Ge3Dslki+Eqq0PSPntgVvIx
	kQqlFVSOnTTD7m9Z2C5naQ7PfWjEQtui/WwXMVQ0G5mHB1Q8B56UKXI7E6aTljUDKRaN9oOqdh7KM
	WlMrZte7xxmXRcOdZZSDcvWYLmAx1hQH7kx5CQu0r9XaZd8gFodwkWJdMOTNAaM/YCCeqvTAuY/ZE
	zBflEBOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdfQH-00000009s8m-37by;
	Fri, 31 Jan 2025 01:02:17 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdfQF-00000009s8O-43pI
	for kexec@lists.infradead.org;
	Fri, 31 Jan 2025 01:02:17 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Ykd054JrCz6CmM6f;
	Fri, 31 Jan 2025 01:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738285330; x=1740877331; bh=EweZ6dX4TOqLaZ7/jsdXd0hq
	7l0Zj/VRiZSC1hJuhCA=; b=RxcBfOX5SayNT6SbgCre0JcHI+LNsiWdpajejs3m
	quXvn62+IyDpr3ZPzeTrEX6vFx50choJIpTDgpNbscqhHen+55rQhYJ+amYMv9de
	3F9NpqbgtSWrtX4HMQTsNH67Xs8zaGeOBNDmZWPp7ZZ9aFb1UZqktm6EkXFh/P8E
	fRRfpBu+V5/PrBEMcWtk5LSCDcnO5BYPAXFFUcDQvny65sZ9EuaWqbwG7PUSiTee
	ncRoM2X4jO9utfcWNMVzbssEAhQVne6PISt6gDxFCyQKEIg0EGf1gbc6fcLRQTxc
	L4yWILb+OeeIfPiaOMb15a3mVqEMBbwlnMtuEwFIG8hwuA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Q457ksNJtRJS; Fri, 31 Jan 2025 01:02:10 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Ykd014ys1z6CmQwN;
	Fri, 31 Jan 2025 01:02:09 +0000 (UTC)
Message-ID: <9f3dac06-1329-43d0-89c7-6888d2c96bd2@acm.org>
Date: Thu, 30 Jan 2025 17:02:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] procfs: Fix a locking bug in a vmcore_add_device_dump()
 error path
To: Andrew Morton <akpm@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 David Hildenbrand <david@redhat.com>
References: <20250129222003.1495713-1-bvanassche@acm.org>
 <20250130020209-mutt-send-email-mst@kernel.org>
 <20250130155843.05418f6dacfc094c7cc587fb@linux-foundation.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250130155843.05418f6dacfc094c7cc587fb@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_170216_039856_4563D4BF 
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

On 1/30/25 3:58 PM, Andrew Morton wrote:
> On Thu, 30 Jan 2025 02:02:38 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Wed, Jan 29, 2025 at 02:20:03PM -0800, Bart Van Assche wrote:
>>> Unlock vmcore_mutex when returning -EBUSY.
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Fixes: 0f3b1c40c652 ("fs/proc/vmcore: disallow vmcore modifications while the vmcore is open")
>>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> This applies to patches which are in linux-next via your tree (I
> think), so I'll take the above to mean "thanks, applied" ;)

Is my understanding correct that the commit fixed by this patch made it
into Linus' tree a few days ago?

$ git log --after=2025-01-26 --before=2025-01-27 origin/master | \
     grep 0f3b1c40c652
commit 0f3b1c40c65262a216fb459fd375f39442a5138b

Thanks,

Bart.


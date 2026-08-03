Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDA8C55184
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-ID:Content-Type:
	Message-ID:Date:MIME-Version:Subject:Cc:To:References:In-Reply-To:From:
	Reply-To:Content-Transfer-Encoding:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wSbzfg+WF8irzWdRDzhVCU6AXptOY9bPmk0b+GI3hig=; b=1lpv/zMUEoGrDaHVopBE9L2m+V
	Cha8y+5WA9caMWyzTxgEpt+oq5xMypAGAHW/CJSJxVRqY112xe2fTJjfmLSdVNkkH68ToqQIZ/RSR
	4sqhioJMKEaRzlZkFT40u8kFFuPhq0NcwaGY6t+WTebKmZfRvLIq85XM4lbmbehl0pnafeCMAjEHq
	FmIsoVbfTZdqBmhw9OA25opyQ3xcgicxQVKW1qhvqV3DAKtiyNhwEWroRawwePnZSRlY72/V3v7sB
	o1sRJD8iLxTvLSSapoPAL8G5OPS2ZhfUbkpulFPA7/DjKnJQejMRKM5gSasURM9tXZ1WO//7Uo1xS
	oSLgU65w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqpTA-0000000GljU-2Ogk;
	Mon, 03 Aug 2026 10:00:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqpT8-0000000Glj3-1TtJ
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 10:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785751223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSbzfg+WF8irzWdRDzhVCU6AXptOY9bPmk0b+GI3hig=;
	b=gJUDoLiydIIMj4BfCHAVTm2/ybhP9UeHIyUpp0J/nrn2uv8CbD60hAGu5KAulshVycwX2O
	hC9TKrs/idcaq7iYTfKsOqtwA11XbuqDFQKF4gouQAs9EQ/YvKsP/vuHOTLM9WIb1TxR3m
	EtdUhMUAXyUG2PXytL0kSv4teLVsEkA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-5OgXQmzJOZ-Z3BY2OCUC2A-1; Mon,
 03 Aug 2026 06:00:19 -0400
X-MC-Unique: 5OgXQmzJOZ-Z3BY2OCUC2A-1
X-Mimecast-MFC-AGG-ID: 5OgXQmzJOZ-Z3BY2OCUC2A_1785751216
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F46519560B4;
	Mon,  3 Aug 2026 10:00:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B1301800480;
	Mon,  3 Aug 2026 10:00:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev>
References: <79610b53-5201-4af3-913a-0c4dcbb6f9d6@linux.dev> <20260731154608.153258-1-linux@jaseg.de> <am38qk60mpVFuJRi@MiWiFi-R3L-srv> <74625f78-15ea-439f-b9f0-939d2976fa7f@jaseg.de>
To: Dave Young <ruirui.yang@linux.dev>
Cc: dhowells@redhat.com,
    =?UTF-8?Q?Jan_Sebastian_G=C3=B6tte?= <linux@jaseg.de>,
    Baoquan He <baoquan.he@linux.dev>,
    Andrew Morton <akpm@linux-foundation.org>,
    Mike Rapoport <rppt@kernel.org>,
    Pasha Tatashin <pasha.tatashin@soleen.com>,
    Pratyush Yadav <pratyush@kernel.org>,
    Jarkko Sakkinen <jarkko@kernel.org>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E. Hallyn" <serge@hallyn.com>,
    Mimi Zohar <zohar@linux.ibm.com>,
    James Bottomley <James.Bottomley@hansenpartnership.com>,
    Rob Herring <robh@kernel.org>,
    Saravana Kannan <saravanak@kernel.org>, Coiby Xu <coxu@redhat.com>,
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
    kexec@lists.infradead.org, keyrings@vger.kernel.org,
    linux-mm@kvack.org, linux-security-module@vger.kernel.org,
    linux-integrity@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCH 0/4] CRASH_ZEROIZE: Wipe secrets before kdump
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 10:59:59 +0100
Message-ID: <2490025.1785751199@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 0LpeocheHDMSTLTO1LV8ZspHMWEYAsj1-0V81C4Aly0_1785751216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2490024.1785751199.1@warthog.procyon.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_030026_469923_D7D0EB1A 
X-CRM114-Status: GOOD (  15.18  )
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

Dave Young <ruirui.yang@linux.dev> wrote:

> Cleaning up secret data can be done with makedumpfile + eppic scripts (see
> the manual of makedumpfile), or it is even possible to do so in kdump kernel
> with Tao Liu's improvments for makedumpfile previously (I don't know the
> status, probably dropped for the time being, but it is possible, cced him).

Does this represent a leak of the secrets?  Also do governmental
standardisation bodies have opinions on what constitutes a leak?

David



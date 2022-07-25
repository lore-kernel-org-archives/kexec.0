Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6EFC433EF
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 10:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:MIME-Version
	:Subject:Cc:To:References:In-Reply-To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BhbOcuE91uL0g2FmyveI1bTHOrn+zR/Y6i4U21Wl2LU=; b=EE+fha2AOGhRVW
	YUTYUIf08RDxOw6H6qbMYxNndo+IcgBN5gWUnh5Y3qx2C8qqhj0PiW4qdpgQnCrd/P20kKbkWUMPj
	Lntq3X58Da5Jdnq4PcPaPdAPxEvyqSOuooCPl4Ud5UZo4qUn+Y8dEvDLe7XfrStlb1HmaORWXNS6J
	bw1AHTdZZlCFLMrjrsTa568YUg2DXgbcPFd8vi86KC3miJdqlfETDyCDlw4yf9nu8csXYywPts69+
	FtGmWjwA79IIVUjdDCJp9/UhtuUlusM7SCgNHcNgqqgUqdlJJl3JpVqhBfqG3lh4ZXAC6/MsCR0Ew
	nEZ1idbcVzhVa7PBHDYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFvk7-008WqU-58; Mon, 25 Jul 2022 10:55:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFvk5-008Wli-0R
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 10:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658746514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73TJkuj66rI8i79ddEyS/Vt1Sy1WWMqNacac5Cb+Gx0=;
	b=gkSuaUCu9B3sJqUlWCwNub19uGuHM5VsxoWyUN0eI5556dfGYR/wLIwH/p8CNMRNORQ9NP
	+CTBrZFTqx6wLpO7F+mVRXA1BpHvjAw6WwsrrFmFvTMJoarg6WFsDwZqApEz46knWw43i/
	l6onNzdsARY0gK/aGrIPKHpgZZAuQ48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-qR4FMCCrNXuPS6LJvhdcnQ-1; Mon, 25 Jul 2022 06:55:11 -0400
X-MC-Unique: qR4FMCCrNXuPS6LJvhdcnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02DDA8032FB;
	Mon, 25 Jul 2022 10:55:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B6FDEC28118;
	Mon, 25 Jul 2022 10:55:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv> <20220721015605.20651-1-slark_xiao@163.com>
To: Baoquan He <bhe@redhat.com>
Cc: dhowells@redhat.com, corbet@lwn.net, Slark Xiao <slark_xiao@163.com>,
    vgoyal@redhat.com, dyoung@redhat.com, ast@kernel.org,
    daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
    song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
    kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
    jolsa@kernel.org, william.gray@linaro.org, peterz@infradead.org,
    mingo@redhat.com, will@kernel.org, longman@redhat.com,
    boqun.feng@gmail.com, tglx@linutronix.de, bigeasy@linutronix.de,
    kexec@lists.infradead.org, linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
    linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
MIME-Version: 1.0
Content-ID: <2778503.1658746506.1@warthog.procyon.org.uk>
Date: Mon, 25 Jul 2022 11:55:06 +0100
Message-ID: <2778505.1658746506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_035517_168191_BAB3BDE2 
X-CRM114-Status: GOOD (  13.47  )
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

Baoquan He <bhe@redhat.com> wrote:

> sed -i "s/the the /the /g" `git grep -l "the the "`

You might want to clarify the first "the" with a preceding boundary marker.
There are some English words ending in "the" that can be used as verbs, though
I'm not sure you'd find any of them here - clothe for example.

David


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

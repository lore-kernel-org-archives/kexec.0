Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1AFC4829A
	for <kexec@archiver.kernel.org>; Sat, 10 Feb 2024 04:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/eVozhgoDiMzprjcWFQDjr7Aw2yw70g71WX0Ut+8hlQ=; b=iDNx4HpgDIXdTH
	ofKswWT2bnDEvLf8cW61coRGXeT/3AI2K5nxK9aWmoDEBYDIl/UIg3DrsHsDwFSPkK7oVkC+yq024
	oiF/Hg7Y4Wz/t9GKuJjZO7H8VljVcTyOOR2xJqDkJhBKa4VOLyFU9Kbb8FcjsVs9xC+ynxJyzgEFX
	is/oYTiYsA7ygaeLGIimpnM6AhlZVCXDg1EfWFrAqpcfoaXce5A6gbx4IzC2bWiOdhsTeUrE9ZrW1
	l1pThPj/qoMD4ityV5TYkbkswaOnDTQndLL+sOnjzPVjgtotyioSaoekKkieSDvnd3bxTPW4uKBCl
	vC0NBHF06Yquuijtzi0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYfKz-00000001DMQ-0yYm;
	Sat, 10 Feb 2024 04:51:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYfKv-00000001DLx-3KMa
	for kexec@lists.infradead.org;
	Sat, 10 Feb 2024 04:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707540691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ro8rUn2VeTdW1n/4yHjYsv5KEEL3rbmZwbel3sqRTQg=;
	b=IkrYXTA8J+YEPgk31iXSiS/w+Be5fhrf+sQeXMojLiFvWBU7zhvJkfdFH86MhFTbrwAWvu
	cXjvy2sg4bYAz3SxCPw1o/4A+n8USXORRMdF3CdP4pN4bBgVoSKtYXdexRrqiKBbr8QYU6
	BKapl8GeNB07t6TjPezHiSEFssiuCAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-4iDbVx2BN9uxqJO_PVzkBQ-1; Fri, 09 Feb 2024 23:51:25 -0500
X-MC-Unique: 4iDbVx2BN9uxqJO_PVzkBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 485B4811E79;
	Sat, 10 Feb 2024 04:51:25 +0000 (UTC)
Received: from localhost (unknown [10.72.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E98AC1D;
	Sat, 10 Feb 2024 04:51:23 +0000 (UTC)
Date: Sat, 10 Feb 2024 12:51:21 +0800
From: Baoquan He <bhe@redhat.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
	Kexec-ml <kexec@lists.infradead.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
Message-ID: <ZccAyalp+NyKQoGp@MiWiFi-R3L-srv>
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
 <ZcZ6myvln-v0Y98S@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZcZ6myvln-v0Y98S@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240209_205133_928924_F92EA853 
X-CRM114-Status: GOOD (  11.04  )
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

On 02/09/24 at 11:18am, Stanislav Fomichev wrote:
> On 02/09, Hari Bathini wrote:
> > With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> > to the below warning:
> > 
> >   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> > 
> > Fix it by using the appropriate #ifdef.
> 
> Same question here: how did you find this particular kconfig option
> (CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
> in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
> existing ifdef seems correct?

This patch is based on the latest next tree, I have made some changes to
split the crash code from kexec_core.c. If you check next/master branch,
crash_kexec is not in kernel/keec_core.c any more.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

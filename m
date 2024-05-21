Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80CFC25B77
	for <kexec@archiver.kernel.org>; Tue, 21 May 2024 03:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O6RDPDdDq/fD2GkvkakoumErRyrVFmJiehwvISX03h8=; b=HJVqDOknyQmfDE
	lo3lmZZUnjnhBVtOONje4NhVUahKNJB0rUpE9Boa/6sWlr+tWFq6MninQPZUKuwgyyP74bWugK1Bo
	6fU4Ck2HAY/rGhfL9PMc+MBeZ0pTiuPF5n5+A0qDmKDQnI9+gw8qWvrTRzC2k4w5B9zflVqVakk0Z
	JQAiEGcjV5wVt+IfRE3w/13HgmZTajEAQQuTyNgq7J/JzeZOOHMgILeNNOo9jPWQ1BSwMw6oDECZy
	LeS9a2MAKfmG/qSNX5nX7It4KGnYcsKyUA6vJuoDraRRbFxONoMnHcMYqkbeXSr8EYSZYXLEeNohu
	Z0BVT23cuFcGA/B8G3Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9G2u-0000000GAyG-0ExA;
	Tue, 21 May 2024 03:20:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9G2p-0000000GAvr-2xBg
	for kexec@lists.infradead.org;
	Tue, 21 May 2024 03:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hOmz1H0+MMWbfr1lFiKOcLjgn2XgwhPLxYAWmTnPe74=;
	b=J/jFYeyR1Byj5ZFdSZFjc4vX8LXsOXNCK2eBNgrDKdwdb1xddgDByfT5guELN+FLLdhTZA
	34XwsUDZxOxOvZ7bEecV3ViquwhZX1N4zx1TJh12a/euvDUQ6cS6cyGwlS45PQ8FzC0sC/
	pCPKyn+tYvJvLVDLQqXRct6HWsorutc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-32LAG1HHPKSOFakPszE3fw-1; Mon,
 20 May 2024 23:20:02 -0400
X-MC-Unique: 32LAG1HHPKSOFakPszE3fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3EB129AA393;
	Tue, 21 May 2024 03:20:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C29E45618;
	Tue, 21 May 2024 03:20:00 +0000 (UTC)
Date: Tue, 21 May 2024 11:19:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <ZkwS3UNmjTkK2HeY@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
 <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_202007_863074_964D4E16 
X-CRM114-Status: GOOD (  18.40  )
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

On 05/21/24 at 09:43am, Coiby Xu wrote:
> On Mon, May 20, 2024 at 02:18:09PM +0800, Baoquan He wrote:
> > Please don't add dm-devel@redhat.com in the public list because it's a
> > internal mailing list or aliase. And I got error when replying.
> 
> Thanks for the reminder! Actually it's a public mailing list and you
> can find all emails publicly listed on [1]. I did some research and it
> seems we should email to dm-devel@lists.linux.dev instead. Quoting [2],

I always got this when replying to your patch. Maybe you registered
before.

msmtp: recipient address dm-devel@redhat.com not accepted by the server
msmtp: server message: 550 5.1.1 <dm-devel@redhat.com>: Recipient address rejected: User unknown in local
recipient table


> > To post a message to all the list members (who were subscribed with
> > mail delivery enabled as of 2023.10.20), send email to
> > dm-devel@lists.linux.dev.  You can no longer subscribe to
> > dm-devel@redhat.com, to subscribe to dm-devel@lists.linux.dev please
> > send email to dm-devel+subscribe@lists.linux.dev.
> 
> [1] https://lore.kernel.org/dm-devel/
> [2] https://listman.redhat.com/mailman/listinfo/dm-devel
> 
> -- 
> Best regards,
> Coiby
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

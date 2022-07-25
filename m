Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC06C433EF
	for <kexec@archiver.kernel.org>; Mon, 25 Jul 2022 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AwJ6xn8zdcGHpTM7r0s66daXukecpf4sdoECYI6OfaQ=; b=eM1JfyXYj3OYUg
	oLrq/41+BODGQXF1MgdR7VRS7WysMqS+r4kMj+pN8Lmp8fokL6oZl1CF3xGXmAesnDIFQNLZF32mL
	AdDBKEtVMtOCrUE94SrcU5no6muuIMGIbBJBuQUk6dZAScKQwLavZ4JdA9ri3k0urgdvY5Yy+kc/x
	ModN7aeTaVTSmdkLBH+Sak5Emi0wLlq1+XJxmm0bhBowlf4iM7H8Zr+Rz1XUVlYCxGmMD1lwnVb3z
	4nYefc93izwphZHxKQz2xyX3/qWbKjGbGH8CrCbjrTzRuOp+z7P8UvbKuD/FLUl+DbNbiswRg8uFB
	/eOtOXZc6k9V1vEpA/2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyC6-00A24B-BH; Mon, 25 Jul 2022 13:32:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oFyC3-00A228-Hs
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 13:32:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1658755938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyZo0WxiL5oXBoeMfzl8+8hKmuMVqE5C0/+Gga0ddkY=;
	b=XQs0JX89LTBk6iUh0AgqBY8LkxnQ+7tI/W7abJQxJqdxEsA/FZ8RSd4DzEIIT2PeGug7Qi
	R2iwi0zAN1igzsOws3/OaxjXOe4+2qCPDTOQtCk/69H/RW8S3o0IkGdi8MjO+tAX6oPMNR
	NG+cne6XEd1/dMf37MFd6ITubWPDWEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103--Zr6J0TZO1qRWRxqH02CyQ-1; Mon, 25 Jul 2022 09:32:10 -0400
X-MC-Unique: -Zr6J0TZO1qRWRxqH02CyQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87EE980418F;
	Mon, 25 Jul 2022 13:32:08 +0000 (UTC)
Received: from localhost (ovpn-12-90.pek2.redhat.com [10.72.12.90])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 841DB40E80E0;
	Mon, 25 Jul 2022 13:32:07 +0000 (UTC)
Date: Mon, 25 Jul 2022 21:32:04 +0800
From: Baoquan He <bhe@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: corbet@lwn.net, Slark Xiao <slark_xiao@163.com>, vgoyal@redhat.com,
	dyoung@redhat.com, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	william.gray@linaro.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	tglx@linutronix.de, bigeasy@linutronix.de,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: Re: [PATCH v2] docs: Fix typo in comment
Message-ID: <Yt6bVIoRa0nIvxei@MiWiFi-R3L-srv>
References: <YtlyDZEsOZHt6tRs@MiWiFi-R3L-srv>
 <20220721015605.20651-1-slark_xiao@163.com>
 <2778505.1658746506@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2778505.1658746506@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_063219_736857_8D7EDADA 
X-CRM114-Status: GOOD (  12.12  )
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

On 07/25/22 at 11:55am, David Howells wrote:
> Baoquan He <bhe@redhat.com> wrote:
> 
> > sed -i "s/the the /the /g" `git grep -l "the the "`
> 
> You might want to clarify the first "the" with a preceding boundary marker.
> There are some English words ending in "the" that can be used as verbs, though
> I'm not sure you'd find any of them here - clothe for example.

Right. I plan to split this big one into patches corresponding to
different component as Jonathan suggested, and will consider how to mark
the first 'the' as you suggested, and wrap Slark's pathces which
includes typo fix of "then the".

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

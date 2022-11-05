Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698E8C4332F
	for <kexec@archiver.kernel.org>; Sat,  5 Nov 2022 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wTTy8n0OXv3fWficjsfxBqPeogz3s1y1ONY8iFU5a94=; b=3dSdwP2pSs/s7q
	SqG6rCp0l2+wV+S9DcWJits8XCiSLZhTv08KpcOQEOdBmdRK3WTMxFcsp7y82lBtSr+J5UWYUqXPw
	Og1Sb+p6JdnSZyN178Ay+PBWk8xVmG0g7jV5fgOjz5dVtyNryXTzJjtIkU+Z1i1jiFxoakmz+Md2U
	GY5mFr7ySDdu7XjQsAATmBSyFocLMiGZ1Y4wtPLBdZ15yg1gRi0c9l7p/XXRPrjcnXY/+jMPNxy/o
	8mA09mx/4MkwkhOTeNnsZ7FV/ePCLB8a0/1Ra5zvxslDecclszQGXWou3fhNlPbw964JHCvfys33C
	MZrVPKc3x5Hx/8b9M3pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or8Jr-005iYg-Ul; Sat, 05 Nov 2022 01:49:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1or8Jo-005iXT-IR
	for kexec@lists.infradead.org; Sat, 05 Nov 2022 01:49:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1667612993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQoLp9xA++Cf2825fhwYlVXuPuDSBqU1eW87N+RAla4=;
	b=XEqMLCPNlWGme8bf7FIjlNKzfp7Zd7PzdK6fu8OyXZzhNycgK+rqkHWUt8bPZxmK6HXgRe
	2Z+k9TBHrbVe4nGeqtTG5gnNCBkiWtQtnDb2fOhTyAd08CPzR6CiTzP3qhTN25BcPcVBlP
	4M6dYMqQMl58tRSLkrPufHjNxl+OVjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-UOPRFcpCMci4j9UHkWtzrw-1; Fri, 04 Nov 2022 21:49:49 -0400
X-MC-Unique: UOPRFcpCMci4j9UHkWtzrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A8EA85A583;
	Sat,  5 Nov 2022 01:49:49 +0000 (UTC)
Received: from localhost (ovpn-13-134.pek2.redhat.com [10.72.13.134])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B0A71C2C8D9;
	Sat,  5 Nov 2022 01:49:48 +0000 (UTC)
Date: Sat, 5 Nov 2022 09:49:44 +0800
From: Baoquan He <bhe@redhat.com>
To: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: where/how 2nd kernel's elfcorehdr_addr comes from
Message-ID: <Y2XBOErUs8qQE0Ki@MiWiFi-R3L-srv>
References: <72d4be26-1711-aab8-50ed-8af538b4f6eb@fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <72d4be26-1711-aab8-50ed-8af538b4f6eb@fujitsu.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_184956_723172_56D789D9 
X-CRM114-Status: GOOD (  16.22  )
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/04/22 at 09:03am, lizhijian@fujitsu.com wrote:
> Hi folks,
> =

> I'm trying to add pmem's metadata(located at pmem device) to =

> /proc/vmcore. To accomplish this, I think
> =

> something i need to know is where the contents of /proc/vmcore come =

> from, and then append
> =

> something into it.
> =

> I have read =

> https://opensource.com/article/17/6/kdump-usage-and-internals, and knew =

> /proc/vmcore is a elf file.
> =

> It mentioned that "Creates /proc/vmcore as per elfcorehdr information =

> received", but i don't get how it
> =

> elfcorehdr(maybe elfcorehdr_addr) be assigned in 2nd kernel.
> =

> I tried to grep it in the kernel source, but still no answer.=A0 So i dee=
p =

> hope you guys can give me some hints or answer.

Since you have studied this, so:
crash_prepare_elf64_headers() is the place where elf header of vmcore is
contructed in 1st kernel. And in crash_load_segments() it's prepared to
be passed out. I am talking about x86, and kexec_file load. You should
be able to find the similar thing in user space code.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F03ECCFA05
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 01:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOE3+WNCmO2l7emNZOVxTGcMy/4xRS0btLplCRQG9Sg=; b=qUQwoBbvZxwyadTW6q+PVLJsSa
	xARK5MU6YNOyPeNDvvIbfYNHMR4Z47TUl4luRdHZbPM6C0MNppUVsapQU4g6zr7ixMS5TkdUt1+yD
	N8WtcLDqGhGW27QVwVSvGx/nBvAgZSSTamhIOpNcWEwuwHMpGOqiUkJijXNmGBvfX8bFhlb5SUVUG
	NVMj/aJFVIdu4ILlp8yJ08W6F5WRoizY7WsywlfB5AZt2ybREATIyWp2xekPhprpyu09uhcqnQlIf
	I6ZEpx+3/MOW1im1VPTlm7+AO7S75jxoOkHzZC8ZIFVoOTDhBuoCpQP/S2cfWoyPdUy9UVUnW1sH3
	6G5abSQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBdK-0000000GXQO-0cNL;
	Fri, 07 Nov 2025 01:51:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHBdF-0000000GXPx-3sG3
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 01:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762480276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOE3+WNCmO2l7emNZOVxTGcMy/4xRS0btLplCRQG9Sg=;
	b=eRqfkIPBEmsv+hDDlvx9uwGmkIHI7PNIRDLSUW6pix3aRoQNglq8NmmRcDctxVeftPxQXA
	uTAs8ZfOY0nebQMrVS8trQfkblg6ojc9sXW3/HQvG77XdavZKwfsuvNw+d2l530t5dQC9n
	V5bba0cBIYXr+wlgDFvg+pDijo0IXT4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-CZ1givntP2GQytu_CEziNw-1; Thu,
 06 Nov 2025 20:51:13 -0500
X-MC-Unique: CZ1givntP2GQytu_CEziNw-1
X-Mimecast-MFC-AGG-ID: CZ1givntP2GQytu_CEziNw_1762480271
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80CD81800358;
	Fri,  7 Nov 2025 01:51:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DC881945110;
	Fri,  7 Nov 2025 01:51:08 +0000 (UTC)
Date: Fri, 7 Nov 2025 09:51:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
 <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_175118_059801_432394A5 
X-CRM114-Status: GOOD (  16.10  )
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

On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> On Thu, Nov 6, 2025 at 4:01 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > When I tested kexec with the latest kernel, I ran into the following warning:
> > >
> > > [   40.712410] ------------[ cut here ]------------
> > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > [...]
> > > [   40.816047] Call trace:
> > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > [...]
> > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > >
> > > This is caused by the fact that kexec allocates the destination directly
> > > in the CMA area. In that case, the CMA kernel address should be exported
> > > directly to the IMA component, instead of using the vmalloc'd address.
> >
> > Well, you didn't update the log accordingly.
> >
> 
> I am not sure what you mean. Do you mean the earlier content which I
> replied to you?

No. In v1, you return cma directly. But in v2, you return its direct
mapping address, isnt' it?

> 
> > Do you know why cma area can't be mapped into vmalloc?
> >
> Should not the kernel direct mapping be used?

When image->segment_cma[i] has value, image->ima_buffer_addr also
contains the physical address of the cma area, why cma physical address
can't be mapped into vmalloc and cause the failure and call trace?



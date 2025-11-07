Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C4CCFA05
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 05:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIpaacKZHnJUNIQ6uKG4gx1AM30s80yCIKhtIRTzyv0=; b=TFt8Q42gaatalWqNq9so9P6i1J
	sq1CWaz9qJMJDAc32Gc8+kmySVjV/AMoDjdIa/5TYFAj31RPbnS2KgqAg19qI54wYUtTSeYElrS77
	SbhO4wGWqzbFpUleNu1HsoHVc3xF1isRneaKjO9Div3cGcz9wSPhlX0uXXPd1x8K697I/TYw4ikOW
	G3dQldVQJH4qjhXceDLg1XfX55vMH3jtRoL66l/wjmJTwzCFRsb0uW2+VsgYlQrzmV7klY72hw6B+
	C5330DnAc9S2TORN3XX+tf7D/nTK+h8Hkx3bgfFpWsrS/pgyVeVxxsAK259tmnETwFX33igGsvRs9
	kXfkw6JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHEz3-0000000GgoG-0A4n;
	Fri, 07 Nov 2025 05:26:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHEyz-0000000Ggnr-1jEy
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 05:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762493154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIpaacKZHnJUNIQ6uKG4gx1AM30s80yCIKhtIRTzyv0=;
	b=DArbjkgc2YyKn1WNfy79XsGHk3V/KAO+Yz+KGKNRW8eXURkZTZqJLD/TywklX1IrORYWeI
	14YCSJzSfrjMsQy4ffLIGfkGFuL4mBKNuJwJMXQUEyPwx6fWXdxe2j04V6+55bYktF1xkN
	AE3zOaD811izKjX/zXHEpSNUyoSterk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-Ga0bJ94AOjqLafsq0-eLSg-1; Fri,
 07 Nov 2025 00:25:51 -0500
X-MC-Unique: Ga0bJ94AOjqLafsq0-eLSg-1
X-Mimecast-MFC-AGG-ID: Ga0bJ94AOjqLafsq0-eLSg_1762493149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60FAD19560A7;
	Fri,  7 Nov 2025 05:25:48 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 839681945110;
	Fri,  7 Nov 2025 05:25:46 +0000 (UTC)
Date: Fri, 7 Nov 2025 13:25:41 +0800
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
Message-ID: <aQ2C1UyJoyyuC/ZK@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
 <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
 <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
 <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_212557_528587_25C8116C 
X-CRM114-Status: GOOD (  25.11  )
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

On 11/07/25 at 01:13pm, Pingfan Liu wrote:
> On Fri, Nov 7, 2025 at 9:51 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> > > On Thu, Nov 6, 2025 at 4:01 PM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > > > When I tested kexec with the latest kernel, I ran into the following warning:
> > > > >
> > > > > [   40.712410] ------------[ cut here ]------------
> > > > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > > > [...]
> > > > > [   40.816047] Call trace:
> > > > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > > > [...]
> > > > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > > > >
> > > > > This is caused by the fact that kexec allocates the destination directly
> > > > > in the CMA area. In that case, the CMA kernel address should be exported
> > > > > directly to the IMA component, instead of using the vmalloc'd address.
> > > >
> > > > Well, you didn't update the log accordingly.
> > > >
> > >
> > > I am not sure what you mean. Do you mean the earlier content which I
> > > replied to you?
> >
> > No. In v1, you return cma directly. But in v2, you return its direct
> > mapping address, isnt' it?
> >
> 
> Yes. But I think it is a fault in the code, which does not convey the
> expression in the commit log. Do you think I should rephrase the words
> "the CMA kernel address" as "the CMA kernel direct mapping address"?

That's fine to me.

> 
> > >
> > > > Do you know why cma area can't be mapped into vmalloc?
> > > >
> > > Should not the kernel direct mapping be used?
> >
> > When image->segment_cma[i] has value, image->ima_buffer_addr also
> > contains the physical address of the cma area, why cma physical address
> > can't be mapped into vmalloc and cause the failure and call trace?
> >
> 
> It could be done using the vmalloc approach, but it's unnecessary.
> IIUC, kimage_map_segment() was introduced to provide a contiguous
> virtual address for IMA access, since the IND_SRC pages are scattered
> throughout the kernel. However, in the CMA case, there is already a
> contiguous virtual address in the kernel direct mapping range.
> Normally, when we have a physical address, we simply use
> phys_to_virt() to get its corresponding kernel virtual address.

OK, I understand cma area is contiguous, and no need to map into
vmalloc. I am wondering why in the old code mapping cma addrss into 
vmalloc cause the warning which you said is a IMA problem. 



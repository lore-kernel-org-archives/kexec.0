Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043D7C4332F
	for <kexec@archiver.kernel.org>; Thu, 13 Oct 2022 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xLrAdBfv0ApW3Df+hbbBu0CRGpL9B0kGGnRY38B8o4Y=; b=skFdQQ6fy1mktO
	+ourCw72A/IgdnVwczmhngdtjVtw9M4U+CZDks7RVCGOLUwwDwVv0NP0Tj3l67aBsC+etkOnAP0kI
	K3fXQew6irMT5mVKY2Fkahj1QVw0wCt6fcrKCM1Qx73B7L3IQxRb6iTc5jEyVBLk673vt55WGviCr
	Z/lJ6UujUZvzpegmAa7j9MjimIxBTIsduTka4hceMTsbW2zXSauHqDr3jKmXaeVh38lXoHpTZg60T
	6ZE4aFrvWEX1wLyhjrAkrmegpElfgSLHScCCEOxSStZ91sndItPivuzdbr7sDqgFX9EZy/YcwbV9/
	0dypqi2yp4fzh8lCcl+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oivkJ-00BSqj-TV; Thu, 13 Oct 2022 10:47:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oivkH-00BSpJ-G6
	for kexec@lists.infradead.org; Thu, 13 Oct 2022 10:47:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665658039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q6GB/B4JNp1TxbUrS+fPKO1tu1+KnvBnyZ+rYl22l5I=;
	b=UB1zJWvukLm3Hop5pln3kvEdaz7oZMCHS2iQc/RvQW82KuajcdLYpnsvfklP7oQXyknsjZ
	A3GjMTHzvFBWRB8flaWdsF3CLMRYPkiogefE3FNxRm/St1NLF7LJB2aWX+0/LygZidCIAe
	oiMUs6QsUHSIsJEtRx2bWH6bEEiapW4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-yo6PH1nlNbie3fsaqQq5hw-1; Thu, 13 Oct 2022 06:47:17 -0400
X-MC-Unique: yo6PH1nlNbie3fsaqQq5hw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD5181C05EAD;
	Thu, 13 Oct 2022 10:46:50 +0000 (UTC)
Received: from localhost (ovpn-12-120.pek2.redhat.com [10.72.12.120])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2C712011568;
	Thu, 13 Oct 2022 10:46:39 +0000 (UTC)
Date: Thu, 13 Oct 2022 18:46:35 +0800
From: Baoquan He <bhe@redhat.com>
To: john.p.donnelly@oracle.com, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	"samasth.norway.ananda" <samasth.norway.ananda@oracle.com>
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
Message-ID: <Y0fsi4+T6k/OO0hx@MiWiFi-R3L-srv>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <YueMyUqannVg7l9v@MiWiFi-R3L-srv>
 <a80c2b7e-a510-8e45-1f3c-7e2ddf79bc37@huawei.com>
 <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d89e2cb-de26-0f85-7a2a-f68599a1b143@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221013_034721_636051_06BCDA12 
X-CRM114-Status: GOOD (  21.10  )
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

On 10/06/22 at 09:55am, john.p.donnelly@oracle.com wrote:
> On 8/1/22 9:47 PM, Leizhen (ThunderTown) wrote:
......
> > > Do you have plan to pick this series so that it can be taken into 5.20
> > > rc-1~3?
> > 
> > Hi, Catalin:
> >    Only function reserve_crashkernel() is modified in these two patches. The core
> > process of the arm64 architecture is not affected. I remember you suggested that
> > arm64 and x86 share the same kdump code, so these two subfeatures are needed.
> > Maybe we can lay the foundation first for the people who build the road. Unifying
> > the external interfaces of kdump on arm64 and x86 does not seem to hurt.
> > 
> > 
> > > 
> > > We have back ported the basic crashkernel=high, low, support into our
> > > distros and have taken wide testing on arm64 servers, need this patchset
> > > to back port for more testing.
> > > 
> > 
> Hi ,
> 
> What is the progress of this series ?
> 
> Without this patch set we are seeing  larger crashkernel=896M failures on
> Arm  with Linux-6.0.rc7.  This larger value is needed for
> iSCSI booted systems with certain network adapters.

This change is located in arch/arm64 folder, I have pinged arm64
maintainer to consider merging this patchset. Not sure if they are
still thinking, or ignore this.

Hi Catalin, Will,

Ping again!

Do you have plan to accept this patchset? It's very important for
crashkernel setting on arm64 with a simple and default syntax.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

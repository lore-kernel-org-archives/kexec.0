Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAADAC282EC
	for <kexec@archiver.kernel.org>; Tue, 18 Mar 2025 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o9Gs8I6caiy1/fPWZYvSLm6+kkS17oGi9fBfJW9dipQ=; b=zITj6xIFumQnU80FL5Sva+l+f1
	Vmqqtwkf88tB/IT8lPlsSTkiSIB23rBlaVjUMgVQ923hEfbnbCIW7yGPBUhrEtOQc24ZsSaGc+igx
	gz+ZMZN/zSpyF7OOPCngz8nf5g0Ia8nKzE1FXuvb0ahhpClF2S2h77sn48OMaTnxGKYRAWJFzJlKC
	cL3v6J1WSKv1AoZYDePTKAG//XQ2D8d9ZPN+a8sQhQRQleitQKNFcZsEdYRoEnz79ws8W6cIkCHsb
	bCmxyMhC+SXMgDorI6D9Uh4RzBtC+zVUo5hwrGwaEZFK82ycfysoLb13j8fRHorpKY1fvzybaApxS
	GLK6+1Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tug5I-00000007LGr-3oai;
	Tue, 18 Mar 2025 23:10:56 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tufxI-00000007JP9-0kkh
	for kexec@lists.infradead.org;
	Tue, 18 Mar 2025 23:02:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1742338960; x=1773874960;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=o9Gs8I6caiy1/fPWZYvSLm6+kkS17oGi9fBfJW9dipQ=;
  b=GRh9JyZysKcHF6ChcWEPz+1wdgLRWqwxt9BZjoFu/LeY/WtZjpFBqYCX
   feabq7ETEnTmBRJS5/x/QNzo3/SjF/egfmG5E4m/znuj//4qgAViJqW0B
   hbN9Inu2VKY1feylaWTK9k/ImLiZJw62gMqKzHFeaEn0rRl6DVJdPxQxU
   s=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="706160683"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:02:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:9378]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 587d40c0-f869-4b16-8e9b-ae504ea90e33; Tue, 18 Mar 2025 23:02:32 +0000 (UTC)
X-Farcaster-Flow-ID: 587d40c0-f869-4b16-8e9b-ae504ea90e33
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:02:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D020UWC003.ant.amazon.com (10.13.138.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:02:32 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 23:02:32 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTP id 201F480140;
	Tue, 18 Mar 2025 23:02:32 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id AB4514EA8; Tue, 18 Mar 2025 23:02:31 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Christian Brauner <brauner@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Eric Biederman <ebiederm@xmission.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, "Hugh
 Dickins" <hughd@google.com>, Alexander Graf <graf@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, David Woodhouse
	<dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport
	<rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, "Dave
 Hansen" <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
In-Reply-To: <20250318145707.GX9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
	<20250307005830.65293-2-ptyadav@amazon.de>
	<20250307-sachte-stolz-18d43ffea782@brauner> <mafs0ikokidqz.fsf@amazon.de>
	<20250309-unerwartet-alufolie-96aae4d20e38@brauner>
	<20250317165905.GN9311@nvidia.com>
	<20250318-toppen-elfmal-968565e93e69@brauner>
	<20250318145707.GX9311@nvidia.com>
Date: Tue, 18 Mar 2025 23:02:31 +0000
Message-ID: <mafs0a59i3ptk.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_160240_375765_3BFBF0EE 
X-CRM114-Status: GOOD (  32.41  )
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

On Tue, Mar 18 2025, Jason Gunthorpe wrote:

> On Tue, Mar 18, 2025 at 03:25:25PM +0100, Christian Brauner wrote:
>
>> > It is not really a stash, it is not keeping files, it is hardwired to
>> 
>> Right now as written it is keeping references to files in these fdboxes
>> and thus functioning both as a crippled high-privileged fdstore and a
>> serialization mechanism. 
>
> I think Pratyush went a bit overboard on that, I can see it is useful
> for testing, but really the kho control FD should be in either
> serializing or deserializing mode and it should not really act as an
> FD store.
>
> However, edge case handling makes this a bit complicated. 
>
> Once a FD is submitted to be serialized that FD has to be frozen and
> can't be allowed to change anymore.
>
> If the kexec process aborts then we need to unwind all of this stuff
> and unfreeze all the FDs.

I do think I might have went a bit overboard, but this was one of the
reasons for doing so. Having the struct file around, and having the
ability to map it back in allowed for kexec failure to be recoverable
easily and quickly.

I suppose we can serialize all FDs when the box is sealed and get rid of
the struct file. If kexec fails, userspace can unseal the box, and FDs
will be deserialized into a new struct file. This way, the behaviour
from userspace perspective also stays the same regardless of whether
kexec went through or not. This also helps tie FDBox closer to KHO.

The downside is that the recovery time will be slower since the state
has to be deserialized, but I suppose kexec failure should not happen
too often so that is something we can live with.

What do you think about doing it this way?

>
> It sure would be nice if the freezing process could be managed
> generically somehow.
>
> One option for freezing would have the kernel enforce that userspace
> has closed and idled the FD everywhere (eg check the struct file
> refcount == 1). If userspace doesn't have access to the FD then it is
> effectively frozen.

Yes, that is what I want to do in the next revision. FDBox itself will
not close the file descriptors when you put a FD in the box. It will
just grab a reference and let the userspace close the FD. Then when the
box is sealed, the operation can be refused if refcount != 1.

>
> In this case the error path would need to bring the FD back out of the
> fdbox.
>
> Jason
>

-- 
Regards,
Pratyush Yadav


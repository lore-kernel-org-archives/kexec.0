Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AF3EB64DD
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 18:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WfHaFaFfMElzGzxiLOtdpAuTA+OqlA8/PLQBjeTATrM=; b=JI/2zMVrZ2gdRp
	a4vu080P3mTrpLAvhnhjKBwAb+RC31/H3vuqlSA9mIz5Idw7/HkZGLwG1r0NdB2eje8YhJ5dx+bW3
	Ga/9yjSgeGDL+4rOBrl32V6t3H52Q2QIMVS2t2pvrqeXU5HwKLlqI9HrvEvAwBFbTHBgjMhJ/SrOk
	l07AL0gQ5T/6yaEqrT9/gVMXqo/CtJuigAN0oQMG5sVwXD6jrBZZNxbXUJQkNtqSYIdsXpHY8ka6F
	EUbNKcCTgkfVLW5ed/lhxkoYSpSaftnwwchRhPFI/FFBPmO9diY9yS8K5Kg8oiTY/kqO00Xh96/9G
	xVUg2XdV/qRPh1JF468w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRdBK-00AbE0-0J;
	Thu, 03 Aug 2023 18:36:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRdBH-00AbDE-17
	for kexec@lists.infradead.org;
	Thu, 03 Aug 2023 18:36:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 50D8461D95;
	Thu,  3 Aug 2023 18:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2C5C433C7;
	Thu,  3 Aug 2023 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691087773;
	bh=EPrIzhnHngRmYcpriOSsv2C4b5KD1vrTxnytJvuJaq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3m576+o47BBOW0zkBUz47OGhhZvDB4sdkQTE+y7N7fCmm010mcLqCDZedn1T5ob1
	 uMwMzjE71THOEPJ9pZb0QnnZEpCheaqphUenUm7XMOyYUarNpGWAD/nmjtHMDGdout
	 oaYx3ASWxF+VsVbwvAu+kNiylGg3EpW35CMpxQIU=
Date: Thu, 3 Aug 2023 20:36:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
	ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
	rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
	lf32.dev@gmail.com, akpm@linux-foundation.org,
	naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
	bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
	seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v25 01/10] drivers/base: refactor cpu.c to use
 .is_visible()
Message-ID: <2023080320-dinner-ravine-7d18@gregkh>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-2-eric.devolder@oracle.com>
 <2023070342-human-spill-a62c@gregkh>
 <31c1393d-4285-0032-7675-737737d21f71@oracle.com>
 <6d2811f5-a5ee-a49d-012d-b519b2c6ee26@oracle.com>
 <a6dd6e27-e8a7-09ac-f33d-03318dd5695c@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a6dd6e27-e8a7-09ac-f33d-03318dd5695c@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_113615_584177_B803D0D6 
X-CRM114-Status: GOOD (  37.40  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Aug 03, 2023 at 01:20:28PM -0500, Eric DeVolder wrote:
> =

> =

> On 7/21/23 11:32, Eric DeVolder wrote:
> > =

> > =

> > On 7/3/23 11:53, Eric DeVolder wrote:
> > > =

> > > =

> > > On 7/3/23 08:05, Greg KH wrote:
> > > > On Thu, Jun 29, 2023 at 03:21:10PM -0400, Eric DeVolder wrote:
> > > > > =A0 - the function body of the callback functions are now wrapped=
 with
> > > > > =A0=A0=A0 IS_ENABLED(); as the callback function must exist now t=
hat the
> > > > > =A0=A0=A0 attribute is always compiled-in (though not necessarily=
 visible).
> > > > =

> > > > Why do you need to do this last thing?=A0 Is it a code savings goal=
?=A0 Or
> > > > something else?=A0 The file will not be present in the system if the
> > > > option is not enabled, so it should be safe to not do this unless y=
ou
> > > > feel it's necessary for some reason?
> > > =

> > > To accommodate the request, all DEVICE_ATTR() must be
> > > unconditionally present in this file. The DEVICE_ATTR() requires the
> > > .show() callback. As the callback is referenced from a data
> > > structure, the callback has to be present for link. All the
> > > callbacks for these attributes are in this file.
> > > =

> > > I have two basic choices for gutting the function body if the config
> > > feature is not enabled. I can either use #ifdef or IS_ENABLED().
> > > Thomas has made it clear I need to use IS_ENABLED(). I can certainly
> > > use #ifdef (which is what I did in v24).
> > > =

> > > > =

> > > > Not doing this would make the diff easier to read :)
> > > =

> > > I agree this is messy. I'm not really sure what this request/effort
> > > achieves as these attributes are not strongly related (unlike
> > > cacheinfo) and the way the file was before results in less code.
> > > =

> > > At any rate, please indicate if you'd rather I use #ifdef.
> > > Thanks for your time!
> > > eric
> > > =

> > > > =

> > > > thanks,
> > > > =

> > > > greg k-h
> > =

> > Hi Greg,
> > I was wondering if you might weigh-in so that I can proceed.
> > =

> > I think there are three options on the table:
> > - use #ifdef to comment out these function bodies, which keeps the diff=
 much more readable
> > - use IS_ENABLED() as Thomas has requested I do, but makes the diff mor=
e difficult to read
> > - remove this refactor altogether, perhaps post-poning until after this
> > crash hotplug series merges, as this refactor is largely unrelated to
> > crash hotplug.
> > =

> > Thank you for your time on this topic!
> > eric
> =

> Hi Greg,
> If you have an opinion on how to proceed, please provide.

Sorry, totally swamped by "stuff".  I don't know, use your judgement
here and send a new version, don't wait for me to weigh in on design
decisions for longer than a week.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

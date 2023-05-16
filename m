Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66A6C7EE22
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 01:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dxda0G2lbKGvmkBkt2OsFGtVrfwi/pAOjdlYsMJlMgE=; b=Axg/JbXpUOdCaP
	gBugfPS0koXkd+W9c6ex3cltMeErhOzm08wWYaTFtfriJ3NAOYkZ261JZ2u3tvWIZVolheBB9J4S+
	op9FkBazESlZJWx/DwkDVjpie/1cQJIlDzBv2ASJDi8EJ5LI3WOAylG260YXg7o9Q2xC5zKzAh/gl
	CgxjKwE+EWhTF2P7TvJBLWy1T4PUEsxw7Yob3XOkN+wshoSSEpsgi/J3jvfDer3esAwBlhTIqCMFA
	rKe9+J3mGrkjQt+S0RLdhbjMmjYjQ2AEf1NgQBFaBLAUs4HAK+aSK9o8rUA5grx25iwicOQ90/AGe
	xIgwt5jCjnQa/D0cqV1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjlD-0044TM-1k;
	Tue, 16 May 2023 01:45:55 +0000
Received: from irc.codon.org.uk ([2a00:1098:84:22e::2] helo=cavan.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjlA-0044SG-0R
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 01:45:53 +0000
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 7F4FC42529; Tue, 16 May 2023 02:45:49 +0100 (BST)
Date: Tue, 16 May 2023 02:45:49 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	ardb@kernel.org, James.Bottomley@hansenpartnership.com,
	luto@amacapital.net, nivedita@alum.mit.edu,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Message-ID: <20230516014549.GB5403@srcf.ucam.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <20230512112623.GE14461@srcf.ucam.org>
 <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
 <7ff17d2b-7030-fbbd-c495-b43583e3f9e7@apertussolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7ff17d2b-7030-fbbd-c495-b43583e3f9e7@apertussolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_184552_328481_5F70BF33 
X-CRM114-Status: GOOD (  20.12  )
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

On Mon, May 15, 2023 at 09:11:15PM -0400, Daniel P. Smith wrote:
> On 5/12/23 12:17, Ross Philipson wrote:
> > This is a good point. At this point it is really something we
> > overlooked. We will have to revisit this and figure out the best way to
> > find the final event log depending on how things booted.
> 
> I believe Ross misunderstood what you were asking for here. There are two
> reasons this is not possible or desired. The first reason is that on Intel,
> the DRTM log is not initialized by TrenchBoot code in the preamble. It is
> only responsible for allocating a buffer and recording the location in the
> TXT structures. When the SINIT ACM is executed, it will initialize the log
> and record the measurement that CPU sent directly to the TPM and then the
> measurements the ACM makes of the environment. If you pointed at the SRTM
> log, then the ACM would write over existing log, which I don't think you
> want. Now if you pointed at the tail end of the SRTM log, you would still
> end up with a second, separate log that just happens to be memory adjacent.

Ok. I think it would be clearer if either the function names or some 
comments expressly indicated that this refers to the DRTM event log and 
that that's a separate entity from the SRTM one, "event log" on its own 
is likely to cause people to think of the existing log rather than 
associate it with something else.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

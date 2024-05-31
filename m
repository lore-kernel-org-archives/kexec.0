Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10999C25B75
	for <kexec@archiver.kernel.org>; Fri, 31 May 2024 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=XrY+L+uaMUSWwz+ISilZ1W4TfJX5t9OUdsh0XmQTvtE=; b=Z5R9r+qQ7kmq/DfKS/bHZjEe/g
	S5ms1wziotc8ReaTuZS/0MfHAMsaQIctt6n2io3KmrTqH9LGUS4tTY61SqIGuv+NsRpUiMQSCU7jj
	90cUz8/Z6gNdAxUu+IAoaKkVb6yi1kV+cfwoPde+FVsSRvvRceXO4aZXpqxOQ0Y/Kbz0UDl9Iypm9
	rY0BvIEdqwyEuu/9+3zqfkngfg8ajPpr928bDKI9fQt/IlL7CJixB3CFC8InLCqbbaeHmx8AzqGrX
	H0Rlcslp5Vxzb8KxI+Gx1yxaTtBp3D3yTYcLmR8SUKBHv3uk369oOgRxq48TYUtcD3rXF63TiQd4Y
	UxVB/XCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2kN-0000000AQKg-2eZo;
	Fri, 31 May 2024 13:56:43 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD2kH-0000000AQIi-2zUn
	for kexec@lists.infradead.org;
	Fri, 31 May 2024 13:56:41 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:42770)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sD2jp-003KCz-6R; Fri, 31 May 2024 07:56:09 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:39510 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sD2jo-00Bi30-2x; Fri, 31 May 2024 07:56:08 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>,
  linux-kernel@vger.kernel.org,  x86@kernel.org,
  linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-crypto@vger.kernel.org,  kexec@lists.infradead.org,
  linux-efi@vger.kernel.org,  iommu@lists.linux-foundation.org,
  dpsmith@apertussolutions.com,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  hpa@zytor.com,  dave.hansen@linux.intel.com,
  ardb@kernel.org,  mjg59@srcf.ucam.org,
  James.Bottomley@hansenpartnership.com,  peterhuewe@gmx.de,
  jarkko@kernel.org,  jgg@ziepe.ca,  luto@amacapital.net,
  nivedita@alum.mit.edu,  herbert@gondor.apana.org.au,
  davem@davemloft.net,  corbet@lwn.net,  dwmw2@infradead.org,
  baolu.lu@linux.intel.com,  kanth.ghatraju@oracle.com,
  andrew.cooper3@citrix.com,  trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
	<20240531010331.134441-7-ross.philipson@oracle.com>
	<20240531021656.GA1502@sol.localdomain>
Date: Fri, 31 May 2024 08:54:21 -0500
In-Reply-To: <20240531021656.GA1502@sol.localdomain> (Eric Biggers's message
	of "Thu, 30 May 2024 19:16:56 -0700")
Message-ID: <874jaegk8i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1sD2jo-00Bi30-2x;;;mid=<874jaegk8i.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19trb9vNuHauQyjgb2/8G4ddYyfaO4Rxd0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_065637_999096_3520166E 
X-CRM114-Status: GOOD (  22.38  )
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

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>> 
>> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
>> choice of hashes used lie with the platform firmware, not with
>> software, and is often outside of the users control.
>> 
>> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
>> to safely use SHA-256 for everything else.
>> 
>> The SHA-1 code here has its origins in the code from the main kernel:
>> 
>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>> 
>> A modified version of this code was introduced to the lib/crypto/sha1.c
>> to bring it in line with the SHA-256 code and allow it to be pulled into the
>> setup kernel in the same manner as SHA-256 is.
>> 
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>
> Thanks.  This explanation doesn't seem to have made it into the actual code or
> documentation.  Can you please get it into a more permanent location?
>
> Also, can you point to where the "deliberately cap the SHA-1 PCRs" thing happens
> in the code?
>
> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
> but why would you not at least *prefer* SHA-256?

Yes.  Please prefer to use SHA-256.

Have you considered implementing I think it is SHA1-DC (as git has) that
is compatible with SHA1 but blocks the known class of attacks where
sha1 is actively broken at this point?

No offense to your Trenchboot project but my gut says that anything new
relying on SHA-1 is probably a bad joke at this point.

Firmware can most definitely be upgraded and if the goal is a more
secure boot the usual backwards compatibility concerns for supporting
old firmware really don't apply.

Perhaps hide all of the SHA-1 stuff behind CONFIG_TRENCHBOOT_PROTOTYPE
or something like that to make it clear that SHA-1 is not appropriate
for any kind of production deployment and is only good for prototyping
your implementation until properly implemented firmware comes along.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

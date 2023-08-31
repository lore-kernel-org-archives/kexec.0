Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC94C83F10
	for <kexec@archiver.kernel.org>; Thu, 31 Aug 2023 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Mime-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IdB7fgehXBvl9xpwhGpoy1HqzwxrFANQfNUFoHAjCpk=; b=nHJCt4+m1FznHj
	S5JDhpj4iIn0KamRvWxNay7OJsxu72wCP1eEqBOzyUI9MqHd/s6KAd2haf5VMONMQVoRkntH2/OL/
	Sll8KZrvPjts1u5VsMRDPt+ys544CDBrEdPTu7sYgrRvyg7n0SPvWJ2HkSTBKrRRdhi1gXgo35ZgQ
	XRwJqQwBKVl9jnm5MEp7VhCn7H4I6FEwVtYbasjVZ+XGWdI8NWkUjvNgtGXFKqrskjVjrHCxDUyzh
	nw9pQ4Hjp0R6r81QP9v0itIgmbJnFn2E5NUU/KIfx62whDCj8hHaq4XUskrve7ptnfwXU0lYcRPNi
	1J6pKcZa1z9End2m0LSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbk1C-00FXSU-36;
	Thu, 31 Aug 2023 15:55:38 +0000
Received: from wind.enjellic.com ([76.10.64.91])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbk19-00FXRp-2L
	for kexec@lists.infradead.org;
	Thu, 31 Aug 2023 15:55:37 +0000
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 37VFsPnb004307;
	Thu, 31 Aug 2023 10:54:25 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 37VFsO32004303;
	Thu, 31 Aug 2023 10:54:24 -0500
Date: Thu, 31 Aug 2023 10:54:24 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Ken Goldman <kgold@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - unseal
Message-ID: <20230831155423.GA3820@wind.enjellic.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com> <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 31 Aug 2023 10:54:26 -0500 (CDT)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230831_085535_921464_A000AD02 
X-CRM114-Status: GOOD (  18.44  )
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
Reply-To: "Dr. Greg" <greg@enjellic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Aug 30, 2023 at 03:12:39PM -0400, Ken Goldman wrote:

Good morning, I hope the day is going well for everyone.

> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
> 
> >For remote attestation to work, the service will need to know how to
> > validate the snapshot_aggregate entry in the IMA log.  It will have
> >to read the PCR values present in the template data of
> >snapshot_aggregate event in the latest IMA log, and ensure that the
> >PCR quotes align with the contents of the past UM_snapshot_file(s).
> >This will re-establish the chain of trust needed for the device to
> >pass remote attestation.  This will also maintain the ability of the
> >remote-attestation-service to seal the secrets, if the client-server
> > use TPM unseal mechanism to attest the state of the device.

> I think that seal/unseal to IMA PCRs is futile.  Since boot is
> multi-threaded, the IMA PCR is unpredictable even when valid.

Yes, unbiased observation calls into question the relevancy of the
2000-2002/Palladium model for TPM based integrity attestation, both
from a hardware and software perspective.  In addition to interference
by standard scheduling artifacts, the notion of everything being SMP
makes PCR invariancy a hopeless issue.

In fact, our trust orchestrators demonstrate that the very act of
modeling, ie computing file digests, causes an event ordering that
will be different from subsequent invocations when the digest value is
cached.  A concept that should be of no surprise to anyone fluent in
the writings of Heisenberg... :-)

We discuss this at some length, along with our proposed solution, in
the documentation that we provide with our TSEM LSM:

https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

TSEM is a superset of IMA, given that file checksums are just one of
the components in the security state coefficients that our security
modeling is based on, but the issue is the same.

Having an invariant 'security state' value also simplifies the
attestation processw, since the relying party only needs to evaluate a
single signed value in order to verify that the workload has been
consistent with its desired security model.

It is also becoming increasingly apparent that advancing the art of
integrity and trusted systems will become problematic without the
ability to 'namespace' or partition integrity on a workload by
workload basis.  We also introduce support for that with our security
modeling namespaces.

I missed copying the LSM list on my reply, but I discussed some of the
challenges that TDX, and COCO in general, raises to current integrity
infrastructures in the following thread, which should be easily
locatable on the LKML or COCO lists:

tsm: Introduce a shared ABI for attestation reports

Given our experiences, it is difficult to understand how the notion of
'legitimate' confidential computing is going to grow from 7 billion
dollars to 55 billion dollars over the next five years without the
concept of better 'trust orchestration'.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

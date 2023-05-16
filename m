Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BB5C77B7D
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 01:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QeQVBv/vMhYEzsc5xIVPvVDgRzllF9QwNFL/jNc3cwM=; b=XZBI6W1WSdIiyg
	CPsHr4eAMHX7dLg4/jxAqhGQ52SA+mhAOSmirn/EAMa/9AbfSJAoO2oSOu/Ok/8kN0sks1nfEmCtA
	HqjU5Gv83cOKzwQIUNjSkSJCpcj1r1E/e2XaukDhUEA1Igc4ydvaipqo5J+n0K+t1uBeNbAO9517l
	qnGeYLjidj45+vOvw5+5bGANfEm7CVp2QXVFwn7KlKO7nLigrRw55pijaE4H6bLgqSE3KBQeC/dro
	dJNoQeljX9t8di15DPsqC1kYAlqPbzc0hIK2LtGBBNb0ZvIkhImqR1mrvJyVaVXRAmyDZyIQa65oa
	gqZxe64KbxIODCdbc4vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjE4-0040zm-26;
	Tue, 16 May 2023 01:11:40 +0000
Received: from sender3-of-o57.zoho.com ([136.143.184.57])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjE1-0040zB-1E
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 01:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1684199480; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MBzvm1i6w5sH9qB90XtoDWPnzsiAxVMUrAquePUtEQUay8xbP0iEIehH0iPtU12UTXFc28TsN9kguT53KvIFyS3QxYQLKSq/b/VvZX/9+gxbOveV0vrFfiX9SsUZ/xXRBZcDJeo3y0/s458GrjtaGfZep0soRKQ/1gYW0nUMwgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1684199480; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=3D1ZcgeS6gbmfb74g6qO4yIjzREqLwPUB74IkVK5hiE=; 
	b=YF0ONQkmYu/eFV5tXlTxRET1MLUVYXbWjX/NIjEFLhR0ptkGKcf8OYNw05swr0LDdSVxPgil0QL3EW1H/Q7c+oGqLvutx5KVN/307co3cHGAEemhiLb2ky5VGvxbCGTjIuy085hZqgkaqUxhn/E/Kgz399vEdGjVysdZRytYeDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684199480;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3D1ZcgeS6gbmfb74g6qO4yIjzREqLwPUB74IkVK5hiE=;
	b=eF0JQ9HC29IQT8CAesMjHLcuTjhmoFhWidAgpxW3cr1t79/ekq1bo+RHa/KvmrCe
	5CkfzqSd3qdahwWqDR0UCseja3klsydvIUs4gvHt5/jhTfSQx+HsVi651NXwAbQo2G/
	z41V1Az7BhP9riZUaoopJicuZsK4Yg7xxfBeBGww=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1684199478060628.8578234862518; Mon, 15 May 2023 18:11:18 -0700 (PDT)
Message-ID: <7ff17d2b-7030-fbbd-c495-b43583e3f9e7@apertussolutions.com>
Date: Mon, 15 May 2023 21:11:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Content-Language: en-US
To: Ross Philipson <ross.philipson@oracle.com>,
 Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 James.Bottomley@hansenpartnership.com, luto@amacapital.net,
 nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <20230512112623.GE14461@srcf.ucam.org>
 <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_181137_475419_2DD5AC17 
X-CRM114-Status: GOOD (  19.00  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 5/12/23 12:17, Ross Philipson wrote:
> On 5/12/23 07:26, Matthew Garrett wrote:
>> On Thu, May 04, 2023 at 02:50:16PM +0000, Ross Philipson wrote:
>>
>>> +static void sl_find_event_log(struct slr_table *slrt)
>>
>> If this is called after the EFI stub then we're presumably
>> post-ExitBootServices and we're copied the TPM event log into a
>> configuration table so it's available to the runtime kernel. That also
>> means that we should be adding all further measurements to the Final
>> Events Table rather than the initial event log. How's that handled here,
>> both in terms of ensuring further events (generated by firmware or by
>> us) get added to the right place, and in terms of ensuring the event
>> logs the kernel has later on were covered appropriately? Or is the SL
>> event log an entirely different thing that can be merged in later
>> because it only covers the DRTM PCRs?
> 
> This is a good point. At this point it is really something we 
> overlooked. We will have to revisit this and figure out the best way to 
> find the final event log depending on how things booted.

I believe Ross misunderstood what you were asking for here. There are 
two reasons this is not possible or desired. The first reason is that on 
Intel, the DRTM log is not initialized by TrenchBoot code in the 
preamble. It is only responsible for allocating a buffer and recording 
the location in the TXT structures. When the SINIT ACM is executed, it 
will initialize the log and record the measurement that CPU sent 
directly to the TPM and then the measurements the ACM makes of the 
environment. If you pointed at the SRTM log, then the ACM would write 
over existing log, which I don't think you want. Now if you pointed at 
the tail end of the SRTM log, you would still end up with a second, 
separate log that just happens to be memory adjacent. The second reason 
is more from a trusted computing perspective, these are two different 
trust chains starting from two different Roots of Trust reflecting two 
different temporal states of the system, i.e. freshness. Typically this 
is were most will point out the need to have a measure of the resident 
firmware, i.e. SMM. To address that, should Intel to publish the spec 
for interacting with PPAM[1], TrenchBoot will be able to finally close 
the SMM gap, giving runtime validation of SMM.

[1] 
https://www.intel.com/content/dam/www/central-libraries/us/en/documents/drtm-based-computing-whitepaper.pdf

v/r,
dps

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

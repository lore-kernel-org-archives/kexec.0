Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534AAC77B7D
	for <kexec@archiver.kernel.org>; Tue, 16 May 2023 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CZqLjsXDYWxxYRiDvLEOiRRijwa0KnWGfb9qbGZu92w=; b=1KjFF0ig1obuJJ
	iX2O/oszqm2mFlCgquzU7/h7caa5kFhXeN5ltTBvfPdvw4SVzl+pBRAfdH1SlDfZIiREjigiNH9J6
	v0qJ2pXPtmYKwEe/LKPluK12BjHqCZg665rcZbjLur0UtxTiJ+udALd19ov6HUHvkYVIM9maB3uOK
	ds7mdzzNWNd0gUHJKuX/8IYoF0BILA+bhd+yVbgqktvHDgw76IMK6r2LgKxjR0kAsZFtvMYAppijj
	nSNJpS3w/ty3khI/GYMxQUmtqc0vdcGHRMQx0hvLaBnYlxwJzmowT6xZNBkow8YxlGdjRqVg5Ce+L
	PKxJB0Ulc74lyg5NriYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjPp-0042Cv-0t;
	Tue, 16 May 2023 01:23:49 +0000
Received: from sender3-of-o59.zoho.com ([136.143.184.59])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyjPm-0042CK-1t
	for kexec@lists.infradead.org;
	Tue, 16 May 2023 01:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1684200216; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RR1TfYZEGin5arrnpEvRLWCOsSlqGAODka5QOqh2UA6NN6tkN7W1/C/km7Ck+0CDl4L5rVEUMtYv+yPDiA7jNsSCKS+WP2uxKsvQC2jf61kWiBZRvWAErOIZ5SbVaixkF4lGKQqpLmeLnqHfv8cgiqYVUb1uFpAADHh84lCeVhk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1684200216; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=t9xe8yTG0sKAFENcXbIvh8DJsGK2DfwwVT3xWVKVb+I=; 
	b=UiPq7TVpfHS6m6iqXIN5DewJeEvOV/dHvI8gI9eNHXYCMxTsDm/WuiYOHyCfayPhky6qGStvc3KUk3qzB7QUrxZ7ro/5tyKIGkN6PuLm3k3UMpmKfw9QQpQq2/Fc1Y7mhA8jJOSYw7FhYsmMzWRTgybRi/vuCfSZgBMCwJB8U1Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684200216;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=t9xe8yTG0sKAFENcXbIvh8DJsGK2DfwwVT3xWVKVb+I=;
	b=UChlLcFEY/XnIK0uv4PQvV3Wp/AYkCd1F/foF76++k0T6Fbsfwsl1QUco905bf8W
	YSZLMd/ydEkuFSZj1ZRHIGKTEMctK5pQzMZz4tWjqAVsVwYRWWTNNOLtnJKj2XByA59
	gWMN4d5dNI0bPS0iPIJWi8kUs/zySml0uj8qu6Ko=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1684200214907165.64041646283852; Mon, 15 May 2023 18:23:34 -0700 (PDT)
Message-ID: <0e232a30-9b47-2315-86ea-4f6eeb7829a8@apertussolutions.com>
Date: Mon, 15 May 2023 21:23:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 11/14] reboot: Secure Launch SEXIT support on reboot
 paths
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
 <20230504145023.835096-12-ross.philipson@oracle.com>
 <20230512114000.GG14461@srcf.ucam.org>
 <a38e0589-fa20-77ac-2fb0-2cb247c2b408@oracle.com>
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <a38e0589-fa20-77ac-2fb0-2cb247c2b408@oracle.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_182346_695087_DC1F336C 
X-CRM114-Status: GOOD (  15.10  )
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

On 5/15/23 14:16, Ross Philipson wrote:
> On 5/12/23 07:40, Matthew Garrett wrote:
>> On Thu, May 04, 2023 at 02:50:20PM +0000, Ross Philipson wrote:
>>> If the MLE kernel is being powered off, rebooted or halted,
>>> then SEXIT must be called. Note that the SEXIT GETSEC leaf
>>> can only be called after a machine_shutdown() has been done on
>>> these paths. The machine_shutdown() is not called on a few paths
>>> like when poweroff action does not have a poweroff callback (into
>>> ACPI code) or when an emergency reset is done. In these cases,
>>> just the TXT registers are finalized but SEXIT is skipped.
>>
>> What are the consequences of SEXIT not being called, and why is it ok to
>> skip it in these circumstances?
> 
> Well the system is resetting so there are no real consequences. The 
> problem on those two paths is that the APs have not been halted with a 
> machine_shutdown() and that is a precondition to issuing GETSEC[SEXIT]. 
> Only the BSP should be active and SEXIT must be done on it.

To expand on this just a bit further. On all paths we were able to 
identify, the SECRETS bit is cleared, memconfig is unlocked, and the 
private registers are all closed. This makes the system as safe as 
possible to go through a power event and be able to come back up on the 
other side. The clean way is to always go through an SEXIT before a 
power event, but as Ross highlighted this can only be done after the APs 
have been halted.

v/r,
dps

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

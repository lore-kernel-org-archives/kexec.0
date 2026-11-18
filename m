Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97131606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e9NNefCx;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fnyNgTay
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b7bwUXugmVGuIIm4wGoslG4ej9FrGSL/WtU06h+6y6M=; b=e9NNefCxnKgIX865iduLp82p3I
	1XBxRxy9nvaUbfuOvmbAFfUEI5TQtoksMfTc31GUNFxEVz4x2cdkYZt7Pz4DNvsdR5WT+zIkLZsVw
	LthHeSH/D55UUT4hoJrmsN/E4PGwAP96BplTo1VOkoUgRx9oUMrIyKPNX2N44BCzqoh71tLjX1l6B
	sIZBOVutFY0TTrMdFk5GOVHiSnh9qHa1ExPkvQkVXIzjS7Bkd3pcHLk5RYSoV/TfvcF2ugc2GA1M3
	EiJ0wGFwv1dD0WiQPKxW/HYB07dETwpeauhs6wHUPrNz+bsUEqkqLrfsAsu9jxeq21riCaiwB+tIR
	J1JMiiRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaUD-000000084Rk-0vhp;
	Wed, 18 Nov 2026 07:53:45 +0000
Received: from out-147.mta1.migadu.com ([95.215.58.147] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaU9-000000084RL-2435
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 07:53:43 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=nTbgEmKnXYDBu3OqGkfNm1HRD+xN4s1F4VElGzerOvQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794988414; v=1; x=1795593214;
 b=fnyNgTayZu+sHsZdxPBbY0lVZBRZtxR6OkjdAivnY2JYOTR5dHrvLhi6SjXz5vJgHaRKBAXJ
 ejlKnscTSrGCJZsSyX+pfnOM16OBOnnMVVyTOj45mdsafjBe2w3CoqLYTwy0vLPuPQv+PDHtthm
 FPMHRAdaRUuoVon+1MYw2mjQ=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 70be349846b7b404;
	Wed, 18 Nov 2026 07:53:33 +0000
X-Mizu-Trace-ID: 70be349846b7b404
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 07:53:33 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Baoquan He <baoquan.he@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 3/4] x86/vmware: Add the vmware_record_panic_msg sysctl
In-Reply-To: <av1ZB3ia13M420_I@MiWiFi-R3L-srv>
References: <cover.1794980455.git.zack.rusin@broadcom.com> <4c5de34b10f579368b890eaa9333a2755886bad3.1794980455.git.zack.rusin@broadcom.com> <sashiko-outbox-220212@kernel.org> <av1IuMZ2W0SXWcNn@MiWiFi-R3L-srv> <20261117230201.921ec5bddf49cd459ddb8428@linux-foundation.org> <av1ZB3ia13M420_I@MiWiFi-R3L-srv>
Message-ID: <AAB2E512-6577-4AA9-82E3-F8297A4CBDD8@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_235341_677646_81A28B45 
X-CRM114-Status: GOOD (  17.44  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>, Kees Cook <kees@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Young <ruirui.yang@linux.dev>, Stephen Brennan <stephen.s.brennan@oracle.com>, Bo Gan <bo.gan@broadcom.com>, "H. Peter Anvin" <hpa@zytor.com>, Zack Rusin <zack.rusin@broadcom.com>, Jonathan Corbet <corbet@lwn.net>, Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, x86@kernel.org, sashiko@lists.linux.dev, Joel Granados <joel.granados@kernel.org>, Alexey Makhalov <alexey.makhalov@broadcom.com>, Eugenio Perez <eperezma@redhat.com>, Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, John Ogness <john.ogness@linutronix.de>, virtualization@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, Borislav Petkov <bp@alien8.de>, Shuah Khan <skhan@linuxfoundation.org>, Michael Kelley <mhklinux@outlook.com>, sashiko-reviews@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, Ian Forbes <ian.forbes@broadcom.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 November 2026 07:51:35 GMT, Baoquan He <baoquan.he@linux.dev> wrote:
>On 11/17/26 at 11:02pm, Andrew Morton wrote:
>> On Wed, 18 Nov 2026 14:42:00 +0800 Baoquan He <baoquan.he@linux.dev>
>wrote:
>> 
>> > On 11/18/26 at 06:14am, sashiko-bot@kernel.org wrote:
>> > > > Allow administrators to disable host log transfer on ordinary
>guests or
>> > > > opt in on encrypted guests. Expose the boolean recording policy
>through
>> > > > kernel.vmware_record_panic_msg using proc_dobool(), as Joel
>suggested.
>> > > > Zero disables recording, nonzero integers enable it, and reads
>return
>> > > > 0 or 1.
>> > > > 
>> > > > Register the sysctl only after the logger is ready. A registration
>failure
>> > > > leaves the internal default in force. Document that the log is
>sent
>> > > > before kdump, and that disable_panic_notifiers_platform_list also
>skips
>> > > > it.
>> > > > 
>> > > > Link:
>https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw7f3zjbz7c@srfabx6lsusj
>> > > > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
>> > > 
>> > > Sashiko has reviewed this patch and found no issues.
>> > 
>> > It might be better to turn off this message if not issues found, just
>> > like what LKP bot has been doing.
>> 
>> (+sashiko@lists.linux.dev)
>> 
>> Yes please.
>> 
>> These emails do have a little bit of value: they tell you that Sashiko
>> was able to apply the patch and to review it.  I guess.  Or something.
>
>In that case a message saying Sashiko can't apply the entire patchset
>is better.

yes my sashiko emails go to spam automatically (not cuz I set it, but 
cuz I get so much "no issues!" Emails, that it clogs up my inbox. 

What even is the need to have the no issues emails? If one was THAT
interested in sashiko, they could search for it?

>
>> 
>> Me:
>> 
>> :0 D:
>> * ^From:[ 	]*sashiko-bot@kernel\.org[ 	]*$
>> * B ?? ^Sashiko has reviewed this patch and found no issues\.$
>> /home/akpm/.nsmail-zip/Trash
>> 
>> hp2:/home/akpm> grep "From:.*sashiko-bot" .nsmail-zip/Trash | wc -l
>> 1140
>> hp2:/home/akpm> 
>> 

--- Thanks!


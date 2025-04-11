Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FAAC369A2
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1L8eJTBYOe3IqPq2LCTPLnMwB1yCh94JwNwUb/2VUY=; b=tprO/s3a1ZZlKMKMrQDnbFESKm
	GoHQBGR+GLNgIUYwh67Khde+YqCnJHdnIR4YLKstGvX9rCI8ZtkayYmxpOAn9NYpGF+q17LCPSVf0
	rE77nQ1uWfHYPLmjLaaS4G4wVfI8NGm03hvRFqgWWOW6zEc7Bg/4fBH61ue1PG+itVdXWjhiht6R8
	aEwiGFBIvVyXjKV6zyroHGCVbbyI+3aepURav6a6OIrJWgnTiaFv1/JeHXPLLPgQpi50AghufLCaG
	7KesKdbzIPXfIn/DAFfLdSBWWTw6AuZ21SdvaT6sHlSy3W2SRJUBJrDOeqBrCHhJRD1OU+6VfU/Ci
	l+MhfgeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3Lzb-0000000EwI8-2wY4;
	Fri, 11 Apr 2025 21:32:55 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u3LzY-0000000EwHV-49Kz
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 21:32:54 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2241e7e3addso22103625ad.1
        for <kexec@lists.infradead.org>; Fri, 11 Apr 2025 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744407171; x=1745011971; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1L8eJTBYOe3IqPq2LCTPLnMwB1yCh94JwNwUb/2VUY=;
        b=NrjWfiDbnh4FEGnc2AZQ+7zb1xiO+G27HwbINs80rdgLLj9zxgdGXHYBIKAW3NPHwu
         G6iefBizn5xub98Rp7srUPbo6ncIfiAOZrek6rWCjkpby0F9R9+RhK6bDVZ0tdfIEMHe
         n7Mn1jYEPylVnlPFegGFMmAbHWVV25MfVG3FEBoTSuF5NNkZjctgE8pETx6N5J8rK9Tr
         dbHGFR4pbqe8r4k97y+7Gbyjni7WPeFKM0UnOLz/+6XQqYEBqY9A4psK1D37Y0UFlYIj
         aT3ciqo5UAV7+bS0CNtsAd37gPLH7RIG7Lf81uWh1oTTc8MQRMC/4xcMEJ6iSItY2NjK
         V7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407171; x=1745011971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1L8eJTBYOe3IqPq2LCTPLnMwB1yCh94JwNwUb/2VUY=;
        b=vWvhtM5DmoheoTK3byjdZU8pz5n2jzVRoSqt9bXlnQcIlyMT/pANcFm64IuspaXwCd
         VebhkE8V/qnpJmysCZYKNdJA7/JhjVKi5yyFdwgEb3EDoLBWlSMpkMHK6XkOSU3AOg+5
         OTS5DR8U9BmkqtQfZ6iU6EZCjUdoPc9F1LxakMBZY/X3O0EYuRUHpc08vmTLRTJ9+2w0
         vrRouis/SLK+hIBPxvvJsLPFJP8nIJ3FdHaOGll1aohLZ4TCmZ+nXht5aU4ujKRzzLen
         j6DqL1UCCGFbJCKl5I8cBtPLBbmx/hdR+DmTIQiKvC7qfUnvqc+BKGYhS6sX2YpdrKMz
         B81w==
X-Forwarded-Encrypted: i=1; AJvYcCWI7rqcP4y4D1CU/1qUkA9X1htMwTDrctGd1PmhQblY2kAtxJLeMIY0hlknS7WkfIr/Avsr2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzAsHKcVnRQJqTjs1/gKmSz/SwK/ILPiERQObZT4js31WV1jf/f
	9MVmTgMbgVEKaEhalp1FH6In6cXHualjHcN/Nk1o9YwyKrsqEJ8z6O1I7dAJWkK4/SB3sahPFlf
	/vw==
X-Google-Smtp-Source: AGHT+IGWRveftZO1wji7CvlkOdr/kE0uz4l6esz3nDwfvBuY+d4Ew0jp3EjBMobySbyO9+duVZkiSgztRF8=
X-Received: from pfvf19.prod.google.com ([2002:a05:6a00:1ad3:b0:732:51fc:618f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccd:b0:224:910:23f6
 with SMTP id d9443c01a7336-22bea4fcc8dmr67226125ad.45.1744407171250; Fri, 11
 Apr 2025 14:32:51 -0700 (PDT)
Date: Fri, 11 Apr 2025 14:32:49 -0700
In-Reply-To: <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
Mime-Version: 1.0
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
 <20250410204149.2576104-2-ross.philipson@oracle.com> <f816c36c-cb7e-4143-b58c-f96a40699f7a@oracle.com>
 <b06b187a-54e2-460e-8fc5-b440184b6f7a@oracle.com>
Message-ID: <Z_mKgfZznBZgS-Pb@google.com>
Subject: Re: [PATCH v13 01/19] Documentation/x86: Secure Launch kernel documentation
From: Sean Christopherson <seanjc@google.com>
To: ross.philipson@oracle.com
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250411_143253_036005_06850F63 
X-CRM114-Status: GOOD (  11.71  )
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

On Fri, Apr 11, 2025, ross.philipson@oracle.com wrote:
> On 4/10/25 10:50 PM, ALOK TIWARI wrote:
> > 
> > 
> > On 11-04-2025 02:11, Ross Philipson wrote:
> > > +
> > > + - Entry from the dynamic launch jumps to the SL stub.
> > > + - SL stub fixes up the world on the BSP.
> > > + - For TXT, SL stub wakes the APs, fixes up their worlds.
> > > + - For TXT, APs are left halted using MONITOR/MWAIT intructions.
> > 
> > typo intructions -> instruction
> 
> Thanks for the review. They are two separate instructions so is this really
> incorrect?

From the peanut gallery, I'd just drop the "instruction(s)" qualifier, i.e.

	- For TXT, APs are left halted using MONITOR/MWAIT.

Pedantically, it's the combination of MONTIOR+MWAIT that puts the CPU into a
sleep state, not the individual instructions.

And while I'm picking nits, the documentation is also a bit misleading as the CPU
isn't halted per se.  I'd go with something like:

	- For TXT, APs are left in an optimized (MONITOR/MWAIT) wait state.


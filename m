Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E55C52D7F
	for <kexec@archiver.kernel.org>; Thu, 15 Aug 2024 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A215wJfKXjhiKh2I+p8f1ZCskvhZR9nYHvtc0XlQBcA=; b=nlcJT/DS5rD1uJ
	L8z0lWPZW21DPTNnayqYDvCKn0a2gHL0zcx+lCN9hJBgggeGtL7Xnu+0kqEXh1b2oYds0+kDJfGX6
	8vHW48gFH5APdTph16rYWjVeOxJvqCj8ZiD+/aKLBvFAw49/FldwS/ANM5O+dflp8jw1/EGYxTCbU
	x5U4LsPapvAbLhAgLzuLaXsXIWCL/ZmHojMeJfrEFuQ1IGq1OTIxkWfqYSXm3F3CExi/jwpqastFc
	vUJNbZwEBhI8tisN36/ENnS3Ib72V+0uc8QoTwmSPTqAlnFFqD/ycqtyN4SwReLHvGr0gAxQbOH33
	+BK1bO3iGhBXq5KOC3jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sefrZ-0000000ArME-2TGs;
	Thu, 15 Aug 2024 19:10:21 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sefrU-0000000ArKU-2Ey6
	for kexec@lists.infradead.org;
	Thu, 15 Aug 2024 19:10:20 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723749014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZTVvaO2p2W+P+UPnKNV9BKWDUfkQHL/Xf0aN8/w5q0=;
	b=tXHVRT29inPW/Cw8vHHs1o14Q4Yg3be6qe6cDE1L2kjUo1Ou+VJWbihHot0QdYTT2XmfNq
	Q7QHsyjgqoB5Q42qu0yDhBmmkonyK9Cl6Ff4CsaEjhOwJ86AXJXwKqyY5kAg9g14zXrdxO
	ax7P6WZqn9oe9FXaY5ioB5ukKN9HGo/U2D2wj5FHKutnuWinDt8ZRCGFBmxRLt3hc8qnfc
	sJvVZE7ClLcjgLf59JVQy2y7fu6zGzKEnF1gvED+dsVLlyDPjYBCOWSqXX1AJYZeW0plRT
	84C/Hq8k3joLra6RWJ+SAEv1oMijRvkMW5KQVtHRF8nD6KNa++f8NFzn4DeM4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723749014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZTVvaO2p2W+P+UPnKNV9BKWDUfkQHL/Xf0aN8/w5q0=;
	b=cAIOFZazMeEHCSiUEc0/bZDaCxz0Zt0Bdo6zTqNdOOXhSC3N+b2lASD42ZXOG8ROfzkNKS
	ENdJDWGyB1XUvtDQ==
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
 trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
In-Reply-To: <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
Date: Thu, 15 Aug 2024 21:10:14 +0200
Message-ID: <87ttflli09.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_121016_738762_DC2B0536 
X-CRM114-Status: GOOD (  13.13  )
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

On Thu, Aug 15 2024 at 13:38, Daniel P. Smith wrote:
> On 5/31/24 09:54, Eric W. Biederman wrote:
>> Eric Biggers <ebiggers@kernel.org> writes:
>>> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
>>> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
>>> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
>>> but why would you not at least *prefer* SHA-256?
>> 
>> Yes.  Please prefer to use SHA-256.
>> 
>> Have you considered implementing I think it is SHA1-DC (as git has) that
>> is compatible with SHA1 but blocks the known class of attacks where
>> sha1 is actively broken at this point?
>
> We are using the kernel's implementation, addressing what the kernel 
> provides is beyond our efforts. Perhaps someone who is interested in 
> improving the kernel's SHA1 could submit a patch implementing/replacing 
> it with SHA1-DC, as I am sure the maintainers would welcome the help.

Well, someone who is interested to get his "secure" code merged should
have a vested interested to have a non-broken SHA1 implementation if
there is a sensible requirement to use SHA1 in that new "secure" code,
no?

Just for the record. The related maintainers can rightfully decide to
reject known broken "secure" code on a purely technical argument.

Thanks,

        tglx


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

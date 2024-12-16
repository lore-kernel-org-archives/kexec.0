Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6EFE77180
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DI8N+uG9ECaO9MtUeDVcCbPw1YWgb8PFeENftVe0d2Y=; b=zW0LpCBxgC2epMPthpyrdyI3Dt
	umgxLMpxIXgUuFamDvjZIPMphjgYOySBnOENrwkXbDz1oz+ed+TzOXwdXO5M1j/7IVl+mTjklfYgL
	DTAzX8clTD7QSUnev4F6nEkFu5m8W8zpLxbFtkmkWJFi66N+JDpqFWUINWeBKM2aUhVeAljWguSBx
	uhQCorsVpvy6hYBU7NmF0TTxjtDyde4jJIyLHb+mcsc+isgMpnkDlGB2B1nool4dYMguO+9baxuTo
	CwDsFbvPdjatNOwH+49V4lFeHBe6TLRKhJvEqATnHPpPCQKtxnpmc7eQDgHEYTGFV7oWDl8RuhTZY
	mpjjg7HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFmM-0000000AxfZ-3hhC;
	Mon, 16 Dec 2024 18:25:14 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFin-0000000Ax0u-1Sxe;
	Mon, 16 Dec 2024 18:21:34 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:35192)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNFil-004lrv-IE; Mon, 16 Dec 2024 11:21:31 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:49960 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNFik-00FtDO-Lx; Mon, 16 Dec 2024 11:21:31 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ming Lei <ming.lei@redhat.com>,  LKML
 <linux-kernel@vger.kernel.org>,  Linux PM <linux-pm@vger.kernel.org>,
  Kexec Mailing List <kexec@lists.infradead.org>
References: <4968818.GXAFRqVoOG@rjwysocki.net>
	<d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
	<87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
	<E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org>
Date: Mon, 16 Dec 2024 12:21:01 -0600
In-Reply-To: <E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org> (David
	Woodhouse's message of "Mon, 16 Dec 2024 18:14:17 +0000")
Message-ID: <87bjxbzdyq.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tNFik-00FtDO-Lx;;;mid=<87bjxbzdyq.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+z7hsfZYbh2h99As8mJSOdcZfr7Fg2uXQ=
Subject: Re: Does anyone actually use KEXEC_JUMP?
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, dwmw2@infradead.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_102133_388147_83683F98 
X-CRM114-Status: GOOD (  17.35  )
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

David Woodhouse <dwmw2@infradead.org> writes:

> It isn't broken. I know of it being used a few million times a week.
>
> There are corner cases which have never worked right, like the callee
> putting a different return address for its next invocation, on the
> stack *above* the address it 'ret's to. Which since the first kjump
> patch has been the first word of the page *after* the swap page (and
> is now fixed in my tree). But fundamentally it *does* work.
>
> I only started messing with it because I was working on
> relocate_kernel() and needed to write a test case for it; the fact
> that I know of it being used in production is actually just a
> coincidence.

Cool.  I had the sense that the original developer never got around
to using it, so I figured I should check.

Mind if I ask what you know of it being used for?

I had imagined it might be a way to call firmware code preventing the
need to code of a specific interface for each type of firmware.

Eric



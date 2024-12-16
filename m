Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83350E77183
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 16:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q0pY5UmBxAG4qsrTUdR16vU5Dk8H3SLuygEtjRZFKWM=; b=CeZW7Rn8ZpBlqGROcUkmASQM45
	IBZc6q+cakcMlAvhX7dWhm47j063Rkk3rpCCiIQs6kpH0mUgaHldPvNTOsOm35cg6GtW7qozRVV0D
	HFhyGXw7wqRpHI97HJq0SQgs35wrrYig/VExk1j0yL+gsJIHJ2R1QrPedLTXM6hqlMT5ZQ28GR0vM
	MCxooeHax7gqFqDSr3ov5U5jP11dxcY88SCoQUPUT7icv9m/7iGUQh0j8LbvRvd3Eao0NvLW23BhI
	EcX2/yS+Nk9lzJzMaC4Z6x86M9R+4LSh0+h6IiUwuACSb8UwjHl6d3TM7HtMD06OqTMUINU691Bw9
	KRBjEg9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDWh-0000000AV3C-498A;
	Mon, 16 Dec 2024 16:00:55 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDWf-0000000AV0Q-2HQL;
	Mon, 16 Dec 2024 16:00:54 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:53580)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNDWM-004V9m-Dg; Mon, 16 Dec 2024 09:00:34 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59886 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tNDWL-007X7c-36; Mon, 16 Dec 2024 09:00:33 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Thomas Gleixner <tglx@linutronix.de>,  Ming Lei <ming.lei@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Kexec Mailing List <kexec@lists.infradead.org> 
References: <4968818.GXAFRqVoOG@rjwysocki.net>
	<d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
Date: Mon, 16 Dec 2024 10:00:00 -0600
In-Reply-To: <d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org>
	(David Woodhouse's message of "Mon, 16 Dec 2024 13:43:05 +0000")
Message-ID: <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tNDWL-007X7c-36;;;mid=<87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/IoUPRXc2CZDplraCLK6J/GomP+OYV8hI=
Subject: Does anyone actually use KEXEC_JUMP?
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: kexec@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ming.lei@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, dwmw2@infradead.org
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_080053_577532_F84B5CDF 
X-CRM114-Status: GOOD (  19.07  )
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

> On Mon, 2024-12-16 at 14:39 +0100, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> 
>> The KEXEC_JUMP flow is analogous to hibernation flows occurring
>> before
>> and after creating an image and before and after jumping from the
>> restore kernel to the image one, which is why it uses the same device
>> callbacks as those hibernation flows.
>> 
>> Add comments explaining that to the code in question and update an
>> existing comment in it which appears a bit out of context.
>> 
>> No functional changes.
>> 
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks. I'll round that up into my kexec-debug tree, which Ingo has
> been taking into tip/x86/boot. Once I'm done fighting with
> objtool(qv).

I have no objection to getting kexec jump more in sync with the
rest of the power management code.

I do have a question though.  Does anyone actually use kexec jump?

It is fine if folks do, but I haven't actually heard of anyone using
it.  If folks aren't using it, it might make sense to just use the fact
that it is broken as a nudge to remove that option.

Eric





Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB733CD98D2
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MaX7x21+nHDjl6ZC8E7UHL0betYQU1IeZDqIxfjL42A=; b=4WY+1Nsai7dZK2Qh2WSS5gkIP0
	L+Ay3UdfqEz/vhS8W8gutGy0kQGDOOrK/qhEQFfBpye8QxDHrKEK0BKmBXbp38dno+Ur4l1fuHYYC
	luIsttiPzxvjnFGdnNURN5yyzD282B4hB7pwG5H8cQaVrx0hE/Da4BcTqrcYs+5a/BZ8AlpCHCfM6
	zqZs3Qc23qSP7UHK1Az1G89LBbtfXlqic9TT5BQPDSeMTu08EvFuGJ1x8AsveyROgNI4tebVkRUrs
	TDEwmSA76q/iCbGriHS6t0NfaSXiEukWIn1mMJD0e7qeGnLsTk7Ry07gQNisFBPOIwDp6yi5Yw6Hj
	VYm92IDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbk9-0000000981L-1tqw;
	Thu, 11 Jun 2026 09:30:33 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXbk6-0000000980F-42mA
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 09:30:32 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-68d232dc704so7944943a12.0
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 02:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781170229; x=1781775029; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaX7x21+nHDjl6ZC8E7UHL0betYQU1IeZDqIxfjL42A=;
        b=q6gQsndeWrx62stxT598/ezxzNn6OYxY7gZhfDo7WC3Kh7q/59faI/wCNyrs4TOyE/
         oR/HzDllBUId/PRyg5qXTWVa/YrCPVE78QTdlkkgDfU/zKWu+oXJnAsDTOxbgNd3w+Ao
         mcovXPT5KQvJf9Sg2mHwwA51K/d+TwXOAUbEjbVsgLpoP113YT65u1yLckQ5dzyhUBS+
         nFXPLaZPl0PlMHi7+muPhUckzPZp2SGsPMCmsNwKOfnae3v9RqR6arFeHF4Y75ZXOZNz
         m3VB7mIoCSAEtS7qK79DuqxHnDF6/Tfkd9KQxD0bDtAO3xvFYVoBs0o/LJTikTlZJRdj
         Ce4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781170229; x=1781775029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaX7x21+nHDjl6ZC8E7UHL0betYQU1IeZDqIxfjL42A=;
        b=Kt3BP5vf37dJwpQUgC9Pxqu5ixR6Djk5anBCc4E0lyj/b1t1GIncfjFKEK4Z7iWcB3
         XYOJurBPsa5jDot0xlAB750jqQHS9qJM75h0Xf4gkihl/30jNGJfefhumQlX4v7QdFJz
         SpL+ho20DT8KG+6NB8QfOkhcrA6VHfcwCAIWFJnHkrKKEs9RT6Xm6Y2XJmnV0wYPLen7
         WRFK9ZCfdG6Q/0o1+hUwNW0++k3O2HxiF690g2/imMZmuTGk3OiqG7Xugwp9kITh7u8f
         +eajjQ77sgfuug09K/d7smeF54bC2ihzOxZCmxv4SbP6d5oDsFLWA8wz8zl4aSYpCcDd
         6bmw==
X-Forwarded-Encrypted: i=1; AFNElJ8wQn6K0V+Z15mcaHkDBwUXOjsL8wMBdMaLv61dZroWZZlOvJUx2lbV95WX7sV2bdSY3sTr2Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0UwYSzMkhHHjo2wVaYUMOhT/v6B12jnz3BtZyDwXLPgM1kxHz
	RpmGwrz029CWDnFyPu+ybYMdBupegb1DQo1hp16Bs1uNJsEXiCTOCpxU5sR42Lzlvv/oVscUWO9
	lTludgh4JCce0JiHC9Q==
X-Received: from edvi16.prod.google.com ([2002:aa7:dd10:0:b0:68d:63b5:c714])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:e0e:b0:68c:dbd5:a6ee with SMTP id 4fb4d7f45d1cf-6930e2e93c4mr874570a12.25.1781170228404;
 Thu, 11 Jun 2026 02:30:28 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:30:27 +0000
In-Reply-To: <2vxzfr2vso9b.fsf@kernel.org>
Mime-Version: 1.0
References: <074445fc4964961f12171ea129f2a7690322a78a.1780944056.git.tarunsahu@google.com>
 <2vxzfr2vso9b.fsf@kernel.org>
Message-ID: <9huz1pedv2z0.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH] liveupdate: Document that retrieve failure is permanent
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, vipinsh@google.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_023031_007991_5E9FA1B0 
X-CRM114-Status: GOOD (  15.52  )
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

Pratyush Yadav <pratyush@kernel.org> writes:

> On Mon, Jun 08 2026, Tarun Sahu wrote:
>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/uapi/linux/liveupdate.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
>> index 30bc66ee9436..a564d2bd05c1 100644
>> --- a/include/uapi/linux/liveupdate.h
>> +++ b/include/uapi/linux/liveupdate.h
>> @@ -168,7 +168,8 @@ struct liveupdate_session_preserve_fd {
>>   * associated with the token and populates the @fd field with a new file
>>   * descriptor referencing the restored resource in the current (new) kernel.
>>   * This operation must be performed *before* signaling completion via
>> - * %LIVEUPDATE_IOCTL_FINISH.
>> + * %LIVEUPDATE_IOCTL_FINISH. Once retrieve call is failed, retrieve status
>> + * is saved. So it is permanent failure and retry is pointless.
>
> Perhaps the wording below is slightly better from a user perspective?
>
>     If a retrieve of a token fails, subsequent attempts to retrieve the
>     token fail with the same error code. Failed retrieves are not
>     retried.

Updated!

>
>>   *
>>   * Return: 0 on success, negative error code on failure (e.g., invalid token).
>>   */
>>
>> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
>> prerequisite-patch-id: 30753743cdfab5c3c5355ecde725b6648f1b7a17
>
> -- 
> Regards,
> Pratyush Yadav


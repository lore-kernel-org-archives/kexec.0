Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941D4EA719F
	for <kexec@archiver.kernel.org>; Sun, 19 Apr 2026 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELMcQZlFdeS4+itJFABeR3Hl864BgvTQvITeQpTy5+g=; b=2JZ37LWsgZdtcdUEqOj0aGFAzv
	ktzYJHk7uhdPilwfeSi5VKZzBM8pOpgEC5fbTEQtXnF6E1pTM4/QACDF3NHVaih667kHK/dCO5p1n
	E1N/rccpBqimVGDlPZ/1V4wo+1JaL9Fdxzrum5UKFXGxBO8NAN17v4hJomAaS9haP4287oD82UzLt
	+fngN0+2eRzZcGjwaEwFvxzUeV2q9CnmMa12Yyu5FLP3PcpnMymWNPmVrW86LTqZc+nV5Uxhh6tJ+
	nc3un2RmRJzbtl30BZ0+mAbkN6Sh+lJXMGJxtTc0y9icKOrIHEE0qJ9EYASlIsWDv1t928ciDC9jh
	CkP/rnvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEToa-00000005sbA-2oTp;
	Sun, 19 Apr 2026 15:12:04 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEToY-00000005sap-2e9L
	for kexec@lists.infradead.org;
	Sun, 19 Apr 2026 15:12:03 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-8d7e7f48499so262778685a.1
        for <kexec@lists.infradead.org>; Sun, 19 Apr 2026 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776611521; x=1777216321; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELMcQZlFdeS4+itJFABeR3Hl864BgvTQvITeQpTy5+g=;
        b=itAHD8D1wkAeqAB7b4FbTWtm+gAZpTq1UBuebPZHa4xL+DdvaT4f2QIWipXxbXkUtl
         kHYvw/y40ZE8uAjQK1TPeUQ4v3AZA+PNKuK2CKePvqay+5N7CQsYkcSr3R9DS1+hXPUI
         Tu8o4SW2LG/vF/XRNvZLQMlnasrUPCh94yXD066l41OP/KSEW7AgbyPK47eLWtuf7Ygf
         vloj7pQ6tFnq9PSw7VXsdO2kJRS378d2opKW01Ew1pQRhz3fS6Au097yViOg8ZpCSRA/
         nDlJOn1GlMhWMf0mK5/FFex5evgaRWSwlTEawz1k27Fg0hRVfE1REUBGVubzxd+jjqWd
         H3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776611521; x=1777216321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELMcQZlFdeS4+itJFABeR3Hl864BgvTQvITeQpTy5+g=;
        b=M23n6CkpNeNF0T5GEEJOybenREijGSjNgBBRmQxbJhCV22iGvv0WZDddAXSn5wDRkV
         5Y3Wd7Bwmpe8Ipc485XOfBTLb52cTPT2mIh98h5wA+eRjh/Dxw3Hj0oSB4Kp0NlIxoXz
         gH7kkiGG5k4ne21D+AmYp+ad4fsoHYTWStNhp+HwicdGi7nLtpkILb7vy7HkhQMf81HW
         nX7KjoWIXh5pnOWxTaNHuWufVJopzg20lJBw5uIkVTnvWz49NDc4n51dP2iUAn1h7K3+
         dfSD2QowXPuBU1CeNMOBe422+y5fQbP9WCVQA8XtRoP9xZwMKHMI3O+HQ6z4vKbW0DxB
         C0nQ==
X-Gm-Message-State: AOJu0Ywmi8TcBCd1KzSWgf4B/lTFLAruAPEwI4JNu7zTQ6FuGqaOtQJ+
	aYLSr5xn0LKp+roouPAEhQiqarKODWVEhgO11/bmsEz3iGecVFEjAezh9guRhC2fGaM=
X-Gm-Gg: AeBDietthgpBsLcS2Yqb+zuFaXWikvNMN2+k3TduIwnh1Rj8FzL34orCHbv+7ADWZ9/
	PTwZ+knFKzHKVtXPOmixog7LhZF9UDuHcyWTBFKBHzkNwiCJo3MSNQG9BKUEwudfn9Y5EKBHhTt
	r6u7aVgywN3p7RRj5/SLhQwB5YZ3LsRG7fZ/lb6XSK727DK39fffVbc+i5F4pdjn/WJk37OoDs7
	XHO/DGY/MpdEoYSLKkVauwS5F507O/NPqTkSkPvhgIIWV6SD+ymFNGIqw/pDsDT9Jjqkc8u3yhD
	u8z2ECkkIv1CpXcA7J9lvRn4m8rUiWjOGe357D8+e6uHSfnV267i6FBAsnVCoNvy9OLMYiBsr2W
	Gz5ejDpiWnpucSYf50v80VA/WBDFqXXppsU6FN2toJULKbK+FrFYHlyvDw7720G/NM0Vg0Wo8LY
	6Y9OL7JFOoBAaXRRWSbtW7Qwk1ynJMzDqzPTNbK/O49SNdTefYXuhpFjgmcnhJ
X-Received: by 2002:a05:620a:2914:b0:8e4:ebbb:b162 with SMTP id af79cd13be357-8e78f541532mr1351149685a.9.1776611521172;
        Sun, 19 Apr 2026 08:12:01 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ae320sm681145585a.20.2026.04.19.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 08:12:00 -0700 (PDT)
Date: Sun, 19 Apr 2026 15:11:58 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] selftests/liveupdate: add test cases for
 LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
Message-ID: <3vcfqee2mhtojsq4ujp2prb5kd3aj7hf5feegpbmkazibphl2q@rk25bwblttil>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-3-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418163358.2304490-3-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260419_081202_672239_1B6F3201 
X-CRM114-Status: UNSURE (   6.61  )
X-CRM114-Notice: Please train this message.
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

On 04-18 17:28, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Verify that LIVEUPDATE_IOCTL_CREATE_SESSION ioctl which provide a name
> that is an empty string or too long are not allowed.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 


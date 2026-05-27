Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2EDCD5BD0
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJr2tB77juL4ByDP6LkH0aebWzIYmr6O5s8SXDRsvVw=; b=3FSSVz+znw4QinTewO1WB8c0XB
	J+OOJHTh6Io2ITMP3mNEOPWbU9AZOhD9NDf7FgTAlvazo/rHSGPqbV8NeeJKzO3LLE09KHqp9EU2l
	PpuNs3uh4gMCtKaQATvbSXoHXWXaOz33Io3e+k1Zoz2RcgGGuVQnbsWWQGJZckkupQsG63HfPX3Oi
	ZhSMXd7A/iYgg2CpQpFGjr4wG33Oa8J9KFqXJvAzUyU2GRapAioEpX8WZNfFWwxQyrbM1DZBv+Wnf
	EvH1SAhfkZAN9GKI9tPzIZHTWQs6dw0QskfjZ3lx2NW86dewyDKdhkt+vk7IttB9KHGB/B9PuweGZ
	6iB+o1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKWc-00000004hhQ-0JAD;
	Wed, 27 May 2026 20:06:46 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKWZ-00000004hh3-0Vcc
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 20:06:44 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-91080895355so1361684885a.3
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779912401; x=1780517201; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nJr2tB77juL4ByDP6LkH0aebWzIYmr6O5s8SXDRsvVw=;
        b=RZR4rLPKE1lMjoB99Fis3O0ncNvULWdXHhNZ+xNxyNrmvyhrpJhmr0uMrukENxiOhk
         PQTia+xdBrI4F2+6b+5CSWRrZQgP5iCVF4pNOtMJ74C8BlGA7/aT/NkXRMtDzui6bqoe
         5i9t68IVDDQZy+/6iJxIO0BHiPOPtdkWzqxIzR0vn7lmp7aOQfVb7LeEZuWvpUHlcQSJ
         ki4EcbowX3Q5y7J9mMSsNdKIJujxtR6xA4Rq+U593MOjsdoFbWsGfzEyNL2ixLjN0kvB
         T6ZaFoMs8ktxrU4fswnZLX08HLxtLk+M7uOslaZYJL7IDOVb/9mQ4KKxeYGPH7wjE1i0
         Mw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779912401; x=1780517201;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJr2tB77juL4ByDP6LkH0aebWzIYmr6O5s8SXDRsvVw=;
        b=lJtjYeTaRLVw7GVu9mAFN0cFfOJa1ZsPezeODLKokT2+ir3Foxt6Joflo4Ev5PaD+H
         4cEULhu/lV/OC6R0njeiIxCYJNXmy81sgOoEtkpK59lyS0L2Bg4K6CKysVp+Qkff2sJo
         9hibvR94tLQXAHteHYcNhoTR7NLnhKLUbKbAUbVn3O3CE9pBSnSXwGRzDrW5JSDSwqqF
         XtNTzw6F0L0xO1OaNevq3KI4AbjVIa5qyHTJpB4kh6Rr5NJmk+Gjw3t6A/CfxzmTqzVe
         AOdOu5yc0DOvQRarJCxoTZPFS6EpknPzj4DR0XWBByO2yO0dq42UVUvjwzmubczB2fYi
         qS7g==
X-Forwarded-Encrypted: i=1; AFNElJ9gyyhmzMMNZY+BX5tZSSGqNautg5B+b+hDPN3l6NLbheL+MEfEgEXy2m7t6QCgLeTk3lebqA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfBF5YUMrhScn9lPnAJukhyDe3m5wBj/35k5pl2dfG2pdGTHd4
	ypS6wl1zJbwD5ZGTS3RlrneNBtMenqWzWV7jbB4h8smrbC1+GadwTBF3PrQ2IgJlb08=
X-Gm-Gg: Acq92OGaUbRKDIbmDn51M6VSATxKd8oda4e6RKxQs9zgziCdEL1I02Twu9nMSLmZKJ9
	BiD3A0/xmkpz4OiCzXfhKpoqELKuIXmp0GCrvMNgOQrMrqinB6fgPW7ZSgd0VIJFir5d0xm2KhP
	FQ7i9YIskJ7/NK9Lleifc29IXOgY7jhEQBfudBxWJDkBYNeUjSNSVNTY1F45sn30ntZUls4x01c
	+30rGWlfogBTUGNz03vC6YRWbqTBwOyQaBn/MDW2bKWtEuH9DV9nShxaUVPpyP/cz3c6tGzguA1
	btTgCtzrLBaLnWEfGc01qOiRbe17p5ir3pVwwA1dDR3bNN9dXl6oRz9jbbVOVgOhBcMCYmBg/J8
	uxenzZweuDoA/YhOZdx5h9UNZ05Oc/0dTBaV/fpiMQE4lIDXGKLgYt0QFYeL4nkiUy9Xgxmno9A
	NCxyor3LzG1uABrkTtYQATEgaItIytf+JYY5xHPST/46USNzGcVbp8OygXxbwtgg==
X-Received: by 2002:a05:620a:408e:b0:8f8:d217:f46a with SMTP id af79cd13be357-914b48e0887mr3337181485a.8.1779912401292;
        Wed, 27 May 2026 13:06:41 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f863287dsm570050085a.0.2026.05.27.13.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:06:40 -0700 (PDT)
Date: Wed, 27 May 2026 20:06:39 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org, 
	sourabhjain@linux.ibm.com, jbouron@amazon.com, akpm@linux-foundation.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, rafael.j.wysocki@intel.com, 
	piliu@redhat.com, kexec@lists.infradead.org, skhawaja@google.com, graf@amazon.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v5 3/5] liveupdate: block session mutations during reboot
Message-ID: <ahdOql2hT3dwQk9e@plex>
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
 <20260518125459.1092373-4-pasha.tatashin@soleen.com>
 <2vxzo6ic8ysn.fsf@kernel.org>
 <aguXhxrjhvmxAyb2@plex>
 <2vxz4ijz8v48.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2vxz4ijz8v48.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_130643_196279_FF414F99 
X-CRM114-Status: GOOD (  30.94  )
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

On 05-22 14:52, Pratyush Yadav wrote:
> On Mon, May 18 2026, Pasha Tatashin wrote:
> 
> > On 05-18 18:31, Pratyush Yadav wrote:
> >> On Mon, May 18 2026, Pasha Tatashin wrote:
> >> 
> >> > During the reboot() syscall, user processes may still be running
> >> > concurrently and attempting to mutate sessions (e.g., creating,
> >> > retrieving, or releasing sessions). To prevent this, introduce
> >> > luo_session_serialize_rwsem to synchronize mutations with the
> >> > serialization process.
> >> >
> >> > All session mutation operations (create, retrieve, release, ioctl) take
> >> > the read lock. The serialization process (luo_session_serialize) takes
> >> > the write lock and holds it indefinitely on success. This effectively
> >> > freezes the LUO session subsystem during the transition to the new
> >> > kernel. If serialization fails, the lock is released to allow recovery.
> >> 
> >> Good idea I think.
> >
> > Hi Pratyush,
> >
> >> 
> >> But, do we need a new mutex? Can't we use luo_session_header->rwsem?
> >> Session creation and release take the header rwsem at one point anyway,
> >> so perhaps we can just reuse that?
> >
> > The sh->rwsem is for protecting the the session list. We only take it as 
> > a writer when modifying the list (insert/remove) and as a reader when 
> > traversing it. Also, we drop sh->rwsem as soon as we've acquired the 
> > per-session mutex to allow other list operations to proceed while a 
> > session is being modified.
> >
> > Because of this, many session mutation operations (specifically ioctl 
> > calls) don't touch sh->rwsem at all—they jump straight to the  session 
> > state via the file's private_data. To use sh->rwsem to block
> > these mutations, we would be forced to add down_read(&sh->rwsem) to 
> > every ioctl path. This would be a layering violation, coupling list 
> > management to per-session data mutations, and would introduce a global
> > bottleneck for operations that are otherwise independent.
> 
> As for the layering violation, I think we would need to change the
> semantics of the lock -- it no longer protects only the list, but other
> session operations as well.
> 
> But yeah, if we do this then operations like session creation would have
> to wait for ongoing session operations like PRESERVE_FD. My argument was
> based around the fact that session creation or removal should not be
> very frequent (and don't happen in the hot path anyway) so the added
> latency should not affect them as much. By doing this tradeoff we get
> slightly simpler code (and simpler locking scheme).
> 
> But I see your point as well. In practice session creation and
> PRESERVE_FD are independent and one should not block the other. Maybe we
> get VMMs creating sessions while another VMM is preserving stuff, and
> this slowing down the live update preparation? Dunno...
> 
> I suppose let's go with this patch. But, can you please document the
> lock hierarchy where you explain what this lock is for?

SGTM, Added a documentation about locking.

Pasha


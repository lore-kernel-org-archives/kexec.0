Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66477CD4F26
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7l5YUe4iMmfyIV/63bKF7KguYvHwDoEqvDEkpS8VgM=; b=vs44v423v5KQVh+l2umPZ8FXkD
	caydk55gXqMUKylfZ7SjhORsKVS+PDfIt/zKOm4y1do14BCVnCy4mQfjGLpfmRuGkpDWTtvxfyCo2
	X4R/qQZ68HoGfCTG07P8apuE9p8CSTPAXHnQmMaMJsJBw5CzdmENurnmOibstdYD/TSyvc942lSRk
	rrBxeSU3d3bVxhGWSIgFRLex8l4/cfVTfB0tZL18Jr4ZyAHM/m/pc4WfoYhuPPqBw2EyvzB9dddJm
	pcYxVows/vCjW4Rc3Q4V9s0kvWhOXrqZBDKKV7tuOxIdZeS4nSUNwN5xrJ/UlaQwL0nkDxhKM9rOH
	OrGVxhUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxs7-000000062xt-0rNj;
	Tue, 23 Jun 2026 09:56:47 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbxs4-000000062xK-3A1L
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 09:56:45 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-695f710d929so5499917a12.2
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782208602; x=1782813402; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7l5YUe4iMmfyIV/63bKF7KguYvHwDoEqvDEkpS8VgM=;
        b=TzgQz9X2xGIp9Dpa89Z603c1AeyboRFUNaYZZ5sUzssj+JUb4ZgcvsQwJ/pml5Mm25
         I0i0hYLisRvcaWVyB2Vr9pyNmd/qe/0rfMVHes8RbsYgaB5LTweEAF8RgG0oXlYrX3dC
         vxX0EVBkP2bqoaOPRxQhrfsVAO567bHVz5GxG82JsJ1CURdgjiMiMrR7/nG/priHqOv5
         Wim9kO28isntyNq8akY32y9XXeNOeuaLXG3D9E9KWBAV0mDKub1la5pK9gBDwx0FPtq/
         PBo58CD3l0AAhedgtKK2jQIsDX5fu4X7alcfj8doQHwWO/tvc4Cx5dD0aOJR9v8DX5Io
         B1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208602; x=1782813402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7l5YUe4iMmfyIV/63bKF7KguYvHwDoEqvDEkpS8VgM=;
        b=q1vh2eQ1dDGfLz1h4d9kUSfgfRbvszkHn/boBpH3v3+svXUZxeMQCj39MKp4PRKLEg
         dR6TaJWOrkjCjrGi7q8PjtbpXQd8em0WR64EhUvNKFutgAxDDORsFMbQ/LALfCdROok5
         yKwh6SIox97nn2ZPo5JrPd6mhoGel1etKGJr0wms70oSHodEwwdhpIH/bGtr/V/pv0Xo
         Mmeg2fXh11dZxSaraIf3msJOYCzwGdpY0S+rlmXXYuISZEj5YFlVZAb4hBEHXwWqUOpc
         WV4pGz7A2zozYa0cDSiwjtpdIZjtUdGfyUbmiH+PgC7nH8k7xUdu84sh3aKa9PC/z1VT
         v1aA==
X-Forwarded-Encrypted: i=1; AFNElJ/yxuJzbIQAuF/CMsgg7r2/mH+lM0+dTQN7q9s5tZBuj08PC9shOqaJ9lYZ3Hwl71aHGr4nlA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwT0ZdVnDbhC+w5QagMx9hRUTZo1zsU5qTkBJrmHYf4L3SDyiaF
	0LjNn5kWXGXb7yb/IKy0t2Nkfx1aryeLB3z6nhREaiKYtrQsFskKUurzHN2Ndd1vxiN8ypM/R+F
	8RO4HfZXlImb+oa2qZg==
X-Received: from edtr21.prod.google.com ([2002:aa7:cb95:0:b0:695:4c2b:47b3])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a50d:10b0:697:5efa:ef21 with SMTP id 4fb4d7f45d1cf-6975efaf64fmr5571985a12.9.1782208601957;
 Tue, 23 Jun 2026 02:56:41 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:56:40 +0000
In-Reply-To: <178220761164.162773.6384380547612711985.b4-review@b4>
Mime-Version: 1.0
References: <20260622225736.2961438-1-tarunsahu@google.com>
 <20260622225736.2961438-3-tarunsahu@google.com> <178220761164.162773.6384380547612711985.b4-review@b4>
Message-ID: <9huzpl1h37hj.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 2/2] luo: Update serialized data to use KHOSER_PTR
From: tarunsahu@google.com
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_025644_798660_A6F111ED 
X-CRM114-Status: GOOD (  10.15  )
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

Mike Rapoport <rppt@kernel.org> writes:

> On Mon, 22 Jun 2026 22:57:36 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
>> Convert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
>> This series also takes care of resolving the bug with memfd of using
>> phys_to_virt before checking the args->serialized_data value.
>
> For easier backporting the memfd fix should be a standalone commit that
> comes first in the series.
>
> Other than that

It will break compilation for individual patch. For example, memfd_luo
changes are hard coded dependent on the args->serialized_data
conversion to KHOSER_PTR?

Maybe I did not understand, Could you please explain what you mean?

>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>
> -- 
> Sincerely yours,
> Mike.


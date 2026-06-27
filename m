Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B784C43458
	for <kexec@archiver.kernel.org>; Sat, 27 Jun 2026 00:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vVYfSXCDWmf5gbYok3uJRaEhWbuILu/Vcmy1zPHwtMI=; b=D7yiqssxCKeTob1PqAOn6BOa6f
	AWj7rZV6AmKnVybWGu4XTVgfxBTxdLD0rOXcuTX5aRHZw/dlyfXTeWmHjKAKSUPSXgWKNdWyqkeFK
	syrjo8cLxkmmf7ehumyUFJEQPY8tNZX51mS+cG0eor+Z9U7Fr9WkMJw5sDkzjjT5cJyCyAo+s+0ni
	uPvcuAfJuXnydVi8d4P6WI5xBUzPdF5ty8zaik/NdZ6Rk3gWT8QyeCGfn7x6WfUG5MPyDn9opGw9M
	kPI+H+hhVMW3wSLQsg4vYmbDzcY1kHI52bJ5OfbyvxVrpnfVI2eeCLOxcT29/mWKxGLStM3XVaQmO
	lJQ9q0bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdHHz-0000000C2Wo-48mf;
	Sat, 27 Jun 2026 00:52:55 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdHHx-0000000C2WS-1Spm
	for kexec@lists.infradead.org;
	Sat, 27 Jun 2026 00:52:54 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-91588056619so100086985a.2
        for <kexec@lists.infradead.org>; Fri, 26 Jun 2026 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1782521571; x=1783126371; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVYfSXCDWmf5gbYok3uJRaEhWbuILu/Vcmy1zPHwtMI=;
        b=aqUZBVMJqIhPJ1jp5tkCKm/pfMta84drGNrjNzR8/uJ5gOqs21ZcsmXmAtCd8UPN6g
         PISBCNO4nN2Xleup6vuP7o+QFU6dmbLmy8CzHFcOZmUyLmyZKJfjGtXdIIlBINdPVYGx
         3Ode188lL9R1B5hYLxl7qds3TLYp18yIDmzt0x2JWgk2QCX3p/mU4cFDruCYuHOwMc5W
         cGcUEicxr3PEVPruE5V8HV6EZjb5CgyvpFUCxebkz4yl96HW+f6VepqigiNBOso/AOOu
         3uCq5K41I4r4cAgxYuUOnjY9CZCvHWWBJaNbK7Oh6ESeCzmnCRPGAVjlX1pXUs+x3Zja
         AscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782521571; x=1783126371;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVYfSXCDWmf5gbYok3uJRaEhWbuILu/Vcmy1zPHwtMI=;
        b=RBVakK1n7S8/3Qw03y6cR741W8q8djVZttJ5anGfPL7LPvtNSQ2MdNWb/u7QRpzDD2
         8PXgRXyxo3D2pXtkzVs1SVpy7auj0ThP/sS39pm422ojoOiWmAJo8uWbzNALBkURLaNv
         BzKxR1ERaj1TPzaA3IMTRErx2Rsipil2bInd6bAGgsAFWt2FrJ84nEiO4oYVt5Qnmus8
         nQx/VMzz6zk+aR2vbQ6H7yv/gR0oipRpM0QdQBfdFa4kJ2juj5vAK+ch3wZQ8hlelJsg
         UfSoaCU4rbeomLfSw/iCEX1ce7QS/fvxp0Nr7v6+ZX/ME26ql1U74AyJDxzorXjMVWd3
         TCQg==
X-Forwarded-Encrypted: i=1; AFNElJ8f4PjILHOX2eU5bHiXh8kpdGV3rnOzyR8TLdZQ2AN98JssoXBTBIQhxRrpDqtF92HjNNOY2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHE6iXfmxvkn3iGG2VjoTEMrPEAYUp0aYjtFs/VLSo18coGQDD
	j2hGRnjFt2DNvUqGq5gpBQ6O5p1/d5frWoLBJzohUH259X1NsDBREU2eva3b5ymg46g=
X-Gm-Gg: AfdE7cmO6RDSMRCw0TEW2iuw8JrCihUQS6vTdwGD0Odz4yUeIHZo5hmITCjdDoribbG
	xCEu+U4eHlSbVZS+o3JTvIYJ83WtLiPjkLlqqiu4JAkGfSu175RJTVnTJlTqdIKEOhA1xLj+TJs
	ZQrKLNEwzOVUZLZa7O0SyCnJVOTmOXKyo8yZ+4dGlJnYGrXPAPxLnTXlFDSQMtBomT2I/AsHUHp
	NSGyh21mc6Lm6yChbBKrSl5wpRaPMrqrP9T7SKMGUR8pUAtf4kNLTvN8gMSFYx8cQ7vXLYwXhCg
	8ur0EiAYyewxpXmOuTNfu6F4VAevhbx5TM/4TvemAx5gF3MYwcTmrlmb/GL3qVjYHuZ0ioDSmDD
	1kfwpwF8RSeTq+neXQomz4T6RSATCeo5mWkxg6xipgwJyMnJisjigN8XBSA6pWTwi7v/Kvssl+3
	pox9lp9QWV+YDLudqW801Br7uPWluz5Xz8FO9pvMAzc2tSNbK8vA==
X-Received: by 2002:a05:620a:4413:b0:92c:ba97:9b28 with SMTP id af79cd13be357-92cba97b01emr51609185a.58.1782521571509;
        Fri, 26 Jun 2026 17:52:51 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926000c0c0csm1304879985a.25.2026.06.26.17.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 17:52:51 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/3] mm/memfd_luo: validate serialized_data before
 conversion
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260623105201.3724592-2-tarunsahu@google.com>
References: <20260623105201.3724592-1-tarunsahu@google.com>
 <20260623105201.3724592-2-tarunsahu@google.com>
Date: Sat, 27 Jun 2026 00:52:45 +0000
Message-Id: <178252156515.136430.8828544568760798209.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=667;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=lA9Ld76U/OZePGMYSwBGOUPWdUw3wx0ta7LzTU2JjXg=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqPx7i6XBsRVosljnAEJPuGa4GIhpxEyJNpsUUu
 eODBiTs6H+JAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaj8e4gAKCRC7dyhM23N6
 3rHkEAClYVvZXcLcIYww1NmCuxoqyIcTwNmfZ7YRrSmcCbayxGiOmHeO2cDUEtek6MYaqMnQ4PQ
 VtPpfm9ZfIjx/wCaTN1vYCj7t2rDndKrJIZcP/poz6iMjONujZ0WYh8G1eSISQVKrn0TdJ90C9u
 u0B1As4Pi5iSfK2xlEnhTIMF9sioKdG68998nIXlscpwSGTDQeclcaxvRxbGs2XFT0cZ/oIy4eI
 r7rYOzykpsiqyXUFm9nQK7zfvjtA/0nOygHz54mOeGOWS2d40yIX0alocNsTX+3IUlMUri4KSRX
 YrZJamlftCGCx/EamG/7viE4FhBimMnvbBmPlxtvDkGt0rq0JviVVvFEFDP7qUpU5YGkHT/LGE9
 eK4FSbRJwImWRfC2IGguZ9qpSSWXK9HpVlXrWsvObgKlu13kMNfxNSMteuDNSvNPBsIJs23mQMt
 jGxvmnB3pAzm0e0St1G0g/c/tJEjXAe6XcuAUWDZZlOEI5sO0IfuKuAwGqQ9TE3l5wze/6GJw16
 KDgi7sZDsgp0cf8/Xc0b6DJKd+wXWNojjHxdcfI5hBkFB7FObDNvG4Ixmh2kPvQa2pIMI0AF6Oz
 U1QlPkkbr1T1OqgDQG/SwqT7v5a247kIJ9ohMOPY8l1z3osTH8HYJOaupsWihIwHt1Gvve3bf/e
 x21CziXQacgN+cg==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_175253_435098_2A3DA5B2 
X-CRM114-Status: UNSURE (   6.78  )
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

On Tue, 23 Jun 2026 10:51:59 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> on args->serialized_data before checking if the physical address is valid.
> Since physical address 0 does not map to virtual NULL (due to direct
> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> catching a missing serialized_data, leading to unsafe dereferences later.
> 
> Validate that args->serialized_data is non-zero before calling
> phys_to_virt().
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>


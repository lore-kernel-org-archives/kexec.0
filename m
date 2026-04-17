Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D88F99C6C
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yi0JgmK3R35yP16fhb0/s1gdWapAm05kYmMX0/wAIk4=; b=0VAcmYp3D83KEfZWG5qKFoa7jS
	90ms9XOGdUv27aRHRzmUJ5lVOOZbHkllT8qsuzpU8p4VkD+Pq39vAelqlFPttIsMsOQdP04OpOTzN
	x4akkng0PQIiUZ4irXoeNlAatw8SblPsyMyLkzNEl3jqnSpbA4tGBPU1XI28epsx5mhhmVBXC0D3z
	negcgqLc+OBjARk8+y2VfIeqmP23JyiHgRTa89vBL8eAkXBt/Kp/HePIe5ijl4U68QoNzoamVsKST
	/HJG3vCS2y10aTcKkexo8pcKGedQDDWq1GtsCTkflVIaaSm2i9H/f7k0q67Lda+/qclStyWxJKa0l
	aQl3kCsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrNs-00000004Vwq-3bU8;
	Fri, 17 Apr 2026 22:09:56 +0000
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrNp-00000004VwQ-3fx3
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 22:09:55 +0000
Received: by mail-yx1-xb132.google.com with SMTP id 956f58d0204a3-651b4d09141so1752176d50.1
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 15:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776463792; cv=none;
        d=google.com; s=arc-20240605;
        b=CKrbSvbUn/fZvGsDt+18IQBdUn3Hri9jDnDCOX8DaZcWmNypC093ilUkj/8ACwowrE
         dd0A54AdgnMkFG361ak2kNxbyLukBxU+SIW56mcL2FD0aMGUJ0JFhHf18bC75tdYh3HH
         jeuXi4a93kOt5FYXDiEJbsI283GRIjuQGYeYISjY5bR3qDxkMvrCRlJpSUwv/e4lPdJx
         si8FZfOe2+AwmN+yQhZlzHi74HONSIhJsko7quLQbLRmIAiyV1tGUoinjdj7CyqJN11W
         zMXrZcGeJte7N702Lad7FsiQf1obBVTbsT2cQaGyuOJpha+UzSma/8WE2q2V2WjNQ2Jq
         t0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yi0JgmK3R35yP16fhb0/s1gdWapAm05kYmMX0/wAIk4=;
        fh=ohCuSSbU8OF8OzIpF+xjR4hSL0ojwXgoq4znVtE914U=;
        b=QB0vpADH65Qophaiu5Ju3dUfpHmQi1BrYCcMfGx5/oFzGchM3L0zJPu3VhmQhott9q
         45YZQLmQHKLTv8Y6gXLLorV5jiph7Ls/FeR6jPBnkJRn6N0eWYVjmp1unjwIJzNH+jHc
         8uTy3q1wdXJKlDlc/dkaaPlghkBsJfzFgRq5KA+BkIHDSvsWRnbCw6uS0Y+ZBBWG/afz
         8IyotzYEE2ostrSlw9DeRLygRBbywOAr5y9MlTZosRtRW0R8poqf7MRA8N/6a4EPFv5B
         o6MJaRCTisLwNq5nrUz2FX7Ju9kvEU47OFpQ63AxgpsbU7NkVVeWCdvq729B4xbyr+vA
         fjjA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776463792; x=1777068592; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yi0JgmK3R35yP16fhb0/s1gdWapAm05kYmMX0/wAIk4=;
        b=Gqb4+kiQWUjOrzpomLlW/HjEtsy1H/l8yCeS/6LcAn0lMP4OJxPMNbXoBqexaXiKPk
         lMlAOiGKAUmUUKKeUx++AetCb/cr7YilDWJYYJiIwusuGDDIuVVPpzI944pd0nrN6JZp
         KN+qwhK5IBmdgXZQud22Hwtire1+/r9ukEJQOstcky/M7KKKSmxU4iypBqaX7QhNM+O/
         zS1y44UPuJj7Vyl7CR28mpj0AiPN7EF2gPZieK0P3sFovCvc2V6uGM+GlETTQLEk/aj4
         BUFD57T7L1mKWbIJoxieBQvNGVHkYCawf5OTjlgOc80QNDKiKzqORkxg1V4b0CyL8oMg
         0ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463792; x=1777068592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yi0JgmK3R35yP16fhb0/s1gdWapAm05kYmMX0/wAIk4=;
        b=JEBoGqmNa8py0FzmHFvtlbV1N970JK/7O218PKzsyqKo3lhdVoGBqbyGMKqN/1PMlC
         nVacSsF/6exJa3nayfQnE3CHuooZ83s12rhxOewuJSXbfb47yjOBjKCWzTqDqt7S9/2A
         xgBa7fb1yC7JGa+GbIOLfPOfSsacl8QypjrAPUInv7i1vgEGcL5/RbteZpynwS1TDA8r
         PS7AGz+W2siYIGrDcx9U0ViuOQ/229FmqAXX9I8kNF+uBxIiT8Ohc2MmUUrKQTRyxJbj
         eXmE2Vicarfh6xNMBPExB9ZEk4gYh6pXhvv/tYWUR30Ncyv2yBibGMO1gIIUswJix66T
         RAyw==
X-Gm-Message-State: AOJu0Yx+ioODhfGPcMaoaIeUhs+fsdx1nA0H7/HOR6gr1m/ROz2k+rIH
	+ZT9E84OqMyLo2US/S1YMa9g/e5Gpw6qbc32j0U0MyIrUujlmRZ+iMJBAIOHUgnpuNvg0oB2vm2
	vfSKAvpZA1JFzyO/FrIoexC7BSVdLSP4=
X-Gm-Gg: AeBDieuEsuPsrmG4dbzn3xHsxr9ydhvDD3JmEkAKUxIprJ1TPHRVlLHVlQqj7nraJc2
	uC3xUBVAA7oCyiiWcaXjY/SDePtFYTtu5/asTyteMV9+wLHU5YdvWkjzS4gG1NTKwyENRkYaKEz
	UD3iqjbKEvqDzPECaE/A6+tFS6yRDmPVnLd4mQT/CeyPaXeznaOBakeqiCAL9LlF/4SjelSaYFm
	2qohdXOGoTueyMRGllYmUa5Tib4oaR7ahR7FqKtYVtJxnLTtyHsQrDNEoXIDWeJ+cL6Mw8H+9Zq
	rrpOpvt5N1UYiCIlW0IzUsx2cCGCXOhZETm/thCs8M/jMZGCl95e
X-Received: by 2002:a05:690e:43db:b0:650:77c7:ae81 with SMTP id
 956f58d0204a3-65311b3180cmr2291569d50.22.1776463792619; Fri, 17 Apr 2026
 15:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260417003856.1525287-1-luca.boccassi@gmail.com> <huu6stumzw7ziu7i5qsbpo54hmvd4j4g6fge3acrulhwekw7ez@mjjf6psjty2g>
In-Reply-To: <huu6stumzw7ziu7i5qsbpo54hmvd4j4g6fge3acrulhwekw7ez@mjjf6psjty2g>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Fri, 17 Apr 2026 23:09:41 +0100
X-Gm-Features: AQROBzBVsf_pm_6AipIBiyNFG5DebocTS5kvjb_xvXWGq8-zQoaXkmR-0dQWyzs
Message-ID: <CAMw=ZnQ1EMxobX+=6yC-h2_LQuwhtcRox=0hUaGBkUAmzWiX4A@mail.gmail.com>
Subject: Re: [PATCH v2] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_150953_922775_F63DF60D 
X-CRM114-Status: GOOD (  18.64  )
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

On Fri, 17 Apr 2026 at 22:48, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On 04-17 01:36, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > Userspace when requesting a session via the ioctl specifies a name and
> > gets a FD, but then there is no ioctl to go back the other way and get
> > the name given a LUO session FD. This is problematic especially when
> > there is a userspace orchestrator that wants to check what FDs it is
> > handling for clients without having to do manual string scraping of
> > procfs, or without procfs at all.
> >
> > Add a ioctl to simply get the name from an FD.
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
> > This was requested by Lennart and Christian when discussing integration
> > with systemd for LUO management.
> >
> > v2: apply one fix from bot review about cleanup on error path:
> >     https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
> >     the other comments are invalid: luo is not a kmod, and the write hooks are not set up
>
> Please split into two patches, and also CC to kernel-linux.

Done in v5. I've also merged this series and the LUO_SESSION_MAGIC
series into a single series, as they modify the same unit test source
file, to avoid merge conflicts.


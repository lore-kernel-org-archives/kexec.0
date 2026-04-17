Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB491F99C63
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 21:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QXJgugqAlraVFQ9lgbeMD3VGh3AxgbVqc+X5mlsbqc=; b=aJ2jPcLZE1rbp9wUhn9/dINc10
	DfsQgg5UI4AHUJud+i/qHJN5v21c6tQb4WGd9yugxfNnlPGPq7a8Qx2/RcXkIxYF2On03D5sP9D3b
	BvckQ4bL8ZL89FWyXZMjgMxTiUcIfYsEIPx9hjqiZ46YJdOaFcLdH+UkQwk/bNDZ5c1LJ92XmlfLY
	ZpgluYBWQ+Yq1IMFOZkVh8kVnF0jwdr60r4vwhuGwqbMbpDAtCp6Q5rslkZJsjKCfmCv9/QJve06N
	be/WqRRzM+X259MRTrQEzh0dD4EBE3SinSy/WI31qTcHBJLLxuH0U71qCnhH/idqepCdV/iNP8Yr5
	ewBJXVTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrCJ-00000004VTz-0RMT;
	Fri, 17 Apr 2026 21:57:59 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrCG-00000004VTd-1khZ
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 21:57:57 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6714fa8b955so2142891a12.0
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 14:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776463074; cv=none;
        d=google.com; s=arc-20240605;
        b=DzMazJFn4HFRpTQOHhOXxby57qWOL9nueg4wLFnPLZ8wGnFHmjrrJtPTEdv1Jzt2tu
         Gi+wPOHrpkh0tQYNSIrq9hFGsjPe2HU9C28XFwrToBV5qn2QaGkJi6PLKckvyJmfuQ/O
         4veR9n4ilD4216mw9dR03HvBuhACE09P9EBjpAthfpbSCeAX3MfiGyFWOfsx6KQFVVZD
         xbxufI5xUOs17uNeQ0MkrwRo71m6Tx208b/uZAONunSrtzDW3mh2ikKRblHDcATKcp3W
         r6rejBccm7jO9y7Bkuh7zcEC20u5H6Z+sRl4HI7yUf9aZ+4qtrKpfnX4xhjb/iftixk8
         GPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5QXJgugqAlraVFQ9lgbeMD3VGh3AxgbVqc+X5mlsbqc=;
        fh=LMYcHJDOLb2KA7nfnrewUCqIzspHg7Qxmce6hTuh/Mc=;
        b=gYGZfHsRWweiArrNISF4inMAH30mdMFO8E4H4hsAghdI4A4pBMgsMCG8rM0184TUX+
         2mkQwfi8JyY5yYyKn40JS9CqxJE/rZf/+OsG0/sP2kG8mnY3X9O/LoyNqdwGA9pb9t1c
         yPPytZrVSZnNudzEPiEx8sbU3SMlwVLXFCq4Bc7K0Vtzm5d9yeHpk8BNNkW5boh7Um5b
         2GRDEhFF4IdJlZPMOU+DSMRzXS8jNzFilIMTzq8JrTMp4bZELwwDVEmfAkZKSa910cP5
         4KDi8wRc0thX5TuzxLdsJ08zwm0jGPd6rXc+eSO6R3Rn7MkVJCTl8s/CqaIHSvoIL0y+
         vjcA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776463074; x=1777067874; darn=lists.infradead.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QXJgugqAlraVFQ9lgbeMD3VGh3AxgbVqc+X5mlsbqc=;
        b=Gz395IG3H/0GOGvyRotNV2oqujVaR7/44VU2POzLXev+vERshKxia8tEFsEwkkN4FH
         /v5YC/uBxHa+z/s6O1L8lboy3HHRov+4lDkxiKM35dxVWwGQtHu5eWo5WwH3MTazMVX+
         +5s48cbYvcYonmONB5/o5dRF3KXhMowasJkMD2NtaxbaUAigSfQJIIrAmsNOxsfYYQIT
         NM3t7jwHQhYUPcNn+gLPP+fojQlqNlUctCXpGbtWJ0KVQO1UECb6q74EYCduadBGKDlw
         OhRnjrxRv9q9k83cSFPMv6xctiJAnqo9yiRrTW557Jgt+Sxa+QAiNcNYiqJlV6jYNaVe
         f7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463074; x=1777067874;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5QXJgugqAlraVFQ9lgbeMD3VGh3AxgbVqc+X5mlsbqc=;
        b=ciP6VRC6y5/189U5E9qybMvO8L4zX/feQ/Tw0U3mwUGDzodubkNyhAKMDAWaegtM9W
         5ltXUz5KyzhaFaWPD8WqR2d+ngdAGp34TJaoUuMeOiAObhudrNbzFAKEeuN6/H0EtF0Y
         Wf3ngxqqN1psU326t0G6cOHmFSzHHcBBTkS/96hoDNZ4iOVaHSqnRyrzAeAGbcfXNXdN
         5rTW88UUNdCWElfolzGnDa6+wnQmhpLgcmUlkTe2JkPB3cJTLhQdUzrVsK83AUc6+Hpi
         K2JGydVH7SH+vS73rvt7i+MwPsxIJQ2PIQfDHwwqRJPb2FYuWXZAw/42s4LWPrcLr4jX
         AiXw==
X-Forwarded-Encrypted: i=1; AFNElJ8WDo4DxPObzFLdEQ72JN+8q7VWZ0M2Ca9IA6kbtgdV0XfgLobYT+RH1lFOYGX8pUWwbOOwQg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdlMrBUt0mjjL90M1JUOzPnImH5JhBhBSta8eF87YAzzyfiX47
	Yj4w6q1KaQX1nvXITWtY8TilpPEZo0OvLA78PxaQthKwUFqeVC7/uw5JeJ7hp3ms9SGGbVnDjRe
	zHzaK3AjBhcoC3gw4hmpYRpOvb2WHBejq9ZhkHDk0rQ==
X-Gm-Gg: AeBDiet9rsvkrQSnfKppJ2SNUDF4Gqej3j27PtugSdr8VnBHDB3y98/AC+n2SDcr6m5
	V+KI3pH5FwdgID0tnAYWele+sWYACosjht+Srpmv4I/18d8JIq+ZH1RW/kNj2kUY7wI845YKWJu
	wg7JbFpiwOLrb/cK+oLCx/s4d/iieMbnxagfvU8ruJCYOqhhFb75wNz/b+YvquPHr/YmDr9LC50
	Ykf56iLu3CdcIcMt6dJa26WgQqcIrY+iHf1qj81luOx9do0t82sC/eixQM3puVrEVl6emjEIfpU
	eOzuKkUYcDZ3kXjvcX2UKZw+m6pwNgRg69eil9wE8f4biuuKcZ1NrHX1Tpg=
X-Received: by 2002:a05:6402:21d5:b0:66e:df52:7ce0 with SMTP id
 4fb4d7f45d1cf-672bfdc9493mr1849875a12.17.1776463073992; Fri, 17 Apr 2026
 14:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260413121146.49215-1-pasha.tatashin@soleen.com>
In-Reply-To: <20260413121146.49215-1-pasha.tatashin@soleen.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 17 Apr 2026 17:57:16 -0400
X-Gm-Features: AQROBzAVaYe7tqDhNO0fa6JobuaMGy95p7t73Y8TVE4-Cw4wNmeQFkTjEfdCtos
Message-ID: <CA+CK2bDwcGLasN56NXJdwq_AvFWrz+WMv9L9uxK8MkChXw29rg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update kexec/kdump maintainers entries
To: rppt@kernel.org, tglx@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, 
	martink@posteo.de, magnus.karlsson@intel.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	krzysztof.kozlowski@oss.qualcomm.com, diego.viola@gmail.com, 
	broonie@kernel.org, cl@gentwo.org, masahiroy@kernel.org, 
	kexec mailing list <kexec@lists.infradead.org>, Baoquan He <baoquan.he@linux.dev>, 
	Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_145756_494837_08F17E28 
X-CRM114-Status: GOOD (  15.11  )
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

CC: kexec mailing list.

On Mon, Apr 13, 2026 at 8:11=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> Update KEXEC and KDUMP maintainer entries by adding the live
> update group maintainers. Remove Vivek Goyal due to inactivity
> to keep the MAINTAINERS file up-to-date, and add Vivek to the
> CREDITS file to recognize their contributions.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/CREDITS b/CREDITS
> index 9091bac3d2da..035f70bae0cc 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1456,6 +1456,10 @@ N: Andy Gospodarek
>  E: andy@greyhouse.net
>  D: Maintenance and contributions to the network interface bonding driver=
.
>
> +N: Vivek Goyal
> +E: vgoyal@redhat.com
> +D: KDUMP, KEXEC, and VIRTIO FILE SYSTEM
> +
>  N: Wolfgang Grandegger
>  E: wg@grandegger.com
>  D: Controller Area Network (device drivers)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d238590a31f2..e5b4db2d8f88 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13796,7 +13796,9 @@ F:      scripts/Makefile.kcsan
>  KDUMP
>  M:     Andrew Morton <akpm@linux-foundation.org>
>  M:     Baoquan He <bhe@redhat.com>
> -R:     Vivek Goyal <vgoyal@redhat.com>
> +M:     Mike Rapoport <rppt@kernel.org>
> +M:     Pasha Tatashin <pasha.tatashin@soleen.com>
> +M:     Pratyush Yadav <pratyush@kernel.org>
>  R:     Dave Young <dyoung@redhat.com>
>  L:     kexec@lists.infradead.org
>  S:     Maintained
> @@ -14112,6 +14114,9 @@ F:      include/linux/kernfs.h
>  KEXEC
>  M:     Andrew Morton <akpm@linux-foundation.org>
>  M:     Baoquan He <bhe@redhat.com>
> +M:     Mike Rapoport <rppt@kernel.org>
> +M:     Pasha Tatashin <pasha.tatashin@soleen.com>
> +M:     Pratyush Yadav <pratyush@kernel.org>
>  L:     kexec@lists.infradead.org
>  W:     http://kernel.org/pub/linux/utils/kernel/kexec/
>  F:     include/linux/kexec.h
> --
> 2.43.0
>


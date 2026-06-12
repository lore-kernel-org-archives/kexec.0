Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE1CD8CA8
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1UzSGETMtXAzR+/046bRaNOWjwaarHbCo4BpWKBR4W0=; b=xBmWIHPUMVmlwu
	w/tODeqxQdW+EM8flKxF1+UgHqZu4yVbmLny6FT3I4bp73ilum6wvgPtfgw5FljBV46SEzXt7xS2x
	V58Dua3Qfibf+2k6fiF8AwFbXThyxNqfUlE5Nu0Iu1phPBkxami4zK8ess+p+Nzui/LilaUzPKVoR
	oRxRIRhsoYBw9JGRWvRU7NrkI+s7rHIJE0yeUicYhfZfj8C1JJqDZgzoqmLpVeTdYPWrRDC1zPEVB
	7P/cDNiaoRgrpsW8UUBN71TTWR8jwr0buCO+we7hnHFFXZxMC/JRBsvC/G4Aw/MRAx8XnJxrqfxVr
	/unkN0eHGUruYsE/jmUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY68f-0000000BN0p-1C9b;
	Fri, 12 Jun 2026 17:57:53 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY68a-0000000BN09-0Oc0
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 17:57:49 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1380104f31eso709c88.0
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 10:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781287066; cv=none;
        d=google.com; s=arc-20240605;
        b=UD9oBdfKhJyrks3PdYFcUGVkL4qFBiJGWfiahcxq0TLPT35bx4nhpKlCtvCIyOe0Bj
         9WA9LXCX2bE96fdo8Wl86mMMSwUWDi8BlCc8v6t7t9eI4MJ/EVtrqQ+IFs0P3n4iAAxY
         D+4Bay6o4rJQKwnJvd/U3Wt8zuHhAjSXeZ71cpM15gnXayHzapliTnPHeYdo+Vq9nPTs
         +e79nziUnbMqW9xfF5bNH2eCGsV1M14A7SpM94Y4Fv7VnHXZNqZVjm80XSnZx04GYf1v
         yQKv37K+771I+PoEM+o3dal4IpIzHkp8yvZeFCl98zQMBB7+ZWs6U3eykNqieUyVAwBj
         IutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1UzSGETMtXAzR+/046bRaNOWjwaarHbCo4BpWKBR4W0=;
        fh=D04XWeTIsu6VLT8VHe0OvzNjfLqCbuJxxIYb92rBV0A=;
        b=WWu79nLa7CV3HvBfXGykDNjUj2bj7OzHfyO85jMp3qxP9bmkJvWgWTO07lbUfUKw9J
         iK1NYx8sroxVruWxzmoHQ9PzVBkx6liT2bT00hyU4Lct9qa0ToGmUd7DmnLsCdJ5nZR1
         hd5uRRbvYvEBz/iCsc6gOp1Sjo4dMlaoVvC0CCwz3iSG7cSaZ4kHv89xa6ZqwPJMS+5R
         VieyBnIkmFf3b12iOS7JugZxVDYqXzzRWdTpqdt0ZY14OqlgrQnZrQRJEiufFL/rq9Q+
         88X5kRgUWvnXpMk4yrIljuV6mbssSQsPjiyfZ6injI+KaAs3OGlL2NNkugOqS02Rbb76
         A1/Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781287066; x=1781891866; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UzSGETMtXAzR+/046bRaNOWjwaarHbCo4BpWKBR4W0=;
        b=bXh1UXu3dW9PozxA1Vi2pmdSQrnWOC4iSskguXwvjhogkNKqw33ml1vKSbHz2Fs8mP
         VOY7VMBrCGsOgeB4nO3pYnDmrXZRw+9dFUJZ227+kRyiaN/dNXNwIizEUSscF+OwK49Z
         3PmDoCms4KBKJJutxCKnhtxrQQCgzAK8iTPOwmSLWA3aBLa7iC3kf2XbsLJ/tCRHXMm5
         cALIW7le49AupZ65hUewuuSJ0ezgZletre0nzPwgOzF4h3wVMaxo6PQRkLg2ZU1WZh1q
         m1vhJK5lN2VU9nrOwOT4FruIyuCRablqIjo5l/74ot6EADgaGRFAm5cruIhj6tuo28VM
         wW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781287066; x=1781891866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UzSGETMtXAzR+/046bRaNOWjwaarHbCo4BpWKBR4W0=;
        b=KZRiAdGlLln383+fyaSohCc13Il42LKZsSdifI1OdYo3TbgPKlFm6KzJoZcALQilDo
         zL1njAeJnow7ltDoJ/AaQjeqFY2/gxEwOi808DQSLVxOuRJSBeGpN0Bb6BQBU11rUbZe
         6AzdWjBl0JFHI896oR7U/PHTeaU9whxjDYwQN+XseQhGFpA4uGKNZNa1dqPv9m98GWyP
         McE2TEKnCBvc6NLIsXTHXO68L/J1qnNsmWF9Vt+7c7XefNF6iqYUNk1f4PVOESF954Dm
         ilUZj425gW6rdX6Q0KP3S0O1yVE5vjF+6KGEnYAEOF4n8we8UUxpkqWIOgZR74u4ty59
         +AjA==
X-Forwarded-Encrypted: i=1; AFNElJ8dqNWIfP6u+4tgBti7phSc8zUNhkc7HyNE2dcEVjvC+QF8RzSL+7Op2DsrBy3WcNbF9jVFKA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3SICiwLWA7Y84rJUjEBbNFY9VlNIObH5N3JtmBfsqPiYQOXi6
	FOrrwjkIhMW5YO83pAzsOAZd4ujEL+lxNS+tJ8/f5mobgznwCAGlaAPbLkVKii46PU5qZVoI6ao
	MfE1YMQ6PwGFVH7tIeiMnD/udIBjr7/2FJZ4bkWuy
X-Gm-Gg: Acq92OEDJq2OQTYeYeQshHYiauCFatpboov250875KQ81IX/FfZOVvQYvhHHkHLTp+w
	zYBj76VfAlVWIrkJoweRePj6KN2Hc6Ppt6rRnb77R1QdeucPcUVgr38eo8MI2r2tHYzzZMf64AJ
	+6BBwYGk8BYEwMO13LXfayUZH8V0GenhxxKbb2yW4moeZs9WRraNmjUd0ybXtqqTCulYwCaLRgc
	k6vP8tw2O3Gg+5Lzi2tlF0Ost5YDeOdLeMzNuOJobB3niE1Wbx8qHujIFFK6vL5uHcdlARxt2Hn
	A/QNnQ==
X-Received: by 2002:a05:7022:995:b0:138:3fb2:7c7d with SMTP id
 a92af1059eb24-138aca54e27mr15470c88.14.1781287065254; Fri, 12 Jun 2026
 10:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260605121040.1177072-1-mclapinski@google.com>
 <aiwa4jIWEMsvfnVg@kernel.org> <aiwbUfeaF9RdCGR-@plex>
In-Reply-To: <aiwbUfeaF9RdCGR-@plex>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Fri, 12 Jun 2026 19:57:32 +0200
X-Gm-Features: AVVi8CdRf_bVtcyfyhhCBnBTsegR18Q05ZRmSDC8ZYavvj6ipRd3OhUBMmzXE_k
Message-ID: <CAAi7L5cnRt6enZnrrbbhsVwtxUDBXrxj16zsg8TtRFvP70ocoQ@mail.gmail.com>
Subject: Re: [PATCH v2] pstore: add a KHO backend
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_105748_139993_DA3CFED9 
X-CRM114-Status: GOOD (  22.87  )
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
Cc: Tony Luck <tony.luck@intel.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jun 12, 2026 at 7:21=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 06-12 17:42, Mike Rapoport wrote:
> > Hi,
> >
> > On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
> > > Up to this point to preserve late shutdown logs in memory, users had =
to
> > > predefine a memory region using ramoops. This commit changes this by
> > > preserving a buffer using kexec-handover.
> > >
> > > pstore_kho supports preserving only 1 dmesg buffer.
> > > It gets replaced with the new buffer on every kexec, so the user has =
to
> > > copy the file out of pstore after every kexec.
> > > There is no erase() support.
> >
> > Sorry I didn't jump at v1.
> >
> > pstore does not really need a KHO backend. It can use ram backend with
> > reserve_mem and reserve_mem can be preserved with KHO already.
>
> I just tested it, and it works well, I think it would be fine for
> Google's requirements:
>
> CONFIG_PSTORE=3Dy
> CONFIG_PSTORE_RAM=3Dy
> CONFIG_PSTORE_CONSOLE=3Dy

Is it common to write to this console? I think what I typically see in
the console are error logs that are also in dmesg, so if I preserve
console logs and dmesg I just have 2 files where one is a subset of
lines from the other.

> With the following parameters:
> 'reserve_mem=3D2M:2M:dmesg_buffer ramoops.mem_name=3Ddmesg_buffer ramoops=
.max_reason=3D5 ramoops.console_size=3D2097152 ramoops.record_size=3D0 ramo=
ops.ftrace_size=3D0 ramoops.pmsg_size=3D0'
>
> KHO preserves pstore properly. However, we need one patch that would
> allow for ramoops console to capture the output even when quiet is
> provided.
>
> Pasha


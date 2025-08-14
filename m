Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B23ACA0EDC
	for <kexec@archiver.kernel.org>; Thu, 14 Aug 2025 05:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3LSoCl56fyWME0v8PiSkctUuL3gtGDTjl3bz0icHfT8=; b=goj+I6ITrmwSkShtJZxUifApO4
	Znl/721meSXCtJ7kWBrmR5eAAlp05xLJQYrhXFNcY6EctQXHQiYwHh32C4nilzsWphVMINYPSnfgS
	4qsG7K539Ag8HzdRmA+l14xsKiezra9lC+gSa4TFkYOJWuYtqzu7GlWy3TfMY3gQ0FPEQFoep1oPr
	7GakbcUt6FQz14gLABPBnwO0zKfxEaKSuWppL8w36/TlBUiuLN+a3gmMU/jOD0JMx3YXOZBp1vMCq
	W66SIFk4CMGMY+ioZDXD6BM6hq3es8od1ys+nvJYHv0mM0qGZaHrKg/vnh4s5sHlwDSUiLr+FbVmt
	rZ3FbSLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umQQm-0000000FooH-0tCA;
	Thu, 14 Aug 2025 05:23:16 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umQQj-0000000FonU-40Yv
	for kexec@lists.infradead.org;
	Thu, 14 Aug 2025 05:23:15 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso334794f8f.3
        for <kexec@lists.infradead.org>; Wed, 13 Aug 2025 22:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755148992; x=1755753792; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LSoCl56fyWME0v8PiSkctUuL3gtGDTjl3bz0icHfT8=;
        b=RX5ox/vHtZIKXgIdfVLaIe+Zd+tSbQ89tqlVxtLsWu6Ef043ygy5R6oJAygLllVcT7
         vFKeyVlnf1r4N3YaH2cJhiavuwnFSQz8DEvL6ixtqIF/sQwsFEeonDbxHxXRgZDrvarI
         R41ssH8RJs+v73dcYX3d0oQTR4QKS+yLFrO5ZIVSjA4uC610m1+LxwdYVgjQKqQi9zOH
         Nmxc7BkpPFvX+g/zY8bs+0joP7w4wOWt4Qf9eJKDdpKUVCAwtVaseqEnSxXsSt/GX0sI
         WmoyZbXJcwpJL9T7Hlq/3YNlLq2S9O/3yqAZQCvQ02Q+ugCZNgxkHU3w7mllSqy+O/KK
         Mq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148992; x=1755753792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LSoCl56fyWME0v8PiSkctUuL3gtGDTjl3bz0icHfT8=;
        b=Gx5t4BPsyDd7X+W/5bnjd4FtCnAKrg1Qm04nQB1+WfIMUq2ku5Gx4iQtlUpiLWRdDS
         waI7PjvZdPChH7QaFXmqw+MJ32AsK1+blO5ppPv7JMeHVCdYE+Yh7hVC+F/79tyIMS95
         9HGNY8gulVV4giqq8jTETMwN/8Glh4exDBYgf1w2GiglqGc6QaWizJwApL4P54syUU3Y
         hWORbFehpOZ4NbUbXqWoNb+zj0J7foFmIdy0yzO6X7p1uoAxhfZlHFuErWhKT4sRVE8C
         GpXkMHluGrulvUYG4Pv8hvEjiBhRY2eoqBsZaSS2aVHOVNerS6ZpwsNy7U2pFm3KdTZK
         zPDA==
X-Forwarded-Encrypted: i=1; AJvYcCUzbWZQVSltCMBPEqr8kNUZL6op8JSVO4g7QxDZq44YV45AFHAks3V6Qow4JcXeVL8mZ0KMug==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywhchxo7aGgl9udWFL0smUEDaiSNBuu0TGhpTOq68iFgABqqxdD
	4OpNy+HGmEnO4BSB1twglDp5DxBUPCgk+iYOy29PayQgRANBrB5kRkRAe45sZrCA+d8Bm//jRFa
	wKfLl1+nxHno8zOXabm2ftEDMZOe75oA=
X-Gm-Gg: ASbGnctxxFh6pwaOEcxfjt/sI/k1R85Ou6EzW0jZYuDOv4i4nwHHxV3xp2vAlL7txeP
	0F38p6XDZXandoTqL+Qb8w2R7xNASmBZi8HEMpxZifmDsfdO9GB4s5ykKVfze+HE0Fl2F6kTf6v
	rWfFcLW3pCI0M1E7LVhGC3gyG1QpazKwVJ/EO33yWWmhiUPUpEXjs4v7+OhhcKNKLrI4EgOO+LP
	sTRF6gRlg==
X-Google-Smtp-Source: AGHT+IG3JLfHafFtVhrpyJJQVLI+yi2yjJjHCa2aqw39VKsfuinwVVPCl+kdFo32hMLPEgR8b1e3VmqLD+4/eg8BBs4=
X-Received: by 2002:a5d:5d88:0:b0:3b6:8acb:a9d2 with SMTP id
 ffacd0b85a97d-3b9edfcd141mr1235453f8f.7.1755148992352; Wed, 13 Aug 2025
 22:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250812124941.69508-1-bhe@redhat.com> <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com> <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
In-Reply-To: <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 14 Aug 2025 07:23:01 +0200
X-Gm-Features: Ac12FXxjjLGYLRyCaqd7TSTNKQmFZtITu9sph-q46cifbE2W4uXByRYl8-gsmGA
Message-ID: <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com, 
	dvyukov@google.com, vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	elver@google.com, snovitoll@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_222313_993640_39437D68 
X-CRM114-Status: GOOD (  14.93  )
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

On Wed, Aug 13, 2025 at 1:14=E2=80=AFPM 'Baoquan He' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> > I'm not familiar with the internals of kdump, but would it be
> > possible/reasonable to teach kdump to ignore the KASAN shadow region?
>
> Yes, we can teach kdump to do that. Then people may hate those conditiona=
l
> check "if (is_kdump_kernel())" being added in kasan code. E.g even
> though we skip kasan_init(), we still need to check is_kdump_kernel()
> in kasan_populate_vmalloc(), right?
>
> Combined with the existing kasan_arch_is_ready(), it will make kasan code
> ugly. I planned to add kasan_enabled() via static key
> kasan_flag_enabled, then it can also easily remove kasan_arch_is_ready()
> cleanly.

What I had in mind was something different: into the kdump code, we
add a check whether the region of memory it's trying to dump is the
KASAN shadow, and make kdump not to dump this region.

Would this work? Would this help with the issue you have?

(I assume the problem is with the virtual region that is the shadow
memory, as kdump would dump all RAM either way? If not, please clarify
what how does the "heavy burden" that the shadow memory causes
manifests.)

Thank you!

